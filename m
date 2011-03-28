From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 6/9] add long-form %(wrap:...) for %w(...)
Date: Tue, 29 Mar 2011 00:17:28 +0100
Message-ID: <1301354251-23380-7-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lhe-00010L-BB
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab1C1XSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab1C1XSC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:18:02 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so3294008wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=p2kfir3RIOn32puwsNhxFzWHJa4Z+ZK12gNVa/9Eino=;
        b=nlGlbiscK3soFjXw9BqRcTE4HZsDvWwy87pnQOBr24AM422MMd1tvM79uoDmOvWi9i
         Z3l/PbfYdbu0aIn09U/1LXNX2w9/QVX+MCIoeQNMjyu+dmdclk6X2YFj6kfTrAi9Gny3
         0znx9AspHJ5/Dwc2ruSK+0Utw/fLd3LHVA8ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kTiOEdvsoDzWKCy3QbtfuU2ABMFy4K1q/ai4CYXZBs7kYBNgGBY1Ki9S3vlBPPRZ8D
         wk3aXURMf7MAcieO4p6padA9fRAKNtqTaJhfvyRiM3dedY/kv2dW5ubWtebm8p3nFI9c
         Ep94ogyukqFElhuT/Vbi0KpP/YTAmMZddgOfE=
Received: by 10.216.246.74 with SMTP id p52mr333742wer.41.1301354281797;
        Mon, 28 Mar 2011 16:18:01 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.18.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:18:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170204>

the list of user-defined format placeholders has grown steadily longer
since they were first introduced. We currently have about forty
placeholders, and the room for new mnemonics is growing scarce. To make
more room, we introduce "long forms" for placeholders, which take the
form:
	'%(' <label> [ ':' <arg> [ ',' <arg> ]* ] ')'
eg:
	%(wrap: 80, 0, 4)

We start by adding a long-form to the %w(...) placeholder, mostly
because as it already takes multiple arguments, it is a good example.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   47 +++++++++++++++++++++++++++++++++-----
 test-pretty.c                    |    1 +
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..c9f3fb6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -144,6 +144,7 @@ The placeholders are:
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
   linkgit:git-shortlog[1].
+- '%(wrap:[<w>[,<i1>[,<i2>]]])': alternative form of %w(...)
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index cb02879..8301008 100644
--- a/pretty.c
+++ b/pretty.c
@@ -108,12 +108,10 @@ const char *parse_arg(struct format_part *part, enum format_arg_type type,
 	arg.type = type;
 
 	c += strspn(c, WHITESPACE);
-	if (!isdigit(*c))
-		return NULL;
-	arg.uint = strtoul(c, &t, 10);
-	if (t == c)
-		return NULL;
-	c = t + strspn(t, WHITESPACE);
+	if (isdigit(*c)) {
+		arg.uint = strtoul(c, &t, 10);
+		c = t + strspn(t, WHITESPACE);
+	}
 	if (*c == ',' || *c == ')'){
 		ALLOC_GROW(part->args, part->argc+1, part->args_alloc);
 		memcpy(&(part->args[part->argc]), &arg,
@@ -124,6 +122,41 @@ const char *parse_arg(struct format_part *part, enum format_arg_type type,
 	return NULL;
 }
 
+static struct format_part *parse_extended(const char *unparsed)
+{
+	struct format_part *part = format_part_alloc();
+	const char *c = unparsed + 2; /* "%(..." + strlen("%(") */
+
+	c += strspn(c, WHITESPACE);
+
+	if (!prefixcmp(c, "wrap")) {
+		part->type = FORMAT_PART_WRAP;
+		c += 4;
+		while(part->argc <= 3){
+			c += strspn(c, WHITESPACE);
+			if (*c == ')')
+				goto success;
+			if (*c != (part->argc ? ',' : ':'))
+				goto fail;
+			if (part->argc == 3)
+				goto fail;
+
+			c = parse_arg(part, FORMAT_ARG_UINT, c+1);
+			if (!c)
+				goto fail;
+		}
+		goto fail;
+	}
+
+fail:
+	format_part_free(&part);
+	return NULL;
+
+success:
+	part->format_len = c - unparsed + 1;
+	return part;
+}
+
 static struct format_part *parse_special(const char *unparsed)
 {
 	struct format_part *part = NULL;
@@ -156,6 +189,8 @@ static struct format_part *parse_special(const char *unparsed)
 			}
 		}
 		return part;
+	case '(':
+		return parse_extended(unparsed);
 	}
 
 	part = format_part_alloc();
diff --git a/test-pretty.c b/test-pretty.c
index 57c1c65..64a8218 100644
--- a/test-pretty.c
+++ b/test-pretty.c
@@ -17,6 +17,7 @@ static const char *all = "a"
 "%gD%gd%gs"
 "%Cred%Cgreen%Cblue%Creset%C(reset)"
 "%m%w()%w(1)%w(1,2)%w(1,2,3)"
+"%(wrap)%(wrap:1)%(wrap:1,2)%(wrap:1,2,3)"
 "%x0a%n%%%@";
 
 static struct strbuf *parts_debug(struct format_parts *parts,
-- 
1.7.4.2
