From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 09:35:53 +0200
Message-ID: <200806180935.54712.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806180212.15392.jnareb@gmail.com> <48586400.4000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 09:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8sE1-0006x4-72
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 09:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYFRHgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 03:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbYFRHgF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 03:36:05 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:48836 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYFRHgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 03:36:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so29928and.103
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bg+3xoZRGxVG1UDrs6W+wFJIi+9UTGcYjOsokNJUFtQ=;
        b=OaOoTnndNWHr97+ZBGur1HjlA0x6tzrzsqc91Susxcp1dlExRxiPL4sMVsQnzi40iW
         rF77OtRO/ncC8jZ4MTH3UGTsv9v2YejYyNaZjQzxS9cFnM3qmj+bNg08FW4UZDaJEFNO
         dK5Z2rIogZpKxwn3cN4ZO7CjbO9ijpOJJ3V/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DrMUuDJbFHsU9X6uQquhTqOiWwDxQeZDlt8e+aOqv++bMcDxPFhWaZM9tY0kSv4h6l
         ccT+9udWofDBlWAEO34B6nAMU5M0wNvgZ0f9nzzaax3D93oV0MKhOBIemd56dr5Pk0aq
         tZdLiBL9lNC3iEHVLmk0NxoOCRMIEtdACJGho=
Received: by 10.101.71.9 with SMTP id y9mr363269ank.145.1213774559500;
        Wed, 18 Jun 2008 00:35:59 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.255.188])
        by mx.google.com with ESMTPS id c37sm5628389ana.11.2008.06.18.00.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 00:35:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48586400.4000504@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85368>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann wrote:
>>>
>>> $hash = get_hash($symbol, 'commit'); # 'commit' to resolve tags
>> 
>> Errr... is there equivalent to ^{}, i.e. resolve to non-tag?
> 
> Yup.  Haven't quite decided whether to simply use "$symbol^{type}" or 
> make type a separate parameter.

Although I think this won't be necessary for gitweb, the ability
should (I guess) be in generic object-oriented interface like
Git::Repo module.

>> Note that you would have to examine gitweb sources to check if it
>> uses href(..., -replay=>1) when it should,
> 
> Good point, will do.

It should, but I might have missed something.

>> BTW. one of earliest idea was to fully resolve hashes, add missing
>> parameters if possible (like 'h', 'hp', 'f') and convert hashes to
>> sha-1.  One of intended uses was (weak) ETag for simple HTTP caching.
> 
> Interesting.  Something to keep in mind is that using name-rev still can 
> wreck with this since it has the unique property of taking hashes but 
> still depending on the current refs.  Gitweb isn't using name-rev a lot 
> right now, but that might change of course (e.g. I think that it would 
> be convenient to always display names along with any commit hashes).

Well, you will have two level cache: first from refnames[*1*] to hashes
(by the way I think you can treat tag names as valid indifinitely,
and use them in the place of full sha-1 hashes; thanks to heads<->tags
ambiguity gitweb now spells tags in full as refs/heads/<tag>), second
from "normalized" URLs to content, or rather from "normalized" URL
derivative to data used to generate content.

So I think you can use first-level cache to calculate equivalent
of 'name-rev', or keep cached 'name-rev' there.

Currently gitweb uses name-rev only in (I think) rarely used 'raw'
(text/plain) version of 'commit' and 'commitdiff' views... and I think
it is here to stay thanks to gitk like displaying refs marks in
log-like views (I think result of git_get_references() should also
be cached...).

[*1*] Well, project name (repository path) + refname.


We will see if this two-tier cache solution is good idea...

>> All the time I think that caching _everything_ is a bad solution.
> 
> So?  We can easily add an option to the cache; e.g. no_cache => 
> ['get_blob', 'ls_tree'].  I doubt that it will be needed, but if it 
> does, it's easy to add it.  Don't worry about it, really.

Well, on the other hand from what I understand kernel.org gitweb caches
unconditionally (but adaptively) every page, same with CGit (used for
example on freedesktop.org).

It would be nice to have some stats of gitweb access (e.g. from
repo.or.cz and kernel.org).

>> CHI (or other in recommended thread) for inobtrusive data caching
> 
> Thanks for the pointer!  On the one hand CHI is very recent and not even 
> in Debian, on the other hand it provides things like busy_lock on top of 
> Memcached (AFAICS), at fairly little cost.  I'll look into it.

I was not thinking about using CHI, or any Perl module metioned in

  "[RFD] Gitweb caching, part 3: examining Perl modules for caching (long)"
  http://thread.gmane.org/gmane.comp.version-control.git/77529/focus=77527

(perhaps with exception of Cache::Cache and its submodules/engines), but
rather about emulating best of its interfaces (well, perhaps also
"borrowing" some of its code, if license permits).

-- 
Jakub Narebski
Poland
