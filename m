From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Check for large pack offsets could be optimized away
Date: Thu, 16 Aug 2007 09:58:51 +0200
Message-ID: <e5bfff550708160058q6674f832m641647cd883accfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 09:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaFy-0003tj-4t
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 09:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbXHPH6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 03:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbXHPH6x
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 03:58:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:31937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbXHPH6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 03:58:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so197024wah
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:58:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oP6Uh9JV5tOfsXGN/PAAtvwimTGTLJ3ap/38Z9oAI501MdpGgKwkOwBJb+pJIwSIJZLj//b2okGlRhoQa1DYOX2BXHtP6SnxKsCI0QpmhRGVUhvr1i9AOGQSdPM8PkssqHBLP8fSU3fWTbLMuqn/W/o+uNRYf64S8cgnDJcL8pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Iv7DIA31wd2KmhFyFJkeDtpiHnY7HFA+qvI23oFfnLXFQ72ibfd5T9dZvFmbwMlC0Yg6JH36KQDxAGBuNXUPg/TY98/VzVEVPtVLWTyTI1lqhModh8//GTItXbqwM160hXj6+53LYUiHKnvi3VmaBAjgqsiXw4MBBGgai0fwHYQ=
Received: by 10.114.93.17 with SMTP id q17mr1479287wab.1187251131774;
        Thu, 16 Aug 2007 00:58:51 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Thu, 16 Aug 2007 00:58:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55982>

Without this fix gcc 4.2.1 warns with:

warning: assuming signed overflow does not occur
when assuming that (X + c) < X is always false

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 sha1_file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b219d4d..ba29000 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -524,7 +524,8 @@ static int check_packed_git_idx
 		if (idx_size != min_size) {
 			/* make sure we can deal with large pack offsets */
 			off_t x = 0x7fffffffUL, y = 0xffffffffUL;
-			if (x > (x + 1) || y > (y + 1)) {
+			off_t x1 = x + 1, y1 = y + 1;
+			if (x > x1 || y > y1) {
  				munmap(idx_map, idx_size);
 				return error("pack too large for current definition of off_t in %s", path);
 			}
-- 
1.5.3.rc4.67.gf9286
