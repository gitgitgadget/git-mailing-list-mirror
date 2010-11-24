From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] git apply: binary files differ can be applied with -pN (N>1).
Date: Wed, 24 Nov 2010 13:20:46 +0800
Message-ID: <4CECA0AE.90505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 24 06:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL7mr-000075-GL
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 06:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab0KXFUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 00:20:52 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47668 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0KXFUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 00:20:52 -0500
Received: by pva4 with SMTP id 4so751377pva.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 21:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=k7yUCR/X7E6xue+Nmg+nfvw9MOiSzlrKW+A1Rb78uPY=;
        b=PunabNq6UbqtIr3vWuJuqBEzTgypYsCgZb/qcMk13SVJ1catOZj/ssvh7AkPq1MzUJ
         PKbPi3072NdNeHYv4RL+rmh6j1V6i0z02RW/g8GJwXPRHdtZ3NbS8Yv5u48QCOXLyyMP
         ozpxq+2pOHoPAkwLbfK7vFG3AagULzHTlI6Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=cx8kUj53lZxbIU88OiiruYqcWDiEDka04u7jPPAcj4s9cXDTQlCxA0tdBCMx8jsKPJ
         MVoA/1hc97cY0Qj10m0f4o4xxYpGdUhTDsw/LdD7s7wFVlUxltNh87Ua+eYsJ1mbtQxi
         RRe0eLNWLA9RJ5pb8kcwDww2kyYz6KddorVyo=
Received: by 10.142.239.3 with SMTP id m3mr7853021wfh.180.1290576051622;
        Tue, 23 Nov 2010 21:20:51 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id v19sm8904344wfh.12.2010.11.23.21.20.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 21:20:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162046>

When patch file generated against two non-git directories using
'git diff --binary --no-index' without '--no-prefix', the patch
file has patch level greater then 1, and should be applied with
'-p2' option. But it does not work if there are binary differ
in the patch file, it is because in one case the patch level is
not properly handled.

Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
---
 builtin/apply.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..d603e37 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int llen)
 	 * form.
 	 */
 	for (len = 0 ; ; len++) {
+		int nslash = p_value;
 		switch (name[len]) {
 		default:
 			continue;
@@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int llen)
 				char c = *second++;
 				if (c == '\n')
 					return NULL;
-				if (c == '/')
+				if (c == '/' && --nslash <= 0)
 					break;
 			}
 			if (second[len] == '\n' && !memcmp(name, second, len)) {
-- 
1.7.3.2.245.g03276.dirty
