From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] vcs-svn: allow 64-bit Prop-Content-Length
Date: Fri, 6 Jul 2012 12:27:50 -0500
Message-ID: <20120706172750.GJ31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCK1-0007RR-UR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab2GFR1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:27:55 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57533 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab2GFR1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:27:54 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so8838387ggl.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ok4wxlU1Z2aGJ0qqcEvh0TDsnzDKK4O4sNBfdzpACJw=;
        b=ss1W5RoMAR4cLik183ELafOELkyj2Hf1FID1itkxYDxAjnb4202zgOEXmb1IH/Fh3c
         WWdkTVrRPfCM7doR93/MwXj7xMVRpmg2220ccHvi2zlRyK+dROWpZr0+pqCjmHrWjj+V
         s2dNg9+qDT4xFiPgXBWn6404FohUWDI3j18XTUX0biJvQvlG1EyyIT+oRZr/hm0t0rOF
         +X/6xUzvIwWbju/PXLbM5+qtw/liAYk6P0ms+I9xsDppkjxOBYFGplpzaPDRX2uj41K1
         KcIjkbXeRx8Kv+DjSG8ZOj1C/eHsi3OqnlhmWWVkRU/MIJ3cIvEati/DRsTjn0OijtBd
         RH8w==
Received: by 10.50.197.168 with SMTP id iv8mr3110382igc.12.1341595674403;
        Fri, 06 Jul 2012 10:27:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z7sm2848329igb.3.2012.07.06.10.27.53
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:27:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201134>

Date: Thu, 5 Jul 2012 22:47:47 -0500

Currently the vcs-svn/ library only pays attention to the presence of
the Prop-Content-Length field and doesn't care about its value, but
some day we might care about the value.  Parse it as an off_t instead
of arbitrarily limiting to 32 bits for intuitiveness.

So now you can import from a dump with more than 2 GiB of properties
for a node.  In practice that isn't likely to happen often, and this
is mostly meant as a cleanup.

Based-on-patch-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Another change that was mixed into v2's signedness warnings patch.
In v2 it changed the type of propLength without changing its name.
This version of the patch is more thorough about consistently using
the intuitive type (off_t instead of a 32-bit integer).

That's the end of the series.  Thanks for your patience.

 vcs-svn/svndump.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c5d07a66..a7f3ea64 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -34,14 +34,13 @@
 #define NODE_CTX 2	/* node metadata */
 #define INTERNODE_CTX 3	/* between nodes */
 
-#define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
 
 static struct line_buffer input = LINE_BUFFER_INIT;
 
 static struct {
-	uint32_t action, propLength, srcRev, type;
-	off_t text_length;
+	uint32_t action, srcRev, type;
+	off_t prop_length, text_length;
 	struct strbuf src, dst;
 	uint32_t text_delta, prop_delta;
 } node_ctx;
@@ -61,7 +60,7 @@ static void reset_node_ctx(char *fname)
 {
 	node_ctx.type = 0;
 	node_ctx.action = NODEACT_UNKNOWN;
-	node_ctx.propLength = LENGTH_UNKNOWN;
+	node_ctx.prop_length = -1;
 	node_ctx.text_length = -1;
 	strbuf_reset(&node_ctx.src);
 	node_ctx.srcRev = 0;
@@ -209,7 +208,7 @@ static void read_props(void)
 static void handle_node(void)
 {
 	const uint32_t type = node_ctx.type;
-	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
+	const int have_props = node_ctx.prop_length != -1;
 	const int have_text = node_ctx.text_length != -1;
 	/*
 	 * Old text for this node:
@@ -273,7 +272,7 @@ static void handle_node(void)
 	if (have_props) {
 		if (!node_ctx.prop_delta)
 			node_ctx.type = type;
-		if (node_ctx.propLength)
+		if (node_ctx.prop_length)
 			read_props();
 	}
 
@@ -409,22 +408,26 @@ void svndump_read(const char *url)
 			node_ctx.srcRev = atoi(val);
 			break;
 		case sizeof("Text-content-length"):
-			if (!constcmp(t, "Text-content-length")) {
+			if (constcmp(t, "Text") && constcmp(t, "Prop"))
+				continue;
+			if (constcmp(t + 4, "-content-length"))
+				continue;
+			{
 				char *end;
-				uintmax_t textlen;
+				uintmax_t len;
 
-				textlen = strtoumax(val, &end, 10);
+				len = strtoumax(val, &end, 10);
 				if (!isdigit(*val) || *end)
 					die("invalid dump: non-numeric length %s", val);
-				if (textlen > maximum_signed_value_of_type(off_t))
+				if (len > maximum_signed_value_of_type(off_t))
 					die("unrepresentable length in dump: %s", val);
-				node_ctx.text_length = (off_t) textlen;
+
+				if (*t == 'T')
+					node_ctx.text_length = (off_t) len;
+				else
+					node_ctx.prop_length = (off_t) len;
 				break;
 			}
-			if (constcmp(t, "Prop-content-length"))
-				continue;
-			node_ctx.propLength = atoi(val);
-			break;
 		case sizeof("Text-delta"):
 			if (!constcmp(t, "Text-delta")) {
 				node_ctx.text_delta = !strcmp(val, "true");
-- 
1.7.10.4
