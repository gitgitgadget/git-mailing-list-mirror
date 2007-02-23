From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv3] git-fetch: Split fetch and merge logic
Date: Fri, 23 Feb 2007 11:42:05 +0100
Message-ID: <8aa486160702230242r4059811ewbc4cb5c6d33500df@mail.gmail.com>
References: <87wt29i7hg.fsf@gmail.com>
	 <7vabz56vyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 11:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKXsS-0008G5-OT
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 11:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbXBWKmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Feb 2007 05:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbXBWKmJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 05:42:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:51847 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbXBWKmH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 05:42:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so328883uga
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 02:42:06 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/fC7Wy2GZfN4hJm670lDR2hfNP2u9oq2cLhv0SBdde4422yoAhBdVt2HiyMXqTD5xhCl0PuMTglfGh1qMTUlzilORLQ0E0S7LA2fcseIfhZqrxgjZx4FY7Pj8DaHYu3kXzuKoHIGr9IGJwNF6B2JeyOUb1R+XzRasRS1dpaCXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lF1ITotxAofDEJ0+hPx0QDs17Lrt73CedqLLLwB9iTTZjEJIcjxRo2OFuuVxIQJKXxWKiDjupaUQ+mcPARe1LQkooQFxT7kMzNhsS57XqMVfVKOb5S1n+P66UB9FxoI3wBMhxkoZ+z433jxdMBdopHuxr8RQ8bEHjB9FISv1tDM=
Received: by 10.78.149.15 with SMTP id w15mr150616hud.1172227325557;
        Fri, 23 Feb 2007 02:42:05 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Fri, 23 Feb 2007 02:42:05 -0800 (PST)
In-Reply-To: <7vabz56vyq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40437>

On 2/23/07, Junio C Hamano <junkio@cox.net> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > It makes git-parse-remote.sh and almost all git-fetch independent
> > of the merge logic.
> >
> > git-fetch fetches the branches from the remote and saves this
> > information in .git/FETCH_FETCHED, and at the end it generates
> > the file .git/FETCH_HEAD.
>
> I might have some more comments after actually applying this and
> reviewing it with wider contexts, but it looks nice overall.

Thanks.

>
> I am wondering if FETCH_FETCHED is purely for internal use by
> git-fetch (it appears so), and if so if it is worth trying to do
> without the temporary file, but that is a minor detail.

Yes, it's purely internal. With "without the temporary file" you mean
to put the content in a variable or removing at the end?

> > diff --git a/git-fetch.sh b/git-fetch.sh
> > index d230995..637d732 100755
> > --- a/git-fetch.sh
> > +++ b/git-fetch.sh
> > @@ -491,3 +467,44 @@ case "$orig_head" in
> >       fi
> >       ;;
> >  esac
> > +
> > +# Generate $GIT_DIR/FETCH_HEAD
> > +case ",$#,$remote_nick," in
> > +,1,$origin,)
> > +     curr_branch=3D$(git-symbolic-ref -q HEAD | sed -e 's|^refs/he=
ads/||')
> > +     merge_branches=3D$(git-repo-config \
> > +             --get-all "branch.${curr_branch}.merge" | sort -u)
>
> Why "sort -u" (instead of erroring out if the repository is
> misconfigured)?

It is consistent with the current code and I needed it for the
intersection below. The check could be added later.

>
> > +     fetch_branches=3D$(get_remote_default_refs_for_fetch -n $remo=
te_nick |
> > +             sed 's/:.*$//g;s/^+//' | sort -u)
>
> GNU sed users do not have problems with this, but I recall that
> we had to rewrite our sed scripts not to use multiple commands
> concatenated with ';' for portability, like:
>
>         sed -e 's/:.*$//g' -e 's/^+//'

OK.

>
> Again why "sort -u"?

=46or the intersection below. Moreover, it make sense because
remotes.${remote}.fetch could be of the form:

[remote "origin"]
url=3D...
fetch=3D refs/heads/master:refs/remotes/origin/master
fetch=3D refs/heads/*:refs/remotes/origin/*

to have a well defined first refspec. In this case refs/heads/master
appears twice.

>
> > +     test "$merge_branches" && test "$fetch_branches" &&
>
> We probably would want to be defensive by saying "test -n".
>

Ok.

> > +     merge_branches=3D$(echo -e "$merge_branches\n$fetch_branches"=
 | sort | uniq -d)
>
> I appreciate the cleverness of the intersection.  However, is
> "echo -e" portable?  I think we have avoided it so far (we have
> avoided even "echo -n" which is traditionally much more
> available).

printf '%s\n%s' "$merge_branches" "$fetch_branches"

is OK?

>
> > +cat "$GIT_DIR"/FETCH_FETCHED | while IFS=3D'   ' read sha1 ref not=
e ; do
> > +     remote_branch=3D$(expr "z$ref" : 'z\([^:]*\):')
> > +     for merge_branch in $merge_branches ; do
> > +             [ "$merge_branch" =3D=3D "$remote_branch" ] &&
> > +                     echo "$sha1             $note" && continue 2
> > +     done
> > +     if ! test "$merge_first" || test "$merge_first" =3D=3D "done"=
 ; then
> > +             echo "$sha1     not-for-merge   $note"
> > +     else
> > +             echo "$sha1             $note"
> > +             merge_first=3Ddone
> > +     fi
> > +done >> "$GIT_DIR/FETCH_HEAD"
>
> You can do:
>
>         while ...
>         do
>         done < "$GIT_DIR/FETCH_FETCHED"
>
> which is easier on the eye.
>
> I often see a buggy shell script that expects assignment in a
> while loop to survive after the loop finished, when the loop is
> on the downstream side of a pipe (e.g. the loop is run in a
> subshell so merge_first after this loop is finished will never
> be 'done').  You do not use the variable after the loop so your
> script is not buggy, but avoiding a pipe into while loop is a
> good habit to get into.

OK, and thanks for the explanation.

>
> > diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> > index 5208ee6..691d46c 100755
> > --- a/git-parse-remote.sh
> > +++ b/git-parse-remote.sh
> > @@ -196,32 +159,43 @@ canon_refs_list_for_fetch () {
>
> >       config)
> > -             canon_refs_list_for_fetch -d "$1" \
> > -                     $(git-config --get-all "remote.$1.fetch") ;;
> > +             set $(expand_refs_wildcard "$1" \
> > +                     $(git-repo-config --get-all "remote.$1.fetch"=
)) ;;
>
> Oops?  It is not buggy but it's better to set an example by
> using git-config consistenty.  You have another mention of
> repo-config above.

Yes, of course.

>
> >       remotes)
> > -             canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: =
*/{
> > +             set $(expand_refs_wildcard "$1" $(sed -ne '/^Pull: */=
{
> >                                               s///p
> > -                                     }' "$GIT_DIR/remotes/$1")
> > +                                     }' "$GIT_DIR/remotes/$1"))
>
> Hmph.  I wonder why the original author did not do '/^Pull: */s///p'.=
=2E.

I don't know, I'll do.

Santi
