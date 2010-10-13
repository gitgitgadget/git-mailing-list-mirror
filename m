From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/4] limit "contains" traversals based on commit
 timestamp
Date: Wed, 13 Oct 2010 18:21:53 -0500
Message-ID: <20101013232153.GC11793@burratino>
References: <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123419.GB25699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 01:25:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AhK-0001gK-0e
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 01:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0JMXZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 19:25:19 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45011 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab0JMXZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 19:25:19 -0400
Received: by qyk5 with SMTP id 5so1128361qyk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DyVDq7iJC3izAVfI8ELYdEgFybktcSNj9XYSwSSj5wc=;
        b=TjOwBkFMj3fEFoZJ/+dgSlZsRJHRyCYVTvZtiB6n0JpcYT6Fl6zKybgGO5Y7SEJOvY
         HFxXlJl9H8gibpNfyPSB46swXgjgsJs1dFVMWGRh9c7cyKmAIfh10U7mznCU/lv+9rrh
         GVp1E6kAEpC60+F/FuZYOP948weoGfihmZkYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ji5MAtwlMx+n+G2UQ6wrhEwq18cwmY1TODFi9lwYeZtFWFp64jfwEzTbpBUBjM8qtR
         XUwa1wGhItGz88VFHTKJ7BTFTov4yB4iBJkNBp+C6KiuuibFRsg0c/y3paLVfngcX/TV
         tryHWhsOBFOyTd0O7mPEDKNWeJYqmzYs8LIis=
Received: by 10.224.185.144 with SMTP id co16mr7438745qab.399.1287012318321;
        Wed, 13 Oct 2010 16:25:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l13sm8803081qck.43.2010.10.13.16.25.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 16:25:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100705123419.GB25699@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159004>

Jeff King wrote:

> Name-rev already implements a similar optimization, using a
> "slop" of one day to allow for a certain amount of clock
> skew in commit timestamps. This patch introduces a
> "core.clockskew" variable, which allows specifying the
> allowable amount of clock skew in seconds.  For safety, it
> defaults to "none", causing a full traversal (i.e., no
> change in behavior from previous versions).

Tests?

Actually just a short example script to try would be helpful,
if anyone has one handy (yes, I am terribly lazy).  Such a script
would be useful for figuring out which commands ought to be
updated to respect core_clock_skew.  rev-list is one.

> --- a/commit.c
> +++ b/commit.c
[...]
> @@ -872,9 +874,13 @@ static int contains_recurse(struct commit *candidate,
>  	if (parse_commit(candidate) < 0)
>  		return 0;
>  
> +	/* stop searching if we go too far back in time */
> +	if (candidate->date < cutoff)
> +		return 0;
> +

Nice idea.

> @@ -885,5 +891,20 @@ static int contains_recurse(struct commit *candidate,
>  
>  int contains(struct commit *candidate, const struct commit_list *want)
>  {
> -	return contains_recurse(candidate, want);
> +	unsigned long cutoff = 0;
> +
> +	if (core_clock_skew >= 0) {
> +		const struct commit_list *c;
> +		unsigned long min_date = ULONG_MAX;
> +		for (c = want; c; c = c->next) {
> +			if (parse_commit(c->item) < 0)
> +				continue;

Why ignore these errors?  Will they be noticed later?

The rest of the patch looks good to me.  I am not thrilled with
making the user figure out an acceptable "[core] clockskew" value
(and am not sure it makes much sense as a tunable setting), but
it is better than the status quo, so...
