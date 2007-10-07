From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and optimize it a bit
Date: Sun, 07 Oct 2007 18:27:15 +0200
Message-ID: <851wc6lwkc.fsf@lola.goethe.zz>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home> <85fy0nknnq.fsf@lola.goethe.zz>
	<20071007161012.GB3270@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYxz-0003ju-0p
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbXJGQ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXJGQ0q
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:26:46 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60183 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXJGQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:26:45 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IeYwt-0002nC-SK; Sun, 07 Oct 2007 12:25:48 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3380E1D20DB9; Sun,  7 Oct 2007 18:27:15 +0200 (CEST)
In-Reply-To: <20071007161012.GB3270@steel.home> (Alex Riesen's message of "Sun\, 7 Oct 2007 18\:10\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60193>

Alex Riesen <raa.lkml@gmail.com> writes:

> David Kastrup, Sun, Oct 07, 2007 16:24:57 +0200:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > It is definitely less code (also object code). It is not always
>> > measurably faster (but mostly is).
>> 
>> > -int strbuf_cmp(struct strbuf *a, struct strbuf *b)
>> > -{
>> > -	int cmp;
>> > -	if (a->len < b->len) {
>> > -		cmp = memcmp(a->buf, b->buf, a->len);
>> > -		return cmp ? cmp : -1;
>> > -	} else {
>> > -		cmp = memcmp(a->buf, b->buf, b->len);
>> > -		return cmp ? cmp : a->len != b->len;
>> > -	}
>> > -}
>> > -
>> 
>> > +static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
>> > +{
>> > +	int len = a->len < b->len ? a->len: b->len;
>> > +	int cmp = memcmp(a->buf, b->buf, len);
>> > +	if (cmp)
>> > +		return cmp;
>> > +	return a->len < b->len ? -1: a->len != b->len;
>> > +}
>> 
>> My guess is that you are conflating two issues about speed here: the
>> inlining will like speed the stuff up.  But having to evaluate the
>> (a->len < b->len) comparison twice will likely slow it down.
>
> Can't the result of the expression be reused in compiled?
> Isn't it a common expression?

No, since the call to memcmp might change a->len or b->len.  A
standard-compliant C compiler can't make assumptions about what memcmp
might or might not touch unless both a and b can be shown to refer to
variables with an address never passed out of the scope of the
compilation unit.

>> So if you do any profiling, you should do it on both separate
>> angles of this patch.
>
> I compared the inlined versions of both.

Interesting.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
