From: "Carlos Rica" <jasampler@gmail.com>
Subject: [PATCH] fix memory leak in parse_object when check_sha1_signature fails
Date: Fri, 25 May 2007 03:46:22 +0200
Message-ID: <1b46aba20705241846u615785eeh7c3ebeaf840b2180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 03:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrOsw-0006o0-SK
	for gcvg-git@gmane.org; Fri, 25 May 2007 03:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXEYBqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbXEYBqX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 21:46:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:61769 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXEYBqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 21:46:22 -0400
Received: by wr-out-0506.google.com with SMTP id 76so243022wra
        for <git@vger.kernel.org>; Thu, 24 May 2007 18:46:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AG3qNJrEmW4uz74coziKTVV2sObQVqGpRNj1ZwNbyZzCuvUy+TQDjT/laoPuxTtm5HKBMNhhkHevTggKHqtH60MlJonFO9Avaf6/mSLTOZ2qnUwpqEqWrL3SAy4f6iNp11odN0Bc5mMvmzeumAb8KPMusId+VBUTv0ct50sG1r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LN5TbQzhFYub2awi6gx8pQukQL9Q0mIlagOUH1O8ptJacrudCAB/J8sMP5kOFqfb33HB6j3f/6nzm/eASFIFFDhsp/8+0khC60Ey7/hPtKha/I91IhR1mUTZBpNGp9DzLlW5oDsSNIu7xXfg1WtzDkZLy+CChCCurp9kBSFYJBk=
Received: by 10.114.46.1 with SMTP id t1mr1237324wat.1180057582198;
        Thu, 24 May 2007 18:46:22 -0700 (PDT)
Received: by 10.114.58.13 with HTTP; Thu, 24 May 2007 18:46:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48325>

When check_sha1_signature fails, program is not terminated:
it prints an error message and returns NULL, so the
buffer returned by read_sha1_file should be freed before.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 object.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/object.c b/object.c
index 78a44a6..ccd7dd7 100644
--- a/object.c
+++ b/object.c
@@ -185,6 +185,7 @@ struct object *parse_object(const unsigned char *sha1)
 	if (buffer) {
 		struct object *obj;
 		if (check_sha1_signature(sha1, buffer, size, typename(type)) < 0) {
+			free(buffer);
 			error("sha1 mismatch %s\n", sha1_to_hex(sha1));
 			return NULL;
 		}
-- 
1.5.0
