From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 15:03:16 -0500
Message-ID: <20141113200315.GA3869@peff.net>
References: <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
 <20141113183033.GA24107@peff.net>
 <xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
 <20141113192655.GA3413@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:03:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp0bz-0001fs-U8
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 21:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911AbaKMUDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 15:03:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:40057 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933146AbaKMUDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 15:03:18 -0500
Received: (qmail 13488 invoked by uid 102); 13 Nov 2014 20:03:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 14:03:18 -0600
Received: (qmail 30662 invoked by uid 107); 13 Nov 2014 20:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:03:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 15:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20141113192655.GA3413@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 02:26:55PM -0500, Jeff King wrote:

> > Makes sense, including the use of strbuf (otherwise you would
> > allocate ce and then discard when it turns out that it is not
> > needed, which is probably with the same allocation pressure, but
> > looks uglier).
> 
> Exactly. Constructing it in ce->name does save you an allocation/memcpy
> in the case that we actually use the new entry, but I thought it would
> look weirder. It probably doesn't matter much either way, so I tried to
> write the most obvious thing.

Actually, it is not that bad:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..5a78758 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -67,6 +67,7 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 {
 	int len;
 	struct cache_entry *ce;
+	int pos;
 
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
@@ -79,6 +80,23 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
+
+	/*
+	 * If the entry is the same as the current index, we can leave the old
+	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
+	 * do the right thing.
+	 */
+	pos = cache_name_pos(ce->name, ce->ce_namelen);
+	if (pos >= 0) {
+		struct cache_entry *old = active_cache[pos];
+		if (ce->ce_mode == old->ce_mode &&
+		    !hashcmp(ce->sha1, old->sha1)) {
+			old->ce_flags |= CE_UPDATE;
+			free(ce);
+			return 0;
+		}
+	}
+
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
 }

and in some ways more readable, as you form the whole thing, and then as
the final step either add it, or realize that what is there is fine (I'd
almost wonder if it could be a flag to add_cache_entry).

-Peff
