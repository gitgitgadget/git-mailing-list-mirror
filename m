From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 5/7] imap-send: provide fall-back random-source
Date: Sat, 3 Oct 2009 16:43:17 -0400
Message-ID: <20091003204317.GB9058@sigill.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
 <20091003095811.GB17873@coredump.intra.peff.net>
 <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org, mike@codeweavers.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:45:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuBTm-0008PG-Jc
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbZJCUn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbZJCUn4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:43:56 -0400
Received: from peff.net ([208.65.91.99]:45835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584AbZJCUnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 16:43:55 -0400
Received: (qmail 6282 invoked by uid 107); 3 Oct 2009 20:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 03 Oct 2009 16:46:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 16:43:17 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0910031145l2849697ftd2da2f5aaa28d957@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129504>

On Sat, Oct 03, 2009 at 11:45:55AM -0700, Erik Faye-Lund wrote:

> I tried to trace this a little bit, but I got lost a bit in the
> callback-stuff. However, it looks to me like it might get sent to the
> server: it gets injected into cb.data in imap_store_msg(), and in
> v_issue_imap_cmd() it gets sent to the server if the LITERALPLUS
> capability is supported. I might be wrong though, as I find this code
> quite confusing.

It does get stored on the server either way (LITERALPLUS is just an imap
server extension that gives us different options for how we send). The
code actually munges an extra "X-TUID" rfc822 header into your message,
which has a randomly generated value. But we never _use_ the value for
anything. I think it is just inherited via cut-and-paste from the
original isync, which I guess actually does use it for synchronization.

The patch below rips it (and the arc4 code) out completely. It still
works in my simple test case, but I am not really an imap-send user, so
caveat emptor.

The other confusing bit is that the code carefully tracks the "uid"
(deep within the call chain it munges cb.ctx, which is a pointer to uid)
which is assigned to the newly created message by the server. This could
be used by a client to later refer to the same message unambiguously.
But we never do that, and just throw away the uid value that the server
gives us.  Again, I suspect this is a holdover from isync wanting to do
repeated synchronization (and it looks like this x-tuid stuff may be
about working around servers which don't support certain uid
operations).

So that could probably be ripped out, too, with no ill effect.

That's just from looking at the code for a few minutes. I would not be
surprised if there is more useless cruft, nor would I be surprised to
find that I am totally wrong about something above.

Anyway, here is the patch to rip out the arc4 stuff. It has a very
pleasant diff-stat. :)

---
 imap-send.c |  130 ++--------------------------------------------------------
 1 files changed, 5 insertions(+), 125 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..d60a0bd 100644
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
 static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
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
@@ -1491,9 +1374,6 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	/* init the random number generator */
-	arc4_init();
-
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
 
