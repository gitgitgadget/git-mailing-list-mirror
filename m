From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 08 Oct 2007 00:46:39 +0900
Message-ID: <87sl4nlyg0.fsf@catnip.gol.com>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
	<20071007172425.bb691da9.tihirvon@gmail.com>
	<20071007143912.GB10024@artemis.corp>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 17:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYLN-0005YX-SA
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 17:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXJGPqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 11:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbXJGPqu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 11:46:50 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:59893 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbXJGPqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 11:46:49 -0400
Received: from 203-216-97-240.dsl.gol.ne.jp ([203.216.97.240] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IeYL5-0006Sm-TO; Mon, 08 Oct 2007 00:46:44 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 7EE6F2F5D; Mon,  8 Oct 2007 00:46:40 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <20071007143912.GB10024@artemis.corp> (Pierre Habouzit's message of "Sun\, 07 Oct 2007 16\:39\:12 +0200")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60186>

Pierre Habouzit <madcoder@debian.org> writes:
>> strbuf->buf is always non-NULL and NUL-terminated so you could just do
>> 
>> static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
>> {
>> 	int len = a->len < b->len ? a->len : b->len;
>> 	return memcmp(a->buf, b->buf, len + 1);
>> }
>
>   doesn't work, because a buffer can have (in some very specific cases)
> an embeded NUL.

Couldn't you then just do:

   int len = a->len < b->len ? a->len : b->len;
   int cmp = memcmp(a->buf, b->buf, len);
   if (cmp == 0)
      cmp = b->len - a->len;
   return cmp;

[In the case where one string is a prefix of the other, then the longer
one is "greater".]

?

-Miles

-- 
"Suppose He doesn't give a shit?  Suppose there is a God but He
just doesn't give a shit?"  [George Carlin]
