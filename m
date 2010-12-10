From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 9 Dec 2010 22:11:44 -0600
Message-ID: <20101210041144.GA28166@burratino>
References: <201011041721.53371.jnareb@gmail.com>
 <4D00316F.9000305@eaglescrag.net>
 <201012092330.06688.jnareb@gmail.com>
 <20101209225211.GA20426@burratino>
 <88CF82F1-0363-47B4-8C6F-AE4A2DA1714B@wundersolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	"J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Olaf Alders <olaf@wundersolutions.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 05:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQuL5-0001TJ-GK
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 05:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab0LJEMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 23:12:05 -0500
Received: from mail-gw0-f66.google.com ([74.125.83.66]:37033 "EHLO
	mail-gw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0LJEME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 23:12:04 -0500
Received: by gwj18 with SMTP id 18so1068084gwj.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 20:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eY+jI5+JySSGLi4BBHtYQdTXy+sxHFQBDv+9u0IZ/WI=;
        b=sXCQOIwPszfUDONFjj845I8mqbviwpAyZbYgnXx0vCD2CWbvZ7O2JqTep7wHaOYmjy
         eGox4JJsa9AF8KYYpqRGSNcR0ksWO1EC1nsMiXOKyaf+S3rLsiLaXF0SngjUHSVhO0xv
         YjeYLXd4yIjuc4/MBNwhaKAQfTHjnVQY3Lt+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QdLCFgxg6R7HOdnz+4UWqA6BrxlfKCdNArjNtGzLHzg22wJ5waD8FnvUZ2OnZOkVcO
         fxdpAglS5wqI3IhF2qBPRuYQ0/7yRMdDCna38cGrlAeyEyfiEjuP0X4oG0syQVutXiHs
         ucrqeat4A8yCaThSi3qiESqIAFfPRB8uVUeOM=
Received: by 10.151.7.18 with SMTP id k18mr603266ybi.348.1291954322798;
        Thu, 09 Dec 2010 20:12:02 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id u10sm156940yba.1.2010.12.09.20.12.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 20:12:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <88CF82F1-0363-47B4-8C6F-AE4A2DA1714B@wundersolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163387>

Olaf Alders wrote:
> On 2010-12-09, at 5:52 PM, Jonathan Nieder wrote:

>> HTTP::BrowserDetect uses a blacklist as far as I can tell.  Maybe in
>> the long term it would be nice to add a whitelist ->human() method.
>>
>> Cc-ing Olaf Alders for ideas.
>
> Thanks for including me in this.  :)  I'm certainly open to patching
> the module, but I'm not 100% clear on how  you would want to
> implement this.  How is ->is_human different from !->is_robot?  To
> clarify, I should say that from the snippet above, I'm not 100%
> clear on what the problem is which needs to be solved.

Context (sorry I did not include this in the first place):

The caching code (in development) for git's web interface uses a page
that says "Generating..." for cache misses, with an http refresh
redirecting to the generated content.  The big downside is that if
done naively this breaks wget, curl, and similar user agents that are
not patient enough to grab the actual content instead of the redirect
page.

The first solution tried was to explicitly special case wget and curl.
But in this case it is better to be more inclusive[2]; when in doubt,
leave out the nice "Generating..." page and just serve the actual
content slowly just in case.

In other words, the idea was that user agents fall into three
categories:

 A. definitely will not replace content with target of HTTP refresh
 B. definitely will replace content with target of HTTP refresh
 C. unknown

and maybe ->is_robot could return true for A and ->is_human return
true for B (leaving C as !->is_human && !->is_robot).  In this case,
we should show the "Generating..." page only in the ->is_human (B)
case.

That said, I know almost nothing on this subject, so it is likely
this analysis misses something.  J.H. or Jakub can likely say more.

Thanks,
Jonathan
