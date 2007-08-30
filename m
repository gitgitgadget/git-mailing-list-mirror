From: Junio C Hamano <junkio@pobox.com>
Subject: Re: [PATCH] Temporary fix for stack smashing in mailinfo
Date: Thu, 30 Aug 2007 15:53:06 -0700
Message-ID: <7vir6w7hyl.fsf@gitster.siamese.dyndns.org>
References: <1188502009.29782.874.camel@hurina>
	<20070830214824.GC15405@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Sirainen <tss@iki.fi>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQst4-0003g0-Dy
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763577AbXH3WxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763532AbXH3WxO
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:53:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38735 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763473AbXH3WxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 18:53:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070830225313.XQYS10742.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 30 Aug 2007 18:53:13 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id iNtB1X00W1gtr5g0000000; Thu, 30 Aug 2007 18:53:12 -0400
In-Reply-To: <20070830214824.GC15405@steel.home> (Alex Riesen's message of
	"Thu, 30 Aug 2007 23:48:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57086>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio, I cannot have time to fix the code nice and proper, but as
> heavy user of git-am just have to have it fixed at least a like this.
> And this is ugly (and definitely incomplete), everyone be warned.
>
> Checked with valgrind, looks good (except for iconv_open reading past
> one of its arguments):

On the top of your patch, I think decode_header_bq() needs to
make sure that a string with more than one pieces, each of which
decodes well within piecebuf, cannot overflow outbuf[] in the
while loop.

> @@ -578,56 +588,56 @@ static int decode_header_bq(char *it)
>  		default:
>  			return rfc2047; /* no munging */
>  		case 'b':
> -			sz = decode_b_segment(cp + 3, piecebuf, ep);
> +			sz = decode_b_segment(cp + 3, piecebuf, sizeof(piecebuf), ep);
>  			break;
>  		case 'q':
> -			sz = decode_q_segment(cp + 3, piecebuf, ep, 1);
> +			sz = decode_q_segment(cp + 3, piecebuf, sizeof(piecebuf), ep, 1);
>  			break;
>  		}
>  		if (sz < 0)
>  			return rfc2047;
>  		if (metainfo_charset)
> -			convert_to_utf8(piecebuf, charset_q);
> +			convert_to_utf8(piecebuf, sizeof(piecebuf), charset_q);
>  		strcpy(out, piecebuf);
>  		out += strlen(out);
>  		in = ep + 2;
>  	}

It might also make sense to redo the lower level decoding
functions using existing strbuf interface to build string
without pre-set bounds.
