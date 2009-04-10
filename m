From: Olivier Goffart <ogoffart@kde.org>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 14:17:50 +0200
Message-ID: <200904101417.56422.ogoffart@kde.org>
References: <200903171953.23650.ogoffart@kde.org> <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3630668.f2VLjLxz5I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 14:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsFrw-00063W-Bb
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 14:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbZDJM2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 08:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933450AbZDJM2d
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 08:28:33 -0400
Received: from mx1.apinc.org ([88.191.250.15]:33068 "EHLO smtp.apinc.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756466AbZDJM2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 08:28:32 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2009 08:28:31 EDT
Received: from 19.89-10-24.nextgentel.com ([89.10.24.19] helo=[10.0.0.34])
	by smtp.apinc.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ogoffart@kde.org>)
	id 1LsFap-00013w-6N; Fri, 10 Apr 2009 14:12:23 +0200
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
Jabber-ID: ogoffart@kde.org
X-Scan-Signature: 875f8b06c29cafaff66150ada26aa42c
X-auth-smtp-user: ogoffart@apinc.org 
X-abuse-contact: apinc-admins@apinc.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116256>

--nextPart3630668.f2VLjLxz5I
Content-Type: multipart/mixed;
  boundary="Boundary-01=_vjz3JvmBVQE/ZGm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_vjz3JvmBVQE/ZGm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Tirsdag 17 mars 2009, Johannes Schindelin a =E9crit=A0:
> Hi,
>
> On Tue, 17 Mar 2009, Olivier Goffart wrote:
> > I use git in a workflow in wich we often need to edit the message logs
> > of some commits. The way we do it is using git rebase -i and choose
> > edit.  But then you need to do git commit --amend and git rebase
> > --continue, which is error prone and add more useless steps.
> >
> > The attached patch add a new keyword to git rebase interactive to just
> > edit the message log.
> >
> > I was told on IRC that this has been discussed already not so long ago,
> > and looking on the archive[1], all i seen was bikesheeding .  Here is a
> > patch :-)
>
> Unfortunately, the implementation is not the problem, but picking the best
> name.  The first letter "m" will be taken in a short while by the "merge"
> command for "rebase -i -p", so "message" is out, sadly.
>
> But the "rephrase" command will be part of the "rebase -i -p" series when
> I will finally be able to submit it.

Hi,
Sorry I'm late to reply :-)

I still think this feature to edit the message in git rebase -i is really=20
usefull.  So 'm' is really taken, what about 'r' for 'rephrase'?

or maybe 'rephrase' is something different?

Regards
=2D-=20
Olivier

--Boundary-01=_vjz3JvmBVQE/ZGm
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="rephrase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rephrase.diff"

commit 5d784b748328c7bccfddab7edba5a9dcf70518b8
Author: Olivier Goffart <ogoffart@kde.org>
Date:   Tue Mar 17 19:41:40 2009 +0100

    rebase interactive: add the possibility to easily edit the message log of commits

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 314cd36..91714d6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -406,6 +406,16 @@ do_next () {
 			die_with_patch $sha1 ""
 		fi
 		;;
+	rephrase|r)
+		comment_for_reflog message
+
+		mark_action_done
+
+		pick_one $sha1 ||
+			die_with_patch $sha1 "Could not apply $sha1... $rest"
+
+		git commit --amend || failed=t
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -754,6 +764,7 @@ first and then run 'git rebase --continue' again."
 #  p, pick = use commit
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
+#  r, rephrase = use commit and promt the editor to edit the message log
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.

--Boundary-01=_vjz3JvmBVQE/ZGm--

--nextPart3630668.f2VLjLxz5I
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBJ3zjvz58lY8jWrL0RAgQEAJ0W8YvCDS5YpyeddPl6ZX55sI1esgCfU44v
xWqnWrYMgi9tSYPFPhTheNM=
=btSN
-----END PGP SIGNATURE-----

--nextPart3630668.f2VLjLxz5I--
