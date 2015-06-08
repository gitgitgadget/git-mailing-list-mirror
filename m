From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] bisect: add the terms old/new
Date: Mon, 08 Jun 2015 14:21:18 -0700
Message-ID: <xmqqmw0999rl.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z24U1-0001wP-TE
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 23:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbFHVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 17:21:22 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36671 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbFHVVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 17:21:20 -0400
Received: by ieclw1 with SMTP id lw1so2072106iec.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MxhRyj4kwuER5D0pvcH2Ls8XOzPngV9pdgZIICaIkw8=;
        b=wVMlA7JX0gFiqjoSTgCA+BHy4/hZwAjVpHpKbkIyLET6xjcUxPWz2AOg+0/kk5kf1t
         fUdDwC5HQf+6/0FgH2HU18+J4JUXuBQIv1oT5wJlVNjgp44Y2jjK/U7cfsAXG/3HXpxI
         eojQrNdqI7xwJjfdDl+y/W/ZM8+lh4D/JSxNU8sIrwqYVwDY7a/1k7Bh9o7TkuQVlYPo
         clzQqSMVBRD5/4PEhfJOziRKzrsGtaD77YX7zPEQHWxJeDJsN4619bLAhqoZQLO458qL
         Bqs18/bi/Ez+Osirq5CqkcDn/fLWY4va3aGpUio89YOB68ETw5yCvLH5itW9zxji2+xf
         0Nzw==
X-Received: by 10.42.154.5 with SMTP id o5mr14020656icw.60.1433798479803;
        Mon, 08 Jun 2015 14:21:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id l1sm2554824ioe.32.2015.06.08.14.21.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 14:21:19 -0700 (PDT)
In-Reply-To: <1433794930-5158-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 8 Jun 2015 22:22:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271135>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> When not looking for a regression during a bisect but for a fix or a
> change in another given property, it can be confusing to use 'good'
> and 'bad'.
>
> This patch introduce `git bisect new` and `git bisect old` as an
> alternative to 'bad' and good': the commits which have a certain
> property must be marked as `new` and the ones which do not as `old`.
>
> The output will be the first commit after the change in the property.
> During a new/old bisect session you cannot use bad/good commands and
> vice-versa.
>
> `git bisect replay` works fine for old/new bisect sessions.
>
> Some commands are still not available for old/new:
>
>      * git bisect start [<new> [<old>...]] is not possible: the
>        commits will be treated as bad and good.

Just throwing a suggestion.  You could perhaps add a new verb to be
used before starting to do anything, e.g.

	$ git bisect terms new old

(where the default mode is "git bisect terms bad good") to set up
the "terms", and then after that

	$ git bisect start $new $old1 $old2...

would be treated as you would naturally expect, no?


>      * git rev-list --bisect does not treat the revs/bisect/new and
>        revs/bisect/old-SHA1 files.

That shouldn't be hard to add, I would imagine, either by

	git rev-list --bisect=new,old

or teaching "git rev-list --bisect" to read the "terms" itself, as a
follow-up patch.

>      * git bisect visualize seem to work partially: the tags are
>        displayed correctly but the tree is not limited to the bisect
>        section.

This is directly related to the lack of "git rev-list --bisect"
support, I would imagine.  If you make the command read "terms", I
suspect that it would solve itself.

> @@ -379,6 +408,21 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
>  has at least one parent whose reachable graph is fully traversable in the sense
>  required by 'git pack objects'.
>  
> +* Look for a fix instead of a regression in the code
> ++
> +------------
> +$ git bisect start
> +$ git bisect new HEAD    # current commit is marked as new
> +$ git bisect old HEAD~10 # the tenth commit from now is marked as old
> +------------
> ++
> +If the last commit has a given property, and we are looking for the commit
> +which introduced this property.

Hmph, that is not a complete sentence and I cannot understand what
it is trying to say.

> +For each commit the bisection guide us to we

s/guide us to we/guides us to, we/;

> +will test if the property is present, if it is we will mark the commit as new
> +with 'git bisect new', otherwise we will mark it as old.

It would be easier to read as separate sentences, i.e.

s/is present, if it is/is present. If it is/;

> diff --git a/bisect.c b/bisect.c
> index 3b7df85..511b905 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -409,7 +409,8 @@ static int register_ref(const char *refname, const unsigned char *sha1,
>  	if (!strcmp(refname, name_bad)) {
>  		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
>  		hashcpy(current_bad_oid->hash, sha1);
> -	} else if (starts_with(refname, "good-")) {
> +	} else if (starts_with(refname, "good-") ||
> +		   starts_with(refname, "old-")) {
>  		sha1_array_append(&good_revs, sha1);
>  	} else if (starts_with(refname, "skip-")) {
>  		sha1_array_append(&skipped_revs, sha1);
> @@ -741,6 +742,12 @@ static void handle_bad_merge_base(void)
>  				"between %s and [%s].\n",
>  				bad_hex, bad_hex, good_hex);
>  		}
> +		else if (!strcmp(name_bad, "new")) {
> +			fprintf(stderr, "The merge base %s is new.\n"
> +				"The property has changed "
> +				"between %s and [%s].\n",
> +				bad_hex, bad_hex, good_hex);
> +		}

After reading the previous patches in the series, I expected that
this new code would know to read "terms" and does not limit us only
to "new" and "old".  Somewhat disappointing.

> @@ -439,7 +441,7 @@ bisect_replay () {
>  		start)
>  			cmd="bisect_start $rev"
>  			eval "$cmd" ;;
> -		good|bad|skip)
> +		good|bad|skip|old|new)

Not NAME_GOOD / NAME_BAD?

To support replay, you may want to consider the "bisect terms"
approach and when the bisection is using non-standard terms record
that as the first entry to the bisect log.
