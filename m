From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] builtin/help.c: fix memory leak
Date: Mon,  9 Mar 2015 09:58:24 -0700
Message-ID: <1425920304-22360-3-git-send-email-sbeller@google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 09 17:58:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV10s-0002Cd-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbbCIQ6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:58:35 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47070 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbCIQ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:58:31 -0400
Received: by iecrd18 with SMTP id rd18so14175512iec.13
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txsMBTX9Mc29RZ1u6UDXNsocr4T0j03dNpIAkhosEdI=;
        b=GmoiSeaLZSnq0pd+lgczBfLGamuascXzydbd5IJE1bLu7ERZkZjluPTkMUnJZbTEYS
         BEsy2OkegkgLMrPKmVDEy0NNJq+hICvbqw/sY2Nh4CViRl8QyV9ZK9EGt8faAe5SoSNL
         xvSTkukHIaMilOXlw1mbcpbbRq55RjMMsi59oGBRA/fJf7mYRuVBelU8cuyezkb5yN0+
         fnnjwByU7S8I76sR7l1Q4+RCj7co6JOAUP+DgaSTthaeAR9GZ0DrcKbvZX+JTcOYIBP8
         4Qj3jbGavCuzhqeDcY+czMdk8c7bBmihhjGf48JY6xKYE2DLlBANRGrZ7KvcO2TIbzV0
         LpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txsMBTX9Mc29RZ1u6UDXNsocr4T0j03dNpIAkhosEdI=;
        b=Kw3JHDjr+7w6nt8bGpf91ApdgaL+fS4wmvTKdHglJLDtPTgOT6+mWByEAnRRwI1w4y
         ToepzCLwYnzvwoSVuSg8cJSFxC8CiFDJl4YrxRcCidY9Ukzv+wzxSCVK7i3b3d73XJOg
         eQWvJFuVn6QDLEXQNj952FQHpRUgqdo6sILQnUPkYfI8G4OgOz9f8DTwuwnTMEeTAeEI
         BN/VbKBaCUKFlH+JrH+Qjogbi6svzs2u3UjWtJB7AI/fVBeuZbiiQOiA54vQkGs2vpYq
         njlXc5Yu4GzGLFuig1167BlTbS5Z2xnM+BWxUePgQHMoZ4xu52Hq3nKYagrPvVon2Coe
         zymg==
X-Gm-Message-State: ALoCoQnHnwUpHMozCxKqh1X0c10EEmCchcl1A610rNp5Bd/FgQm3ZuagW2BVpjlRvitmWY/i2b2l
X-Received: by 10.107.7.18 with SMTP id 18mr25065313ioh.69.1425920310606;
        Mon, 09 Mar 2015 09:58:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:556f:5b0e:5ec6:a1a9])
        by mx.google.com with ESMTPSA id 94sm10056799iod.23.2015.03.09.09.58.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Mar 2015 09:58:30 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425920304-22360-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265180>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/help.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 6133fe4..a1f5a0a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -456,7 +456,7 @@ static void list_common_guides_help(void)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	const char *alias;
+	char *alias;
 	enum help_format parsed_help_format;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -499,6 +499,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
 		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
+		free(alias);
 		return 0;
 	}
 
-- 
2.3.0.81.gc37f363
