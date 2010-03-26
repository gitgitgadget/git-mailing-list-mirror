From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Use strbufs instead of open-coded string manipulation
Date: Fri, 26 Mar 2010 23:56:01 +0100
Message-ID: <20100326225601.GA9177@blimp.localdomain>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org> <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com> <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil> <81b0412b1003251611h62222eabw247ec59678c198ad@mail.gmail.com> <20100326225356.GA6797@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 23:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIRs-0006TL-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 23:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab0CZW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 18:56:11 -0400
Received: from mout5.freenet.de ([195.4.92.95]:33393 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab0CZW4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 18:56:09 -0400
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #2)
	id 1NvIRh-00081q-D3; Fri, 26 Mar 2010 23:56:05 +0100
Received: from p57b1a08b.dip0.t-ipconnect.de ([87.177.160.139]:53311 helo=tigra.home)
	by 1.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.72 #2)
	id 1NvIRh-0006PM-2Q; Fri, 26 Mar 2010 23:56:05 +0100
Received: from blimp.localdomain (blimp.home [192.168.0.79])
	by tigra.home (Postfix) with ESMTP id D23B2277DF;
	Fri, 26 Mar 2010 23:56:01 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 8F7CD36D28; Fri, 26 Mar 2010 23:56:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100326225356.GA6797@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143294>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 config.c |   51 +++++++++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index 83ebe0c..7a514fa 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "strbuf.h"
 
 #define MAXNAME (256)
 
@@ -21,8 +22,8 @@ const char *config_exclusive_filename = NULL;
 struct config_item
 {
 	struct config_item *next;
+	char *name;
 	char *value;
-	char name[1 /* NUL */];
 };
 static struct config_item *config_parameters;
 static struct config_item **config_parameters_tail = &config_parameters;
@@ -32,43 +33,29 @@ static void lowercase(char *p)
 	for (; *p; ++p)
 		*p = tolower(*p);
 }
-static char *skip_space(const char *p)
-{
-	for (; *p; ++p)
-		if (!isspace(*p))
-			break;
-	return (char *)p;
-}
-static char *trailing_space(const char *begin, const char *p)
-{
-	while (p-- > begin)
-		if (!isspace(*p))
-			break;
-	return (char *)p + 1;
-}
 
 int git_config_parse_parameter(const char *text)
 {
 	struct config_item *ct;
-	const char *name;
-	const char *val;
-	name = skip_space(text);
-	text = val = strchr(name, '=');
-	if (!text)
-		text = name + strlen(name);
-	text = trailing_space(name, text);
-	if (text <= name)
+	struct strbuf tmp = STRBUF_INIT;
+	struct strbuf **pair;
+	strbuf_addstr(&tmp, text);
+	pair = strbuf_split(&tmp, '=');
+	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=')
+		strbuf_setlen(pair[0], pair[0]->len - 1);
+	strbuf_trim(pair[0]);
+	if (!pair[0]->len) {
+		strbuf_list_free(pair);
 		return -1;
-	ct = xcalloc(1, sizeof(struct config_item) + (text - name));
-	memcpy(ct->name, name, text - name);
-	lowercase(ct->name);
-	if (!val)
-		ct->value = NULL;
-	else {
-		val = skip_space(++val /* skip "=" */);
-		text = trailing_space(val, val + strlen(val));
-		ct->value = xstrndup(val, text - val);
 	}
+	ct = xcalloc(1, sizeof(struct config_item));
+	ct->name = strbuf_detach(pair[0], NULL);
+	if (pair[1]) {
+		strbuf_trim(pair[1]);
+		ct->value = strbuf_detach(pair[1], NULL);
+	}
+	strbuf_list_free(pair);
+	lowercase(ct->name);
 	*config_parameters_tail = ct;
 	config_parameters_tail = &ct->next;
 	return 0;
-- 
1.7.0.3.309.g532f0
