From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] New strbuf APIs: splice and embed.
Date: Sat, 15 Sep 2007 17:57:44 -0700
Message-ID: <7vwsur77g7.fsf@gitster.siamese.dyndns.org>
References: <20070915141210.GA27494@artemis.corp>
	<20070915141335.ECB4B4C152@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 02:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWiSM-0005E3-0V
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 02:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbXIPA5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 20:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXIPA5q
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 20:57:46 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34510 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXIPA5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 20:57:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070916005744.TRJT10668.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 15 Sep 2007 20:57:44 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id ooxl1X00P1gtr5g0000000; Sat, 15 Sep 2007 20:57:45 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58286>

Pierre Habouzit <madcoder@debian.org> writes:

> * strbuf_splice replace a portion of the buffer with another.
> * strbuf_embed replace a strbuf buffer with the given one, that should be
>   malloc'ed. Then it enforces strbuf's invariants. If alloc > len, then this
>   function has negligible cost, else it will perform a realloc, possibly
>   with a cost.

"embed" does not sound quite right, does it?  It is a reverse
operation of strbuf_detach() as far as I can tell.

> -void strbuf_rtrim(struct strbuf *sb)
> -{
> +void strbuf_rtrim(struct strbuf *sb) {
>  	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
>  		sb->len--;
>  	sb->buf[sb->len] = '\0';

This is changing the style in the wrong direction, isn't it?  We
start our functions like this:

	type name(proto)
        {
        	...

> +void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
> +				   const void *data, size_t dlen)
> +{
> +	if (pos + len < pos)
> +		die("you want to splice outside from the buffer");

That is a funny error message for an integer wrap-around check.

> +	if (pos > sb->len)
> +		pos = sb->len;

Shouldn't this be flagged as a programming error?

> +	if (pos + len > sb->len)
> +		len = sb->len - pos;

Likewise.

By the way, this is the kind of situation I wish everybody wrote
their comparison in textual order.  I had to draw a picture like
this to see what was going on.

        sb->buf
        xxxxxxxxxxxzzzzzxxxxxxxxxxx\0
        ^                         ^
        0                   sb->len
                   ^    ^               ^    ^        
                   pos  pos+len         pos  pos+len  
                   v                    v
                   yyyyyyyyyy           yyyyyyyyyy    
                             ^                    ^   
                             dlen                 dlen
                   -------------        --------------
                   pos < sb->len        sb->len < pos
