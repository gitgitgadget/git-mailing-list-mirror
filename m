X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] for-each-ref: "creator" and "creatordate" fields
Date: Thu, 2 Nov 2006 20:17:30 +0100
Message-ID: <200611022017.31351.jnareb@gmail.com>
References: <200610281930.05889.jnareb@gmail.com> <7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 2 Nov 2006 19:26:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kHNlHAGylPMiam0lizihvCByE73w4OecRjH4Zoy3vPLTuGKu9mrbR1x2BY0Q6+CtdeoHaDmhNXcoMPykiR0FIgX2b9BVC0XVcrybE+pNa/q9brdhY0py84YhukPRPGEhvPyTFnZFyluh+TTn3HOEzGcqjcjaq+ye3Tfa6BZTCIA=
User-Agent: KMail/1.9.3
In-Reply-To: <7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30763>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfi9j-0003Rw-Lz for gcvg-git@gmane.org; Thu, 02 Nov
 2006 20:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752331AbWKBTXI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 14:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbWKBTXI
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 14:23:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8648 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752331AbWKBTXF
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 14:23:05 -0500
Received: by ug-out-1314.google.com with SMTP id m3so214835ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 11:23:04 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr1227696ugj.1162495383636; Thu, 02
 Nov 2006 11:23:03 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id u6sm753629uge.2006.11.02.11.23.03; Thu, 02 Nov
 2006 11:23:03 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

From fa1a32c9a7c8a31b122df7d07f4a8885cbe120d0 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Sat, 28 Oct 2006 13:33:46 -0700
Subject: [PATCH 1/2] for-each-ref: "creator" and "creatordate" fields

This adds "creator" (which is parallel to "tagger" or "committer")
and "creatordate" (corresponds to "taggerdate" and
"committerdate").

As other "date" fields, "creatordate" sorts numerically
and displays human readably. This allows for example for
sorting together heavyweigth and lightweight tags.

[jn: originally fields were named "epoch" and "epochdate".]

Signed-off-by: Junio C Hamano <junkio@cox.net>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
 builtin-for-each-ref.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 93d3d7e..173bf38 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -59,6 +59,8 @@ static struct {
 	{ "taggername" },
 	{ "taggeremail" },
 	{ "taggerdate", FIELD_TIME },
+	{ "creator" },
+	{ "creatordate", FIELD_TIME },
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
@@ -401,6 +403,29 @@ static void grab_person(const char *who,
 		else if (!strcmp(name + wholen, "date"))
 			grab_date(wholine, v);
 	}
+
+	/* For a tag or a commit object, if "creator" or "creatordate" is
+	 * requested, do something special.
+	 */
+	if (strcmp(who, "tagger") && strcmp(who, "committer"))
+		return; /* "author" for commit object is not wanted */
+	if (!wholine)
+		wholine = find_wholine(who, wholen, buf, sz);
+	if (!wholine)
+		return;
+	for (i = 0; i < used_atom_cnt; i++) {
+		const char *name = used_atom[i];
+		struct atom_value *v = &val[i];
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+
+		if (!strcmp(name, "creatordate"))
+			grab_date(wholine, v);
+		else if (!strcmp(name, "creator"))
+			v->s = copy_line(wholine);
+	}
 }
 
 static void find_subpos(const char *buf, unsigned long sz, const char **sub, const char **body)
-- 
1.4.3.3
