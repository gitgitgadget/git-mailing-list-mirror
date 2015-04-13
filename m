From: Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH] reduce progress updates in background
Date: Tue, 14 Apr 2015 00:40:39 +1000
Message-ID: <20150413144039.GD23475@mewburn.net>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Cc: Luke Mewburn <luke@mewburn.net>
To: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 16:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhfXb-0001oY-4y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 16:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbbDMOkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 10:40:43 -0400
Received: from home.mewburn.net ([121.127.199.9]:36179 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbbDMOkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 10:40:42 -0400
Received: by home.mewburn.net (Postfix, from userid 1001)
	id E38986156C; Tue, 14 Apr 2015 00:40:39 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267083>


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 10:11:09AM -0400, Nicolas Pitre wrote:
  | What if you suspend the task and push it into the background? Would be=
=20
  | nice to inhibit progress display in that case, and resume it if the tas=
k=20
  | returns to the foreground.

That's what happens; the suppression only occurs if the process is
currently background.  If I start a long-running operation (such as "git
fsck"), the progress is displayed. I then suspend & background, and the
progress is suppressed.  If I resume the process in the foreground, the
progress starts to display again at the appropriate point.

In the proposed patch, the stop_progress display for a given progress
(i.e. the one that ends in ", done.") is displayed even if in the
background so that there's some indication of progress. E.g.
  Checking object directories: 100% (256/256), done.
  Checking objects: 100% (184664/184664), done.
  Checking connectivity: 184667, done.
This is the test 'if (is_foreground || done)'.

I'm not 100% happy with my choice here, and the simpler behaviour
of "suppress all background progress output" can be achieved by
removing '|| done' from those two tests.

That still doesn't suppress _all_ output whilst in the background.
In order to do that, a larger refactor of various warning methods
would be required. I would argue that's a separate orthoganal fix.


  | Also the display() function may be called quite a lot without=20
  | necessarily resulting in a display output. Therefore I'd suggest adding=
=20
  | in_progress_fd() to the if condition right before the printf() instead.

That's an easy enough change to make (although I speculate that the
testing of the foreground status is not that big a performance issue,
especially compared the the existing performance "overhead" of printing
the progress to stderr then forcing a flush :)


Should I submit a revised patch with
(1) call in_progress_fd() just before the fprintf() as requested, and
(2) suppress all display output including the "done" call.
?


regards,
Luke.

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUr1WcACgkQpBhtmn8zJHLhiQCgk4l4dF99xywTPLhR609Se/xY
p1cAoKofJjYxjUEI3reGw/CWaElCrkzs
=CGyz
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
