From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 06/11] branch: roll show_detached HEAD into regular ref_list
Date: Tue, 28 Jul 2015 15:01:16 +0200
Message-ID: <vpqlhe0xwpv.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK4Vi-0007T3-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 15:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbbG1NBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 09:01:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46549 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbbG1NB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 09:01:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SD1F2C029385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 15:01:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SD1GYl031973;
	Tue, 28 Jul 2015 15:01:16 +0200
In-Reply-To: <1438066594-5620-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 15:01:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SD1F2C029385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438693276.01355@jH2ZHuBkEO2YL8CUYNUpYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274768>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove show_detached() and make detached HEAD to be rolled into
> regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
> supporting the same in append_ref().

Again, this lacks the "why?" explanation.

> Bump get_head_description() to the top.

Here also: why? And this could easily go to a separate patch to let the
reviewer focus on actual changes.

> @@ -504,6 +540,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  	int color;
>  	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>  	const char *prefix = "";
> +	const char *desc = item->name;
>  
>  	if (item->ignore)
>  		return;
> @@ -516,6 +553,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  		color = BRANCH_COLOR_REMOTE;
>  		prefix = remote_prefix;
>  		break;
> +	case REF_DETACHED_HEAD:
> +		color = BRANCH_COLOR_CURRENT;
> +		desc = get_head_description();

I think you're leaking a string here: get_head_description() builds an
strbuf and returns the dynamically allocated string, which you never
free.

> -static void show_detached(struct ref_list *ref_list, int maxwidth)
> -{
> -	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
> -
> -	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {

I'm not sure what this if was doing, and why you can get rid of it. My
understanding is that with_commit comes from --contains, and in the
previous code the filtering was done at display time (detached HEAD was
not shown if it was not contained in commits specified with --contains).

Eventually, you'll use ref-filter to do this filtering so you won't need
this check at display time.

But am I correct that for a few commits, you ignore --contains on
detached HEAD?

> @@ -678,15 +674,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  	if (verbose)
>  		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>  
> -	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
> +	index = ref_list.index;
> +
> +	/* Print detached heads before sorting and printing the rest */

I think you mean head (no s) or HEAD. It's not Mercurial ;-).

> +	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
> +	    !strcmp(ref_list.list[index - 1].name, head)) {
> +		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
> +			       1, remote_prefix);
> +		index -= 1;
> +	}

This relies on the assumption that HEAD has to be the last in the array.
The assumption is correct since you call head_ref(append_ref, &cb) after
for_each_rawref(append_ref, &cb). I think this deserves a comment to
remind the reader that HEAD is always the last (here or at the call to
head_ref to make sure nobody try to change the order between head_ref
and for_each_rawref).

It may be more natural to do it the other way around: call head_ref
first and get HEAD first, as you are going to display it first (but in
any case, you'll have to call qsort on a subset of the array so it
doesn't change much).

> @@ -913,7 +914,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("branch name required"));
>  		return delete_branches(argc, argv, delete > 1, kinds, quiet);
>  	} else if (list) {
> -		int ret = print_ref_list(kinds, detached, verbose, abbrev,
> +		int ret;
> +		if (kinds & REF_LOCAL_BRANCH)
> +			kinds |= REF_DETACHED_HEAD;

Perhaps add

	/* git branch --local also shows HEAD when it is detached */

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
