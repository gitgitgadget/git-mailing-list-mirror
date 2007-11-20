From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN
 cc
Date: Tue, 20 Nov 2007 18:28:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711201823460.4280@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <7vd4ua3hww.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
 <7vhcjhl3ni.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 18:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuWuK-0002IN-0i
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 18:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbXKTR2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 12:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757395AbXKTR2r
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 12:28:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52074 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757043AbXKTR2p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 12:28:45 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 56D4145AE4;
	Tue, 20 Nov 2007 12:28:44 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 20 Nov 2007 12:28:44 -0500
X-Sasl-enc: bVBGsOnP1/wxFP2j3wr72gKqVO2Qct/Hzl5f3AuuHGX0 1195579723
Received: from [192.168.2.101] (p549A271E.dip0.t-ipconnect.de [84.154.39.30])
	by mail.messagingengine.com (Postfix) with ESMTP id E06021C104;
	Tue, 20 Nov 2007 12:28:42 -0500 (EST)
In-Reply-To: <7vhcjhl3ni.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65551>

Hello Junio,

On Tue, 20 Nov 2007, Junio C Hamano wrote:
> I knew it would work on Solaris with gcc and cc that do not understand 
> flexible array members, but I am a bit worried about other environments, 
> where flexible array members are properly supported.  They've been 
> happily using member[] but with the patch they suddenly start wasting a 
> cell.
>
> But we should do this sooner rather than later to find out any breakage, 
> and give people on platforms with a cc that supports flexible array 
> members and care about wasted memory enough time to send patches to 
> support their compiler in the way similar to how gcc is supported.
>
> But I cannot use your message with whitespace-broken patch (note 
> "format=flawed") and insufficient commit log message, which means I have 
> to do this myself.  Not tonight...

sorry for the whitespace-issues. I have attached the patch again with 
improved log message and will turn off format-flawed for this email.

Please let me know if this one is ok and feel free to fix it.

Log message starts here:

Fix "identifier redeclared" compilation error with SUN cc.

The problem is caused by incomplete arrays like

   struct foo {
     ...
     char last_member_that_is_flexible[];
   }

which cannot be handled by certain compilers.
The solution is to change the last member to either

     char last_member_that_is_flexible[0]

or

     char last_member_that_is_flexible[1]

as required. Currently GNU CC can handle [] format for 
version 3 and later. Earlier versions need [0].
Non-GNU compiler use the safe form [1].

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
