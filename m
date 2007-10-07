From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Sun, 07 Oct 2007 18:07:17 +0200
Message-ID: <857ilylxhm.fsf@lola.goethe.zz>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
	<20071007172425.bb691da9.tihirvon@gmail.com>
	<20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYge-0000e2-2a
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbXJGQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXJGQIu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:08:50 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:33212 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbXJGQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:08:49 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IeYfX-0001jt-SN; Sun, 07 Oct 2007 12:07:52 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AEBA31D20DB9; Sun,  7 Oct 2007 18:07:17 +0200 (CEST)
In-Reply-To: <87sl4nlyg0.fsf@catnip.gol.com> (Miles Bader's message of "Mon\, 08 Oct 2007 00\:46\:39 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60189>

Miles Bader <miles@gnu.org> writes:

> Pierre Habouzit <madcoder@debian.org> writes:
>>> strbuf->buf is always non-NULL and NUL-terminated so you could just do
>>> 
>>> static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
>>> {
>>> 	int len = a->len < b->len ? a->len : b->len;
>>> 	return memcmp(a->buf, b->buf, len + 1);
>>> }
>>
>>   doesn't work, because a buffer can have (in some very specific cases)
>> an embeded NUL.
>
> Couldn't you then just do:
>
>    int len = a->len < b->len ? a->len : b->len;
>    int cmp = memcmp(a->buf, b->buf, len);
>    if (cmp == 0)
>       cmp = b->len - a->len;
>    return cmp;
>
> [In the case where one string is a prefix of the other, then the longer
> one is "greater".]
>
> ?

I fail to see where this variant is simpler than what we started the
journey of simplification from.

The only change I consider worth checking from the whole series in
this thread is making the function inline.  All the rest pretty much
was worse than what we started from in that it needed to reevaluate
more conditions and turned out more complicated and obfuscate even to
the human reader.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
