From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ensure that commit/status don't stat all files when
 core.ignoreStat = true
Date: Tue, 27 May 2008 13:00:37 -0700
Message-ID: <7v7idf1pqy.fsf@gitster.siamese.dyndns.org>
References: <1211880549-15758-1-git-send-email-marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15N6-00042g-4P
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbYE0UAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164AbYE0UAy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:00:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbYE0UAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:00:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B8E75663;
	Tue, 27 May 2008 16:00:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6B9165662; Tue, 27 May 2008 16:00:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9AE388DA-2C27-11DD-9E71-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83038>

Marius Storm-Olsen <marius@trolltech.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 8b467f8..104e387 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -882,6 +882,16 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>  	if (ce_uptodate(ce))
>  		return ce;
>  
> +	/*
> +	 * assume_unchanged is used to avoid lstats to check if the
> +	 * file has been modified. When true, the user need to
> +	 * manually update the index.
> +	 */
> +	if (assume_unchanged) {
> +		ce_mark_uptodate(ce);
> +		return ce;
> +	}
> +

The description for core.ignorestat in Documentation/config.txt is quite
bogus.  That single bit does _not_ determine globally if we lstat(2) or
not.  The description in Documentation/git-update-index.txt about it (look
for the section "Using assume unchanged bit") accurately describes what it
is meant to do.  The rules are:

 - (ce->ce_flags & CE_VALID) is the only thing that decides if we can omit
   lstat(2) for _that particular path_.  There is no global "we would
   never ever run lstat(2)" option, and core.ignorestat certainly isn't
   it.

 - you can use the assume-unchanged mechanism without setting
   core.ignorestat.  You flip the CE_VALID bit for selected paths manually
   and forget about them afterwards, when you would want all of your usual
   "active" changes noticed by git, while skipping lstat(2) overhead in
   areas you are not interested in.

 - when you say "git update-index" (or "git add") for a path, if you have
   core.ignorestat set, that path is automatically marked with CE_VALID,
   so that later lstat(2) will be omitted for that particular path.  IOW,
   by having core.ignorestat set, you are promising that you are not going
   to _further_ change the work tree contents _without_ telling git --- or
   at least you are promising that you _will_ tell git if you change it
   when it matters.  But you have to tell git at least once what the
   contents are.

Would it be sufficient for what you are trying to do if you changed that
test to something like this?

        /*
         * CE_VALID means the user promised us that the change to
         * the work tree does not matter and told us not to worry.
         */
	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
        	ce_mark_uptodate(ce);
		return ce;
	}

> diff --git a/wt-status.c b/wt-status.c
> index a44c543..72db466 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -342,7 +342,14 @@ void wt_status_print(struct wt_status *s)
>  	wt_status_print_changed(s);
>  	if (wt_status_submodule_summary)
>  		wt_status_print_submodule_summary(s);
> -	wt_status_print_untracked(s);
> +
> +	if (assume_unchanged && !s->untracked) {
> +		if (s->commitable)
> +			fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
> +		/* !s->commitable message displayed below */
> +	}
> +	else
> +		wt_status_print_untracked(s);
>  
>  	if (s->verbose && !s->is_initial)
>  		wt_status_print_verbose(s);
> @@ -357,6 +364,8 @@ void wt_status_print(struct wt_status *s)
>  			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
>  		else if (s->is_initial)
>  			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
> +		else if (assume_unchanged && !s->untracked)
> +			printf("nothing to commit (use -u to show untracked files)\n");
>  		else
>  			printf("nothing to commit (working directory clean)\n");
>  	}

The core.ignorestat variable does not have anything to do with showing
untracked files.  It is about "do we mark the added path as CE_VALID,
meaning that we do not have to lstat(2) them?"  IOW, it is about tracked
files.

While it might be useful in certain workflows to ignore untracked files, I
do not think it is a good idea to overload such an unrelated meaning to
the variable.
