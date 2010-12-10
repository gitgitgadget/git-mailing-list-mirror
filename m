From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/18] gitweb: Adding isBinaryAction() and isFeedAction() to determine the action type
Date: Fri, 10 Dec 2010 13:25:15 +0100
Message-ID: <201012101325.16629.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <4D01A103.3090900@eaglescrag.net> <201012101310.55094.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 13:25:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR22q-00047r-1A
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 13:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab0LJMZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 07:25:29 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:35396 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab0LJMZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 07:25:27 -0500
Received: by fxm18 with SMTP id 18so3659212fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BLpEIKtIfPBLsuTllQ7iD33E3YjEMvH+2Tf42gcRZjw=;
        b=YNXwlKeoEm5JjoiQDoaivcZomGQBTqU5PZrZgt3ef+/V5OTEiIjniWPX5x9FXQBkGm
         +SizBrgekUl4QDI4xZj8Q5x96O4qYzkUFs6AF7KLXLL906UxGWNVHeWDGetB5Tgy1QCj
         NZln7s5A+naqXdbI+BI7cD6uIqHzDURUbjZME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YhmkdOwWKpWR5yU/dMsDnvWDg0Qwz7tvf1NQwNWPXP0txJv319uViz81i6A1tpqGmf
         QHAKHqMeGCSzVUUhCA7VwcBb1mihxYcvj/xAkNpz2BOTCLIyQMKmeCNBR37xy6yiiPgf
         kiABoCH2GeBfWJcAyBtqeFyrmyvblaebtEM2w=
Received: by 10.223.104.145 with SMTP id p17mr708711fao.105.1291983926281;
        Fri, 10 Dec 2010 04:25:26 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id w12sm870142fah.42.2010.12.10.04.25.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 04:25:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012101310.55094.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163408>

On Fri, 10 Dec 2010, Jakub Narebski wrote:
> On Fri, 10 Dec 2010, J.H. wrote:
> 
>>>> This is fairly self explanatory, these are here just to centralize the checking
>>>> for these types of actions, as special things need to be done with regards to
>>>> them inside the caching engine.
>>>>
>>>> isBinaryAction() returns true if the action deals with creating binary files
>>>> (this needing :raw output)
>>> 
>>> Why do you need special case binary / :raw output?  It is not really
>>> necessary if it is done in right way, as shown in my rewrite.
>> 
>> Because that's not how my caching engine does it, and the reason for
>> that is I am mimicking how the rest of gitweb does it.
> 
> To shorten the explanation why treating binary (needing :raw) output in
> a special way is not necessary: with the way gitweb code is structured
> (with "binmode STDOUT, ':raw'" inside action subroutine), with the way
> capturing output is done (by redirecting STDOUT), and even with the way
> kernel.org caching code is structured the only thing that needs to be
> done to support both text (:utf8, as set at beginning of gitweb) and
> binary (:raw) output is to *dump cache to STDOUT in binary mode*:
> 
> 	binmode $cache_fh, ':raw';
> 	binmode STDOUT, ':raw';
> 	File::Copy::copy($fh, \*STDOUT);
> 
> Nothing more.
> 
> Just dump cache file to STDOUT in binary mode.

Note that special-casing binary output means that you would never be able
to replace custom caching engine with e.g. CHI with Memcached backend,
because that treating some actions in a special way interleaves gitweb
code with guts of caching code.

And memcached might be a way that kernel.org would have to go...
-- 
Jakub Narebski
Poland
