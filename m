From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] Introduce 'convert_path_to_git()'
Date: Fri, 15 May 2009 23:40:45 -0700
Message-ID: <7vy6sxpn2q.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
	<alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>
	<alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
	<alpine.LFD.2.01.0905151156090.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 16 08:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5DaT-0000n9-OX
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 08:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbZEPGkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZEPGkp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 02:40:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35020 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbZEPGko (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 02:40:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516064045.TUZS25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 May 2009 02:40:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id s6gl1b00E4aMwMQ036glvt; Sat, 16 May 2009 02:40:45 -0400
X-Authority-Analysis: v=1.0 c=1 a=yuuqiZowff0A:10 a=SE34-JqcD28A:10
 a=Z4Rwk6OoAAAA:8 a=vTWYdbN4Qlw6vlDWtjQA:9 a=oOOI_F5P-z2xAlNUOBdvLBn0uGMA:4
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119337>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> +#ifdef FAST_UNALIGNED
> +	while (plen >= sizeof(unsigned long)) {
> +		unsigned long x = *(unsigned long *)path;
> +		if (x & (unsigned long) 0x8080808080808080ull)
> +			break;
> +		*(unsigned long *)result = x;
> +		path += sizeof(unsigned long);
> +		result += sizeof(unsigned long);
> +		plen -= sizeof(unsigned long);
> +		retval += sizeof(unsigned long);
> +	}
> +#endif

It somehow bothers me that the stride of this loop is protected from
having different size of unsigned long from what the author of this
function expected, but the literal constant used as the mask is not quite,
which means that taken as a whole it does not work if your unsigned long
is more than 8-bytes.  No, I do not think it matters in practice, and I
find it a neat trick to cast the unsigned long long literal down to
unsigned long, but still it looks somewhat, eh, what would I say...

"Ugly" is not quite the word I am looking for.  "My gut feels that there
has to be a way to write this more cleanly, but I am frustrated that I
cannot come up with one" might be the word...
