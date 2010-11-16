From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit -s: allow "(cherry picked " lines in sign-off
 section
Date: Tue, 16 Nov 2010 14:40:27 -0600
Message-ID: <20101116204027.GB27390@burratino>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <20101116193018.GA31036@sigill.intra.peff.net>
 <20101116202556.GA27390@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 21:41:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PISL5-0005p5-RR
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 21:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab0KPUlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 15:41:09 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46757 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0KPUlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 15:41:08 -0500
Received: by ewy8 with SMTP id 8so659048ewy.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nxl0n6QgH+AY1/jy5+d7a/KlIJreo5AyzUVPhGdKvn0=;
        b=iO78RITH9zr1hoNzu78iLaVMfMy2uFI/utVNJ6CX0nz5gj2vW1dORK28nHuon6fZtu
         XIPNkkqiQgawKRBeukjEAGLI2XiNS3DgrtmI8xffizUA0FSW+5rh+6jKIYSUgjHunbMw
         b2ELAcg9ZvGIy0K+TeyHnxdbz4zlPj9daaqiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z6UcQMxFb7OSOribDitsVRs3gjuZowXpPC7PGkpGHtWLItog0Rq+vK4WpbgoTMZdXe
         DqTlLHdmrsQrPHV+Yur1FOE+JjBUYZh+my33VYczU/5PLQ3NnsWJiTL3WIygyi8HRjJr
         EDayEH9Ge6JufC7YZA6pBEjXTt2EMOQd8kVMY=
Received: by 10.216.60.203 with SMTP id u53mr7053035wec.36.1289940066533;
        Tue, 16 Nov 2010 12:41:06 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id w41sm786289weq.8.2010.11.16.12.41.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 12:41:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101116202556.GA27390@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161587>

Jonathan Nieder wrote:

> 	(cherry picked from commit 9d8117e72bf453dd9d85e0cd322ce4a0f8bccbc0)
> 
> 	Signed-off-by: Back Porter <backporter@example.com>
> 
> The cherry-pick is a step in the line of a patch like any other,
> so one might prefer to lose the extra newline.

Sigh.  s/line/life/

[...]
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Let's kick off the reviews.

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -528,6 +528,8 @@ static int ends_rfc2822_footer(struct strbuf *sb)
>  		i++;
>  
>  	for (; i < len; i = k) {
> +		static const char cherry_pick[] = "(cherry picked from commit ";
> +

Better to share this string with builtin/revert.c, no?

What would happen when "(cherry picked ..." gets translated?
Should only the current language's version be tolerated in
the commit footer, or is there something more generic to
match for that could take care of wording changes automatically?

> @@ -535,6 +537,20 @@ static int ends_rfc2822_footer(struct strbuf *sb)
>  		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
>  			continue;
>  
> +		if (!first && buf[k] == '(' && k + strlen(cherry_pick) < len) {
> +			/* Might be a cherry-pick notice. */
> +			const char *p = buf + k;
> +			if (!memcmp(p, cherry_pick, strlen(cherry_pick))) {
> +				p = memchr(buf + k, '\n', len - k);

Maybe simpler:

	p = memchr(...
	if (!p)
		return 0;
	i = p - buf;

to reuse the termination condition in the sign-off parser.

Presumably the main loop could use memchr() instead of open-coding
it as well.
