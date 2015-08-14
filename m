From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 21:44:17 +0200
Message-ID: <55CE4511.6050704@cs-ware.de>
References: <55CE3F23.7040702@cs-ware.de>
 <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:44:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQKu7-0004fg-OH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbbHNTof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:44:35 -0400
Received: from srv1.79p.de ([213.239.234.118]:48379 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbbHNTof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:44:35 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5] (p200300886B2B1300A5027B37AC722AD5.dip0.t-ipconnect.de [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 8EF29223D7C;
	Fri, 14 Aug 2015 21:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015; t=1439581472;
	bh=vXCjQSbeWSMmkLqA4ja1jPN92xAZazID5F6O6k9O3zI=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=MMaYH1+KX+8FalB1GKpdbx6SDXBZIjcVntEcHdm5jcXSSsJNwCM+S/NeXPvDrEpY/
	 85BwtOjcoF3FS9WvkSbZ8sz+zjYJVgqTNwgHQeG/SMhH1j8mcrRrORLoHtcJD+Bnn6
	 gzs6wys9iOVM7eEKjCwvgerzJwSA7Y78VC/m8wTKbacHOZOKpIe1xdkieFl04eek/Y
	 1vSvkgPNgMzLv2YjwDN1Uq0W2Kv2xgbZ8yObV0y4ybitRO7e9XbqSKDMnrMKoNPY6w
	 3VtnYlENeFk23ZDhNO9orc1A4VVZtNIAcznFp7yPT0MUkNlEJeorcg90U0zmZV3XTx
	 IjD54s7eFMVeQ==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275929>

Without this patch there might be open file handle leaks.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
---
 config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.c b/config.c
index 9fd275f..c06dc2f 100644
--- a/config.c
+++ b/config.c
@@ -2010,6 +2010,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 				error("invalid pattern: %s", value_regex);
 				free(store.value_regex);
 				ret = CONFIG_INVALID_PATTERN;
+				close(in_fd);
 				goto out_free;
 			}
 		}
@@ -2034,6 +2035,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 				free(store.value_regex);
 			}
 			ret = CONFIG_INVALID_FILE;
+			close(in_fd);
 			goto out_free;
 		}
 
@@ -2048,6 +2050,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 		if ((store.seen == 0 && value == NULL) ||
 				(store.seen > 1 && multi_replace == 0)) {
 			ret = CONFIG_NOTHING_SET;
+			close(in_fd);
 			goto out_free;
 		}
 
@@ -2062,6 +2065,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			      config_filename, strerror(errno));
 			ret = CONFIG_INVALID_FILE;
 			contents = NULL;
+			close(in_fd);
 			goto out_free;
 		}
 		close(in_fd);
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
