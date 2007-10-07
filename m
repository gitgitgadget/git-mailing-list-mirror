From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and optimize it a bit
Date: Sun, 7 Oct 2007 18:10:12 +0200
Message-ID: <20071007161012.GB3270@steel.home>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <85fy0nknnq.fsf@lola.goethe.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYi1-0000uY-8T
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXJGQKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXJGQKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:10:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43236 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbXJGQKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:10:15 -0400
Received: from tigra.home (Facde.f.strato-dslnet.de [195.4.172.222])
	by post.webmailer.de (fruni mo57) (RZmta 13.4)
	with ESMTP id w02e32j97EcWqW ; Sun, 7 Oct 2007 18:10:13 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C6DB2277AE;
	Sun,  7 Oct 2007 18:10:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A55A8C502; Sun,  7 Oct 2007 18:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85fy0nknnq.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9oFqQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60190>

David Kastrup, Sun, Oct 07, 2007 16:24:57 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > It is definitely less code (also object code). It is not always
> > measurably faster (but mostly is).
> 
> > -int strbuf_cmp(struct strbuf *a, struct strbuf *b)
> > -{
> > -	int cmp;
> > -	if (a->len < b->len) {
> > -		cmp = memcmp(a->buf, b->buf, a->len);
> > -		return cmp ? cmp : -1;
> > -	} else {
> > -		cmp = memcmp(a->buf, b->buf, b->len);
> > -		return cmp ? cmp : a->len != b->len;
> > -	}
> > -}
> > -
> 
> > +static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> > +{
> > +	int len = a->len < b->len ? a->len: b->len;
> > +	int cmp = memcmp(a->buf, b->buf, len);
> > +	if (cmp)
> > +		return cmp;
> > +	return a->len < b->len ? -1: a->len != b->len;
> > +}
> 
> My guess is that you are conflating two issues about speed here: the
> inlining will like speed the stuff up.  But having to evaluate the
> (a->len < b->len) comparison twice will likely slow it down.


Can't the result of the expression be reused in compiled?
Isn't it a common expression?

> So if you do any profiling, you should do it on both separate angles
> of this patch.
> 

I compared the inlined versions of both.
