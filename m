From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 23:40:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908032336460.3270@localhost.localdomain>
References: <20090804044842.6792.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDiJ-0006Sx-80
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbZHDGlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbZHDGlE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:41:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57719 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755084AbZHDGlD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 02:41:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n746eaPS021248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 23:40:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n746eZSh031546;
	Mon, 3 Aug 2009 23:40:36 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090804044842.6792.qmail@science.horizon.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124759>



On Mon, 4 Aug 2009, George Spelvin wrote:
> +sha1_block_data_order:
> +	pushl	%ebp
> +	pushl	%ebx
> +	pushl	%esi
> +	pushl	%edi
> +	movl	20(%esp),%edi
> +	movl	24(%esp),%esi
> +	movl	28(%esp),%eax
> +	subl	$64,%esp
> +	shll	$6,%eax
> +	addl	%esi,%eax
> +	movl	%eax,92(%esp)
> +	movl	16(%edi),%ebp
> +	movl	12(%edi),%edx
> +.align	16
> +.L000loop:
> +	movl	(%esi),%ecx
> +	movl	4(%esi),%ebx
> +	bswap	%ecx
> +	movl	8(%esi),%eax
> +	bswap	%ebx
> +	movl	%ecx,(%esp)

...

Hmm. Does it really help to do the bswap as a separate initial phase?

As far as I can tell, you load the result of the bswap just a single time 
for each value. So the initial "bswap all 64 bytes" seems pointless.

> +	/* 00_15 0 */
> +	movl	%edx,%edi
> +	movl	(%esp),%esi

Why not do the bswap here instead?

Is it because you're running out of registers for scheduling, and want to 
use the stack pointer rather than the original source?

Or does the data dependency end up being so much better that you're better 
off doing a separate bswap loop?

Or is it just because the code was written that way?

Intriguing, either way.

		Linus
