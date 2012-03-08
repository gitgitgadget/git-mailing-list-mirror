From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/5] srv: tolerate broken DNS replies
Date: Thu, 8 Mar 2012 07:23:39 -0600
Message-ID: <20120308132339.GH9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dJv-0006VP-5x
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab2CHNXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:23:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34217 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2CHNXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:23:44 -0500
Received: by ghrr11 with SMTP id r11so161314ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wH0T2RXppu8O8wAj2hsN7N7ak6Nm7k1FQ0bDvSh6jyw=;
        b=Kdh1FnBnMv14ws6goG4KNzzJCRwMoaAqCkzT66rhLS0NNVORJ6O7BBtOFqF/I10WH2
         PLSohoz8pvm0nOySwUVCHZO7q/V+QHT10GfVC3OHRwnrxZeH6RIRGl4/xUNuWjoV3H9z
         dS9f1xGAzAlipa+A5Y5i/tuezKk1JtInoU6xlENBQQlAXcvIHTpUG88pD6BJli2Cwxh0
         I3CGPZ3G68j+auKYTXAZxrEDoZfZuJNeQlzW7bUbU8snMvFgHzSBopHABI22guLHpdsw
         eL6rZxX3kVtSbPbJknp8NPrrdDaBjimhRtzn6iVJG7CMNy2N02mmqZj5WFn92Kpn+eV9
         Y7rw==
Received: by 10.60.2.98 with SMTP id 2mr2462306oet.34.1331213024102;
        Thu, 08 Mar 2012 05:23:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gl4sm2531053obb.23.2012.03.08.05.23.42
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192599>

At a hotel with a very broken Wi-Fi setup, Richard found his copy
of git unable to cope:

	% git clone git://git.kitenet.net/mr
	Cloning into 'mr'...
	error: cannot initialize DNS parser: Message too long
	fatal: Unable to look up git.kitenet.net

Other programs gave some warnings but otherwise worked fine.  From a
packet capture, it seems that the response to a SRV query for
_git._tcp.git.kitenet.net in this setup was a single A resource record
pointing to the link-local address 169.254.1.1, followed by two
trailing bytes: c0 1a.  The trailing bytes cause the underlying parser
to fail.

It would not be good to silently tolerate this and similar kinds of
brokenness, but working around it would help people on affected
systems to recover.  Luckily RFC2782 gives us enough leeway to act as
we please for this particular kind of error, so give a warning and
fall back to an A/AAAA query (which should work).

Similarly, if we receive non-SRV RRs in response to a SRV query,
RFC2782 does not say to error out, so in the spirit of graceful
degradation let's warn and skip those records.

Reported-by: Richard Hartmann <richih.mailinglist@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  That's the end of the series.

Good night,
Jonathan

 srv.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/srv.c b/srv.c
index 2716206e..829ef762 100644
--- a/srv.c
+++ b/srv.c
@@ -83,7 +83,6 @@ static int srv_parse(ns_msg *msg, struct parsed_srv_rr **res)
 {
 	struct parsed_srv_rr *rrs = NULL;
 	int nr_parsed = 0;
-	int cnames = 0;
 	int i, n;
 
 	n = ns_msg_count(*msg, ns_s_an);
@@ -98,30 +97,33 @@ static int srv_parse(ns_msg *msg, struct parsed_srv_rr **res)
 		if (ns_rr_type(rr) != ns_t_cname)
 			break;
 	}
-	cnames = i;
-	n -= cnames;
 
-	rrs = xmalloc(n * sizeof(*rrs));
-	for (i = 0; i < n; i++) {
+	rrs = xmalloc((n - i) * sizeof(*rrs));
+	for (; i < n; i++) {
 		ns_rr rr;
 
-		if (ns_parserr(msg, ns_s_an, cnames + i, &rr)) {
+		if (ns_parserr(msg, ns_s_an, i, &rr)) {
 			error("cannot parse DNS RR: %s", strerror(errno));
 			goto fail;
 		}
 		if (ns_rr_type(rr) != ns_t_srv) {
-			error("expected SRV RR, found RR type %d",
+			/*
+			 * Maybe the server is playing tricks and returned
+			 * an A record.  Let it pass and if we don't get
+			 * any SRV RRs, we can fall back to an A lookup.
+			 */
+			warning("expected SRV RR, found RR type %d",
 						(int) ns_rr_type(rr));
-			goto fail;
+			continue;
 		}
-		if (srv_parse_rr(msg, &rr, rrs + i))
+		if (srv_parse_rr(msg, &rr, rrs + nr_parsed))
 			/* srv_parse_rr writes a message */
 			goto fail;
 		nr_parsed++;
 	}
 
 	*res = rrs;
-	return n;
+	return nr_parsed;
 fail:
 	for (i = 0; i < nr_parsed; i++)
 		free(rrs[i].target);
@@ -274,13 +276,23 @@ int get_srv(const char *host, struct host **hosts)
 	if (len < 0)
 		goto out;
 
+	/*
+	 * If the reply to a SRV query is malformed, fall back to an
+	 * A query.
+	 *
+	 * The RFC2782 usage rules don't say anything about this, but
+	 * in practice, it seems that some firewalls or DNS servers
+	 * (think: captive portal) handle A queries sensibly and
+	 * provide malformed replies in response to SRV queries.
+	 */
+	if (ns_initparse(buf, len, &msg)) {
+		warning("cannot parse SRV response: %s", strerror(errno));
+		goto out;
+	}
+
 	/* If a SRV RR cannot be parsed, give up. */
 	ret = -1;
 
-	if (ns_initparse(buf, len, &msg)) {
-		error("cannot initialize DNS parser: %s", strerror(errno));
-		goto out;
-	}
 	n = srv_parse(&msg, &rrs);
 	if (n < 0)
 		/* srv_parse writes a message */
-- 
1.7.9.2
