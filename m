From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/67] trace: use strbuf for quote_crnl output
Date: Wed, 16 Sep 2015 11:16:18 -0400
Message-ID: <20150916151618.GB547@flurp.local>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152843.GK29753@sigill.intra.peff.net>
 <CAPig+cS3WFg1JtN7WU-SFSbT3a2L3o7wiZr8OMGJ5E3As00q3w@mail.gmail.com>
 <20150916103114.GE13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:16:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcERj-0004om-CB
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 17:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbIPPQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 11:16:22 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35493 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbbIPPQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 11:16:20 -0400
Received: by igbkq10 with SMTP id kq10so36794011igb.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/guQSYjl27unIJ1AWlpGVkRcTfCwCpLm7i0b3yo9hh8=;
        b=Sjj09gvHx5hAg8cwV5khKx3BHxn0i4Wnm1n2tSQLxxFg7Fa57VqtbtHxxnOobzFwaR
         64XJFxNN7BVSnBUuZ4GE7Qn5JaXeNdjuxOWOYtQetRYrt1VdF1JGt+zzZcB09vuk9OUG
         VmkP0UZG6+8vUek6gvhlPhfZPpE+8YwDW/5quFIkueQdoeFk/fa3QvIXUZC5I6P4OO5K
         wMYOmm9rKclTYg2pwSBLMxHZLLARrtCpRkZB0Xex4VAjCBuZkZWkEvsiqfdAhiiVkFUX
         mYwy4eWpKY38YhNYl2XxQCdQ8s8FA2NciZH34ifvi4Iv/U4McwSKPveqIMKH3tZwByzH
         D5mg==
X-Received: by 10.50.66.5 with SMTP id b5mr17075635igt.84.1442416580025;
        Wed, 16 Sep 2015 08:16:20 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id n14sm10549874ioi.15.2015.09.16.08.16.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 08:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150916103114.GE13966@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278030>

On Wed, Sep 16, 2015 at 06:31:14AM -0400, Jeff King wrote:
> On Tue, Sep 15, 2015 at 08:55:58PM -0400, Eric Sunshine wrote:
> > On Tue, Sep 15, 2015 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> > >  static const char *quote_crnl(const char *path)
> > >  {
> > > -       static char new_path[PATH_MAX];
> > > +       static struct strbuf new_path = STRBUF_INIT;
> > >         const char *p2 = path;
> > > -       char *p1 = new_path;
> > 
> > It's a little sad that this leaves a variable named 'p2' when there is
> > no corresponding 'p1'. Would this deserve a cleanup patch which
> > renames 'p2' to 'p' or do we not care enough?
> 
> Yeah, you're right. The original had symmetry in p1 and p2, in that it
> moved them forward together. Now that symmetry is gone, and I wonder if
> the simplest cleanup is to just drop "p2" altogether and advance the
> "path" source pointer? Like this:

Works for me. The diff is a bit noisier, but the final result feels clean.

> -- >8 --
> Subject: [PATCH] trace: use strbuf for quote_crnl output
> 
> When we output GIT_TRACE_SETUP paths, we quote any
> meta-characters. But our buffer to hold the result is only
> PATH_MAX bytes, and we could double the size of the input
> path (if every character needs quoting). We could use a
> 2*PATH_MAX buffer, if we assume the input will never be more
> than PATH_MAX. But it's easier still to just switch to a
> strbuf and not worry about whether the input can exceed
> PATH_MAX or not.
> 
> The original copied the "p2" pointer to "p1", advancing
> both. Since this gets rid of "p1", let's also drop "p2",
> whose name is now confusing. We can just advance the
> original "path" pointer.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  trace.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/trace.c b/trace.c
> index 7393926..4aeea60 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -277,25 +277,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>  
>  static const char *quote_crnl(const char *path)
>  {
> -	static char new_path[PATH_MAX];
> -	const char *p2 = path;
> -	char *p1 = new_path;
> +	static struct strbuf new_path = STRBUF_INIT;
>  
>  	if (!path)
>  		return NULL;
>  
> -	while (*p2) {
> -		switch (*p2) {
> -		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
> -		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
> -		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
> +	strbuf_reset(&new_path);
> +
> +	while (*path) {
> +		switch (*path) {
> +		case '\\': strbuf_addstr(&new_path, "\\\\"); break;
> +		case '\n': strbuf_addstr(&new_path, "\\n"); break;
> +		case '\r': strbuf_addstr(&new_path, "\\r"); break;
>  		default:
> -			*p1++ = *p2;
> +			strbuf_addch(&new_path, *path);
>  		}
> -		p2++;
> +		path++;
>  	}
> -	*p1 = '\0';
> -	return new_path;
> +	return new_path.buf;
>  }
>  
>  /* FIXME: move prefix to startup_info struct and get rid of this arg */
> -- 
> 2.6.0.rc2.408.ga2926b9
> 
