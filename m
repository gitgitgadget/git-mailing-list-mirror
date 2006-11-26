X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Blake <ebb9@byu.net>
Subject: [patch] cg help broken when $PAGER contains space
Date: Sun, 26 Nov 2006 07:51:24 -0700
Message-ID: <4569A9EC.6080805@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 14:53:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
X-Enigmail-Version: 0.94.1.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32348>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoLNq-0007qJ-6J for gcvg-git@gmane.org; Sun, 26 Nov
 2006 15:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934372AbWKZOxT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 09:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935404AbWKZOxT
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 09:53:19 -0500
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:61874 "EHLO
 rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP id S934372AbWKZOxT
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 09:53:19 -0500
Received: from [192.168.0.103]
 (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225]) by comcast.net
 (rwcrmhc15) with ESMTP id <20061126145317m1500aouc8e>; Sun, 26 Nov 2006
 14:53:17 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With cogito 0.18.1, cg-help line 152 invokes "IFS=$'\n' colorize", which
in turn invokes the "pager" shell function from cg-Xlib with IFS set to
just a newline.  This means that if PAGER contains any spaces, the
expansion of ${PAGER:-less} within pager() will not be split, leading to
the following less-than-useful help message:

$ echo $PAGER
less -s
$ cg help
/usr/lib/cogito/cg-Xlib: line 193: less -s: command not found
$ echo $?
127

This patch fixes the problem:

2006-11-26  Eric Blake  <ebb9@byu.net>

	* cg-help: Don't change IFS when invoking pager.

diff --git a/cg-help b/cg-help
index c2d558f..f428767 100755
- --- a/cg-help
+++ b/cg-help
@@ -149,7 +149,7 @@ BRANCH_COMMANDS="$(ls "$bin_path"/cg-bra
 TAG_COMMANDS="$(ls "$bin_path"/cg-tag* | sed 's#.*/##' | tr '\n' ' ')"
 ADVANCED_COMMANDS="$(ls "$bin_path"/cg-admin-* | sed 's#.*/##' | tr '\n'
' ')"

- -IFS=$'\n' colorize <<__END__
+colorize <<__END__
 The Cogito version control system  $(cg-version)

 Available regular commands:

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFaanr84KuGfSFAYARAmfSAKCZ15/oq3rwsPyB/XLNXpUWYzQRiACfeYcC
DFw8ldbHVYs0vZtjynI3/hU=
=rR/p
