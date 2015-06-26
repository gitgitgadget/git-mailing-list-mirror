From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] refs: add safe_create_reflog function
Date: Fri, 26 Jun 2015 15:12:58 -0700
Message-ID: <xmqqlhf6rudx.fsf@gitster.dls.corp.google.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
	<1435278548-3790-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:13:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8brw-0003Fi-Ca
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbbFZWNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:13:04 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33248 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbFZWNC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:13:02 -0400
Received: by igtg8 with SMTP id g8so11052674igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s3tVZY0DIzJSVaqH87+lnPifQYuz4SiVE4CXhk/ZYDE=;
        b=0NQJNUxhLaFXA5ab/2HXVzs9c2lBWw1tDQPtl5iAc/44Y7SwqDWVlTibTfp1nMUeJL
         5iqhBE+0qnM8nJ62IKFPZ5M9tXMzRrtUqXvUJkTsSk0nK7Ymk0Ahnn1R8L3I7dzVm05Z
         AeHIjbiXCsoxZZJEw8StqfbsDlG4xBrIV36CednCham05jEw1D07unbS22OFE7XMQlgk
         dru8okJzyx8VfPP7AtBH3rKBBAnTfHaQQ5pJa/lsLW7JW1qRdXQDCCAnkWrPWWY3gBDx
         pxz5PNJbchEcHpYBVMednQlKOCDWK/GWK8N9ve2I25vtLsLxrHgyGBiEMTMbA2rYN5kg
         c4Eg==
X-Received: by 10.50.129.101 with SMTP id nv5mr403857igb.31.1435356781016;
        Fri, 26 Jun 2015 15:13:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id e3sm126174igq.21.2015.06.26.15.12.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 15:13:00 -0700 (PDT)
In-Reply-To: <1435278548-3790-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 20:29:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272835>

David Turner <dturner@twopensource.com> writes:

> Make log_ref_setup private, and add public safe_create_reflog which
> calls log_ref_setup.
>
> In a moment, we will use safe_create_reflog to add reflog creation
> commands to git-reflog.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

> @@ -629,9 +628,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
>  				temp = log_all_ref_updates;
>  				log_all_ref_updates = 1;
> -				ret = log_ref_setup(ref_name, &log_file, &err);
> +				ret = safe_create_reflog(ref_name, &err, 0);
>  				log_all_ref_updates = temp;
> -				strbuf_release(&log_file);

What the result of applying this patch does around here is
incoherent, isn't it?  I do understand and agree that adding the
"force-create" argument to safe_create_reflog() is a good idea, but
then I do not think you need to temporarily set log-all-ref-updates
while calling it (and revert it afterwards).  Not having to do that
is the whole point of "force-create", isn't it?

> diff --git a/refs.c b/refs.c
> index dff91cf..7519dac 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3123,11 +3123,12 @@ static int should_autocreate_reflog(const char *refname)
>  	return starts_with(refname, "refs/heads/") ||
>  		starts_with(refname, "refs/remotes/") ||
>  		starts_with(refname, "refs/notes/") ||
> +		!strcmp(refname, "refs/stash") ||
>  		!strcmp(refname, "HEAD");
>  }

This change is *not* part of creating safe-create-reflog.

It may be part of "allowing us to use safe_create_reflog() to manage
stash", but I'd imagine that a new "reflog create" command should
ignore log-all-ref-updates settings (after all, the end user is
explicitly telling us to create one by issuing a command), so I
doubt it matters if 'stash' is on the auto-create list.

>  /* This function will fill in *err and return -1 on failure */
> -int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
> +static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  	char *logfile;
> @@ -3136,7 +3137,8 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	logfile = sb_logfile->buf;
>  	/* make sure the rest of the function can't change "logfile" */
>  	sb_logfile = NULL;
> -	if (log_all_ref_updates && should_autocreate_reflog(refname)) {
> +	if (log_all_ref_updates &&
> +	    (force_create || should_autocreate_reflog(refname))) {

With this patch, force_create is used as "we are throwing you an
unusual name that do not automatically get a reflog when log-all is
set, and we are overriding that selection-by-name aspect of auto
creation" but does not defeat log-all settings.  Is that intended?

If somebody asks safe_create_reflog() to create a reflog and passes
force_create, shouldn't we create that reflog regardless of
log_all_ref_updates settings?  That is

	if (force_create || should_autocreate_reflog(refname)) {
        	... create it ...

would be more natural to read here, and you would get that for free
if 4/7 checked log_all_ref_updates in should_autocreate_reflog().
