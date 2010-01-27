From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Wed, 27 Jan 2010 06:40:09 -0500
Message-ID: <20100127114009.GE6262@coredump.intra.peff.net>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vpr4wy2lk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 12:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Fx-0003XX-De
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab0A0LkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914Ab0A0LkP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:40:15 -0500
Received: from peff.net ([208.65.91.99]:37638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab0A0LkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 06:40:14 -0500
Received: (qmail 6033 invoked by uid 107); 27 Jan 2010 11:40:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 27 Jan 2010 06:40:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2010 06:40:09 -0500
Content-Disposition: inline
In-Reply-To: <7vpr4wy2lk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138129>

On Tue, Jan 26, 2010 at 01:32:07PM -0800, Junio C Hamano wrote:

> I don't know if it deals with things like "@{-1}@{u}@{now}"; the users
> should have every right to expect it to, but I didn't consciously try to
> make that work with this patch.

Nice. This also fixes "git log -g @{-1}". Static uses like "git show
@{u}@{1.week.ago}" and "git show @{-1}@{1.week.ago}" were already fine,
so I think the bug was really confined to the reflog walker (and your
fix is therefore correct).

Using "git show @{-1}@{u}" is still broken, though.

I tried tracing the parsing through get_sha1_basic and
interpret_branch_name, but it's pretty confusing. Especially as we seem
to deal with @{upstream}, @{now}, and @{-1} at different places.

I think the patch below does what we want, but the whole thing feels
overly complicated to me, especially with the split of parsing @{...}
between get_sha1_basic and interpret_branch_name. I guess we have spots
that don't take reflogs but do take branch names, but I think the code
would be much simpler if the syntax were parsed in one place, and then
we threw out or complained about bogus semantics (like "checkout
@{now}").

---
diff --git a/sha1_name.c b/sha1_name.c
index ed4c028..ef8f3fa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -881,8 +881,28 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 
 	if (!len)
 		return len; /* syntax Ok, not enough switches */
-	if (0 < len)
-		return len; /* consumed from the front */
+	if (0 < len && len == namelen)
+		return len; /* consumed all */
+	else if (0 < len) {
+		/* we have extra data, which might need further processing */
+		struct strbuf tmp = STRBUF_INIT;
+		int used = buf->len;
+		int ret;
+
+		strbuf_add(buf, name + len, namelen - len);
+		ret = interpret_branch_name(buf->buf, &tmp);
+		/* that data was not interpreted, remove our cruft */
+		if (ret < 0) {
+			strbuf_setlen(buf, used);
+			return len;
+		}
+		strbuf_reset(buf);
+		strbuf_addbuf(buf, &tmp);
+		strbuf_release(&tmp);
+		/* tweak for size of {-N} versus expanded ref name */
+		return ret - used + len;
+	}
+
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
