From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 02:12:15 +0200
Message-ID: <200806180212.15392.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806180054.33490.jnareb@gmail.com> <48584D1F.5070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 02:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8lP7-0005nv-Ra
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 02:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbYFRATH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 20:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758793AbYFRATG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 20:19:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15621 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbYFRATF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 20:19:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1042fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/S2eTNzjllTEw7gxmnnIdGrqzpmjrH6ci95FK7FfyF8=;
        b=unucxQG/FO5JJ71meDCBKf6zd+oTMVIeP/Vq6aScMIV/y6Q1Fqpq/TrKfK0BKQiKJj
         KavTA9JEUWHj6oPYLn6JZt3fxUFFItmcdjwLO/8j9AJxGdo7INjtaBUbvUOmqvNWZVV4
         FS9SUBNH/TVj1A5z+UKBG+sfSgjqm/zO+fNiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XRl2kVTPUv6IIFNwHxvylVEd2440Da2O7X4R8fiRPuO+qMV3HOHkKhAWIK2y3UVuxs
         YEtIzg19hX8EBve28q8UNKfBYj0F38DdKxnmXhOhtnlbAJkA7SO4sI51717KdkiFLoDT
         57O8avgLd7O+UyPIG/04UaBcgwLgLy4oOzUD0=
Received: by 10.86.49.13 with SMTP id w13mr9606152fgw.65.1213747935562;
        Tue, 17 Jun 2008 17:12:15 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.69])
        by mx.google.com with ESMTPS id d6sm14129354fga.2.2008.06.17.17.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 17:12:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48584D1F.5070000@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85347>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > But what are arguments for "check params; run command" vs "run command;
> > check params if error" proposed by Junio?  Why do you want to check
> > parameters upfront?
> 
> It's actually not checking, it's resolving.  Instead of ...
> 
> get_commit($symbol)
> 
> ... (with $symbol = 'HEAD' for instance), you do (pseudocode):
> 
> $hash = get_hash($symbol, 'commit'); # 'commit' to resolve tags

Errr... is there equivalent to ^{}, i.e. resolve to non-tag?

> check that $hash is defined
> get_commit($hash)

Note that you would have to examine gitweb sources to check if it
uses href(..., -replay=>1) when it should, so the links from "volatile"
link, e.g. HEAD version URL, also lead to appropriate version,
e.g. "tree" from current / HEAD version.

> (And get_commit won't even accept anything but 40-byte hashes.)  This is 
> for two reasons:
> 
> 1. Caching: Resolving symbols first gives you some (very few) cache 
> entries that need to be expired (namely, get_hash results for symbols 
> that are not SHA1 hashes already), but most cache entries (like the 
> get_commit) are infinitely valid.

BTW. one of earliest idea was to fully resolve hashes, add missing
parameters if possible (like 'h', 'hp', 'f') and convert hashes to
sha-1.  One of intended uses was (weak) ETag for simple HTTP caching.

But it was before git-cat-file --batch-check, and before
href(...,-replay=>1).

[...]

Thanks for explanation.  It makes clear why you have chosen this
solution (I think that (1) is deciding factor here).


> > By the way, would you be sending your current WIP for review?
> 
> Will do in the next 2 days after some cleanup.

Thanks.

I have read your current code, but I'd rather not comment on it
(like no_plan and skipping tests, or elaborate wrapping fields
vs. perltie) until it is ready, i.e. sent for peer review.

> > [is] adding object oriented interface (wrapper) to git repositories
> > really  needed for implementing gitweb caching?
> 
> It makes things better to read for sure, and it means that you can have 
> a plain API without caching, and implement the caching layer as a 
> subclass (which overrides the methods with cacheable results).

All the time I think that caching _everything_ is a bad solution.
Besides sometimes you need to cache information specific for gitweb,
or information _aggregated_ by gitweb, which doesn't have place as
single entity in Git::Repo.

So while I think that Git::Repo and making gitweb use it is
a worthwhile goal, I think caching should be explicitely in gitweb.
See CGI::Cache for good solution of inobtrusive output caching, and
CHI (or other in recommended thread) for inobtrusive data caching
using callbacks (and Cache::None engine).  That not said that we
should use such non-standard Perl modules!

<probably should not send email this late>
-- 
Jakub Narebski
Poland
