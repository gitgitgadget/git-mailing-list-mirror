From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [Was Re: sprintf security holes?] Building on OpenBSD
Date: Fri, 16 Sep 2005 23:36:27 +0200
Message-ID: <20050916213627.GA19867@ebar091.ebar.dtu.dk>
References: <86zmqd5aey.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 17 00:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGOEx-0006Ox-63
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 23:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVIPV6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIPV5u
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 17:57:50 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:41890 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1750713AbVIPV5o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:44 -0400
Received: (qmail 21265 invoked by uid 5842); 16 Sep 2005 21:36:27 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86zmqd5aey.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8737>

On Fri, Sep 16, 2005 at 07:56:05AM -0700, Randal L. Schwartz wrote:
> 
> As I was trying to (unsuccessfully) compile git for OpenBSD, I noticed
> a number of occurances of sprintf(), because OpenBSD thoughtfully
> yells at programmers for using that.

I've got git mostly working on OpenBSD.  Here is what I changed:

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -87,7 +87,7 @@ SCRIPT_PYTHON = \

 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
-       git-get-tar-commit-id git-mailinfo git-mailsplit git-stripspace
        \
+       git-get-tar-commit-id git-mailsplit git-stripspace \
        git-daemon git-var

 # ... and all the rest
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,7 +50,7 @@ test_expect_success \

 test_expect_success \
     'validate file modification time' \
-    'TZ=GMT tar tvf b.tar a/a |
+    'TZ=GMT gtar tvf b.tar a/a |
      awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
      >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
 

The two issues showing up are
1) missing strcasestr() which is used in mailinfo.c
2) OpenBSD tar tvf doesn't format the date as we expect.

There were talks about making a directory compat/ with system 
specific code, where an implementation of strcasestr.c could go?

With those changes all I did to compile was: 

gmake CFLAGS+='-I/usr/local/include/ -L/usr/local/lib'
gmake test
gmake install


Regards,

Peter
