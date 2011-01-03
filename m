From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] vcs-svn: tweak test-line-buffer to not assume
 line-oriented input
Date: Sun, 2 Jan 2011 18:52:28 -0600
Message-ID: <20110103005228.GD30506@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 01:52:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYfB-0004Av-5k
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1ACAwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:52:37 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48438 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1ACAwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:52:36 -0500
Received: by yib18 with SMTP id 18so2931080yib.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 16:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ca6syXm5r9JNM9bHIE+u+ewtGyplYaiUTZB2/HJnHTI=;
        b=Yrpz+tNMXMDxAed6MmjMUyLytVQaYo2tureGB4iY08AEsgTVH6bb+APf/PsoYPOSGx
         mdTL4KE2s7AW263HSV+q/0+H+YTgwUKqeea+tKhX0zc1AbgXaxJkehjnvWnOkKfSljIr
         vZtKbI9J4cutpoOEUvZQU6hl19JNhKcakB6YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LLV543AxjB+uNwSVYot4qHO0ZaKbyN2H+YV5qBsA6MX6FdNBANrvARx/dk4RXfRO0C
         jfJbez1NAr9jMsSp/0k3fX9XGWaMn8lMw7fs/2Z2o3iI2KZ69RNGGFfV0R1ga+imqQzo
         s2XT5Y6uEUjXticAjaTWehrNUVcRiRkBnWxwg=
Received: by 10.90.74.19 with SMTP id w19mr11563946aga.196.1294015955780;
        Sun, 02 Jan 2011 16:52:35 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id 8sm2518865yhl.44.2011.01.02.16.52.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 16:52:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103004900.GA30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164433>

Do not expect an implicit newline after each input record.
Use a separate command to exercise buffer_skip_bytes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0081-line-buffer.sh |   27 +++++++++++++--------------
 test-line-buffer.c     |   10 +++++++---
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 13ac735..68d6163 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -7,45 +7,44 @@ test_description="Test the svn importer's input handling routines.
 test_expect_success 'read greeting' '
 	echo HELLO >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 5
+	read 6
 	HELLO
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success '0-length read, send along greeting' '
-	printf "%s\n" "" HELLO >expect &&
+	echo HELLO >expect &&
 	test-line-buffer <<-\EOF >actual &&
 	read 0
-
-	copy 5
+	copy 6
 	HELLO
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success 'buffer_read_string copes with trailing null byte' '
-	echo >expect &&
+test_expect_success 'buffer_read_string copes with null byte' '
+	>expect &&
 	q_to_nul <<-\EOF | test-line-buffer >actual &&
-	read 1
+	read 2
 	Q
 	EOF
 	test_cmp expect actual
 '
 
-test_expect_success '0-length read, copy null byte' '
-	printf "%s\n" "" Q | q_to_nul >expect &&
+test_expect_success 'skip, copy null byte' '
+	echo Q | q_to_nul >expect &&
 	q_to_nul <<-\EOF | test-line-buffer >actual &&
-	read 0
-
-	copy 1
+	skip 2
+	Q
+	copy 2
 	Q
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'long reads are truncated' '
-	printf "%s\n" foo "" >expect &&
+	echo foo >expect &&
 	test-line-buffer <<-\EOF >actual &&
 	read 5
 	foo
@@ -56,7 +55,7 @@ test_expect_success 'long reads are truncated' '
 test_expect_success 'long copies are truncated' '
 	printf "%s\n" "" foo >expect &&
 	test-line-buffer <<-\EOF >actual &&
-	read 0
+	read 1
 
 	copy 5
 	foo
diff --git a/test-line-buffer.c b/test-line-buffer.c
index 383f35b..da0bc65 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -19,14 +19,18 @@ static void handle_command(const char *command, const char *arg, struct line_buf
 	switch (*command) {
 	case 'c':
 		if (!prefixcmp(command, "copy ")) {
-			buffer_copy_bytes(buf, strtouint32(arg) + 1);
+			buffer_copy_bytes(buf, strtouint32(arg));
 			return;
 		}
 	case 'r':
 		if (!prefixcmp(command, "read ")) {
 			const char *s = buffer_read_string(buf, strtouint32(arg));
-			printf("%s\n", s);
-			buffer_skip_bytes(buf, 1);	/* consume newline */
+			fputs(s, stdout);
+			return;
+		}
+	case 's':
+		if (!prefixcmp(command, "skip ")) {
+			buffer_skip_bytes(buf, strtouint32(arg));
 			return;
 		}
 	default:
-- 
1.7.4.rc0.580.g89dc.dirty
