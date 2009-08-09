From: Ryan Flynn <parseerror@gmail.com>
Subject: [PATCH] fix potential infinite loop given large unsigned integer
Date: Sun, 9 Aug 2009 00:41:21 -0400
Message-ID: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 06:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma0Dz-00011L-LV
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 06:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbZHIElW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 00:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZHIElV
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 00:41:21 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:58268 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZHIElV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 00:41:21 -0400
Received: by vws2 with SMTP id 2so2176760vws.4
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 21:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ttssrO+Zt5npMyE3D8BEEV1ELtUWRCsnk5tIsCfmGtQ=;
        b=dgy6nCSfmfupP//t+OGfLCa12V9cRFPIWbeTE4hlm1UDNA4LRPjBj5ObwexE7jLOHp
         Uiq9sQqbZFrodeP96kBsDbz7QOobWpuMGeH1qHDYbBATrusdPnhIpvQ4uAYMoZxyHvEZ
         SE2ggRg/9Aj08M6ENw95JLImUmuf1Bl1/1P+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kn2nu0jX9As3tw9pwdI59LfE2va/6NxfrE4+M8yqLBDJWHTKtS08uZgWzI06w2EjQS
         En1xhqH8F8lsckNxM1j6fujEZVRjSV1uIbk5+BM+8+hSo9iucE6XBqTjFc+QaCthlDGr
         SNFRcKru6XKyqWMeJfWSL24xOVDjBZtIJdRaM=
Received: by 10.220.86.133 with SMTP id s5mr2991681vcl.50.1249792881798; Sat, 
	08 Aug 2009 21:41:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125319>

given n, tried to find i greater than n via i=1, iterate i *= 10.
given n sufficiently close to UINT_MAX this will overflow; which can
produce i==0, which results in an infinite loop. iteratively dividing
n /= 10 does not have this problem, and though division is slower than
multiplication this only runs once per `git format-patch
--cover-letter`

Signed-off-by: pizza <parseerror@gmail.com>
---
 log-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 6f73c17..53a1bd2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -160,9 +160,9 @@ static void append_signoff(struct strbuf *sb,
const char *signoff)

 static unsigned int digits_in_number(unsigned int number)
 {
-       unsigned int i = 10, result = 1;
-       while (i <= number) {
-               i *= 10;
+       unsigned int result = 1;
+       while (number > 9) {
+    number /= 10;
                result++;
        }
        return result;
-- 
1.6.0.4
