From: Thomas Rast <trast@student.ethz.ch>
Subject: O(#haves*...) behaviour in "have <sha>" processing in upload-pack
Date: Sat, 13 Sep 2008 02:11:07 +0200
Message-ID: <200809130211.14091.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3517746.OAFJuZcvOv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 02:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeIku-0004K0-IT
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 02:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758801AbYIMALV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 20:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbYIMALU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 20:11:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:13928 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759087AbYIMALT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 20:11:19 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 02:11:17 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 02:11:17 +0200
User-Agent: KMail/1.9.9
X-OriginalArrivalTime: 13 Sep 2008 00:11:17.0185 (UTC) FILETIME=[3DD8FB10:01C91535]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95787>

--nextPart3517746.OAFJuZcvOv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi *

evilchelu (Cristi Balan) pointed out on IRC that 'git fetch' takes a
long time when fetching a history-disjoint repository.

=46or example,

  mkdir test && cd test
  git init
  git remote add -f paperclip git://github.com/thoughtbot/paperclip.git
  git remote add -f hoptoad git://github.com/thoughtbot/hoptoad_notifier.git
  git remote add -f aasm git://github.com/rubyist/aasm.git
  git remote add -f forgot git://github.com/greenisus/forgot_password.git
  git remote add -f restful git://github.com/technoweenie/restful-authentic=
ation.git

(taken straight from evilchelu's example, but it should be the same
with random repositories).

Peeking at the transmission with Wireshark, there is a noticeable
pattern of 4-5s delays before _every_ "0008NAK\n" line sent by the
server.

Looking at upload-pack.c, it seems that the server does far too much
work when processing the "have" lines.  I've only just read into this
area of code, but the rough idea seems to be:

  [404: get_common_commits()]
  for (H =3D every "have" line) {

      [321: got_sha1()]
      flag H and its parents (shallow!) as THEY_HAVE

      [415: get_common_commits()]
      if (we do not have H in our object store) {

          [367: ok_to_give_up()]
          for (W =3D every "want" object specified earlier) {

              [338: reachable()]
              walk the entire history to see if anything flagged
              THEY_HAVE so far is reachable from W

          }

          [418: get_common_commits()]
          if the innermost test succeeded for all W: ACK this H so the
          client stops walking history from it
      }
  }

The entire loop seems to have O(h*w*n) (n=3Dhistory) complexity, which
probably is to blame for the delays.

* Isn't this ok_to_give_up() test moot?  If H is not in our object
  store, it cannot be of any use in the transfer (of our history to
  the client).  So if we are going to fake an ACK to stop the client
  digging on this side of his history, we might as well send it right
  away.  (And what does reaching a THEY_HAVE commit from all W's have
  to do with it?)

* Even assuming it is not, it would save some work if the server
  avoided walking the entire history for every H.  For example, it
  could buffer up all H's until a "0000\n" arrives, which currently
  seems to be 32 haves, then check all of them in a single pass over
  history.  (Unfortunately the 'h' factor cannot be removed completely
  unless we buffer all of them, which again defeats the point.)

Much of the code in question was added in 937a515 (upload-pack: stop
the other side when they have more roots than we do., 2006-07-05).

[I hope I'm making some sense, it's far too late here, but it was
either this or trying to understand it again in the morning.]

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch





--nextPart3517746.OAFJuZcvOv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjLBSIACgkQqUud07tmzP3lpACfT7xNdEPp64zYwV4MbAlOVj/T
OXQAn2pE7mYRbLQgH+vJSdtPe4dt0fpF
=Iidb
-----END PGP SIGNATURE-----

--nextPart3517746.OAFJuZcvOv--
