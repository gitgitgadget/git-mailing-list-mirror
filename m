From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/10] contrib/examples/git-repack.sh: don't use the -a or -b option with the test command
Date: Thu, 15 May 2014 07:17:32 -0700
Message-ID: <1400163457-28285-5-git-send-email-gitter.spiros@gmail.com>
References: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:18:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwU7-0005or-BY
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbaEOOSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:18:05 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64374 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbaEOORr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:17:47 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so1129092pab.26
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YGk0e6IMc+oJzHMtiIbt6Bvg09bBmfo8aPgegZoLjxw=;
        b=Kx0KN04A/qllaWSH0T/k0zL2IbG+WABCwaHD/ozl044/HRhYXK5AyBm6ZJ1+HLYJ+n
         mh961OU8RpQE8DWUyHWs473LYevflOwuRlswX6qHmrd002/SZOeLdjPyvXpDY7te8IiC
         lrcQCKsvjJqN1C/SL9MHwf8y7toaVYFWPTZK/AnsSkciYON/X7wQE7qzHlzeUj8ESTJf
         rQkjtOdQDBsHqlvAPJAfIK81P97dwFCfeSIC7nkvwod9zwKsrvbiAAh1z6c3vOAyNHe9
         MX1xNKGqs9xN2rjezW+3e7pRU47h3gqexnMtmbiFInbsUdc7spSt2ODLkL+ICPk+U25q
         ghNA==
X-Received: by 10.68.203.39 with SMTP id kn7mr12764778pbc.141.1400163467122;
        Thu, 15 May 2014 07:17:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id as12sm21782704pac.43.2014.05.15.07.17.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:17:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249088>

Even though POSIX.1 lists -a/-o as options to "test", they are
marked "Obsolescent XSI". Scripts using these expressions
should be converted  as follow:

test "$1" -a "$2"

should be written as:

test "$1" && test "$2"

Likewise

test "$1" -o "$2"

should be written as:

test "$1"  test "$2"

But note that, in test, -a has higher precedence than -o while
"&&" and "||" have equal precedence in the shell.

The reason for this is that the precedence rules were never well
specified, and this made many sane-looking uses of "test -a/-o" problematic.

For example, if $x is "=", these work according to POSIX (it's not
portable, but in practice it's okay):

   $ test -z "$x"
   $ test -z "$x" && test a = b

but this doesn't

   $ test -z "$x" -a a = b
   bash: test: too many arguments

because it groups "test -n = -a" and is left with "a = b".

Similarly, if $x is "-f", these

   $ test "$x"
   $ test "$x" || test c = d

correctly adds an implicit "-n", but this fails:

   $ test "$x" -o c = d
   bash: test: too many arguments

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056

 contrib/examples/git-repack.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
index f312405..96e3fed 100755
--- a/contrib/examples/git-repack.sh
+++ b/contrib/examples/git-repack.sh
@@ -76,8 +76,8 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-		if test -n "$existing" -a -n "$unpack_unreachable" -a \
-			-n "$remove_redundant"
+		if test -n "$existing" && test -n "$unpack_unreachable" && \
+			test -n "$remove_redundant"
 		then
 			# This may have arbitrary user arguments, so we
 			# have to protect it against whitespace splitting
-- 
1.7.10.4
