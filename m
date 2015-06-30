From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] config.c: fix writing config files on Windows network shares
Date: Tue, 30 Jun 2015 16:34:13 +0200
Message-ID: <5592A8E5.2090601@gmail.com>
References: <20150528075142.GB3688@peff.net> <20150528075443.GB23395@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:34:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9wcF-00054e-N6
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 16:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbbF3OeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 10:34:18 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35513 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbF3OeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 10:34:16 -0400
Received: by wiga1 with SMTP id a1so100130705wig.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UVDD3t2V7uhfAUoWIilcgP70kCCeDEtrf2hKN5zhuts=;
        b=QU7cjmylbX1E+vcQ08HyNVqJPCpghiNs/nNxy4KNWNuGCL43CzPMgEQjfxsJKwELiB
         d0qHAz0zjrWxmQ3Mjv/V18TYpYnXD6qJTCf6QUH1vLBxhB43/X3G37tshXLfHyyDL1Ej
         Jhit29PvWdJHYIpskkNvt7nd65vPzPh650G5dIbD24xqiBVS64N09ZYTTw48n2SSC5ym
         v2brUEcFZrZTbNeMOxrhoBJwkcI770cmatt+rNZKIxjhZSj8Vx23lyJlMgYH2fAiSrZN
         5Ej4qqkWjS0nH4N2tJZ89zswlKhQj9wwNvxspdTYCBPyXHNOxaKAYJPTbqPmMa+AO3dF
         33Sw==
X-Received: by 10.194.121.163 with SMTP id ll3mr40521671wjb.142.1435674855694;
        Tue, 30 Jun 2015 07:34:15 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id sc16sm31335501wjb.28.2015.06.30.07.34.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 07:34:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150528075443.GB23395@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273065>

Renaming to an existing file doesn't work on Windows network shares if the
target file is open.

munmap() the old config file before commit_lock_file.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

See https://github.com/git-for-windows/git/issues/226

Strangely, renaming to an open file works fine on local disks...

 config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.c b/config.c
index 07133ef..3a23c11 100644
--- a/config.c
+++ b/config.c
@@ -2153,6 +2153,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 					  contents_sz - copy_begin) <
 			    contents_sz - copy_begin)
 				goto write_err_out;
+
+		munmap(contents, contents_sz);
+		contents = NULL;
 	}
 
 	if (commit_lock_file(lock) < 0) {
-- 
2.4.3.windows.1.1.g87477f9
