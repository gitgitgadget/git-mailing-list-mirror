From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] vcs-svn: factor out usage of string_pool
Date: Sat, 19 Mar 2011 04:08:21 -0500
Message-ID: <20110319090821.GD6706@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300518231-20008-6-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 10:08:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0s9F-0007UL-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 10:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1CSJId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 05:08:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37638 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1CSJIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 05:08:32 -0400
Received: by iyb26 with SMTP id 26so4791521iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qBrH90LoZBionccI9Gr2LqRGnUq+zDRJchxhIiFNzdo=;
        b=L+mgOyneARpuEg5ypwgUCMxOIhjykBWyvSdsl5ArTYuae/khKItCfqoa5+bY7FoXG+
         Xq84ATjk52iVU7HZbLQwhWcGMuwCj13jV4GGT0b6BqdRsU9Y6QNrcuMWJPujQpOdw8Ww
         SJZzfL8WZWMry/DJnW8sfYbz8TF/GTeaAJ6Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ek+6DyqncLCPDmCwSKxMO5vxueFJHV/iFkX6yDTXMJq0lklRum1b1OjtmconKT6mtL
         V1NF50hE+BPQvOs+W4Ayan0V8veltUVDDgJ0uV9S4s44xA3VYL7e6LbM0HhB9VO1wkZI
         +m4npkCNATIR43xfdLzh8Al7u1UJ1YGyGI+pw=
Received: by 10.42.74.70 with SMTP id v6mr3126967icj.190.1300525710999;
        Sat, 19 Mar 2011 02:08:30 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id wt14sm2451699icb.4.2011.03.19.02.08.26
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 02:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300518231-20008-6-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169419>

David Barr wrote:

> [Subject: vcs-svn: factor out usage of string_pool]

This actually means something like: use strbufs and strings instead of
interned strings for values of rev, dump, and node fields that happen
to be strings.  After this change, there are no more users of the
string-pool library left.

> @@ -71,14 +71,16 @@ static void reset_rev_ctx(uint32_t revision)
>  	rev_ctx.revision = revision;
>  	rev_ctx.timestamp = 0;
>  	strbuf_reset(&rev_ctx.log);
> -	rev_ctx.author = ~0;
> +	strbuf_reset(&rev_ctx.author);

Side note: should the default timestamp really be the epoch?  I'd
rather the default timestamp be the timestamp of the parent revision,
to make out-of-order dates a little less likely.

>  }
>  
> -static void reset_dump_ctx(uint32_t url)
> +static void reset_dump_ctx(const char *url)
>  {
> -	dump_ctx.url = url;
> +	strbuf_reset(&dump_ctx.url);
> +	if (url)
> +		strbuf_addstr(&dump_ctx.url, url);

Good, we keep our own copy of the url still.

> @@ -91,13 +93,15 @@ static void handle_property(const char *key, const char *val, uint32_t len,
>  			break;
>  		if (!val)
>  			die("invalid dump: unsets svn:log");
> -		/* Value length excludes terminating nul. */
> -		strbuf_add(&rev_ctx.log, val, len + 1);
> +		strbuf_reset(&rev_ctx.log);
> +		strbuf_add(&rev_ctx.log, val, len);

What is this change about?

> @@ -447,5 +456,4 @@ void svndump_reset(void)
>  {
>  	fast_export_reset();
>  	buffer_reset(&input);
> -	pool_reset();

strbuf_release(&dump_ctx.url)?

Likewise for dump_ctx.uuid and the other one.

Thanks; except as noted above this looks good.
