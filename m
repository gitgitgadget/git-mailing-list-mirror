From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] do not discard constness in interp_set_entry value argument
Date: Thu, 28 Sep 2006 21:12:55 +0200
Message-ID: <20060928191255.GB4294@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 28 21:13:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1K4-0000h9-1T
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWI1TNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWI1TNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:13:25 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:29401 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030322AbWI1TNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:13:24 -0400
Received: from fwd33.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1GT1Jp-0006D1-04; Thu, 28 Sep 2006 21:13:13 +0200
Received: from tigra.home (JO3GUYZ18evhGaolyZ8Bxz3io+ChfRjBVPoA9LigbAnuD7+rQfAEcS@[84.160.84.153]) by fwd33.sul.t-online.de
	with esmtp id 1GT1Ja-1unx560; Thu, 28 Sep 2006 21:12:58 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 793C0277AF;
	Thu, 28 Sep 2006 21:12:55 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GT1JX-00022W-8H; Thu, 28 Sep 2006 21:12:55 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-ID: JO3GUYZ18evhGaolyZ8Bxz3io+ChfRjBVPoA9LigbAnuD7+rQfAEcS
X-TOI-MSGID: d0533931-3d5a-4e55-b5c8-10e5f1c486d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28036>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Actually, both of the struct interp's fields could be made const,
if not this interp_set_entry. And even then it could just return
the old value of ->value casting away its constness. I.e.:

struct interp
{
    const char *name;
    const char *value;
};

static inline char *interp_set_entry(struct interp *table, int slot, const char *value)
{
	char *oldval = (char *)table[slot].value;

	table[slot].value = newval;
	return oldval;
}

The caller can than decide if it should be freed. This leaves
compiler with a chance to optimize something.

diff --git a/interpolate.c b/interpolate.c
index 62701d8..5d9d188 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -8,10 +8,10 @@ #include "git-compat-util.h"
 #include "interpolate.h"
 
 
-void interp_set_entry(struct interp *table, int slot, char *value)
+void interp_set_entry(struct interp *table, int slot, const char *value)
 {
 	char *oldval = table[slot].value;
-	char *newval = value;
+	char *newval = NULL;
 
 	if (oldval)
 		free(oldval);
diff --git a/interpolate.h b/interpolate.h
index a55fb8e..190a180 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -16,7 +16,7 @@ struct interp {
 	char *value;
 };
 
-extern void interp_set_entry(struct interp *table, int slot, char *value);
+extern void interp_set_entry(struct interp *table, int slot, const char *value);
 extern void interp_clear_table(struct interp *table, int ninterps);
 
 extern int interpolate(char *result, int reslen,
