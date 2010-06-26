From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 06/12] add range clone functions
Date: Sat, 26 Jun 2010 06:27:31 -0700
Message-ID: <1277558857-23103-7-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQl-0007r7-US
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0FZN2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36015 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0FZN2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:06 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so1126863pxi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G8TAc9oHfkFM+HABhHkBIF44jGnOoduZ17QzewInGYc=;
        b=La9uhxprAudtlUg2rr9xaNan+xLqrIKlSlTEPoHbL3LJ0Q7KoMKgUwaiwogH9sgNmI
         gp66uhGlBG3Wy+6/iA5zNkO4vaHZhFTYgK1uXd1f+5Z7Hv1iYbzVaL0dSOJxKtfPQiB4
         E7uMrzgyg62kF14XWBGEgOYiEJLaiqVAILoI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fhpp6NdWUQYMn+3p8odm7CCMAddgUpHNQxo6di9wWNsF0B8gWeIYtnsh6V+r+nGmCO
         Xs3lieiMdNrsc6O6G8oGF1/Bc3A80vryrBfIo/v4CfzIYDcn0PZOXdd1nTYx9yurbwOy
         12pdhTEaENsJIT2tzkd3M28z6qJboa8gFlj34=
Received: by 10.142.2.23 with SMTP id 23mr849112wfb.288.1277558886186;
        Sat, 26 Jun 2010 06:28:06 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149748>

Both single range clone and deeply clone are supported.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   35 +++++++++++++++++++++++++++++++++++
 line.h |    4 ++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index 7b7f3f3..f765a03 100644
--- a/line.c
+++ b/line.c
@@ -370,6 +370,41 @@ void diff_line_range_append(struct diff_line_range *r, const char *arg)
 	r->ranges[r->nr - 1].arg = arg;
 }
 
+struct diff_line_range *diff_line_range_clone(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = xmalloc(sizeof(*ret));
+
+	DIFF_LINE_RANGE_INIT(ret);
+	ret->ranges = xcalloc(sizeof(struct range), r->nr);
+	memcpy(ret->ranges, r->ranges, sizeof(struct range) * r->nr);
+
+	ret->alloc = ret->nr = r->nr;
+
+	ret->spec = r->spec;
+	assert(ret->spec);
+	ret->spec->count++;
+
+	return ret;
+}
+
+struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r)
+{
+	struct diff_line_range *ret = NULL;
+	struct diff_line_range *tmp = NULL, *prev = NULL;
+
+	assert(r);
+	ret = tmp = prev = diff_line_range_clone(r);
+	r = r->next;
+	while (r) {
+		tmp = diff_line_range_clone(r);
+		prev->next = tmp;
+		prev = tmp;
+		r = r->next;
+	}
+
+	return ret;
+}
+
 struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
 	struct diff_line_range *other)
 {
diff --git a/line.h b/line.h
index a2f8545..b6f328c 100644
--- a/line.h
+++ b/line.h
@@ -110,6 +110,10 @@ extern void diff_line_range_append(struct diff_line_range *r, const char *arg);
 
 extern void diff_line_range_clear(struct diff_line_range *r);
 
+extern struct diff_line_range *diff_line_range_clone(struct diff_line_range *r);
+
+extern struct diff_line_range *diff_line_range_clone_deeply(struct diff_line_range *r);
+
 extern struct diff_line_range *diff_line_range_merge(struct diff_line_range *out,
 	struct diff_line_range *other);
 
-- 
1.7.1.577.g36cf0.dirty
