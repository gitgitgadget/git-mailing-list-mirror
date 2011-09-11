From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Sun, 11 Sep 2011 15:14:36 +0200
Message-ID: <m239g3i5kz.fsf@igel.home>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
	<20110911062206.GA29620@sigill.intra.peff.net>
	<20110911062740.GA8018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 11 15:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2jsO-0007kh-CW
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 15:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1IKNOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 09:14:47 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45082 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1IKNOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 09:14:46 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 8C4CB188B58F;
	Sun, 11 Sep 2011 15:14:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E17501C0024C;
	Sun, 11 Sep 2011 15:14:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id BNYk3DQZHeSL; Sun, 11 Sep 2011 15:14:38 +0200 (CEST)
Received: from igel.home (ppp-88-217-122-177.dynamic.mnet-online.de [88.217.122.177])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Sep 2011 15:14:38 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B0091CA296; Sun, 11 Sep 2011 15:14:37 +0200 (CEST)
X-Yow: If I am elected no one will ever have to do their laundry again!
In-Reply-To: <20110911062740.GA8018@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 11 Sep 2011 02:27:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181173>

Jeff King <peff@peff.net> writes:

> IOW, the zip file looks right. I wonder if this is actually a bug in
> "unzip".

It is.  This only happens if you have more then 16k entries and when one
of the 16k entry infos is reused it happend to be previously used for a
symlink entry.

Here's a patch for unzip60 for reference:

--- process.c
+++ process.c
@@ -1751,6 +1751,12 @@ int process_cdir_file_hdr(__G)    /* ret
         = (G.crec.general_purpose_bit_flag & (1 << 11)) == (1 << 11);
 #endif
 
+#ifdef SYMLINKS
+    /* Initialize the symlink flag, may be set by the platform-specific
+       mapattr function.  */
+    G.pInfo->symlink = 0;
+#endif
+
     return PK_COOL;
 
 } /* end function process_cdir_file_hdr() */

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
