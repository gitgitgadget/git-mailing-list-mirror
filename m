From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and
 optimize it a bit
Date: Sun, 7 Oct 2007 17:24:25 +0300
Message-ID: <20071007172425.bb691da9.tihirvon@gmail.com>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
	<1190625904-22808-2-git-send-email-madcoder@debian.org>
	<20071007140052.GA3260@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 16:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeX3q-0001E8-DD
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 16:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbXJGOYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJGOYl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 10:24:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:3011 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbXJGOYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 10:24:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1041157nfb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=53L+zohzvQbPCwsZV0bbjxiSQPAFCaLkT55kjLK0Gws=;
        b=hi4ME+ahMW2Roij7XffbTmq4up5gf+eeVz5T1c7LQE11q8sZZdjWwJXcPcC2blmxw1RQw+XU8lLsZbwqdqNVo85ehEWYqQ0P2z+6bGFufv4kbIXJGyRZh3CoRtAs0LAxW6gTT0FasppTc4w1fJMFsacdcTKITo1TIQaqGiexoPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mywDyJZpAtYsArTzAGxJxUMzKCmbCmnyjIr8GdQkdGRxlKdNKbyuyT3RrZedck9C5/OJ8Y7xjSqHfWxqE+Qc40Vy0m6jyXan7HiwBd0zLpiKLBVaSWy7zhBphCTt46oM9z3+kTQ4/VHoS3M96VQgflmESTGYvIQSL25zL335mdA=
Received: by 10.86.28.5 with SMTP id b5mr4274885fgb.1191767079319;
        Sun, 07 Oct 2007 07:24:39 -0700 (PDT)
Received: from garlic.home.net ( [85.23.19.170])
        by mx.google.com with ESMTPS id k29sm4442855fkk.2007.10.07.07.24.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Oct 2007 07:24:35 -0700 (PDT)
In-Reply-To: <20071007140052.GA3260@steel.home>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.14; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60179>

Alex Riesen <raa.lkml@gmail.com> wrote:

> +static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> +{
> +	int len = a->len < b->len ? a->len: b->len;
> +	int cmp = memcmp(a->buf, b->buf, len);
> +	if (cmp)
> +		return cmp;
> +	return a->len < b->len ? -1: a->len != b->len;
> +}

strbuf->buf is always non-NULL and NUL-terminated so you could just do

static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
{
	int len = a->len < b->len ? a->len : b->len;
	return memcmp(a->buf, b->buf, len + 1);
}
