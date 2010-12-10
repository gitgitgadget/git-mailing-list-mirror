From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/18] gitweb: Adding isBinaryAction() and isFeedAction() to determine the action type
Date: Fri, 10 Dec 2010 13:10:53 +0100
Message-ID: <201012101310.55094.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3lj3y1ogb.fsf@localhost.localdomain> <4D01A103.3090900@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 13:11:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR1oe-00061F-Km
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 13:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab0LJMLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 07:11:09 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:35706 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab0LJMLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 07:11:07 -0500
Received: by bwz16 with SMTP id 16so3893360bwz.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=amyIxtaGCKYPq6Cm5Zbs9Z3DLYFmTrXQpmCWLvftMYo=;
        b=SIUcXb+UkmnCU+hYaPiC/Yy43BKvA+BIePSi1HbyXnW8oL0zo1pXRXSXSSOmwlb7DZ
         8q8hnWP4mP30DT58x2RcM/t5Uowj4en13cjPgeaFe/q5+K7vjtDhJXeoide1p0B3wON1
         U12SWmUrF4S78mgcbYwLNb2ZfeiEaRpx5DnIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uch+VpvKbXZOv+ypW/IYMGegzkJ8YFYxyfXUzo7PtXa0OJAuPTwGyfxgYMLxw0y5S5
         6h/YTX4PuqtBVcjyMBk8X+mTLbeOEL4FSTltMkCO9BVC0YZ5kMmXCLsAwzfdVvRVI8jA
         n9oOMQ0T05HVkGYnK0Fo2NEbkqcVxQTB9QUbc=
Received: by 10.204.34.77 with SMTP id k13mr188942bkd.204.1291983066249;
        Fri, 10 Dec 2010 04:11:06 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id s16sm1503767bkk.0.2010.12.10.04.11.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 04:11:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D01A103.3090900@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163407>

On Fri, 10 Dec 2010, J.H. wrote:

>>> This is fairly self explanatory, these are here just to centralize the checking
>>> for these types of actions, as special things need to be done with regards to
>>> them inside the caching engine.
>>>
>>> isBinaryAction() returns true if the action deals with creating binary files
>>> (this needing :raw output)
>> 
>> Why do you need special case binary / :raw output?  It is not really
>> necessary if it is done in right way, as shown in my rewrite.
> 
> Because that's not how my caching engine does it, and the reason for
> that is I am mimicking how the rest of gitweb does it.

To shorten the explanation why treating binary (needing :raw) output in
a special way is not necessary: with the way gitweb code is structured
(with "binmode STDOUT, ':raw'" inside action subroutine), with the way
capturing output is done (by redirecting STDOUT), and even with the way
kernel.org caching code is structured the only thing that needs to be
done to support both text (:utf8, as set at beginning of gitweb) and
binary (:raw) output is to *dump cache to STDOUT in binary mode*:

	binmode $cache_fh, ':raw';
	binmode STDOUT, ':raw';
	File::Copy::copy($fh, \*STDOUT);

Nothing more.

Just dump cache file to STDOUT in binary mode.
 
> I attempted at one point to do as you were suggesting, and it became too
> cumbersome.  I eventually broke out the 'binary' packages into a special
> case (thus mimicking how gitweb is already doing things), which also
> gives me the advantage of being able to checksum the resulting binary
> out of band, as well as being able to more trivially calculate the file
> size being sent.

I don't see how it needs to be special-cased: the ordinary output would
also take advantage of this.  Note that plain 'blob' action can also
be quite large.

If there is to be done smarter, i.e. HTTP-aware, parsing and dumping of
cache entry file, e.g. by reading the HTTP header part to memory and
fiddling with HTTP headers (e.g. adding Content-Length header), it can be
done in a contents-agnostic way.

Note that with the way I do it in my rewrite, namely saving cached output
to temporary file to rename it to final destination later (atomic update),
we can do mungling of HTTP headers before/during this final copying to
final file, e.g. calculating Content-Length and perhaps Content-MD5 
headers.

> 
>>> isFeedAction() returns true if the action deals with a news feed of some sort,
>>> basically used to bypass the 'Generating...' message should it be a news reader
>>> as those will explode badly on that page.
>> 
>> Why blacklisting 'feed', instead of whitelisting HTML-output?
> 
> There are a limited number of feed types and their ilk (standard xml
> formatted feed and atom), there are lots of html-output like things.
> Easier to default and have things work, generally, than to have things
> not work the way you would expect.

Ah, I see from what you written in other subthreads of this thread that
you prefer to have "Generating..." page where it is not wanted that not
have it where it could be useful (i.e. blacklist approach), while I took
the opposite side (i.e. whitelist approach).

-- 
Jakub Narebski
Poland
