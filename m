From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and optimize it a bit
Date: Sun, 07 Oct 2007 16:24:57 +0200
Organization: Organization?!?
Message-ID: <85fy0nknnq.fsf@lola.goethe.zz>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 16:25:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeX43-0001GY-P8
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbXJGOYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXJGOYw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:24:52 -0400
Received: from main.gmane.org ([80.91.229.2]:40753 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXJGOYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:24:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IeX3i-0004nN-Ra
	for git@vger.kernel.org; Sun, 07 Oct 2007 14:24:42 +0000
Received: from dslb-084-061-036-151.pools.arcor-ip.net ([84.61.36.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:24:42 +0000
Received: from dak by dslb-084-061-036-151.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:24:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-036-151.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:yalEBXF7AMpFVKrLKempH+3ZWnc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60180>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is definitely less code (also object code). It is not always
> measurably faster (but mostly is).

> -int strbuf_cmp(struct strbuf *a, struct strbuf *b)
> -{
> -	int cmp;
> -	if (a->len < b->len) {
> -		cmp = memcmp(a->buf, b->buf, a->len);
> -		return cmp ? cmp : -1;
> -	} else {
> -		cmp = memcmp(a->buf, b->buf, b->len);
> -		return cmp ? cmp : a->len != b->len;
> -	}
> -}
> -

> +static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> +{
> +	int len = a->len < b->len ? a->len: b->len;
> +	int cmp = memcmp(a->buf, b->buf, len);
> +	if (cmp)
> +		return cmp;
> +	return a->len < b->len ? -1: a->len != b->len;
> +}

My guess is that you are conflating two issues about speed here: the
inlining will like speed the stuff up.  But having to evaluate the
(a->len < b->len) comparison twice will likely slow it down.

So if you do any profiling, you should do it on both separate angles
of this patch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
