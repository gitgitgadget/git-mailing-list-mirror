From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] Fix cogito handling of timezones
Date: Wed, 08 Jun 2005 21:40:07 -0600
Message-ID: <42A7BA17.5050707@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 09 05:37:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgDqS-0002jP-Lc
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 05:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFIDki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 23:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVFIDke
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 23:40:34 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:44041 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261594AbVFIDkX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 23:40:23 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j593e8Ho007838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2005 21:40:09 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Current cogito behavior treats the timezone offset as if it's decimal,
but most zone offsets begin with a 0.  As a result, the computation
in cg-Xlib uses the zone offset as an octal number.  -0700 looks like
4 1/2 hours offset, rather than 7, and -0800 is an invalid octal
number.

This patch fixes the behavior to strip off leading 0s.  It's ugly,
but it should produce the right values until someone with better
bash scripting skills than I can fix it.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

diff --git a/cg-Xlib b/cg-Xlib
- --- a/cg-Xlib
+++ b/cg-Xlib
@@ -6,6 +6,8 @@
 # This file provides a library containing common code shared with all the
 # Cogito programs.
 
+shopt -s extglob
+
 _cg_cmd=${0##*/}
 
 _git=${GIT_DIR:-.git}
@@ -51,8 +53,12 @@ showdate () {
 	[ "$format" ] || format=-R
 	sec=${date[0]}; tz=${date[1]}
 	if [ "$has_gnudate" ]; then
- -	        dtz=${tz/+/}
- -		lsec=$(($dtz / 100 * 3600 + $dtz % 100 * 60 + $sec))
+		sign=${tz%%[0-9]*}
+		sign=${sign:?+}
+		dtz=${tz/[+-]}
+		dtz=${dtz##*(0)}
+		dtz=${dtz:?0}
+		lsec=$(($sec + $dtz % 100 $sign $dtz / 100 * 3600))
 	        pdate="$(date -ud "1970-01-01 UTC + $lsec sec" "$format" 2>/dev/null)"
 	else
 		# FIXME: $format


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCp7oXaI0dwg4A47wRAnOFAJ4jsaQodgxOr3gp8jMYhOxuJ98GFgCgnclC
Zd68hflXn8pV39zBF4YOlUc=
=C+hn
-----END PGP SIGNATURE-----
