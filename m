From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add option -L to git-tag.
Date: Sat, 02 Jun 2007 03:10:46 -0700
Message-ID: <7vfy5avf89.fsf@assigned-by-dhcp.cox.net>
References: <1180773465209-git-send-email-mmelchior@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Melchior <mmelchior@xs4all.nl>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuQZW-0002sF-2j
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 12:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXFBKKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXFBKKt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 06:10:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65269 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbXFBKKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 06:10:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602101047.SFMZ22318.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Jun 2007 06:10:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6aAm1X0041kojtg0000000; Sat, 02 Jun 2007 06:10:47 -0400
In-Reply-To: <1180773465209-git-send-email-mmelchior@xs4all.nl> (Matthijs
	Melchior's message of "Sat, 2 Jun 2007 10:37:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48920>

Matthijs Melchior <mmelchior@xs4all.nl> writes:

>   This will list the selected tags and include annotations, if any.
>
> Signed-off-by: Matthijs Melchior <mmelchior@xs4all.nl>
> ---
>
> This patch has been created to allow me to easily see the annotations with tags.
> I have not found any other way to do this...

Hmmmm.  This feature ought to belong to git-show, but that
command already has its own interpretation of how a tag should
be shown.

Do we care about the "one line summary"?  Perhaps...

	$ git tag --pretty=short -L v2.6.11-tree
	v2.6.11-tree
            This is the 2.6.11 tree object.

	$ git tag -L v2.6.11-tree
	v2.6.11-tree
            This is the 2.6.11 tree object.

	    NOTE! There's no commit for this, since it happened...

The answer to this question would really depend on why we would
want to have this feature.  "git-tag" started as a way to
"create", and then it gained -l to "list" and -v to "verify".  I
think your -L is meant to be an extension to "list", but I
suspect that while you are listing many things you would keep
the annotation short-and-sweet, and you would want to view the
full description when your interest is focused at a single one.
Maybe we would want a separate "print" action for the full
contents and use the short one for "list but more verbosely than
usual"?

I dunno; I've never been very good at the user interfaces.

>  - Sorting the tag names resulting from git-rev-parse is not nessecary since
>    the list of tags is already deliverd in sorted order.

This I am a bit reluctant about, as that sorting done by
rev-parse is purely by accident (i.e. it is an implementation
detail).

>  - Using git-cat-file -t on every tag is expensive, but there is no alternative

This is Ok, as we have somebody working on doing git-tag as a
built-in, and once that happens, we do not have to pay the
performance penalty.  So I would think at this point we should
concentrate on discussing the usefulness of this new feature and
correctness of your implementation, as that would set the course
for the future.  On the other hand, "cat-file -t" performance
issues will not stay with us forever.

> @@ -26,13 +26,23 @@ do
>      -f)
>  	force=1
>  	;;
> -    -l)
> -	case "$#" in
> -	1)
> -		set x . ;;
> -	esac
> +    -l|-L)
> +	TAGSONLY=true
> +	[ "$1" = -L ] && TAGSONLY=false
> +	[ "$#" = 1 ] && set x .
>  	shift
> +	git rev-parse --symbolic --tags | grep "$@" |
> +	    while read TAG
> +	    do
> +		echo "$TAG"
> +		$TAGSONLY && continue
> +		OBJTYPE=$(git cat-file -t "$TAG")
> +		case $OBJTYPE in
> +		    tag)    git cat-file $OBJTYPE "$TAG" |
> +				sed '1,/^$/d;/^-----BEGIN PGP SIGNATURE-----$/Q;s/^/    /'
> +			    ;;
> +		esac

Micronit.  If you already know it is a tag, you do not have to
say "cat-file $OBJTYPE".

Style.  Please indent the case arm to the same level as, not
deeper than, case/esac.
This is the same as C's switch() { case ...: } indentation rule.

Please do not feed multiple expressions concatenated with
semicolon to sed, as it is one of the often observed portability
issues (not all the world is GNU yet).  Write it like this
instead:

        case "$OBJTYPE" in
        tag)
                git cat-file tag "$TAG" |
                sed -e '1,/^$/d' \
                    -e '/^-----BEGIN PGP SIGNATURE-----$/Q' \
                    -e s/^/    /'
                ;;
        esac

> +	    done
>  	exit $?

What does this command exit with now?  It used to be that

	$ git tag -l no-such-tag-at-all ; echo $?

said "1", I think, because grep did not match.
