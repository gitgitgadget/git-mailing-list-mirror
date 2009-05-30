From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 2/2] diff: generate pretty filenames in
	prep_temp_blob()
Date: Fri, 29 May 2009 18:22:05 -0700
Message-ID: <20090530012204.GA26210@gmail.com>
References: <1243558164-74756-1-git-send-email-davvid@gmail.com> <1243558164-74756-2-git-send-email-davvid@gmail.com> <20090529195537.GA13961@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 30 03:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MADIl-0001pZ-72
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 03:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZE3BWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 21:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbZE3BWO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 21:22:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:53349 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZE3BWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 21:22:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1963090rvb.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/5N9Qj9c275A0RfI05ppavXJJDqqjziUVBF7KKSQBbk=;
        b=HD0X/wSQRtVavvirqzAhti9Hcmy685VrF6PgtDQA/kVmui4nw9pqpkKAiz75FcyQ3h
         i5biS9zua5zyd1IbD/+9Eyn5jMhqftuUD0S6oCZx1buzKcmdWTehM81nMAT78w/BO91k
         3pkCuyB9wx85liVWKf3A5RK46xzB/lhYSkwOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ujkoH4fgwI/7Yif/beHaF9XIaBnQgTpZ3J876PvMg5HcN2lwl5yuAcnaiAAmLQCAis
         mlzqmzaF1DSrOAGlWPWOLXeuxd3arMaNBZR9/x6OVSQ1oQbL5ATU42bpXAopxZhk9xkg
         nWxaiy5MAsYHlOtyZOslUqT/8PPV7VZyCJSoY=
Received: by 10.141.18.15 with SMTP id v15mr1881671rvi.197.1243646535263;
        Fri, 29 May 2009 18:22:15 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j26sm3073321waf.28.2009.05.29.18.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 18:22:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090529195537.GA13961@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120329>

On Fri, May 29, 2009 at 03:55:37PM -0400, Jeff King wrote:
> On Thu, May 28, 2009 at 05:49:24PM -0700, David Aguilar wrote:
> 
> > @@ -1964,8 +1964,24 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
> >  {
> >  	int fd;
> >  	struct strbuf buf = STRBUF_INIT;
> > +	struct strbuf template = STRBUF_INIT;
> > +	char *basename = ((char*)path) + strlen(path) - 1;
> 
> Why do you drop constness in this assignment?


That was a mistake.


> > +	/* Windows lacks basename() */
> > +	while(*basename && basename > path) {
> > +		basename--;
> > +		if (is_dir_sep(*basename)) {
> > +			basename++;
> > +			break;
> > +		}
> > +	}
> 
> This is such an easily-factorable bit, maybe it makes sense to add as
> basename() in compat/?

I would feel a little better calling it
git_basename(const char *) and keeping it in path.c
(or another name if basename is no good)

The reason is from the manpage for basename:

"Both dirname() and basename() may modify the
contents of path, so it may be desirable to
pass a copy when calling one of these functions."

The above snippet is much simpler and does not have
that restriction since we can guarantee const-ness.

All this version cares about is being able to find the
last dir_sep and returning a pointer.

What do you think?

-- 

	David
