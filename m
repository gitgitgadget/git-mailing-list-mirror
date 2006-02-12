From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 12:19:23 +0100
Message-ID: <87accwlt8k.fsf@mid.deneb.enyo.de>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 12 12:19:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8FGL-0000zj-Lv
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 12:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBLLT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 06:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWBLLT0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 06:19:26 -0500
Received: from mail.enyo.de ([212.9.189.167]:24037 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750707AbWBLLT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 06:19:26 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F8FGG-0004Q6-U0
	for git@vger.kernel.org; Sun, 12 Feb 2006 12:19:25 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F8FGF-0001TX-PJ
	for git@vger.kernel.org; Sun, 12 Feb 2006 12:19:23 +0100
To: git@vger.kernel.org
In-Reply-To: <7virrli9am.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 11 Feb 2006 18:46:09 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15991>

* Junio C. Hamano:

>  static int hashtable_index(const unsigned char *sha1)
>  {
> -	unsigned int i = *(unsigned int *)sha1;
> -	return (int)(i % obj_allocs);
> +	int cnt;

> +	unsigned int ix = *sha1++;
> +
> +	for (cnt = 1; cnt < sizeof(unsigned int); cnt++) {
> +		ix <<= 8;
> +		ix |= *sha1++;
> +	}

memcpy(&ix, sha1, sizeof(ix));

(GCC should do the rest.)

> +	return (int)(ix % obj_allocs);
>  }

return (int)(ix & (obj_allocs - 1));

AFAICS, obj_allocs is a power of two.
