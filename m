From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] vcs-svn: avoid self-assignment in dummy initialization
 of pre_off
Date: Fri, 6 Jul 2012 12:16:51 -0500
Message-ID: <20120706171651.GC31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnC9O-0002zt-74
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614Ab2GFRQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:16:57 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59793 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2GFRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:16:56 -0400
Received: by gglu4 with SMTP id u4so8827418ggl.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=F9FEYLAkPD+z38XzVdlgDCVsjqT9zmanoCtciZ6Ktt0=;
        b=ZStS57JbJ2JaKoJ6NaCryIbUGX19fd0k2RhEcCZAWZG8JInqRpi3YMLTQ2Y5xOTQie
         lcaf3V6NNSpZ6MBMUtbjPXqyNmPK2kzviJPwDYBZTLPggw6RNdITYt246GyI+bF1AIVP
         D5B0KvELFsBu+76xXB5HrAwuiTbSQGXGguoURK2ntDZ4o2t0ufLeRqtZiQ3t/bUx8oKU
         yBvsZoFG++zNXJkbAIWiTxHvntF4m0v4s1HDpa4r0MOFbI8jwhsFuWvbAs40w10WStzd
         mBr3B2hnCuJ6EgqzUc8MmG7zR7G5xJ2Pt41n9JJH9+aJr88DWmEB9q4F9KSuyZZHKUkR
         lGaw==
Received: by 10.50.158.233 with SMTP id wx9mr3085562igb.42.1341595015506;
        Fri, 06 Jul 2012 10:16:55 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id zu2sm753966igb.0.2012.07.06.10.16.54
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201126>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:25 +1000

Without this change, clang complains:

 vcs-svn/svndiff.c:298:3: warning: Assigned value is garbage or undefined
                 off_t pre_off = pre_off; /* stupid GCC... */
                 ^               ~~~~~~~

This code uses an old and common idiom for suppressing an
"uninitialized variable" warning, and clang is wrong to warn about it.
The idiom tells the compiler to leave the variable uninitialized,
which saves a few bytes of code size, and, more importantly, allows
valgrind to check at runtime that the variable is properly initialized
by the time it is used.

But MSVC and clang do not know that idiom, so let's avoid it in
vcs-svn/ code.

Initialize pre_off to -1, a recognizably meaningless value, to allow
future code changes that cause pre_off to be used before it is
initialized to be caught early.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v2:

 - new commit message inspired by the discussion at [2]
 - initialize pre_off to -1 instead of 0

[1] http://thread.gmane.org/gmane.comp.version-control.git/198909/focus=198910
[2] http://thread.gmane.org/gmane.comp.version-control.git/169098/focus=169128

 vcs-svn/svndiff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 1647c1a7..c89d9623 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -295,7 +295,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 	if (read_magic(delta, &delta_len))
 		return -1;
 	while (delta_len) {	/* For each window: */
-		off_t pre_off = pre_off; /* stupid GCC... */
+		off_t pre_off = -1;
 		size_t pre_len;
 
 		if (read_offset(delta, &pre_off, &delta_len) ||
-- 
1.7.10.4
