From: Jeff Garzik <jeff@garzik.org>
Subject: Re: {RFC/PATCH] micro-optimize get_sha1_hex()
Date: Sat, 09 Sep 2006 18:33:39 -0400
Message-ID: <45034143.4050308@garzik.org>
References: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 00:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMBOW-0007P9-IF
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 00:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWIIWdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWIIWdp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 18:33:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14977 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964984AbWIIWdo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 18:33:44 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GMBOO-0005ng-GQ; Sat, 09 Sep 2006 22:33:41 +0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26773>

Junio C Hamano wrote:
>  int get_sha1_hex(const char *hex, unsigned char *sha1)
>  {
>  	int i;
>  	for (i = 0; i < 20; i++) {
> -		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
> -		if (val & ~0xff)
> +		unsigned int v, w, val;
> +		v = *hex++;
> +		if ((v < '0') || ('f' < v) ||
> +		    ((v = hexval[v-'0']) == 255))
> +			return -1;
> +		w = *hex++;
> +		if ((w < '0') || ('f' < w) ||
> +		    ((w = hexval[w-'0']) == 255))
>  			return -1;
> -		*sha1++ = val;
> -		hex += 2;
> +		*sha1++ = (v << 4) | w;

Why not just make the table include the range of all possible 
characters?  That would eliminate some comparisons and subtractions 
against '0'.

The end result would look more like the current (unpatched) form, except 
with a function replaced by the table.

	Jeff
