From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline functions
Date: Mon, 23 Jun 2008 00:20:13 +0200
Message-ID: <vpqej6p9ko2.fsf@bauges.imag.fr>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 00:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXyn-0007JG-3O
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758871AbYFVWWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 18:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176AbYFVWWl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:22:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:57554 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758335AbYFVWWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 18:22:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m5MMKLrX022830
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 00:20:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KAXuv-0000uV-BS; Mon, 23 Jun 2008 00:20:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KAXuv-0004em-9C; Mon, 23 Jun 2008 00:20:13 +0200
In-Reply-To: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 22 Jun 2008 12\:19\:25 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 23 Jun 2008 00:20:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85810>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> -static inline char* xstrdup(const char *str)
> -{
> -	char *ret = strdup(str);
> -	if (!ret) {
> -		release_pack_memory(strlen(str) + 1, -1);
> -		ret = strdup(str);
> -		if (!ret)
> -			die("Out of memory, strdup failed");
> -	}
> -	return ret;
> -}

Wouldn't it be better to split that kind of function into two parts:

- inline the short common case
- put the special case apart

like

static inline char* xstrdup(const char *str)
{
	char *ret = strdup(str);
	if (!ret)
		return xstrdup_failed(str);
	else
		return ret;
}

(with xstrdup_failed not being inline.)

?

-- 
Matthieu
