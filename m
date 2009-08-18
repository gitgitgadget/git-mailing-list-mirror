From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 14:56:49 +0200
Message-ID: <4A8AA511.1060205@gmail.com>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 14:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOFL-0007Vy-2e
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758748AbZHRM4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758531AbZHRM4y
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:56:54 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51660 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbZHRM4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:56:53 -0400
Received: by bwz22 with SMTP id 22so2993361bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=JbVebiyzFR6rxQxLTQD0CQHH5ZfvebMmA75j9v4UDXg=;
        b=otVTH7NM9j4kwQlDjseFiuUbi+i+NFvZMNYWeu0wc1jRCgith4M6K+5ZtSPsUJ1wvr
         FEBP5FmhJmtiFjGRUorGFb6p645+FqOx23UHpnGD1byjqa0mu1GphgIKU7T9jTpA7CQg
         zXANY7RfHKrQhlH8LLZ6aGn73iBA36eGi7DRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=F0WXhOZsD25DqXZK2ZgHpmFiCfTm3FvdObCHf6/BNkmcBdD5MZo1DTZKz/PDY7TP5W
         UHG+wkRS+eoIQbcFvjAnoYLLMSuwgnna9XJJ1aNCOmmzOXnthrRs3mWBSPs1BQ4CNmzy
         HcSnXj5iLFj+b9DGYVjhw++DA4MgJS3lJF27g=
Received: by 10.103.84.28 with SMTP id m28mr1883340mul.113.1250600212086;
        Tue, 18 Aug 2009 05:56:52 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-126-56.multimo.pl [89.174.126.56])
        by mx.google.com with ESMTPS id s10sm24616734mue.8.2009.08.18.05.56.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 05:56:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <4A8A8661.5060908@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126389>

Sebastian Schuberth wrote:
> As ntohl()/htonl() are function calls (that internally do shifts), I
> doubt they're faster than the shift macros, though I haven't measured
> it. However, I do not suggest to go for the macros on Windows/Intel, but
> to apply the following patch on top of your patch:

> On Windows/Intel, ntohl()/htonl() are function calls that do shifts to
> swap the
> byte order. Using the native bswap instruction boths gets rid of the
> shifts and
> the function call overhead to gain some performance.

Umm, nothing like this should be needed on linux; the compiler/glibc
will choose bswap itself. (see endian.h and bits/byteswap.h).
I did try using __builtin_bswap32 directly and the result was a few
(3 or 4, iirc) differently scheduled instructions, that's all, no
performance difference.

>   * Performance might be improved if the CPU architecture is OK with
> - * unaligned 32-bit loads and a fast ntohl() is available.
> + * unaligned 32-bit loads and a fast ntohl() is available. On Intel,
> + * use the bswap built-in to get rid of the function call overhead.
>   * Otherwise fall back to byte loads and shifts which is portable,
>   * and is faster on architectures with memory alignment issues.
>   */
> 
> -#if defined(__i386__) || defined(__x86_64__) || \
> -    defined(__ppc__) || defined(__ppc64__) || \
> -    defined(__powerpc__) || defined(__powerpc64__) || \
> -    defined(__s390__) || defined(__s390x__)
> +#if defined(__i386__) || defined(__x86_64__)
>
> +#define get_be32(p)    __builtin_bswap32(*(unsigned int *)(p))
> +#define put_be32(p, v)    do { *(unsigned int *)(p) = __builtin_bswap32(v); } while (0)
> +
> +#elif defined(__ppc__) || defined(__ppc64__) || \
> +      defined(__powerpc__) || defined(__powerpc64__) || \
> +      defined(__s390__) || defined(__s390x__)

I'd limit it to windows and any other ia32 platform that doesn't pick the
bswaps itself; as is, it just adds an unnecessary hidden gcc dependency.

Hmm, it's actually a gcc-4.3+ dependency, so it won't even build w/ gcc 4.2;
something like this would be required: "(__GNUC__>=4 && __GNUC_MINOR__>=3)" .

artur
