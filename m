From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 3/4] verify-tag.c: suppress gpg output if asked
Date: Sun, 23 Nov 2008 22:23:19 -0500
Message-ID: <1227497000-8684-4-git-send-email-deskinm@umich.edu>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
 <1227497000-8684-2-git-send-email-deskinm@umich.edu>
 <1227497000-8684-3-git-send-email-deskinm@umich.edu>
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 04:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4S4K-00061G-Fc
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYKXDXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYKXDXh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:23:37 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:59877 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYKXDXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:23:32 -0500
Received: by gxk4 with SMTP id 4so1583175gxk.13
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=RZTih66eEnp4IeNgxcwEr2ouxNas4RzLDlwNIzWJ3qQ=;
        b=b4olcUlKE+Lm/7nxQmfanjMwAyTwMDDYeUQ1syUh+LIR8vP8Z555sJM4pSeObrYXm9
         1Z1uGYGg087DxyD4xWYJaIfOlgSJBQH7kOUX9mk9hs6hFb0rrmxepVmweMyQ6zUsWMYd
         IVjCCbxd0h60jjxTv/RUDPUn5fuXPK3YgtvZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=oOYkm8a5PQ3Z888oH58luP9BxcFa8t5WTza8Oe7wh5mA2+jKqCzq5LpX72iUkE2wpP
         1BqcWlvEziNNg1ZaZ/H7vKiakEWVAGJ2Zg8x735EWSQWbtf6teph7549tFdmTdRPvt2U
         wESgwomW37+11IUQ4LgXmbSfA7d3jjwUxcUvg=
Received: by 10.150.228.19 with SMTP id a19mr2812015ybh.198.1227497009952;
        Sun, 23 Nov 2008 19:23:29 -0800 (PST)
Received: from localhost.localdomain ([152.160.57.162])
        by mx.google.com with ESMTPS id a13sm6706484rnc.12.2008.11.23.19.23.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 19:23:29 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.770.ga8394
In-Reply-To: <1227497000-8684-3-git-send-email-deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101586>

Previously, tag verification would output messages from gpg on standard
error.  Allow this to be controlled by a parameter to verify_tag_sha1.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 verify-tag.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/verify-tag.c b/verify-tag.c
index c3e35f3..b47acc9 100644
--- a/verify-tag.c
+++ b/verify-tag.c
@@ -35,13 +35,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-	if (verbose)
+	if (verbose == 1)
 		write_in_full(1, buf, len);
 
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args_gpg;
 	gpg.in = -1;
 	args_gpg[2] = path;
+	if (verbose == -1)
+		gpg.no_stderr = 1;
 	save_handle = signal(SIGPIPE, SIG_IGN);
 	if (start_command(&gpg)) {
 		unlink(path);
-- 
1.6.0.4.770.ga8394
