From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 19:10:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908051909080.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <7vocqtu286.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 04:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsRt-0003ZB-72
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 04:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbZHFCKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 22:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbZHFCKp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 22:10:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41586 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662AbZHFCKp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 22:10:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n762AInM012700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 19:10:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n762AIWt032557;
	Wed, 5 Aug 2009 19:10:18 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vocqtu286.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125021>



On Wed, 5 Aug 2009, Junio C Hamano wrote:
> 
> Like this?

No, combine it with the other shifts:

Yes:

> -	ctx->size += (unsigned long long) len << 3;
> +	ctx->size += (unsigned long long) len;

No:

> +	ctx->size <<= 3; /* bytes to bits */
>  	padlen[0] = htonl(ctx->size >> 32);
>  	padlen[1] = htonl(ctx->size);

Do

	padlen[0] = htonl(ctx->size >> 29);
	padlen[1] = htonl(ctx->size << 3);

instead. Or whatever.

		Linus
