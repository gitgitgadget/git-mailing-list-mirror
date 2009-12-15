From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Tue, 15 Dec 2009 20:41:35 +0100
Message-ID: <200912152041.36194.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org> <20091212043259.3930.98779.chriscool@tuxfamily.org> <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 20:39:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdEr-0001xR-DG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 20:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbZLOTjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZLOTjJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 14:39:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:35311 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbZLOTjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2009 14:39:08 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1C389818068;
	Tue, 15 Dec 2009 20:38:56 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C245281811F;
	Tue, 15 Dec 2009 20:38:53 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135294>

On samedi 12 d=E9cembre 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > It is strange and fragile that a mixed reset is disallowed in a bar=
e
> > repo but is allowed in a .git dir. So this patch simplifies things
> > by only allowing soft resets when not in a working tree.
>
> I would not mind what you said were "I find the difference strange", =
as
> it is a fairly subjective word.  But if you say "fragile", you would =
need
> to defend the use of the word better.  What kind of misuse does it
> invite, and what grave consequences such misuses would cause?  I do n=
ot
> see any fragility and I would want to understand it better so that I =
can
> write about it in the Release Note to warn people and encourage them =
to
> upgrade.
>
> More importantly, I think the difference between the two actually mak=
es
> sense.  A bare repository by definition does _not_ have any work tree=
 so
> there is no point in having the index file in there.  On the other ha=
nd,
> even though it is not necessary to "cd .git && git reset HEAD^", I do=
n't
> see a strong reason why it needs to be disallowed.

Ok. I have the following patch now:

---------- 8< ---------------
commit c20f969db6e565f2fe854b95202c3ef95ad0ff42
Author: Christian Couder <chriscool@tuxfamily.org>
Date:   Thu Dec 10 22:10:07 2009 +0100

    reset: improve mixed reset error message when in a bare repo

    When running a "git reset --mixed" in a bare repository, the
    message displayed is:

    fatal: This operation must be run in a work tree
    fatal: Could not reset index file to revision 'HEAD^'.

    This message is a little bit misleading as a mixed reset is ok in
    a git directory, so it is not absolutely needed to run it in a
    work tree.

    So this patch improves upon the above by changing the message to:

    fatal: mixed reset is not allowed in a bare repository

    This patch is also needed to speed up "git reset" by using
    unpack_tree() directly (instead of execing "git read-tree"). A
    following patch will do just that.

    While at it, instead of disallowing "git reset --option" outside
    a work tree only when option is "hard" or "merge", we now disallow
    it except when option is "soft" or "mixed", as it is safer if we
    ever add options to "git reset".

diff --git a/builtin-reset.c b/builtin-reset.c
index 11d1c6e..ac3505b 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -286,11 +286,15 @@ int cmd_reset(int argc, const char **argv, const =
char=20
*pre
        if (reset_type =3D=3D NONE)
                reset_type =3D MIXED; /* by default */

-       if ((reset_type =3D=3D HARD || reset_type =3D=3D MERGE)
-           && !is_inside_work_tree())
+       if (reset_type !=3D SOFT && reset_type !=3D MIXED
+            && !is_inside_work_tree())
                die("%s reset requires a work tree",
                    reset_type_names[reset_type]);

+       if (reset_type =3D=3D MIXED && is_bare_repository())
+               die("%s reset is not allowed in a bare repository",
+                   reset_type_names[reset_type]);
+
        /* Soft reset does not touch the index file nor the working tre=
e
         * at all, but requires them in a good order.  Other resets res=
et
         * the index file to the tree object we are switching to. */
---------- 8< ---------------

> On the other hand, I don't see a strong reason why such a use needs t=
o be
> supported, other than "we've allowed it for a long time, and people m=
ay
> have hooks (they typically start in $GIT_DIR) that rely on it", which=
 by
> itself is not something strong enough to veto the change.  It is only=
 a
> minor incompatibility and I can be persuaded to listen to a pros-and-=
cons
> argument.
>
> An honest justification might have been "This change to disallow a mi=
xed
> reset in $GIT_DIR of a repository with a work tree will break existin=
g
> scripts, but I think it is not widely used _for such and such reasons=
_,
> and can easily be worked around.  On the other hand, this change vast=
ly
> simplifies the reimplementation of 'reset' _because X and Y and Z_".

My opinion is that it works this way just by accident not by design (th=
at's=20
why I said "fragile"). But if we don't want to take any risk of regress=
ion,=20
then let's use the new patch above.

> > This patch is also needed to speed up "git reset" by using
> > unpack_tree() directly (instead of execing "git read-tree").
>
> It is very unclear _why_ it is "needed" from this description.

The reason is that after the next patch, it will not fail in a bare=20
repository, so if we don't change anything, the test that checks that i=
t=20
fails in a bare repo will fail. I will add this explanation to the new=20
patch.

Best regards,
Christian.
