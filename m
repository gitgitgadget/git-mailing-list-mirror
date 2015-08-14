From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 22:03:57 +0200
Message-ID: <55CE49AD.4010605@cs-ware.de>
References: <55CE3F23.7040702@cs-ware.de>
 <CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
 <55CE4511.6050704@cs-ware.de>
 <CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLDF-00074y-L5
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbHNUES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:04:18 -0400
Received: from srv1.79p.de ([213.239.234.118]:48647 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbbHNUEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:04:15 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5] (p200300886B2B1300A5027B37AC722AD5.dip0.t-ipconnect.de [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 9675A223D7C;
	Fri, 14 Aug 2015 22:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015; t=1439582653;
	bh=KR7mn4IbXp9HQgerVP7/zlMOzB4jNJweHTyWxQ36k3Q=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=RmBm9Qe9OM+Bn6JboIiVaUXPslyS+ZNXLbd9I0jSEIAHLIBDFfHlJ3BBLnXkYIaNZ
	 S9OBcIJZX2+a+mpiqYcEMsLLFneEfD9MviVKrhtQzADquxDFpKmvY2WFEGU2aUgRfx
	 sLGI+caSDBSyOBtwHyH7F6XlII8H77JS8a56zF2oRhybOSNNs1S3WcynSCMq6GMetR
	 DOcW9K8lv9QYixlYXgEJdo4eS225sfOLfwztLSa0CW+d/hcSnD63S2gdD9xezqgMhH
	 V4LUggEdw5W9VTn2vQumptiW6foa8VuwwqaAgfcDBDbN11WrWkU5ikGK04yZZ2W8aA
	 0uMIwgg3A/IaQ==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275935>

Without this patch there might be open file handle leaks.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
---
 config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.c b/config.c
index 9fd275f..8138d5d 100644
--- a/config.c
+++ b/config.c
@@ -2065,6 +2065,7 @@ int git_config_set_multivar_in_file(const char
*config_filename,
 			goto out_free;
 		}
 		close(in_fd);
+		in_fd = -1;

 		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
 			error("chmod on %s failed: %s",
@@ -2148,6 +2149,8 @@ out_free:
 	free(filename_buf);
 	if (contents)
 		munmap(contents, contents_sz);
+	if (in_fd >= 0)
+		close(in_fd);
 	return ret;

 write_err_out:
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
