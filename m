From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back random-source
Date: Thu, 8 Oct 2009 20:03:50 -0400
Message-ID: <20091009000350.GA5217@coredump.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
 <20091003095811.GB17873@coredump.intra.peff.net>
 <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
 <20091003204317.GB9058@sigill.intra.peff.net>
 <20091003205217.GC9058@sigill.intra.peff.net>
 <40aa078e0910081616wc1129edr2e1397964a0e6ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org, mike@codeweavers.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 02:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw302-0004Ay-2L
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 02:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbZJIAEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 20:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536AbZJIAEa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 20:04:30 -0400
Received: from peff.net ([208.65.91.99]:44665 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994AbZJIAE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 20:04:29 -0400
Received: (qmail 10840 invoked by uid 107); 9 Oct 2009 00:07:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Oct 2009 20:07:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Oct 2009 20:03:50 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0910081616wc1129edr2e1397964a0e6ae5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129723>

On Fri, Oct 09, 2009 at 01:16:50AM +0200, Erik Faye-Lund wrote:

> > And here is a patch (on top of the earlier one) to do that.
> 
> Alright, so I'm spinning a new version of this series, and I'm
> wondering a bit how to include patches like these, where there's no
> commit message (because it was a sketch or something, I guess) or
> sign-off. Should I send the commit-messages to the author and have the
> him/her sign off on them, or should I set me as author and credit the
> real author for the actual work in the commit message? I see the
> latter have been done quite a bit in git.git already. The benefit of
> the first one is of course that authorship is retained, but the
> backside is that it incorrectly looks like the author wrote the commit
> message.
> 
> Are there any preferences?

Usually a "something like this" patch means it is not very well tested,
and that was certainly the case here (I don't even used imap-send). But
if somebody else (like you) concurs that it is the sane thing to do and
has tested or run with it for a while, then maybe it is time to promote
it.

As for how to do that, both of your proposed solutions happen in
practice. Usually I would only mark myself as author if I picked up
somebody's "how about this" and tweaked it significantly or added
something to it. If you write the commit message, or add tests, or
whatever, then usually it is a good idea to just say so in the commit
message.

But when in doubt, ask the original author what they want to do. In this
case, I think it is best for me to write the message, as I did a fair
bit of looking into the reasons for this code.

So here goes. It's still only lightly tested by me, but we have no test
scripts at all for imap-send. I suspect getting it into 'next' is the
best way to actually get it tested.

-- >8 --
Subject: [PATCH] imap-send: remove useless uid code

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
---
As you may be able to tell from the commit message, this is both of the
patches rolled into one. I could probably rip out even more, but it's
not really worth the time. This one solves the portability issue.

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
1.6.5.rc3.206.g63d9c
