From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at
 a time
Date: Fri, 15 Feb 2008 22:17:52 -0800
Message-ID: <7vmyq1e86n.fsf@gitster.siamese.dyndns.org>
References: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
 <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
 <76718490802151537r7658e109o3c981832ae32154d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:19:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQGOK-0000ze-LF
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 07:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYBPGSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 01:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYBPGSm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 01:18:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYBPGSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 01:18:40 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CDAB21EC;
	Sat, 16 Feb 2008 01:18:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 0265921E5; Sat, 16 Feb 2008 01:18:30 -0500 (EST)
In-Reply-To: <76718490802151537r7658e109o3c981832ae32154d@mail.gmail.com>
 (Jay Soffian's message of "Fri, 15 Feb 2008 18:37:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74016>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Feb 15, 2008 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> And it appears to be an obvious fix that should even go to
>> 'maint' where no new features will land.
>
> Yes.
>
>> Care to provide a test case for this one?
>
> I'll see what I can do. I'm not sure it makes a difference...

Of course it does; otherwise I wouldn't have asked.

Thanks for the fix.  The following will go to 'maint'.

-- >8 --
From: Jay Soffian <jaysoffian@gmail.com>
Date: Fri, 15 Feb 2008 16:53:36 -0500
Subject: mailinfo: feed only one line to handle_filter() for QP input

The function is intended to be fed one logical line at a time to
inspect, but a QP encoded raw input line can have more than one
lines, just like BASE64 encoded one.

Quoting LF as =0A may be unusual but RFC2045 allows it.

The issue was noticed and fixed by Jay Soffian.  JC added a test
to protect the fix from regressing later.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c  |    1 +
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0009    |    5 +++++
 t/t5100/msg0009     |    2 ++
 t/t5100/patch0009   |   13 +++++++++++++
 t/t5100/sample.mbox |   23 +++++++++++++++++++++++
 6 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2600847..11f154b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -818,6 +818,7 @@ static void handle_body(void)
 
 		switch (transfer_encoding) {
 		case TE_BASE64:
+		case TE_QP:
 		{
 			char *op = line;
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9b1a745..d6c55c1 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. ../t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 8'
+	test `cat last` = 9'
 
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0009 b/t/t5100/info0009
new file mode 100644
index 0000000..2a66321
--- /dev/null
+++ b/t/t5100/info0009
@@ -0,0 +1,5 @@
+Author: F U Bar
+Email: f.u.bar@example.com
+Subject: updates
+Date: Mon, 17 Sep 2001 00:00:00 +0900
+
diff --git a/t/t5100/msg0009 b/t/t5100/msg0009
new file mode 100644
index 0000000..9ffe131
--- /dev/null
+++ b/t/t5100/msg0009
@@ -0,0 +1,2 @@
+This is to fix diff-format documentation.
+
diff --git a/t/t5100/patch0009 b/t/t5100/patch0009
new file mode 100644
index 0000000..304cd55
--- /dev/null
+++ b/t/t5100/patch0009
@@ -0,0 +1,13 @@
+diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
+index b426a14..97756ec 100644
+--- a/Documentation/diff-format.txt
++++ b/Documentation/diff-format.txt
+@@ -81,7 +81,7 @@ The "diff" formatting options can be customized via the
+ environment variable 'GIT_DIFF_OPTS'.  For example, if you
+ prefer context diff:
+ 
+-      GIT_DIFF_OPTS=-c git-diff-index -p $(cat .git/HEAD)
++      GIT_DIFF_OPTS=-c git-diff-index -p HEAD
+ 
+ 
+ 2. When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 070c166..b9bd90d 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -407,3 +407,26 @@ Subject: [PATCH] another patch
 
 Hey you forgot the patch!
 
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Date: Mon, 17 Sep 2001 00:00:00 +0900
+Mime-Version: 1.0
+Content-Type: Text/Plain; charset=us-ascii
+Content-Transfer-Encoding: Quoted-Printable
+
+=0A=0AFrom: F U Bar <f.u.bar@example.com>
+Subject: [PATCH] updates=0A=0AThis is to fix diff-format documentation.
+
+diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
+index b426a14..97756ec 100644
+--- a/Documentation/diff-format.txt
++++ b/Documentation/diff-format.txt
+@@ -81,7 +81,7 @@ The "diff" formatting options can be customized via the
+ environment variable 'GIT_DIFF_OPTS'.  For example, if you
+ prefer context diff:
+=20
+-      GIT_DIFF_OPTS=3D-c git-diff-index -p $(cat .git/HEAD)
++      GIT_DIFF_OPTS=3D-c git-diff-index -p HEAD
+=20
+=20
+ 2. When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
