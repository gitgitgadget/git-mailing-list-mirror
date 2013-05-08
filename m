From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] help: add help_unknown_ref
Date: Wed, 08 May 2013 15:49:19 -0700
Message-ID: <7vzjw5axzk.fsf@alter.siamese.dyndns.org>
References: <1367625860-20746-1-git-send-email-vikrant.varma94@gmail.com>
	<1367625860-20746-2-git-send-email-vikrant.varma94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 00:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaDB0-0008DJ-VN
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 00:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab3EHWtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 18:49:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab3EHWtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 18:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E2D01D87C;
	Wed,  8 May 2013 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=rsORPRFFcbUoe7gKfGo50mgWAG0=; b=Azc46PddKbO2m4p+V30U
	uvkE+XY7JezrO1bAbvjA5gpVxTBoK+p+jimdB5ND02BsFOEE+oUqFOm47g9yeh1u
	aSXWfiZX4HH2qGCNeKSyF7XQ8IoVCCVTnn+zDNyfSa6TyNk1KEqPH2wJlKS9Vjk/
	e5f2gfh7o5H5UzY1dUIp+B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Iz5m0TwZkMhgNnrbK6OfBWUwYHP7TknD9RfS36z11kDxS0
	ufO6WOUd2EjSphQ8+app2bOc9UnUETD4QceBLbufyFRFcOZUOcwvgBlcEM4KyGmu
	w33By2Lih93z0I2pdiFXUVyl7IJv2skTHZb1LbP2806f1H4qiXzJ283S31FEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D711D87B;
	Wed,  8 May 2013 22:49:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82C431D87A;
	Wed,  8 May 2013 22:49:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85651302-B831-11E2-82AC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223691>

Vikrant Varma <vikrant.varma94@gmail.com> writes:

> When a ref is not known, currently functions call die() with an
> error message.

The first part read somewhat awkward, so I started rewriting the
above like so:

    When the user gives an unknown string to a command that expects
    to see a ref, we could be more helpful than just saying "that's
    not a ref" and die.

which in turn made me realize that some commands may not even know
if the user mistyped a ref.  It is not an objection to this patch
per-se, but a useful future enhancement may be to allow the callers
call guess_mistyped_ref() directly and let them decide what to do
when they suspect the string they did not understand is not a
mistyped ref but something else, i.e. not let help_unknown_ref() die
unconditionally but allow it to return.  Then the caller can do:

        commit = get_commit_from_string(argv[i]);
        if (!commit) {
            ... I do not understand argv[i], but ...
            ... it may be a mistyped ref ...
            help_unknown_ref(argv[i], "expected a revision");
            ... it is not likely to be a typo ...
            ... perhaps it was meant to be a filename? ...
            if (file_exists(argv[i])) {
                ... yes! ...
                ... do the "file" thing instead ...
            }
        }

> Add helper function help_unknown_ref to take care of displaying an
> error message along with a list of suggested refs the user might
> have meant.

OK.

> Example:
> 	$ git merge foo
> 	merge: foo - not something we can merge

That leading "merge: " looks somewhat strange, especially when it
immediately follows the command line to invoke "merge", making it
appear to waste space by stating the obvious.

Our messages are generally marked with "error:", "fatal:",
"warning:", etc. at the beginning.

>
> 	Did you mean one of these?
> 	    origin/foo
> 	    upstream/foo
>
> Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>

> ...
> +struct string_list guess_refs(const char *ref)
> +{
> +	struct similar_ref_cb ref_cb;
> +	struct string_list similar_refs = STRING_LIST_INIT_NODUP;
> +
> +	ref_cb.base_ref = ref;
> +	ref_cb.similar_refs = &similar_refs;
> +	for_each_ref(append_similar_ref, &ref_cb);
> +	return similar_refs;
> +}
> +
> +void help_unknown_ref(const char *ref, const char *cmd, const char *error)
> +{
> +	int i;
> +	struct string_list suggested_refs = guess_refs(ref);
> +
> +	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
> +
> +	if (suggested_refs.nr > 0) {
> +		fprintf_ln(stderr,
> +			   Q_("\nDid you mean this?",
> +			      "\nDid you mean one of these?",
> +			      suggested_refs.nr));
> +		for (i = 0; i < suggested_refs.nr; i++)
> +			fprintf(stderr, "\t%s\n", suggested_refs.items[i].string);
> +	}
> +
> +	string_list_clear(&suggested_refs, 0);
> +	exit(1);
> +}

Looks sensible.

> diff --git a/help.h b/help.h
> index 0ae5a12..5003423 100644
> --- a/help.h
> +++ b/help.h
> @@ -27,4 +27,9 @@ extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>  extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
>  extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
>  
> +/*
> + * This function has been called because ref is not known.
> + * Print a list of refs that the user might have meant, and exit.
> + */

The wording is a bit funny; I'll amend it somehow before queuing.

> +extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
>  #endif /* HELP_H */
