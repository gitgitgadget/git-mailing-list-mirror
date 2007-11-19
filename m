From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: [PATCH] Fix "identifier redeclared" compilation error with SUN cc
Date: Mon, 19 Nov 2007 18:51:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@ostkamp.fastmail.fm, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuAmO-0006qU-1F
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbXKSRvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbXKSRvK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:51:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54585 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753922AbXKSRvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 12:51:09 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id BE6654CA35;
	Mon, 19 Nov 2007 12:51:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 19 Nov 2007 12:51:06 -0500
X-Sasl-enc: a+fR/MAEJXGmFsXndr/29wb9iZLPca3B3WSY9ig+gAt6 1195494666
Received: from [192.168.2.101] (p549A1A4B.dip0.t-ipconnect.de [84.154.26.75])
	by mail.messagingengine.com (Postfix) with ESMTP id 79BDF172A1;
	Mon, 19 Nov 2007 12:51:05 -0500 (EST)
In-Reply-To: <7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65478>

Hello Junio,

On Thu, 15 Nov 2007, Junio C Hamano wrote:
> As I suspect there are other compilers that do not implement flexible 
> array members (so you cannot use "member[]") nor older gcc extension of 
> zero sized member (so you cannot use "member[0]" either), this checking 
> specifically for Sun is too narrow.
>
> On the other hand, as you said, this is too broad, because not everybody 
> may be using the SUN compiler on Sun, nor the version that does not 
> understand flexible array members.
>
> But being broad should always be safer, albeit a bit wasteful.
>
> How about doing it this way?

it looks ok on Solaris. I assembled the following patch from your posting, 
could you please include it?


Signed-off-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
---
  git-compat-util.h |   11 ++++++++++-
  1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 276a437..97759fd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -4,11 +4,20 @@
  #define _FILE_OFFSET_BITS 64

  #ifndef FLEX_ARRAY
-#if defined(__GNUC__) && (__GNUC__ < 3)
+#if defined(__GNUC__)
+#if (__GNUC__ < 3)
  #define FLEX_ARRAY 0
  #else
  #define FLEX_ARRAY /* empty */
  #endif
+#else
+/* more cases we know we can use 0 or empty can come here */
+#endif
+#endif
+
+/* if still undefined, default to the safe, old fashioned way */
+#ifndef FLEX_ARRAY
+#define FLEX_ARRAY 1
  #endif

  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
-- 
1.5.3.6.728.gea559
