From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 01 May 2013 11:35:58 -0700
Message-ID: <7vppxa5z01.fsf@alter.siamese.dyndns.org>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
	<1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:36:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbst-0001hF-Du
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab3EASgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:36:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab3EASgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:36:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B47B81B7DB;
	Wed,  1 May 2013 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sWCkRk6V8G4d8Jqc5wYI3z5Elng=; b=fQyAl6gYE7jK7gm5SulB
	XAN3KnBupwp/LRfsBx9kYQ//73Ndi14I4DrMghhvNEmmjXUgvaj3PqysGjFNwM6/
	gJC8YHDYqAXEVtLGus95rtO6DBTZrXYnMsuQA050IGXchfQS3YrpHJKvN9kLy+/w
	BnHl7jtfHcMIaPpbADTrNPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XEgvSUvRR+gHvMYAcJBWDR/cf0AaSugNlWleenI0kHMgIB
	S0vqB3EJ/yXsKgCtWOSSkVuJIXGkoniN4dnW6B8w2dWyspNT1PFonNJJMvCsSu9r
	RhQaQ90ULgv4HfG0OuOqkARhF/F9O4xJepnndOjgXYb5iZ0H6q/g2yXpg2S04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8D71B7DA;
	Wed,  1 May 2013 18:36:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E712E1B7D7;
	Wed,  1 May 2013 18:35:59 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F83ED40C-B28D-11E2-9B78-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223115>

Vikrant Varma <vikrant.varma94@gmail.com> writes:

> Give better advice when trying to merge a branch that doesn't exist. If
> the branch exists in any remotes, display a list of suggestions.
>
> Example:
> 	$ git merge foo
> 	fatal: foo - not something we can merge
>
> 	Did you mean this?
> 	    bar/foo
>
> Signed-off-by: Vikrant Varma <vikrant.varma94@gmail.com>
> ---

Nicely explained.

If you step back a bit, you would notice two things.

 (1) Saying 'foo' when the user means 'origin/foo' is hardly the
     only (or even the most common) kind of mistake that the code
     you need to add to 'git merge' would encounter and could help
     the user with.  "git merge origin/mastre" and "orign/master"
     may benefit from a typofix as well, and the mechanism to come
     up with the suggestion is likely to hook to the same codepath
     you are modifying with this patch, even though the logic to
     come up with the suggested alternatives may be different.

 (2) "merge" is not the single command that user may make this kind
     of mistake the command could help and use the same helper.
     "git branch myfoo foo" may want to suggest "origin/foo", for
     example.  I just typed "git checkout mater", which could have
     been easily corrected to "git checkout master" with a mechanism
     like this.

>  help.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  help.h |  6 ++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/help.c b/help.c
> index 02ba043..faf18b9 100644
> --- a/help.c
> +++ b/help.c
> @@ -7,6 +7,7 @@
>  #include "string-list.h"
>  #include "column.h"
>  #include "version.h"
> +#include "refs.h"
>  
>  void add_cmdname(struct cmdnames *cmds, const char *name, int len)
>  {
> @@ -404,3 +405,46 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  	printf("git version %s\n", git_version_string);
>  	return 0;
>  }
> +
> +struct similar_ref_cb {
> +        const char *base_ref;
> +        struct string_list similar_refs;
> +};
> +
> +static int append_similar_ref(const char* refname, const unsigned char *sha1, int flags, void *cb_data)

An asterisk sticks to the parameter name, not type, like this:

	..._ref(const char *refname, ...

There are other places with the same style problem in this patch.

> +{
> +        int i;
> +        struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
> +        for (i = strlen(refname); refname[i] != '/'; i--)
> +	        ;

Indent with two HT, not HT followed by a run of SPs.

> +        /* A remote branch of the same name is deemed similar */
> +        if (!prefixcmp(refname, "refs/remotes/") && !strcmp(refname + i + 1, cb->base_ref))

An overlong line can and should be split, perhaps like this:

	if (!prefixcmp(... very long parameter list ...) &&
            !strcmp(... another very long parameter list ...))

> +	       	string_list_append(&(cb->similar_refs), refname + 13);

To suggest "orign/foo" => "origin/foo", "foz" => "origin/foo", and
"mastre" => "master", using levenshtein.c would help here.

You would special case the distance between "foo" and "origin/foo"
as "very low", e.g. 0, and compute levenshtein distance with refname
and cb->base_ref, store the result in the .util field of the string
list, and sort it at the end after you finish iterating using the
computed distance to come up with the list of suggestions.

> +        return 0;
> +}
> +
> +void help_unknown_ref(const char* ref) {
> +        int i;
> +        struct similar_ref_cb ref_cb;
> +        ref_cb.similar_refs = (struct string_list)STRING_LIST_INIT_NODUP;
> +        ref_cb.base_ref = ref;
> +
> +        for_each_ref(append_similar_ref, &ref_cb);
> +
> +        fprintf_ln(stderr, _("fatal: %s - not something we can merge"), ref);

When you consider the point (2) above, it becomes clear why this
message does not belong to a helper function with a bland and
generic name "help unknown ref".

This API is misdesigned.  A possible alternative that may be better
reusable would be to have a helper that is used to come up with a
list of suggestions and make the caller responsible for emitting the
error message.

> +        if (ref_cb.similar_refs.nr > 0) {
> +	        fprintf_ln(stderr,
> +		           Q_("\nDid you mean this?",
> +		              "\nDid you mean one of these?",
> +		              ref_cb.similar_refs.nr));
> +
> +	        for (i = 0; i < ref_cb.similar_refs.nr; i++)
> +		        fprintf(stderr, "\t%s\n", ref_cb.similar_refs.items[i].string);
> +        }
> +        exit(1);
> +}
> +	
> +			
> +
> +

Do not add trailing blank lines.

> diff --git a/help.h b/help.h
> index 0ae5a12..613cb45 100644
> --- a/help.h
> +++ b/help.h
> @@ -27,4 +27,10 @@ extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>  extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
>  extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
>  
> +/* 
> + * ref is not something that can be merged. Print a list of remote branches of the
> + * same name that the user might have meant. 
> + */
> +extern void help_unknown_ref(const char* ref);
> +
>  #endif /* HELP_H */
