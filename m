From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config' access
Date: Wed, 8 Apr 2009 12:18:38 +0200
Message-ID: <200904081218.39984.jnareb@gmail.com>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz> <m3prfo1xh6.fsf@localhost.localdomain> <49DC3ADD.5000902@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Apr 08 12:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUtS-0001In-UM
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763051AbZDHKS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 06:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759551AbZDHKS4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:18:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:45594 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZDHKSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:18:55 -0400
Received: by rv-out-0506.google.com with SMTP id f9so41756rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2DDGJZBDd9gCdXoswlKVgzb42m8HX/ipj9yeHgNo/JE=;
        b=wpPEdJ3gNbL4dCPXTU7R9ulPswPAQVnI+L1kLlmVeSdCroY1LeEbfRRaiZfzqyXwDO
         R2u43h1wtyomIOlgGCYXV/QfNcJYQZ6PVV/vZ1jQnuXXWFrTioXT3k7hQHCg4uKDXfft
         2EcLqtwYq3p5RstNbgq6YrXjhyiM0Ht2rGbCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZwUpztK0fx5HOHbYFYwhlLQ5wDxx63sKZhJM4vrsh5RcXui5/wFtFnMOnDARUt6np+
         reA80nheNu9Pe/lEgyy6ew+XSE1yiPXzFtWSzVkSO/RKEK78AXSWRNL9CzkBTPbsA1xx
         p/WJDnqtKrbWdjYehPTEJSdp/UXftBPxydlHw=
Received: by 10.141.52.6 with SMTP id e6mr469254rvk.133.1239185934391;
        Wed, 08 Apr 2009 03:18:54 -0700 (PDT)
Received: from ?192.168.1.13? (abuz219.neoplus.adsl.tpnet.pl [83.8.197.219])
        by mx.google.com with ESMTPS id k2sm25071733rvb.14.2009.04.08.03.18.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:18:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <49DC3ADD.5000902@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116075>

By the way, did you take a look how cached 'git config' access and
typecasting is done in gitweb?  See commit b201927 (gitweb: Read
repo config using 'git config -z -l') and following similar commits.

On Wed, 8 April 2009, Sam Vilain wrote:
> Jakub Narebski wrote:

>>> -		my ($item, $value) = m{(.*?)=(.*)};
>>> +		my ($item, $value) = m{(.*?)\n((?s:.*))\0}
>>> +			or die "failed to parse it; \$_='$_'";
>> 
>> Errr... wouldn't it be better to simply use 
>> 
>> +		my ($item, $value) = split("\n", $_, 2)
>> 
>> here?
> 
> Yeah, I guess that's easier to read and possibly faster; both are
> using the regexp engine and using COW strings though, so it's probably
> not as bad as one might think.

The version using 'split' has the advantage that for config variable
with no value (e.g. "[section] noval") it sets $item (why this variable
is called $item and not $var, $variable or $key, BTW.?) to fully 
qualified variable name (e.g. "section.noval"), and sets $value to 
undef, instead of failing like your original version using regexp.

And I also think that this version is easier to understand, and might be 
a bit faster as well; but it is more important to be easier to 
understand.

>> Have you tested Git::Config with a "null" value, i.e. something
>> like
>> 
>>     [section]
>>         noval
>> 
>> in the config file (which evaluates to 'true' with '--bool' option)?
>> Because from what I remember from the discussion on the 
>> "git config --null --list" format the lack of "\n" is used to
>> distinguish between noval (which is equivalent to 'true'), and empty
>> value (which is equivalent to 'false')
>> 
>>     [boolean]
>>         noval        # equivalent to 'true'
>>         empty1 =     # equivalent to 'false'
>>         empty2 = ""  # equivalent to 'false'
> 
> That I didn't consider.  Below is a patch for this.  Any more
> gremlins? 

I have nor examined your patch in detail; I'll try to do it soon,
but with git config file parsing there lies following traps.

1. In fully qualified variable name section name and variable name
   have to be compared case insensitive (or normalized, i.e.
   lowercased), while subsection part (if it exists) is case sensitive.

2. When coercing type to bool, you need to remember (and test) that
   there are values which are truish (no value, 'true', 'yes', non-zero
   integer usually 1), values which are falsish (empry, 'false', 'no',
   0); other values IIRC are truish too.

3. When coercing type to int, you need to remember about optional
   value suffixes: 'k', 'm' or 'g'.

4. I don't know if you remembered about 'colorbool' and 'color'; the
   latter would probably require some extra CPAN module for ANSI color
   escapes... or copying color codes from the C version.

> 
> Subject: perl: fix no value items in Git::Config
> 
> When interpreted as boolean, items in the configuration which do not
> have an '=' are interpreted as true.  Parse for this situation, and
> represent it with an object in the state hash which works a bit like
> undef, but isn't.

Why not represent it simply as an 'undef'? You can always distinguish 
between not defined and not existing by using 'exists'...

> Sneak a couple of vim footer changes in too.

Hmmm...

> 
> Signed-off-by: Sam Vilain <sam@vilain.net>

[...]
-- 
Jakub Narebski
Poland
