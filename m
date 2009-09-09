From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
Date: Tue, 8 Sep 2009 20:40:34 -0400
Message-ID: <2DD80FE2-385E-4488-811F-A80450AACA23@gernhardtsoftware.com>
References: <1252418078-68650-1-git-send-email-brian@gernhardtsoftware.com> <7vhbvdyysq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 02:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlBEt-00036R-MH
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 02:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZIIAkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 20:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbZIIAkh
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 20:40:37 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46662 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZIIAkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 20:40:36 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3F4981FFC087; Wed,  9 Sep 2009 00:40:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id F1F221FFC06B;
	Wed,  9 Sep 2009 00:40:27 +0000 (UTC)
In-Reply-To: <7vhbvdyysq.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128051>


On Sep 8, 2009, at 4:19 PM, Junio C Hamano wrote:

> The patch makes sense to me, but as the result, depending on platforms
> and configuration, we would use three variations when linking imap- 
> send
> with no NO_OPENSSL defined:
>
> * Both -lcrypto -lssl
> * Only -lssl
> * Only -lcrypto
>
> I wonder if we can simplify this in some way (not a 1.6.5 topic).
>
> I am suspecting that the reason we do not say "always both" is because
> depending on the vintage of OpenSSL one or the other is missing?

It just occurred to me that I have a Debian machine to test this on.   
I generally don't use my web server for testing, but testing a compile  
should be safe enough.

Sure enough, it compiles without this patch.  It may be a difference  
between the linkers.  It appears that ERR_error_string() is in  
libcrypto for both OS X and Debian and that libssl.{so,dylib} both  
have load commands for libcrypto.{so,dylib}, but OS X ld is pickier  
than Debian ld.  Odd.

I don't see a scenario where only -lcrypto would be used for imap- 
send, actually.  That would imply that we're using OpenSSL's SHA-1  
algorithm but not using it for IMAPS access.  SSL_WITH_CRYPTO is about  
needing -lssl when using -lcrypto for SHA-1 while CRYPTO_WITH_SSL is  
about needing -lcrypto when using -lssl for SSL.

The only simplification I can think of is to make  
NEEDS_CRYPTO_WITH_SSL and NEEDS_SSL_WITH_CRYPTO be the same, so that  
it will include both any time it includes either one.   
NEEDS_SSL_WITH_CRYPTO is set for UnixWare, SCO_SV, and OS X.  I only  
have the latter to test with so I don't know if the symmetry is true  
for the other two.

~~ Brian
