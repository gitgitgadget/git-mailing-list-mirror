From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Wed, 17 Jan 2007 09:32:51 -0800
Message-ID: <7vps9dsgn0.fsf@assigned-by-dhcp.cox.net>
References: <20070116150259.GA2439@cepheus>
	<Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070116162645.GA18894@informatik.uni-freiburg.de>
	<20070116200847.GB29100@spearce.org>
	<Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070117164410.GA5950@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 17 18:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Eet-0003ib-3m
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 18:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbXAQRdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 12:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbXAQRdA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 12:33:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56456 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXAQRc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jan 2007 12:32:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117173253.XMEU20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 12:32:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CHZ91W00Z1kojtg0000000; Wed, 17 Jan 2007 12:33:10 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20070117164410.GA5950@cepheus> (Uwe =?iso-8859-1?Q?Kleine-K?=
 =?iso-8859-1?Q?=F6nig's?= message of
	"Wed, 17 Jan 2007 17:44:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37017>

Uwe Kleine-K=F6nig  <zeisberg@informatik.uni-freiburg.de> writes:

> I tried to do the symmetric part for fetch, but that shell script is =
too
> complicated for me and so I let this part to s.o. being more familiar
> with git-fetch.sh.

I do not know what s.o. is but something like this untested
patch would do.

I do not have strong objection to the configuration on the push
side, but I am not sure if we want to call it pushexec -- it is
naming receive-pack so remote.*.receivepack might be more
appropriate, just in case we update the fetch/push protocol
someday to run more than one program on the other end.


diff --git a/git-fetch.sh b/git-fetch.sh
index 87b940b..7372c5f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -82,6 +82,13 @@ case "$#" in
 	set x $origin ; shift ;;
 esac
=20
+if test -z "$exec" && exec=3D$(git-repo-config "remote.$1.uploadpack")
+then
+	# No command line override and we have configuration for the remote.
+	upload_pack=3D"-u $exec"
+	exec=3D"--exec=3D$exec"
+fi
+
 remote_nick=3D"$1"
 remote=3D$(get_remote_url "$@")
 refs=3D
