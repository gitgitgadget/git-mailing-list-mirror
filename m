From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 03/11] upload-pack: move capabilities out of send_ref
Date: Tue, 26 May 2015 15:01:07 -0700
Message-ID: <1432677675-5118-4-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:02:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMvG-0002BM-4A
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbbEZWBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:38 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33467 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbEZWBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:31 -0400
Received: by iebgx4 with SMTP id gx4so81361ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHIs+VtStTP/UV3nqTXZijPanSVPtvwUHbTvYMxQWLU=;
        b=J5mJP+6u2vcLjaF5Bfj9tEnwhd6lZPPdlU2V3jOJHo/hcP5iT2BDFFVBdmNXR3MCHw
         7k3qAOJzPgkgEobFK1/0sN4O5AauMlDLDjR/cBreHVzHWk4xcO37O80itGoe+mirDBqd
         /7yNNfbxuAt4DFSXZqfofXabyhw653ZAtXYg2PkxE7712tS44+8h2QPbuyX5fQieFjoF
         Y41HL6sTFdhDtGj7nca2v1UwzPHSHMAwegGLDqDrHv1S0UhKjZxvT+thaaNB6yA+Znp/
         Aq+Rq9JQOIhyrSC5o+zTbvdkZKtATztM3Bx12bpffTIAVtyUlqgeO2UzqDLi98KARzDr
         quAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LHIs+VtStTP/UV3nqTXZijPanSVPtvwUHbTvYMxQWLU=;
        b=VrJBThxFkg5/EVmyiHMampNbBKysGWowNO1SCNZZfnOvrfhLQQu2UzMnPsvpABiZEh
         Y10fa0oedxCMPViXU6omb7LKqvKlgSN18iOt8pYlnrZlW/2joCOHRa/VhqdxbkreK9Nu
         v7riQ3Ef75VsVq6QsBI+GhNeYHKrTzKTybRQ29LEj0EOgswG6CoOYVNeHNI3ZKKomlbz
         0n+bUtizQZXvRja09OjJsCIVTrR/iXHswXaIPd860XYQFu1G+qlSAceQxqd3iDLMEq7e
         YkR8EF3ytN01ZVPY1PabBGQn6YCHX+Ry+OL69R+8B9F7ylrpCKhPlREA60DQB1Al2NZr
         JJ9g==
X-Gm-Message-State: ALoCoQkqC2YFbT3Kau8xbm3L0OCjiuQEO2WAcJ56IuLmCOXE8nei1k4orbpr8pCvFaHIxsGkUyYm
X-Received: by 10.50.8.68 with SMTP id p4mr33192335iga.4.1432677690661;
        Tue, 26 May 2015 15:01:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id if2sm308765igb.15.2015.05.26.15.01.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269997>

This will make it easier to reuse the capabilities in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6734777..a5f75b7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -716,33 +716,35 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	static const char *capabilities = "multi_ack thin-pack side-band"
+static const char *advertise_capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
+
+static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
 	if (mark_our_ref(refname, sha1))
 		return 0;
 
-	if (capabilities) {
+	if (advertise_capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
 		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
-			     0, capabilities,
+			     0, advertise_capabilities,
 			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
+		advertise_capabilities = NULL;
 	} else {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	}
-	capabilities = NULL;
 	if (!peel_ref(refname, peeled))
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
-- 
2.4.1.345.gab207b6.dirty
