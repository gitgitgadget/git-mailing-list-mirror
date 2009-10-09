From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 1/8] imap-send: remove useless uid code
Date: Fri,  9 Oct 2009 17:04:35 +0200
Message-ID: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH88-0007fT-IF
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760939AbZJIPFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758831AbZJIPFs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:05:48 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49018 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760909AbZJIPFq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:05:46 -0400
Received: by ewy4 with SMTP id 4so697151ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PwWQHgbvP/fu97n74ThLiDxDYlUrNWahIoC8/ctN9nI=;
        b=ozIRuprVezAoX1d44X9YH4AEBYVRxkFCpLjRpKOWjUu0oJbKmC/f20m6Jop+ZOfGYb
         9RR85yyAQ7P9ziFgCoHxYOn+K90xpNi7BBDxBd7utLN47nTfxZZb7JNoOsv1nyJEWgCX
         wCRESrOaclXSyXz80nRoq4sZvEhvG4050WFzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AJqxPAWfhTh0EXw8jw4HB4SpDirmNyE/LJBTbMH2sy+pinOQk1iCYCSY/frheUy5Qi
         oZptLMYC8cjQ6Axt2dgEz+8wfjffSTcgTBXCZ4a8SQBT8MgAIf3QJljmRsWqBAfW+A+T
         fz+iyqthtwrjFgnMIJXleOtHgeLb8zPWltzak=
Received: by 10.211.188.4 with SMTP id q4mr362449ebp.46.1255100709386;
        Fri, 09 Oct 2009 08:05:09 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 24sm173369eyx.41.2009.10.09.08.05.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129814>

From: Jeff King <peff@peff.net>

The imap-send code is based on code from isync, a program
for syncing imap mailboxes. Because of this, it has
inherited some code that makes sense for isync, but not for
imap-send.

In particular, when storing a message, it does one of:

  - if the server supports it, note the server-assigned
    unique identifier (UID) given to each message

  - otherwise, assigned a random UID and store it in the
    message header as X-TUID

Presumably this is used in isync to be able to synchronize
mailstores multiple times without duplication. But for
imap-send, it the values are useless; we never do anything
with them and simply forget them at the end of the program.

This patch removes the useless code. Not only is it nice for
maintainability to get rid of dead code, but the removed
code relied on the existence of /dev/urandom, which made it
a portability problem for non-Unix platforms.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |  155 ++++------------------------------------------------------
 1 files changed, 11 insertions(+), 144 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..8da7a94 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -123,9 +123,6 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 	return len;
 }
 
-static void arc4_init(void);
-static unsigned char arc4_getbyte(void);
-
 struct imap_server_conf {
 	char *name;
 	char *tunnel;
@@ -489,52 +486,6 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 	return ret;
 }
 
-static struct {
-	unsigned char i, j, s[256];
-} rs;
-
-static void arc4_init(void)
-{
-	int i, fd;
-	unsigned char j, si, dat[128];
-
-	if ((fd = open("/dev/urandom", O_RDONLY)) < 0 && (fd = open("/dev/random", O_RDONLY)) < 0) {
-		fprintf(stderr, "Fatal: no random number source available.\n");
-		exit(3);
-	}
-	if (read_in_full(fd, dat, 128) != 128) {
-		fprintf(stderr, "Fatal: cannot read random number source.\n");
-		exit(3);
-	}
-	close(fd);
-
-	for (i = 0; i < 256; i++)
-		rs.s[i] = i;
-	for (i = j = 0; i < 256; i++) {
-		si = rs.s[i];
-		j += si + dat[i & 127];
-		rs.s[i] = rs.s[j];
-		rs.s[j] = si;
-	}
-	rs.i = rs.j = 0;
-
-	for (i = 0; i < 256; i++)
-		arc4_getbyte();
-}
-
-static unsigned char arc4_getbyte(void)
-{
-	unsigned char si, sj;
-
-	rs.i++;
-	si = rs.s[rs.i];
-	rs.j += si;
-	sj = rs.s[rs.j];
-	rs.s[rs.i] = sj;
-	rs.s[rs.j] = si;
-	return rs.s[(si + sj) & 0xff];
-}
-
 static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 					 struct imap_cmd_cb *cb,
 					 const char *fmt, va_list ap)
