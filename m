From: Dana How <danahow@gmail.com>
Subject: [PATCH 3/8] git-repack --max-pack-size: make close optional in sha1close()
Date: Sun, 08 Apr 2007 16:21:38 -0700
Message-ID: <46197902.1060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haghc-0007DO-EM
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXDHXVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXDHXVl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:21:41 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:64304 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbXDHXVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:21:41 -0400
Received: by py-out-1112.google.com with SMTP id a29so896856pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:21:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=XPSTT9BVkUzHGT7Zqk0fqrT+kci2O0kWtEG5buutvGaestRKSUKbWAr2yjO1tEOZc4Sk2yljwbnAJcXPb+j/4MbkJDaVFMdoNEiB9h39WHcZW2CG2BKoyqkW0dKA2Azbr8/LaWmQ9Mr3vuSatlPQip2D1qrZUPUn95j4hvxNEsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=tAD7IbptZ7Iyj9TNhc4JscUTS8PyGxG7WQEYlEfHhfWoI9x0/SYWI92Fig2iorM2e8Debmrc/hn9DncrON+/ON8CG6/sHeZjd42zoP3Twggd8JGx7vlBl+ZR5f6Vakc8PU/AuWuzVUANo46r+Qmz1OG0PLvkpQqTn4XAbW6LoM4=
Received: by 10.64.181.12 with SMTP id d12mr10526824qbf.1176074500380;
        Sun, 08 Apr 2007 16:21:40 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id r1sm8786289nzd.2007.04.08.16.21.39;
        Sun, 08 Apr 2007 16:21:39 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44013>


sha1close() flushes, writes checksum, and closes.
The second can be suppressed; make the last suppressible as well.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 csum-file.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index b7174c6..e1ff769 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -35,7 +35,10 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
+		f->offset = 0;
 	}
+	if (update < 0)
+		return 0;	/* only want to flush (no checksum write, no close) */
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
-- 
1.5.1.89.g8abf0
