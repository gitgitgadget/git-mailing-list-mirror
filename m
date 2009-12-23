From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads 
	within branch
Date: Wed, 23 Dec 2009 02:03:03 -0500
Message-ID: <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
References: <20091222222032.GU30538@dr-wily.mit.edu>
	 <20091222222316.GY30538@dr-wily.mit.edu>
	 <7vzl5awpf1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 08:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNLGW-0007f7-VP
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 08:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbZLWHDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2009 02:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbZLWHDK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 02:03:10 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38611 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZLWHDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 02:03:06 -0500
Received: by ewy19 with SMTP id 19so6025933ewy.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 23:03:04 -0800 (PST)
Received: by 10.216.90.9 with SMTP id d9mr3782807wef.201.1261551783880; Tue, 
	22 Dec 2009 23:03:03 -0800 (PST)
In-Reply-To: <7vzl5awpf1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135615>

On Tue, Dec 22, 2009 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0- As decoration is a fairly expensive operation (which is the r=
eason why
> =C2=A0 loading_ref_decorations() is called lazily by format_decoratio=
n() in
> =C2=A0 the first place, especially in repositories with tons of refs)=
, you
> =C2=A0 shouldn't give --format=3D%D to rev-list when the new feature =
is not
> =C2=A0 asked for.

OK, will do.


> =C2=A0- This seems to rewrite only branch heads; don't you want to al=
low users
> =C2=A0 to rewrite lightweight tags and possibly annotated ones as wel=
l, by
> =C2=A0 perhaps giving "--rewrite-refs=3Drefs/heads/" or "--rewrite-re=
fs=3Drefs/"
> =C2=A0 to limit what parts of the ref namespace to consider rewriting=
?

Sure.  I specifically left out tags because I generally think of a tag
as something immutable that it would not make sense to rewrite.  But
people use Git in different ways and it makes sense to give the option
of rewriting tags as well as heads.

I do worry that passing --rewrite-refs=3Drefs/ will set up remote refs
for rewriting, which is likely to be confusing if the user does not
notice them and remove them from the TODO.  Perhaps it makes sense to
accept forms like "--rewrite-refs=3Drefs/heads/,refs/tags/" or
"--rewrite-refs=3Drefs/heads/ --rewrite-refs=3Drefs/tags/".  Is there a
Git convention for accepting a sequence of arguments like this to an
option -- one of these, or something else?


> On the other hand, if the "partN" markers in your example workflow ar=
e
> primarily meant to be used to mark places on a branch (as opposed to
> arbitrary branch tips that independent development starting from them=
 can
> further continue), it would make a lot more sense to use lightweight =
or
> annotated tags for them, and instead of "--refs" that rewrites only o=
ther
> branch tips, it might make a lot more sense to have "--rewrite-tags" =
that
> rewrites tags that point at the commits that are rewritten, without
> touching any branch tip.

I think of them as a topic branch developing one feature, then another
branch developing a related follow-on feature, etc.  I would also feel
odd rewriting tags as a routine operation, or calling a ref a tag when
I expect to rewrite it.  So I do think they're best recorded as branch
tips rather than tags.


> Obviously the series also needs tests.

Yes.


> I also have to wonder if this feature should also handle a case like =
this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0side
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0V
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0part1 =C2=A0 * =C2=A0 =C2=A0topic
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=A0=
|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =C2=A0 / =C2=A0 =C2=A0 =C2=A0 v
> =C2=A0 =C2=A0A--*--*--*--*--*--*
> =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0B <--master
>
> =3D=3D=3D>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 side
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 V
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 *
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part1 =C2=A0 * =C2=A0 =C2=A0topic
> =C2=A0 =C2=A0 A =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=
=A0|
> =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0v =C2=A0 / =C2=A0 =C2=A0 =C2=
=A0 v
> =C2=A0 =C2=A0 =C2=A0 B--*--*--*--*--*--*
> =C2=A0 =C2=A0 =C2=A0 ^ [
> =C2=A0 =C2=A0 =C2=A0 |
> =C2=A0 =C2=A0 =C2=A0 master
>
> especially if it were to be specific to branch management.

Huh, that's an interesting idea.  I hadn't thought of that.  This
feature could be nice.  But I am not sure what it would look like.
How might the user indicate that they want both "side" and "topic" to
be rebased?  I suppose we could extend the familiar command line
   git rebase <upstream> [<branch>]
to the form
   git rebase <upstream> [...<branches>...]
so that your example would be
   $ git rebase -i --rewrite-heads master topic side
If we choose this approach, it might even be independent of
--rewrite-refs, though the implementation would presumably rely on the
"ref" command.  Was this interface what you were thinking, or do you
have another idea?

Greg
