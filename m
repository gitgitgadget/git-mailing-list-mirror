From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/3] transport.c::transport_push(): make ref status
 affect return value
Date: Tue, 8 Dec 2009 22:36:49 +0800
Message-ID: <20091208223649.d9ff4fed.rctay89@gmail.com>
References: <20091208223543.c7f88afe.rctay89@gmail.com>,
 <20091208223413.98e99d3e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 15:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1BX-0005RH-S5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbZLHOgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbZLHOgv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:36:51 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:54076 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbZLHOgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:36:50 -0500
Received: by gxk26 with SMTP id 26so5141535gxk.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2FnyGxNhiMNcPnwVbjSRrv0UKp6KHSJvFqM78zqq1gY=;
        b=G3nBxIp/G5i1gqnILt/CvwI8ZUtEhW3kg1tuZJyqkbD7WBl1sWE5kfL+Kj6d+kVV2b
         yNVVjWXBo86gI1ZVn1EBPLX56pv8cGoB3iEJ0aaJsnTkHlZVWzGgnR7Etimtfb2GZcBo
         yBTSo/5rEFyn68Xl8Gkoz8PN89hcddpyguMp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=BHychS5cYk6qqOPjHdOwmKVEH94B83pbH1sHe7C34/0epsV3ZMyLxcCqcL/+A20EYF
         +iA5vLg8ooFE4U9bbYbrNEBIuutYEsDFSmkmX82tXwO3jmAg0+r9BB/MJeBSvijVn3xN
         R2KN3sxDUZIj41o2DSLz0xm4u7kfNJWDbtcRo=
Received: by 10.150.128.11 with SMTP id a11mr4540694ybd.208.1260283017177;
        Tue, 08 Dec 2009 06:36:57 -0800 (PST)
Received: from your-cukc5e3z5n (cm67.zeta153.maxonline.com.sg [116.87.153.67])
        by mx.google.com with ESMTPS id 14sm3423244gxk.14.2009.12.08.06.36.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:36:56 -0800 (PST)
In-Reply-To: <20091208223413.98e99d3e.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134879>

Use push_had_errors() to check the refs for errors and modify the
return value.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Rewrote this.

 transport.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 12c4423..9b23989 100644
--- a/transport.c
+++ b/transport.c
@@ -875,7 +875,7 @@ int transport_push(struct transport *transport,
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
-		int ret;
+		int ret, err;

 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -892,8 +892,11 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);

 		ret = transport->push_refs(transport, remote_refs, flags);
+		err = push_had_errors(remote_refs);

-		if (!quiet || push_had_errors(remote_refs))
+		ret |= err;
+
+		if (!quiet || err)
 			print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
--
1.6.4.4