@@ -1198,88 +1149,20 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
-#define TUIDL 8
-
-static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
+static int imap_store_msg(struct store *gctx, struct msg_data *data)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
 	struct imap_cmd_cb cb;
-	char *fmap, *buf;
 	const char *prefix, *box;
-	int ret, i, j, d, len, extra, nocr;
-	int start, sbreak = 0, ebreak = 0;
-	char flagstr[128], tuid[TUIDL * 2 + 1];
+	int ret, d;
+	char flagstr[128];
 
 	memset(&cb, 0, sizeof(cb));
 
-	fmap = data->data;
-	len = data->len;
-	nocr = !data->crlf;
-	extra = 0, i = 0;
-	if (!CAP(UIDPLUS) && uid) {
-	nloop:
-		start = i;
-		while (i < len)
-			if (fmap[i++] == '\n') {
-				extra += nocr;
-				if (i - 2 + nocr == start) {
-					sbreak = ebreak = i - 2 + nocr;
-					goto mktid;
-				}
-				if (!memcmp(fmap + start, "X-TUID: ", 8)) {
-					extra -= (ebreak = i) - (sbreak = start) + nocr;
-					goto mktid;
-				}
-				goto nloop;
-			}
-		/* invalid message */
-		free(fmap);
-		return DRV_MSG_BAD;
-	mktid:
-		for (j = 0; j < TUIDL; j++)
-			sprintf(tuid + j * 2, "%02x", arc4_getbyte());
-		extra += 8 + TUIDL * 2 + 2;
-	}
-	if (nocr)
-		for (; i < len; i++)
-			if (fmap[i] == '\n')
-				extra++;
-
-	cb.dlen = len + extra;
-	buf = cb.data = xmalloc(cb.dlen);
-	i = 0;
-	if (!CAP(UIDPLUS) && uid) {
-		if (nocr) {
-			for (; i < sbreak; i++)
-				if (fmap[i] == '\n') {
-					*buf++ = '\r';
-					*buf++ = '\n';
-				} else
-					*buf++ = fmap[i];
-		} else {
-			memcpy(buf, fmap, sbreak);
-			buf += sbreak;
-		}
-		memcpy(buf, "X-TUID: ", 8);
-		buf += 8;
-		memcpy(buf, tuid, TUIDL * 2);
-		buf += TUIDL * 2;
-		*buf++ = '\r';
-		*buf++ = '\n';
-		i = ebreak;
-	}
-	if (nocr) {
-		for (; i < len; i++)
-			if (fmap[i] == '\n') {
-				*buf++ = '\r';
-				*buf++ = '\n';
-			} else
-				*buf++ = fmap[i];
-	} else
-		memcpy(buf, fmap + i, len - i);
-
-	free(fmap);
+	cb.dlen = data->len;
+	cb.data = xmalloc(cb.dlen);
+	memcpy(cb.data, data->data, data->len);
 
 	d = 0;
 	if (data->flags) {
@@ -1288,26 +1171,14 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
 	}
 	flagstr[d] = 0;
 
-	if (!uid) {
-		box = gctx->conf->trash;
-		prefix = ctx->prefix;
-		cb.create = 1;
-		if (ctx->trashnc)
-			imap->caps = imap->rcaps & ~(1 << LITERALPLUS);
-	} else {
-		box = gctx->name;
-		prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
-		cb.create = 0;
-	}
-	cb.ctx = uid;
+	box = gctx->name;
+	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
+	cb.create = 0;
 	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
-	if (!uid)
-		ctx->trashnc = 0;
-	else
-		gctx->count++;
+	gctx->count++;
 
 	return DRV_OK;
 }
@@ -1483,7 +1354,6 @@ int main(int argc, char **argv)
 {
 	struct msg_data all_msgs, msg;
 	struct store *ctx = NULL;
-	int uid = 0;
 	int ofs = 0;
 	int r;
 	int total, n = 0;
@@ -1491,9 +1361,6 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	/* init the random number generator */
-	arc4_init();
-
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
 
@@ -1540,7 +1407,7 @@ int main(int argc, char **argv)
 			break;
 		if (server.use_html)
 			wrap_in_html(&msg);
-		r = imap_store_msg(ctx, &msg, &uid);
+		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
 		n++;
-- 
1.6.5.rc1.60.g41795
