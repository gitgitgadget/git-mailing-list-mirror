From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] transport: fix index in ipv6 connection failed message
Date: Mon, 6 Jun 2011 04:40:54 -0500
Message-ID: <20110606094054.GI8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:41:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWJ0-0003WK-0f
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1FFJlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:41:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62971 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1FFJlA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:41:00 -0400
Received: by iyb14 with SMTP id 14so2955062iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dcsoqpWUdzCmLEGLrEYZ8xCHuCxp21LlLkcId8d0OZc=;
        b=Bc18nLAarAMs2oI2eU2Feux/qWPEQoKGPWpQ8kZeyIsmbnC+R2DGPidV5ClXW/xuy+
         Uf1U08+VckeLanKbcwBuR95pyBE3vQ1IqJRut4hbBn4EBQB04s2J7jhpJDlHfHVCWjSt
         SNTFcYyy2xdKyLZoFm4zi2iZwpUA3zdC3cD4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iXP0gjuNhvWExs3YK+7vG0g8NtevBxFa5Iydwz2W5Dp1w4alhpvACHUFM5RNxHkdBV
         5N3bds7YL1q6WfVF5QGcbauR8hODfJttzxaXDxkso6BeZIUZK3iaPSegMd6xQqaOqjqI
         tWvrqXu8thk/OfIRMxuJDp8cve3tsIlXh+Vqk=
Received: by 10.42.158.200 with SMTP id i8mr8461459icx.465.1307353258485;
        Mon, 06 Jun 2011 02:40:58 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id vn4sm2647414icb.19.2011.06.06.02.40.56
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:40:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175110>

Ever since v1.5.3-rc0~185^2~1 (Verbose connect messages to show
the IP addresses used, 2007-05-23), git's ipv4 connection failure
messages have looked something like

	git.example.com[2: 127.0.0.1]: errno=Network Unreachable

The increasing index ("2" above) indicates which item in the list of
addresses returned by gethostbyname was being tried so the operator
can tell that git was not just trying to resolve the same hostname
again and again.

The ipv6 codepath prints something similar, but the counter is never
incremented so the index is always "0".  Fix it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 tcp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcp.c b/tcp.c
index 2cb90db..9916272 100644
--- a/tcp.c
+++ b/tcp.c
@@ -134,7 +134,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
-	int cnt = 0;
+	int cnt;
 
 	get_host_and_port(&host, &port);
 	if (!*port)
@@ -154,7 +154,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
-	for (ai0 = ai; ai; ai = ai->ai_next) {
+	for (cnt = 0, ai0 = ai; ai; ai = ai->ai_next, cnt++) {
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0) {
-- 
1.7.5.3
