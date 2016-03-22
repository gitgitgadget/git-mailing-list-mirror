From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Tue, 22 Mar 2016 10:07:39 -0700
Message-ID: <xmqq1t72jvac.fsf@gitster.mtv.corp.google.com>
References: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:07:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPmV-0002cq-6m
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbcCVRHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:07:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbcCVRHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:07:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 323954DFB9;
	Tue, 22 Mar 2016 13:07:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r1zMXSdWDh8ba6q86vGC3axptqQ=; b=MWnTDj
	DXtIGIJKzZHZR8korGcLRtFVUMW+yyvkN9hMIptDJxrvdj0YmXB18zzR8NvCymjs
	eQkFToCRIIZWYabNBYOlswJV1cUfTR2r8pBqzhCnPdkbaGWjm5t0yKRmLB2knNg6
	R5xGheWmGCw3ZrGlOWfMhipD/OXZHriZnB7I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dt3kwUmvFreeZ9II8DWYRUrU4OnC8ofF
	XNQYTG+osEUo45JCc2xbj7efGC55b9XTeZ0jYwdgvOpDlwMcBDI+P1DRYodXpaEi
	8uOMiu1OEGaWOrlHpMJq2oDUBiEM10iFIa0ecxghrjS2tYzWW2yHE6AtrMPxw+n1
	uTJKTS3Dwj0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28E0B4DFAC;
	Tue, 22 Mar 2016 13:07:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CB3C4DFA8;
	Tue, 22 Mar 2016 13:07:40 -0400 (EDT)
In-Reply-To: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
	(Elena Petrashen's message of "Tue, 22 Mar 2016 11:24:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95D62D3E-F050-11E5-9BC3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289517>

Elena Petrashen <elena.petrashen@gmail.com> writes:

> +static int expand_dash_shortcut(const char **argv, int dash_position)
> +{
> +	if (!strcmp(argv[dash_position], "-")){
> +		argv[dash_position] = "@{-1}";
> +		return 1;
> +	}
> +	return 0;
> +}
>  	int i;
>  	int ret = 0;
> +	int dash_shortcut = 0;
>  	int remote_branch = 0;
>  	struct strbuf bname = STRBUF_INIT;
>  
> @@ -213,7 +223,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
>  		const char *target;
>  		int flags = 0;
> -
> +		if (expand_dash_shortcut (argv, i))
> +			dash_shortcut = 1;
>  		strbuf_branchname(&bname, argv[i]);

I think this code special cases "-" too much.  Have you considered
doing this without "dash_shortcut" variable?  With that variable,
your code says "there is no previous" when the user says "-", but
isn't that message also appropriate when she says "@{-1}" on the
command line?  Furthermore, wouldn't the same apply to the case in
which she said "@{-4}"?

I suspect that you can check that condition immediately after
calling expand-dash-shortcut and then strbuf-branchname, in other
words, right here.  And if there is not enough branch switches, you
can say something like "you gave me @{-4} but you haven't made that
many branch switches" and continue the loop.

I _think_ strbuf_branchname() leaves "@{-<N>}" when you do not have
enough branch switches in the reflog, so perhaps

	strbuf_branchname(&bname, (!strcmp(argv[i], "-") ? "@{-1}" : argv[i]));
	if (starts_with(bname.buf, "@{-")) {
		... say "you do not have enough branch switches" here.
		... when adjusting the message to end-user input,
		... you can look at argv[i] to notice that the original
                ... input was "-".
		error(...);
		continue;
	}

or something?

That way, there is no change necessary below this line, i.e. from
here...

>  		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
>  			error(_("Cannot delete the branch '%s' "
> @@ -231,9 +242,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  					    | RESOLVE_REF_ALLOW_BAD_NAME,
>  					    sha1, &flags);
>  		if (!target) {
> -			error(remote_branch
> -			      ? _("remote-tracking branch '%s' not found.")
> -			      : _("branch '%s' not found."), bname.buf);
> +			error(dash_shortcut
> +				? _("There is no previous branch that could be"
> +					" referred to at the moment.")
> +				: remote_branch
> +					? _("remote-tracking branch '%s' not found.")
> +					: _("branch '%s' not found."), bname.buf);
>  			ret = 1;
>  			continue;
>  		}
> @@ -262,6 +276,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  			       (flags & REF_ISBROKEN) ? "broken"
>  			       : (flags & REF_ISSYMREF) ? target
>  			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));

... to here.


> +			if (dash_shortcut == 1)
> +			       printf( _("\nIf that happened by mistake, you may want to restore"
> +				" it with:\n\ngit branch %s %s\n"), bname.buf,
> +				find_unique_abbrev(sha1, DEFAULT_ABBREV));

This change can be justified only if we believe that people who say

    $ git branch -D -

by mistake are much less clueful than those who say

    $ git branch -D @{-1}
    $ git branch -D a-misspelled-branch-name

by mistake and need extra help recovering.  Is there an evidence to
support such an assumption?

I would actually understand it if this were more like

	if (advice_mistaken_branch_deletion)
        	printf(_("If you deleted the branch by mistake, you can..."));

so that everybody who ran "git branch -D" on a (wrong) branch by
mistake can get the extra help.
