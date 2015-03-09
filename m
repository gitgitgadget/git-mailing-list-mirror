From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH v2] userdiff: funcname and word patterns for sh
Date: Tue, 10 Mar 2015 00:40:32 +0100
Message-ID: <1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
References: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Adrien Schildknecht <adrien+dev@schischi.me>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV7II-0004iA-HA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 00:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbbCIXlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 19:41:02 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41949 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbCIXlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 19:41:00 -0400
Received: by wiwl15 with SMTP id l15so26064546wiw.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 16:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fz0JcrNNcDKHtHWbojv562OB93a80Ugn2MjxyqDC8vg=;
        b=lKpamYZG6Yk0WGNKmrqdeLEv/yG+s7v3v187zSBDcAoCVIBH0e90DEMJBwcwPGVBE1
         M0ZXZ41zyS4WGT061o6f+TFt8fLYDHi9GPx1Iy2nFA6fghaEdVFJbaycdZU4sh120V17
         Rd0boOjVzWYAYi0rSfzp/FA6Y10KBLa+UUgZQJydEs3Vh9Wlfo5spYi3o07v/lF5XnK7
         Kwnjp6bgcgXXE6ax6wZl18g8SMLLNG+qYBAisRWrWuZsVgSCQ9OnsYHL/373UEswYxip
         AEKG6XxSsyLBbLVZxWCQbjpGlZoNy8/avv07Msi1ZMdNjNDkW/UsKSE/dRcBqNXbuFX8
         QuQg==
X-Gm-Message-State: ALoCoQn1xil8NfC7vyBwGWsHJlWzZkcBNWJzXCEy4kqztEm84UvC6Pu04t9nXXoH5w06u6s3s+K3
X-Received: by 10.194.177.195 with SMTP id cs3mr60927579wjc.141.1425944459048;
        Mon, 09 Mar 2015 16:40:59 -0700 (PDT)
Received: from kohral.localdomain ([37.160.7.202])
        by mx.google.com with ESMTPSA id p1sm1267239wib.23.2015.03.09.16.40.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2015 16:40:58 -0700 (PDT)
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265202>

Add regexp based on the "Shell Command Language" specifications.
Because of the lax syntax of sh, some corner cases may not be
handled properly.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/sh-function             |  4 ++++
 t/t4018/sh-function-comment     |  6 ++++++
 t/t4018/sh-function-nested      |  7 +++++++
 t/t4018/sh-function-prefix      |  4 ++++
 t/t4018/sh-function-string      |  4 ++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/sh/expect               | 46 +++++++++++++++++++++++++++++++++++++++++
 t/t4034/sh/post                 | 36 ++++++++++++++++++++++++++++++++
 t/t4034/sh/pre                  | 36 ++++++++++++++++++++++++++++++++
 userdiff.c                      |  7 +++++++
 12 files changed, 154 insertions(+)
 create mode 100644 t/t4018/sh-function
 create mode 100644 t/t4018/sh-function-comment
 create mode 100644 t/t4018/sh-function-nested
 create mode 100644 t/t4018/sh-function-prefix
 create mode 100644 t/t4018/sh-function-string
 create mode 100644 t/t4034/sh/expect
 create mode 100644 t/t4034/sh/post
 create mode 100644 t/t4034/sh/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c892ffa..fb13761 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -545,6 +545,8 @@ patterns are available:
 
 - `ruby` suitable for source code in the Ruby language.
 
+- `sh` suitable for source code in the Shell language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1dbaa38..960b6e4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -40,6 +40,7 @@ diffpatterns="
 	php
 	python
 	ruby
+	sh
 	tex
 	custom1
 	custom2
