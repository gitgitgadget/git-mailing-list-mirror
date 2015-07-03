From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/4] log: add --count option to git log
Date: Fri, 03 Jul 2015 09:29:47 +0200
Message-ID: <vpqa8vd66ms.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-3-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 09:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAvQ5-0000wx-UF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 09:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbbGCH3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 03:29:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34569 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858AbbGCH3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 03:29:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t637Tksl018637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 09:29:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t637Tl7r022725;
	Fri, 3 Jul 2015 09:29:47 +0200
In-Reply-To: <1435881011-13879-3-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Thu, 2 Jul 2015 16:50:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Jul 2015 09:29:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t637Tksl018637
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436513387.08163@vFnZBHUuzfIvnfRLa+Kqqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273282>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> +static void show_object(struct object *obj,
> +			const struct name_path *path, const char *component,
> +			void *cb_data)
> +{
> +	return;
> +}

It seems streange to me to have a function named show_object when it
does not show anything. Maybe name it null_travers_cb to make it clear
it's a callback and it does nothing?

Not a strong objection though, it's only a static function.

> +static void show_commit(struct commit *commit, void *data)
> +{
> +	struct rev_info *revs = (struct rev_info *)data;
> +	if (commit->object.flags & PATCHSAME)
> +		revs->count_same++;
> +	else if (commit->object.flags & SYMMETRIC_LEFT)
> +		revs->count_left++;
> +	else
> +		revs->count_right++;
> +	if (commit->parents) {
> +		free_commit_list(commit->parents);
> +		commit->parents = NULL;
> +	}
> +	free_commit_buffer(commit);
> +}
> +
>  static int cmd_log_walk(struct rev_info *rev)
>  {
>  	struct commit *commit;
>  	int saved_nrl = 0;
>  	int saved_dcctc = 0;
>  
> +	if (rev->count) {
> +		prepare_revision_walk(rev);
> +		traverse_commit_list(rev, show_commit, show_object, rev);
> +		get_commit_count(rev);
> +	}

I didn't test, but it seems this does a full graph traversal before
starting the output. A very important property of "git log" is that it
starts showing revisions immediately, even when ran on a very long
history (it shows the first screen immediately and continues working in
the background while the first page is displayed in the pager).

Is it the case? If so, it should be changed. If not, perhaps explain why
in the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
