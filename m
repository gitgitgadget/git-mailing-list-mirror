From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: (resend) [PATCH] Don't ignore write failure from git-diff,
 git-log, etc.
Date: Sun, 24 Jun 2007 10:08:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
References: <87abuq1z6f.fsf@rho.meyering.net>
 <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 19:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Vab-0004fH-B3
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbXFXRJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbXFXRJY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:09:24 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42836 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755996AbXFXRJX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 13:09:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OH87QX026165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 10:08:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OH81dQ017922;
	Sun, 24 Jun 2007 10:08:01 -0700
In-Reply-To: <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.057 required=5 tests=AWL,BAYES_00,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50802>



On Sun, 24 Jun 2007, Junio C Hamano wrote:
> 
> I still do not like the fact that this patch makes an error from
> the final stdout flushing override the return value from p->fn()
> even when the function already diagnosed an error

Yeah.

I also don't think it's very _pretty_ code, and it violates my personal 
coding standards by adding way too deep indentation for the new error 
cases. It was already three indents deep (reasonably fine, but that 
NOT_BARE test wass already pretty ugly), but now it becomes five 
indentation levels deep at its deepest, which is just a sign that things 
should be split up.

I'd also like to know why it does that fcntl() is done, and I also wonder 
about that "ferror()" call: it is entirely possible that ferror() is set 
due to EPIPE, and in that case, it will *not* set errno to EPIPE at all, 
so it will *still* complain about what I consider an invalid situation.

I dunno. I think the ENOSPC worry is a very real and valid one, but I 
would really tend prefer something different.

How about this following series of two patches instead, which I'll send as 
replies to this email..

		Linus
