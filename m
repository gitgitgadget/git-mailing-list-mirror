From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and 
 optimize it a bit
Date: Sun, 7 Oct 2007 19:18:21 +0300
Message-ID: <20071007191821.c872cc51.tihirvon@gmail.com>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
	<20071007172425.bb691da9.tihirvon@gmail.com>
	<20071007143912.GB10024@artemis.corp>
	<Pine.LNX.4.64.0710071710190.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYq0-0002Pe-5U
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXJGQSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbXJGQSa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:18:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:64135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbXJGQSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:18:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1055787nfb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=DkHYP9zLA2DE09F51akLFOh0IodDemX68JbDSj/hkQI=;
        b=huMzsfoPExp4TjEBGYInsiFAUMqvtJiY7btjubnfjnuOITglsJgZI+eOAqiziHDjvIVHQBdY2muuORTA4uuqUpRt78jPZPmJPhzyF/6YCRMXG7H7tavNVxYL39EtAP7NQxUp+Djf/Xp9LQocKvlqvTiJitRzOxKODV0iQT94DZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sywz8v2CVaJpb6qO0a8jvhAL8oGKs3I81f6Bjws8CPT9RArorqOXmVDckEHbnG+TZHnkFBR38Jf+FEs1Qh267vxsu7vK1zUUkXURBGkk9nVJT2k+7cA1hOQmRIqaq9cB4ZSKuL9aJcyRxx3k4KSyHxFgDG+k254KxJkrzhGPTJI=
Received: by 10.86.96.18 with SMTP id t18mr1138083fgb.1191773907797;
        Sun, 07 Oct 2007 09:18:27 -0700 (PDT)
Received: from garlic.home.net ( [85.23.19.170])
        by mx.google.com with ESMTPS id 22sm9832749fkr.2007.10.07.09.18.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Oct 2007 09:18:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710071710190.4174@racer.site>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.14; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60192>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Sun, 7 Oct 2007, Pierre Habouzit wrote:
> 
> > On Sun, Oct 07, 2007 at 02:24:25PM +0000, Timo Hirvonen wrote:
> >
> > > strbuf->buf is always non-NULL and NUL-terminated so you could just do
> > > 
> > > static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> > > {
> > > 	int len = a->len < b->len ? a->len : b->len;
> > > 	return memcmp(a->buf, b->buf, len + 1);
> > > }
> > 
> >   doesn't work, because a buffer can have (in some very specific cases)
> > an embeded NUL.
> 
> But it should work.  The function memcmp() could not care less if there is 
> a NUL or not, it just compares until it finds a difference.

Almost.  If a is "hello\0world" and b is "hello" then it would compare 6
characters from both and think the strings are equal.
