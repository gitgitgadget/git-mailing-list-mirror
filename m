From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also "skip"ped
Date: Fri, 27 Feb 2009 22:05:10 +0100
Message-ID: <200902272205.10501.chriscool@tuxfamily.org>
References: <20090226082918.6adbc565.chriscool@tuxfamily.org> <200902270730.56998.chriscool@tuxfamily.org> <7v3ae0mfob.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9vi-0004TV-Gb
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZB0VGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZB0VGG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:06:06 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:34028 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbZB0VGE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 16:06:04 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 7FF1C4C810D;
	Fri, 27 Feb 2009 22:05:55 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 5F9794C8097;
	Fri, 27 Feb 2009 22:05:53 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3ae0mfob.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111718>

Le vendredi 27 f=E9vrier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> >> This makes me suspect that we are forgetting
> >> to check return status after we eval the output from filter_skippe=
d
> >> function. Shouldn't the function should string its commands togeth=
er
> >> with "&&" to protect it from a breakage like this?
> >
> > Right, that would be an improvement. I put it in another patch thou=
gh,
> > because it is not really needed to fix a breakage.

Here I wanted to say that I think it fixes a separate breakage or anoth=
er=20
kind of breakage rather than not a breakage. Sorry.

> Sorry, but I have to disagree.
>
> Look at the caller of filter_skipped in bisect_next():
>
> 	eval=3D"git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
> 	eval=3D"$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
> 	eval=3D$(filter_skipped "$eval" "$skip") &&
> 	eval "$eval" || exit
>
> 	if [ -z "$bisect_rev" ]; then
> 		echo "$bad was both good and bad"
> 		exit 1
> 	fi
>
> The eval "$eval" in the middle, if failed properly upon seeing the qu=
ote
> bug, would have exited there, because "|| exit" there is all about
> catching a broken eval string.  It was not effective.

Yes, but before I introduced filter_skipped there was:

	eval=3D"git rev-list --bisect-vars $good $bad --" &&
        eval=3D"$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
	eval=3D$(eval "$eval") &&
        eval "$eval" || exit

so the output of "git rev-list --bisect-vars ..." was evaled, and this=20
output is something like that:

$ git rev-list --bisect-vars HEAD ^HEAD~3
bisect_rev=3Dc24505030fad7cc2872e0a0fd0f44e05571a0ad8
bisect_nr=3D1
bisect_good=3D0
bisect_bad=3D1
bisect_all=3D3

where there is no "&&" at the end of the commands to string them togeth=
er.
So this breakage already existed before I introduced "filter_skipped".

> You were lucky in this case that bisect_rev happens to be empty becau=
se
> the bug happened to be at the place where bisect_rev was assigned to.=
=20
> But with a random other breakage in the filter_skipped, you would not
> have been so lucky.

Yeah, I should have improved on the existing design instead of blindly=20
following it. I hope I won't get sued for that ;-)

> I think it is an integral part of the bugfix to string the commands
> filter_skipped outputs with &&, so that an error while executing an
> earlier command in the output sequence is not masked by execution of
> other commands in the output.

So you should perhaps squash the following hunk to the patch:

diff --git a/git-bisect.sh b/git-bisect.sh
index 08e31d6..980d73c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -284,7 +284,13 @@ filter_skipped() {
        _skip=3D"$2"

        if [ -z "$_skip" ]; then
-               eval "$_eval"
+               eval "$_eval" | {
+                       while read line
+                       do
+                               echo "$line &&"
+                       done
+                       echo ':'
+               }
                return
        fi

as this will string the commands together when there are no skipped com=
mits=20
too.

> Here is what I am thinking about queueing for 1.6.2; it may be necess=
ary
> to apply it to 1.6.1.X (or 1.6.0.X) and merge the fix upwards.

It looks good to me. But frankly I feel always strange when a patch lik=
e=20
this one, where you did most of the code change, get attributed to me. =
I=20
would have prefered that you added a patch attributed to you on top of =
mine=20
if possible.

Best regards,
Christian.
