From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/14] upload-pack.c: Refactor capability advertising
Date: Fri, 29 Apr 2016 16:34:35 -0700
Message-ID: <1461972887-22100-3-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwC-0000oV-GI
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcD2XfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:00 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34585 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcD2Xe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:34:58 -0400
Received: by mail-pf0-f170.google.com with SMTP id y69so54011830pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z9fKjDWmrzaEnQJ1nzyTaYoGidcVj5CaH4O7pk0lvhQ=;
        b=mnaeLrzoNni+BMqE7SpPTAhYNNyp78F+upYQm/OfJMtqY+cPEH/P6uQJCPfmxNYHpn
         +uL1f3+D+Mzf5Vxh7MIFWFs7kUHVvkW5+sti1G3v3NuE88pwYLYhqSxGUtN1vxZogGn6
         hDf7nJaGQRmrlyELhJ+0JOt+po8NSezAEIbdI/Z9DZC/IElXGgdMnRhv93CoLo7UgRPo
         cpdYromUfXEzclblEs8J4ngYOmwGHi++B/XQliDVp1kBgm2S0HzmxsasEaQ46oSV6YjM
         SgdLHgT08bFvrF5uySgDroEzlf3l90GMz+VHUjjWFYnSiXmHQ4ASI7sQf1yR2+WHPLaO
         IZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z9fKjDWmrzaEnQJ1nzyTaYoGidcVj5CaH4O7pk0lvhQ=;
        b=N7EQonH3dvoTUp1cPlEkal9kj9fm7Oc+KBgRHYYPbBMZLNWjkpyO6Q8EPHGErTkruF
         7ZGb7lokR/LkBMh+4jOC/nmLDpj95kVwjhJNriIC2g/xbjGAJYAZ5xPXWWAaJYL87One
         UHhNAsKop4NADWXsWLuzQ+hvVkofs5ma+3e9MbZUi9l+jF2iJ6PPrA+WplH7u4lPkACg
         sxT0PoUw1Yx5qqKl96dFqbidNlJhKEUEFZpkrQ3wKKnKeCY6XBY+FhY5A0FrTbtCNkH5
         XkTpy14B/CVxRuL3ERyb5Vz7xYUgLeiwatpwi1g0zlKgS4cbHyieaLloaZWlkKJhV4v2
         S+jg==
X-Gm-Message-State: AOPr4FVTpLyUG/UyZuterFk+FAJisJrnnPJ4rehQAMuwLaD11zrq/5oin75rdyf9WnkFHNeL
X-Received: by 10.98.25.15 with SMTP id 15mr33096760pfz.60.1461972897359;
        Fri, 29 Apr 2016 16:34:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id c190sm26233837pfb.33.2016.04.29.16.34.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:34:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293072>

Instead of having the capabilities in a local string, keep them
in a struct outside the function. This will allow us in a later patch
to easily reuse the capabilities in version 2 of the protocol.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 59 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index aaaf883..85381d5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -719,37 +719,58 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
+static int advertise_capabilities = 1;
+const char *all_capabilities[] = {
+	"multi_ack",
+	"thin-pack",
+	"side-band",
+	"side-band-64k",
+	"ofs-delta",
+	"shallow",
+	"no-progress",
+	"include-tag",
+	"multi_ack_detailed",
+	"allow-tip-sha1-in-want",
+	"allow-reachable-sha1-in-want",
+	"no-done",
+};
+
 static int send_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
 	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
 
-	if (capabilities) {
-		struct strbuf symref_info = STRBUF_INIT;
-
-		format_symref_info(&symref_info, cb_data);
-		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
-			     oid_to_hex(oid), refname_nons,
-			     0, capabilities,
-			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
-				     " allow-tip-sha1-in-want" : "",
-			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
-				     " allow-reachable-sha1-in-want" : "",
-			     stateless_rpc ? " no-done" : "",
-			     symref_info.buf,
-			     git_user_agent_sanitized());
-		strbuf_release(&symref_info);
+	if (advertise_capabilities) {
+		int i;
+		struct strbuf capabilities = STRBUF_INIT;
+
+		for (i = 0; i < ARRAY_SIZE(all_capabilities); i++) {
+			const char *cap = all_capabilities[i];
+			if (!strcmp(cap, "allow-tip-sha1-in-want")
+			    && !(allow_unadvertised_object_request & ALLOW_TIP_SHA1))
+				continue;
+			if (!strcmp(cap, "allow-reachable-sha1-in-want")
+			    && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
+				continue;
+			if (!strcmp(cap, "no-done") && !stateless_rpc)
+				continue;
+			strbuf_addf(&capabilities, " %s", cap);
+		}
+
+		format_symref_info(&capabilities, cb_data);
+		strbuf_addf(&capabilities, " agent=%s", git_user_agent_sanitized());
+
+		packet_write(1, "%s %s%c%s\n", oid_to_hex(oid), refname_nons,
+			     0, capabilities.buf);
+		strbuf_release(&capabilities);
+		advertise_capabilities = 0;
 	} else {
 		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
-	capabilities = NULL;
 	if (!peel_ref(refname, peeled.hash))
 		packet_write(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
-- 
2.8.0.32.g71f8beb.dirty
