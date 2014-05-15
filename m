From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/10] git-bisect.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:47 -0700
Message-ID: <1400163710-28333-7-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwXz-00084c-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbaEOOWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:04 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40816 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaEOOWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:22:01 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so1166261pbc.32
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYyjVRWbpe7CTLxsH7JvNHoMWSJQpNCBOviRT6iN7ko=;
        b=eMmtbnPoplDCNPI3gR8FnojHhjW+/lkFl9RlO2REZ1sU1BDTTXrMXxbutfKwg2mdbQ
         Vat+vxZx51G27QEdysZPectxsoeRSBU3D5P/DkxhEg6X1c+EIbd670C1NfA5i7JwHTtr
         WLKvaPp1uW7+VqHa9EoVHsYVrRG6vuQ4IGIyQNHPmORn2TK1GwGkKhzXJ61KosYlXUCM
         m1F4VvzUkU4C+AbtLBrNjnSTdDeKkPhy5K2haNZFKYH9/rdvSg1bphTEWbkAnGX/uNnO
         AciCH+VsxnEbtmA/rQm05RW75BRXp83CH3ANVjMGS/A7e2/MHCZm14AScAKwu1nNJrWb
         7cCw==
X-Received: by 10.68.170.131 with SMTP id am3mr12540159pbc.97.1400163720581;
        Thu, 15 May 2014 07:22:00 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.21.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:21:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249095>

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

 git-bisect.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index af4d04c..1e0d602 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -408,7 +408,7 @@ bisect_replay () {
 	bisect_reset
 	while read git bisect command rev
 	do
-		test "$git $bisect" = "git bisect" -o "$git" = "git-bisect" || continue
+		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
 		then
 			rev="$command"
-- 
1.7.10.4
