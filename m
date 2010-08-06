From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] check-ref-format: handle subcommands in separate
 functions
Date: Thu, 5 Aug 2010 22:36:07 -0500
Message-ID: <20100806033606.GR22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
 <20100806033411.GQ22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDkU-0004KN-Ns
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046Ab0HFDha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 23:37:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41198 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645Ab0HFDh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:37:28 -0400
Received: by ywh1 with SMTP id 1so2696482ywh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K88gbMMnGxLOFI7H/4MT7Sr6bMcIA844RdMUxtgg9/o=;
        b=P4QHWDdBP4amyZc3Im3wRl2/uyi3zjNGf0vmm+Fode4tZwd0Jhg+y9l0zOwyaFpSma
         hWhmYjysq7SbGpMGI2Qqd13LaWM51ArIWJAuJILA7qiKtIV3AvE+h58NdYycyf80QE2+
         TpgKLXQGQ/BATJb20UbhHdF9JKm0pVO1NWcxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HPIUxLUOZYFZ0SRUOHuN5fNh+UZQTxNGNM+P68+LVJSCsnjya80nDt7xoPveGbuE8V
         JpasqYzz8UnXGbYXgP5gj9B1nlvt44E9W9vUF99Fq6qUuIkbN8Od4cGDPZLjfTFQhmrp
         RY6cjeDqcBLU5W6U3H4Xp/Ti+OSZiwU6fTWIU=
Received: by 10.100.30.1 with SMTP id d1mr13020834and.76.1281065847771;
        Thu, 05 Aug 2010 20:37:27 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c6sm1319310anj.31.2010.08.05.20.37.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:37:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806033411.GQ22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152760>

The code for each subcommand should be easier to read and manipulate
this way.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/check-ref-format.c |   42 +++++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index b106c65..8707ee9 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -33,28 +33,36 @@ static void collapse_slashes(char *dst, const char *src)
 	*dst = '\0';
 }
 
+static int check_ref_format_branch(const char *arg)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_check_branch_ref(&sb, arg))
+		die("'%s' is not a valid branch name", arg);
+	printf("%s\n", sb.buf + 11);
+	return 0;
+}
+
+static int check_ref_format_print(const char *arg)
+{
+	char *refname = xmalloc(strlen(arg) + 1);
+
+	if (check_ref_format(arg))
+		return 1;
+	collapse_slashes(refname, arg);
+	printf("%s\n", refname);
+	return 0;
+}
+
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
 
-	if (argc == 3 && !strcmp(argv[1], "--branch")) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (strbuf_check_branch_ref(&sb, argv[2]))
-			die("'%s' is not a valid branch name", argv[2]);
-		printf("%s\n", sb.buf + 11);
-		exit(0);
-	}
-	if (argc == 3 && !strcmp(argv[1], "--print")) {
-		char *refname = xmalloc(strlen(argv[2]) + 1);
-
-		if (check_ref_format(argv[2]))
-			exit(1);
-		collapse_slashes(refname, argv[2]);
-		printf("%s\n", refname);
-		exit(0);
-	}
+	if (argc == 3 && !strcmp(argv[1], "--branch"))
+		return check_ref_format_branch(argv[2]);
+	if (argc == 3 && !strcmp(argv[1], "--print"))
+		return check_ref_format_print(argv[2]);
 	if (argc != 2)
 		usage(builtin_check_ref_format_usage);
 	return !!check_ref_format(argv[1]);
-- 
1.7.2.1.544.ga752d.dirty
