From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH v3] grep: allow -E and -n to be turned on by default via configuration
Date: Wed, 30 Mar 2011 14:31:05 -0500
Message-ID: <1301513465-15357-1-git-send-email-jratt0@gmail.com>
References: <AANLkTikpjoyPWYomKsi0YA=KrcPU2Qxn0dBgjbUi2B_x@mail.gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 21:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q517E-0005M8-Oi
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab1C3Tbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:31:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59856 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab1C3Tbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:31:34 -0400
Received: by iwn34 with SMTP id 34so1582473iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=A3Fb2zMySZsK+kT+LaVyORw/qv1USyBBOr3CSYGaGAY=;
        b=BpH783bkYj+9UJNCEQHgq2BRkU+5uLOO+GazYDAjnuB1Ngr8ozRIcj1J16r1oPaU9y
         gSGLfnVbt4xzZaoWhrGwQ5Kvq4Cte+kA9a33Vy8FN/lgAhgnn0+va4C9BAtbmuwAMouc
         +GAIQrvJKwBrLJdd2+M0V3OIUkW04h7SpTJg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OZ+WOe+lIRbfBwLTbC1XidGoCbuN68pk0Aa36PcfxOgzb3tR+qLL06CnLa/BBnStDv
         hwcilBxerpUqmpNEMFJJ3V423e4nYGTT88btVcRi5121BQOQofL7dOytbKZPL6cb2UGL
         UfMLiA0c16kQhiwjxD1GQjWRTntdqI9zNXf0s=
Received: by 10.42.138.67 with SMTP id b3mr1523295icu.490.1301513494021;
        Wed, 30 Mar 2011 12:31:34 -0700 (PDT)
Received: from localhost.localdomain ([129.42.161.50])
        by mx.google.com with ESMTPS id c1sm215345ibe.15.2011.03.30.12.31.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 12:31:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.3.gbe203
In-Reply-To: <AANLkTikpjoyPWYomKsi0YA=KrcPU2Qxn0dBgjbUi2B_x@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170411>

Add two configration variables grep.extendedRegexp and grep.lineNumbers to
allow the user to skip typing -E and -n on the command line, respectively.

Scripts that are meant to be used by random users and/or in random
repositories now have use -G and/or --no-line-number options as
appropriately to override the settings in the repository or user's
~/.gitconfig settings. Just because the script didn't say "git grep -n" no
longer guarantees that the output from the command will not have line
numbers.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

This adds 3 tests to t7810-grep.sh:
1)  git -c grep.linenumber=false grep -n  #  Expected to have line numbers
2)  git -c grep.linenumber=true  grep     #  Expected to have line numbers
3)  git -c grep.linenumber=true  grep --no-line-number  #  Expected to
have no line numbers


 Documentation/config.txt   |    6 ++++++
 Documentation/git-grep.txt |   10 ++++++++++
 builtin/grep.c             |   13 +++++++++++++
 t/t7810-grep.sh            |   24 +++++++++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 701fba9..c63458d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1092,6 +1092,12 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+grep.lineNumber::
+	If set to true, enable '-n' option by default.
+
+grep.extendedRegexp::
+	If set to true, enable '--extended-regexp' option by default.
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 791d4d4..16a0466 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -31,6 +31,16 @@ Look for specified patterns in the tracked files in the work tree, blobs
 registered in the index file, or blobs in given tree objects.
 
 
+CONFIGURATION
+-------------
+
+grep.lineNumber::
+	If set to true, enable '-n' option by default.
+
+grep.extendedRegexp::
+	If set to true, enable '--extended-regexp' option by default.
+
+
 OPTIONS
 -------
 --cached::
diff --git a/builtin/grep.c b/builtin/grep.c
index bb0f932..dcc5a76 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -302,6 +302,19 @@ static int grep_config(const char *var, const char *value, void *cb)
 	default: return 0;
 	}
 
+	if (!strcmp(var, "grep.extendedregexp")) {
+		if (git_config_bool(var, value))
+			opt->regflags |= REG_EXTENDED;
+		else
+			opt->regflags &= ~REG_EXTENDED;
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.linenumber")) {
+		opt->linenum = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
 	else if (!strcmp(var, "color.grep.context"))
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c877758..be95bb2 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -59,7 +59,29 @@ do
 			echo ${HC}file:4:foo mmap bar_mmap
 			echo ${HC}file:5:foo_mmap bar mmap baz
 		} >expected &&
-		git grep -n -w -e mmap $H >actual &&
+		git -c grep.linenumber=false grep -n -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L" '
+		{
+			echo ${HC}file:1:foo mmap bar
+			echo ${HC}file:3:foo_mmap bar mmap
+			echo ${HC}file:4:foo mmap bar_mmap
+			echo ${HC}file:5:foo_mmap bar mmap baz
+		} >expected &&
+		git -c grep.linenumber=true grep -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L" '
+		{
+			echo ${HC}file:foo mmap bar
+			echo ${HC}file:foo_mmap bar mmap
+			echo ${HC}file:foo mmap bar_mmap
+			echo ${HC}file:foo_mmap bar mmap baz
+		} >expected &&
+		git -c grep.linenumber=true grep --no-line-number -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'
 
-- 
1.7.4.1.4.g0ea33
