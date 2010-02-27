From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/5] Allow explicit ANSI codes for colors
Date: Fri, 26 Feb 2010 23:57:46 -0500
Message-ID: <1267246670-19118-2-git-send-email-lodatom@gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlEh4-0007b4-Ho
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967851Ab0B0EyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 23:54:15 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:22110 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967831Ab0B0EyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 23:54:13 -0500
Received: by qw-out-2122.google.com with SMTP id 8so166093qwh.37
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HHARAidgYB7075ltmmpJ4SwwBb8WoWo+31uadFIXFFE=;
        b=KbnnRJB9bkFf7Z+XClixDOoAUqGLdOElbLhOsX8YsiiIp0l1ZP9wklTmeC3XcouX52
         GqsQUl+iEXMzxmK3NJLjnZ1bqfdFlGyHbFtimaPLEKCH6HHgE1Is7jxjzbNIMi/vhB3S
         mm4CPwqvCRy6+x4GRN9UXlUYy4CFlDhFsjzl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q0EDZAMlnVzhVjesAxHN9PCZousRyxOAwAlzN1TbmlJdwXDEe9x/pJf4dn1ZRXcYIN
         xt5TTbKVwSWV83CuzIP32h0qMDT0eTYGDtSlkNOrNlNg8khBUEwDv9CFjkH4Vl/XgJDk
         SDdJfvmKF5poR1UP0BWAWdj+xBjocYIG/NKfY=
Received: by 10.224.53.39 with SMTP id k39mr804676qag.1.1267246452873;
        Fri, 26 Feb 2010 20:54:12 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 20sm622133qyk.12.2010.02.26.20.54.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 20:54:12 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141183>

Allow explicit ANSI codes to be used in configuration options expecting
a color.  The form is "[...m", where "..." are characters in the ASCII
range 0x30 to 0x3f.  This allows users to specify more complex colors
(generically, SGR attributes) than our color language allows.  For
example, to get blinking, bold, underlined, italic, red text,
use "[5;1;4;3;31m".

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |    4 ++++
 color.c                  |   16 ++++++++++++++++
 t/t4026-color.sh         |   18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 664de6b..fed18cb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -663,6 +663,10 @@ accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
 `blink` and `reverse`.  The first color given is the foreground; the
 second is the background.  The position of the attribute, if any,
 doesn't matter.
++
+Alternatively, a raw ANSI color code (SGR attribute) may be specified, in the
+form `[...m` (no escape character).  The `...` is a set of characters in the
+ASCII range 0x30 to 0x3f.
 
 color.diff::
 	When set to `always`, always use colors in patch.
diff --git a/color.c b/color.c
index 62977f4..1b42d9a 100644
--- a/color.c
+++ b/color.c
@@ -56,6 +56,22 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 		return;
 	}
 
+	/* If "[...m", use this as the attribute string directly */
+	if (value_len >= 2 && value[0] == '[' && value[value_len-1] == 'm') {
+		int i;
+		for (i = 1; i < value_len-1; i++)
+			if (value[i] < 0x30 || value[i] >= 0x40)
+				goto parse;
+		if (value_len + 2 > COLOR_MAXLEN)
+			die("color value '%.*s' too long for variable '%s'",
+			    value_len, value, var);
+		*dst = '\033';
+		memcpy(dst+1, value, value_len);
+		*(dst+1+value_len) = 0;
+		return;
+	}
+
+parse:
 	/* [fg [bg]] [attr] */
 	while (len > 0) {
 		const char *word = ptr;
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 5ade44c..754716f 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -46,6 +46,14 @@ test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
 
+test_expect_success 'explicit attribute' '
+	color "[123;456;7890m" "[123;456;7890m"
+'
+
+test_expect_success 'explicit attribute maximum length' '
+	color "[00000000000000000000m" "[00000000000000000000m"
+'
+
 test_expect_success 'color too small' '
 	invalid_color "-2"
 '
@@ -66,6 +74,16 @@ test_expect_success 'extra character after attribute' '
 	invalid_color "dimX"
 '
 
+test_expect_success 'explicit attribute invalid characters' '
+	invalid_color "[/m" &&
+	invalid_color "[@m" &&
+	invalid_color "[mm"
+'
+
+test_expect_success 'explicit attribute too long' '
+	invalid_color "[000000000000000000000m"
+'
+
 test_expect_success 'unknown color slots are ignored (diff)' '
 	git config --unset diff.color.new
 	git config color.diff.nosuchslotwilleverbedefined white &&
-- 
1.7.0
