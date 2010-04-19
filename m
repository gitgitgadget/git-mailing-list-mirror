From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t0001: check syntax of sample hooks
Date: Mon, 19 Apr 2010 03:41:33 -0500
Message-ID: <20100419084132.GA25901@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 10:41:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mXt-0002WO-V3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab0DSIl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:41:28 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:53149 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0DSIl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:41:28 -0400
Received: by pzk15 with SMTP id 15so2276942pzk.15
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=xMTfhxE1Mj6G/Cg2wTCVmv7KxX2cKLyYilKcu9Idm3c=;
        b=OvAflT+hdJw8TQStiKJ3VOdXdeMTpt0T/dmL8g3tGgjtdHJpzSJAxUIhpxLgnNoZKl
         4VGUFbAbjfx9xr5ib8vZmmVRrwNfgAgjkE0wd9MNwK7o1Srk8yzzmP0XdksSS44qgbfA
         3e9u3PG/kzdMbQfEzB8hlqN9TsxQkJKMsxeAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=lrOyimSYfY/JccHEc7bMWeGoKR3uUUDdn0iq4H3/jfEcHj2znXG1NuyAlv7w4wmeIS
         UqMPnmnZus2SiLmT3GIuncK/QxOLvD9ZasgAMozEnPolmaKnOWWa58Cz3+LQYV1Tda6C
         0Q5fjqCnLMbd7a340RDKrHKVBgttdAM0pd5G4=
Received: by 10.140.251.19 with SMTP id y19mr3598917rvh.161.1271666485358;
        Mon, 19 Apr 2010 01:41:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4800069iwn.6.2010.04.19.01.41.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 01:41:24 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145281>

Make sure that the sample hooks do not use any shell features
that the shell used to execute them does not support.

The documentation at the end of the sample pre-rebase script will
never be executed, but "sh -n" does not know that.  Convert it to
a HERE document to avoid spurious failures.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I guess this serves as a test for 502be95 (Make templates honour
SHELL_PATH and PERL_PATH, 2010-03-20).

Actually, my motivation is the second part, since I already run a test
like this locally.  But I thought, while fixing it, why not make it
easy for others to suffer the same problem, too?

 t/t0001-init.sh                    |   15 +++++++++++++++
 templates/hooks--pre-rebase.sample |    3 +++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6757734..3e6e1ed 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -141,6 +141,21 @@ test_expect_success 'reinit' '
 	test_cmp again/empty again/err2
 '
 
+test_expect_success 'sample hooks use acceptable syntax' '
+	mkdir boring &&
+	git init boring &&
+	test -d boring/.git/hooks &&
+	fail=f &&
+	for i in boring/.git/hooks/*.sample
+	do
+		read shebang <"$i" &&
+		shell=${shebang#"#!"} &&
+		$shell -n "$i" ||
+		fail=t
+	done &&
+	test "$fail" = f
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index 053f111..22a9f07 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -91,6 +91,7 @@ fi
 exit 0
 
 ################################################################
+cat <<\EOF
 
 This sample hook safeguards topic branches that have been
 published from being rewound.
@@ -167,3 +168,5 @@ To compute (2):
 	git rev-list master..topic
 
 	if this is empty, it is fully merged to "master".
+
+EOF
-- 
1.7.1.rc1
