From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 08 Oct 2007 10:45:27 +0900
Message-ID: <87odfapefc.fsf@catnip.gol.com>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
	<20071007172425.bb691da9.tihirvon@gmail.com>
	<20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com>
	<857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home>
	<EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com>
	<20071007223140.GG2765@steel.home>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, David Kastrup <dak@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 03:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iehgw-0005en-Pi
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 03:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXJHBpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 21:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbXJHBpn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 21:45:43 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:49219 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbXJHBpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 21:45:42 -0400
Received: from 203-216-97-240.dsl.gol.ne.jp ([203.216.97.240] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IehgX-0000G5-Cs; Mon, 08 Oct 2007 10:45:29 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id E70552F5D; Mon,  8 Oct 2007 10:45:27 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <20071007223140.GG2765@steel.home> (Alex Riesen's message of "Mon\, 8 Oct 2007 00\:31\:40 +0200")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60274>

Alex Riesen <raa.lkml@gmail.com> writes:
> int strbuf_cmp2(struct strbuf *a, struct strbuf *b)
> {
> 	int len = a->len < b->len ? a->len: b->len;
> 	int cmp = memcmp(a->buf, b->buf, len);
> 	if (cmp)
> 		return cmp;
> 	return a->len < b->len ? -1: a->len != b->len;
> }

BTW, why are you making such effort to return only -1, 0, or 1 in the
last line?  memcmp/strcmp make no such guarantee; e.g. glibc says:

     The `strcmp' function compares the string S1 against S2, returning
     a value that has the same sign as the difference between the first
     differing pair of characters (interpreted as `unsigned char'
     objects, then promoted to `int').

     If the two strings are equal, `strcmp' returns `0'.

     A consequence of the ordering used by `strcmp' is that if S1 is an
     initial substring of S2, then S1 is considered to be "less than"
     S2.

So I think the last line can just be:

   return a->len - b->len;

-miles

-- 
Suburbia: where they tear out the trees and then name streets after them.
