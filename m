Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987741FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdC1Rfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:35:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:53018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbdC1Rfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:35:42 -0400
Received: (qmail 3667 invoked by uid 109); 28 Mar 2017 17:35:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 17:35:39 +0000
Received: (qmail 7184 invoked by uid 111); 28 Mar 2017 17:35:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 13:35:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 13:35:37 -0400
Date:   Tue, 28 Mar 2017 13:35:37 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
Message-ID: <20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
 <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:13:15AM +0000, brian m. carlson wrote:

> > I suggested an additional cleanup around "linelen" in one patch. In the
> > name of keeping the number of re-rolls sane, I'm OK if we skip that for
> > now (the only reason I mentioned it at all is that you have to justify
> > the caveat in the commit message; with the fix, that justification can
> > go away).
> 
> Let's leave it as it is, assuming Junio's okay with it.  I can send in a
> few more patches to clean that up and use skip_prefix that we can drop
> on top and graduate separately.
> 
> I think the justification is useful as it is, since it explains why we
> no longer want to check that particular value for historical reasons.

I thought I'd knock this out quickly before I forgot about it. But it
actually isn't so simple.

The main caller in read_head_info() does indeed just pass strlen(line)
as the length in each case. But the cert parser really does need us to
respect the line length. So we either have to pass it in, or tie off the
string.

The latter looks something like the patch below (on top of a minor
tweak around "eol" handling). It's sufficiently ugly that it may not
count as an actual cleanup, though. I'm OK if we just drop the idea.

---
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 58de2a1a9..561a982e7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1483,13 +1483,10 @@ static void execute_commands(struct command *commands,
 }
 
 static struct command **queue_command(struct command **tail,
-				      const char *line,
-				      int linelen)
+				      const char *line)
 {
 	struct object_id old_oid, new_oid;
 	struct command *cmd;
-	const char *refname;
-	int reflen;
 	const char *p;
 
 	if (parse_oid_hex(line, &old_oid, &p) ||
@@ -1498,9 +1495,7 @@ static struct command **queue_command(struct command **tail,
 	    *p++ != ' ')
 		die("protocol error: expected old/new/ref, got '%s'", line);
 
-	refname = p;
-	reflen = linelen - (p - line);
-	FLEX_ALLOC_MEM(cmd, ref_name, refname, reflen);
+	FLEX_ALLOC_STR(cmd, ref_name, p);
 	oidcpy(&cmd->old_oid, &old_oid);
 	oidcpy(&cmd->new_oid, &new_oid);
 	*tail = cmd;
@@ -1510,7 +1505,7 @@ static struct command **queue_command(struct command **tail,
 static void queue_commands_from_cert(struct command **tail,
 				     struct strbuf *push_cert)
 {
-	const char *boc, *eoc;
+	char *boc, *eoc;
 
 	if (*tail)
 		die("protocol error: got both push certificate and unsigned commands");
@@ -1523,10 +1518,17 @@ static void queue_commands_from_cert(struct command **tail,
 	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len);
 
 	while (boc < eoc) {
-		const char *eol = memchr(boc, '\n', eoc - boc);
+		char *eol = memchr(boc, '\n', eoc - boc);
+		char tmp;
+
 		if (!eol)
 			eol = eoc;
-		tail = queue_command(tail, boc, eol - boc);
+
+		tmp = *eol;
+		*eol = '\0';
+		tail = queue_command(tail, boc);
+		*eol = tmp;
+
 		boc = eol + 1;
 	}
 }
@@ -1590,7 +1592,7 @@ static struct command *read_head_info(struct oid_array *shallow)
 			continue;
 		}
 
-		p = queue_command(p, line, linelen);
+		p = queue_command(p, line);
 	}
 
 	if (push_cert.len)