diff --git a/t/t4018/sh-function b/t/t4018/sh-function
new file mode 100644
index 0000000..1d5096a
--- /dev/null
+++ b/t/t4018/sh-function
@@ -0,0 +1,4 @@
+RIGHT_foo()
+{
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-comment b/t/t4018/sh-function-comment
new file mode 100644
index 0000000..f340ee7
--- /dev/null
+++ b/t/t4018/sh-function-comment
@@ -0,0 +1,6 @@
+  RIGHT_foo() # echo 'foo'
+#bar()
+{
+	#bar()
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-nested b/t/t4018/sh-function-nested
new file mode 100644
index 0000000..d3263f3
--- /dev/null
+++ b/t/t4018/sh-function-nested
@@ -0,0 +1,7 @@
+foo (     )
+{
+	RIGHT_bar()
+	{
+		echo ChangeMe
+	}
+}
diff --git a/t/t4018/sh-function-prefix b/t/t4018/sh-function-prefix
new file mode 100644
index 0000000..e96eb7a
--- /dev/null
+++ b/t/t4018/sh-function-prefix
@@ -0,0 +1,4 @@
+function RIGHT_foo()
+{
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-string b/t/t4018/sh-function-string
new file mode 100644
index 0000000..f60a899
--- /dev/null
+++ b/t/t4018/sh-function-string
@@ -0,0 +1,4 @@
+RIGHT_foo() {
+	echo "bar()"
+	ChangeMe;
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f2f55fc..24fd9aa 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -312,6 +312,7 @@ test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
+test_language_driver sh
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
diff --git a/t/t4034/sh/expect b/t/t4034/sh/expect
new file mode 100644
index 0000000..1c6de2d
--- /dev/null
+++ b/t/t4034/sh/expect
@@ -0,0 +1,46 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 20229c3..ab791db 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,36 +1,36 @@<RESET>
+foo() {ls&echo}<RESET>
+$((<RED>a<RESET><GREEN>x<RESET>++))
+$((<RED>a<RESET><GREEN>x<RESET>--))
+$((--<RED>a<RESET><GREEN>x<RESET>))
+$((++<RED>a<RESET><GREEN>x<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>*<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>&<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>**<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>/<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>%<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>+<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>-<RED>b<RESET><GREEN>y<RESET>))
+[ <RED>a<RESET><GREEN>x<RESET><=<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>>=<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>==<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>!=<RED>b<RESET><GREEN>y<RESET> ]
+<RED>a<RESET><GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b a<RESET><GREEN>y x<RESET><<-<RED>b a<RESET><GREEN>y x<RESET><<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>|<RED>b a<RESET><GREEN>y x<RESET><&<RED>b a<RESET><GREEN>y x<RESET>>&<RED>b a<RESET><GREEN>y x<RESET><><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b<RESET><GREEN>y<RESET>
+$((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>*=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>/=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>%=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET><<=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>>>=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>&=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>^=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>|=<RED>b<RESET><GREEN>y<RESET>))
+*)<RED>a<RESET><GREEN>b<RESET>;;ls
+FOO=42&<RED>foo<RESET><GREEN>fro<RESET>
+BAR=$(0)<RESET>
+[[ $<RED>a<RESET><GREEN>x<RESET> -eq $<RED>b<RESET><GREEN>y<RESET> ]]
diff --git a/t/t4034/sh/post b/t/t4034/sh/post
new file mode 100644
index 0000000..ab791db
--- /dev/null
+++ b/t/t4034/sh/post
@@ -0,0 +1,36 @@
+foo() {ls&echo}
+$((x++))
+$((x--))
+$((--x))
+$((++x))
+$((x*y))
+$((x&y))
+$((x**y))
+$((x/y))
+$((x%y))
+$((x+y))
+$((x-y))
+[ x<=y ]
+[ x>=y ]
+[ x==y ]
+[ x!=y ]
+x<<y x>>y x<<-y x<y x>y x>|y x<&y x>&y x<>y
+x&y
+x&&y
+x|y
+x||y
+x=y
+$((x+=y))
+$((x-=y))
+$((x*=y))
+$((x/=y))
+$((x%=y))
+$((x<<=y))
+$((x>>=y))
+$((x&=y))
+$((x^=y))
+$((x|=y))
+*)b;;ls
+FOO=42&fro
+BAR=$(0)
+[[ $x -eq $y ]]
diff --git a/t/t4034/sh/pre b/t/t4034/sh/pre
new file mode 100644
index 0000000..20229c3
--- /dev/null
+++ b/t/t4034/sh/pre
@@ -0,0 +1,36 @@
+foo() {ls&echo}
+$((a++))
+$((a--))
+$((--a))
+$((++a))
+$((a*b))
+$((a&b))
+$((a**b))
+$((a/b))
+$((a%b))
+$((a+b))
+$((a-b))
+[ a<=b ]
+[ a>=b ]
+[ a==b ]
+[ a!=b ]
+a<<b a>>b a<<-b a<b a>b a>|b a<&b a>&b a<>b
+a&b
+a&&b
+a|b
+a||b
+a=b
+$((a+=b))
+$((a-=b))
+$((a*=b))
+$((a/=b))
+$((a%=b))
+$((a<<=b))
+$((a>>=b))
+$((a&=b))
+$((a^=b))
+$((a|=b))
+*)a;;ls
+FOO=42&foo
+BAR=$(0)
+[[ $a -eq $b ]]
diff --git a/userdiff.c b/userdiff.c
index 2ccbee5..40b3dc0 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -146,6 +146,13 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+PATTERNS("sh",
+	"^([ \t]*(function[ \t]+)?[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\).*)$",
+	/* -- */
+	 "[a-zA-Z0-9_]+"
+	 "|[-+0-9]+"
+	 "|[-+*/<>%&^|=!]=|>>=?|<<=?|\\+\\+|--|\\*\\*|&&|\\|\\||\\[\\[|\\]\\]"
+	 "|>\\||[<>]+&|<>|<<-|;;"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
Adrien Schildknecht
http://schischi.me
