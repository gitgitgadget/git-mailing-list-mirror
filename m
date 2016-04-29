From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/14] fetch-pack: move capability selection out of do_fetch_pack
Date: Fri, 29 Apr 2016 16:34:40 -0700
Message-ID: <1461972887-22100-8-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwt-0001Cp-FQ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcD2Xfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36561 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbcD2XfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:05 -0400
Received: by mail-pa0-f51.google.com with SMTP id bt5so50933804pac.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEU3Pu/1ypH9jF/bhsdJslY9/LU8RXMFclEsrJHmuX8=;
        b=WnZ0pB/baZfHZ/+Qa3fgBC9t1QKoSTEIN8UI09Bf0EHvhvV9HVnSIKkqFGa03HqlLL
         n1OxI7SjePs9xX5/2oQROBORC6WVUrTas6ktm1/OjV+48Gsaf86qUNgpFEpZck+qLYPK
         3dO4MXcQ9krj+SluDim/pUBeM55koy1RpOE+7NixDrXIE464EDXAgEZczoi0utrp73hY
         Y+976H1edL1vXjNnq+HoTfu0yK4v5InVhjqI0WO/GhK13McnrTjhxyWA+tBg0EP09ci1
         Coq9IM/RhfVREqFfoTHXSx7XT2bOqbhk/oivM+Xtu0DoX6I6WCYvhwLYws/uSn7HSfhv
         rolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sEU3Pu/1ypH9jF/bhsdJslY9/LU8RXMFclEsrJHmuX8=;
        b=AI+xvxicVzryWSBEWzX/0RGIzDIE/U/eiJ4Q2kyBz7I/Wq4CXdjvZ1voOoxEj8XC40
         tKAcqrvBNO8kYlXaUMccMU2xUL5vUyCNLMQzwA25GOH/xdp/kYrgApEOTkvuAugroA5x
         GIarOdpG6oCO8GLfobprBTwV98gEdbF1D5Un4MNrDRG5GZosvF5yL8uDc4n6DhHRU1HQ
         WDXs3KUEVIJ7An17vgjEv2Gulk+ccNHMvadMd0ung+zZjg8NcC7ze+1W983zyYcPypSW
         NAu0yXYoO3WaSuOim0fksi6gky740lB1tRi132OfxDBs12EIvW+VJ2V6EFWI3u/It50q
         0khQ==
X-Gm-Message-State: AOPr4FWC0rqsqavX6Ewgwfa4QBQQ2+s71VtVc7cm8C3W+oREn0eB2So53Gr1sW0erxApvoJS
X-Received: by 10.67.1.3 with SMTP id bc3mr30513368pad.138.1461972904264;
        Fri, 29 Apr 2016 16:35:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id v75sm26187294pfa.94.2016.04.29.16.35.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293084>

Later in version 2 of the pack protocol the selection of capabilities
happens at another step of the protocol, so move out the current
capability selection, so we can reuse it later more easily.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fetch-pack.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f96f6df..53f6384 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -796,21 +796,11 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
-static struct ref *do_fetch_pack(struct fetch_pack_args *args,
-				 int fd[2],
-				 const struct ref *orig_ref,
-				 struct ref **sought, int nr_sought,
-				 struct shallow_info *si,
-				 char **pack_lockfile)
+static void select_capabilities(struct fetch_pack_args *args)
 {
-	struct ref *ref = copy_ref_list(orig_ref);
-	unsigned char sha1[20];
 	const char *agent_feature;
 	int agent_len;
 
-	sort_ref_list(&ref, ref_compare_name);
-	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
-
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
@@ -867,6 +857,22 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			fprintf(stderr, "Server version is %.*s\n",
 				agent_len, agent_feature);
 	}
+}
+
+static struct ref *do_fetch_pack(struct fetch_pack_args *args,
+				 int fd[2],
+				 const struct ref *orig_ref,
+				 struct ref **sought, int nr_sought,
+				 struct shallow_info *si,
+				 char **pack_lockfile)
+{
+	struct ref *ref = copy_ref_list(orig_ref);
+	unsigned char sha1[20];
+
+	sort_ref_list(&ref, ref_compare_name);
+	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
+
+	select_capabilities(args);
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
-- 
2.8.0.32.g71f8beb.dirty
