From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] verify-tag: use sigchain library to block SIGPIPE
Date: Sat, 20 Mar 2010 00:12:19 -0500
Message-ID: <20100320051219.GB24791@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsqyD-0008V8-Um
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0CTFL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 01:11:29 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:45392 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0CTFL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:11:28 -0400
Received: by ywh2 with SMTP id 2so936308ywh.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 22:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nA2NT3kY4bhCV9rkPLoyh41aZ7cul1ybxY7igNQJ7h4=;
        b=wzbwvXW8LEaKu/PYYTw+Qr1GWqkimJ5q06aRPDy9SYGGGCnuGsNy0qkFQO71u0KMdv
         r1mTJoHn+b5Wdu06yuYuQFKF8GejR+zjni9uRyfjVjj3cwnPiX60M2k8B62/lN/P8Giq
         u2cHKlAuWwa1zpH5FV9lNOsRfRoRlDPF+g1Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HDZGz6PyP2KOVnLI+mrvYBXDLmtKIoXMRWj2oaGobrJTpr6P1tOhe7aakDLLRhvzyw
         Nsc/vXyaWyDS4GKhggDFXNoVgLmKodWiy88mRZOgc/IaDa7GvSwiE+bLyJpMoOChyblG
         jr+qyHEVAsJnkjzQxjKUs0/lbIo4djPu01W58=
Received: by 10.101.133.4 with SMTP id k4mr708332ann.226.1269061887316;
        Fri, 19 Mar 2010 22:11:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm862553iwn.3.2010.03.19.22.11.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320050953.GA24746@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142684>

Without this change, callers cannot use verify_tag() safely without
blocking SIGPIPE themselves.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/verify-tag.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9f482c2..91dd1c1 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -10,6 +10,7 @@
 #include "tag.h"
 #include "run-command.h"
 #include <signal.h>
+#include "sigchain.h"
 #include "parse-options.h"
 
 static const char * const verify_tag_usage[] = {
@@ -54,8 +55,15 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 		return error("could not run gpg.");
 	}
 
+	/*
+	 * gpg will stop as soon as it knows the signature is bad,
+	 * which can result in SIGPIPE.
+	 */
+	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(gpg.in, buf, len);
 	close(gpg.in);
+	sigchain_pop(SIGPIPE);
+
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);
@@ -104,9 +112,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_tag_usage, verify_tag_options);
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
 		if (verify_tag(argv[i++], verbose))
 			had_error = 1;
-- 
1.7.0.2
