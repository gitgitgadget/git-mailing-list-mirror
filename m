From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCHv3 00/10] gitweb: Simple file based output caching
Date: Thu, 18 Feb 2010 14:01:12 -0800
Message-ID: <4B7DB8A8.4020306@eaglescrag.net>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiERC-0000NA-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 23:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab0BRWB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 17:01:29 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:58878 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0BRWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 17:01:28 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o1IM1DnF022884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 14:01:15 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 18 Feb 2010 14:01:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140385>

> Shortlog:
> ~~~~~~~~~
> Jakub Narebski (10):
>   gitweb: href(..., -path_info => 0|1)

This still looks fine to me.

>   gitweb/cache.pm - Very simple file based cache

This looks fine to me, and I'm much more keen on using the CHI interface.

>   gitweb/cache.pm - Stat-based cache expiration

- I think having expires time at -1 (never) is a dangerous default.  I
think having it as an option is fine, but setting this to something like
6 months may be a better option.  I wouldn't expect this to be an issue
in reality, but I can just see someone screwing up and having a cache
system that *never* expires.  I think I'd rather see something long vs.
never.  But that's just my opinion.

- This does have the problem (though this gets fixed later on, again)
that it would return invalid if there's a process already updating the
cache.  This might need to be fixed later to understand the locking
structures on what is/isn't valid (this is mostly a note for me while I
read through the patches)

>   gitweb: Use Cache::Cache compatibile (get, set) output caching

- It might be worth (in a later patch) enabling the PerlIO layers as
there was a significant speed improvement in using them, despite their
non-standardness.

- What if you want to use a different caching library but don't want
cache.pm ?  That first bit of "if ($caching_enabled) {" might need to be
wrapped to figure out if we are using our inbuilt caching or an external
caching system. (just thinking out loud)

Looks fine to me.

>   gitweb/cache.pm - Adaptive cache expiration time

is the commented:

#return &{$self->{'check_load'}}();

intended in check_load() ?

otherwise this looks fine to me.

>   gitweb: Use CHI compatibile (compute method) caching

Looks fine to me.  I think it's fine where it's at in the order myself.

>   gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem

Looks fine to me.

>   gitweb/cache.pm - Serve stale data when waiting for filling cache

Looks fine to me.

>   gitweb/cache.pm - Regenerate (refresh) cache in background

Looks good to me.

>   gitweb: Show appropriate "Generating..." page when regenerating cache

I've got a couple of things that will need to be added on top of this
(mainly to try and guess if the client is dumb or smart) so that if it
won't support generating... as expected it doesn't get it.  But that can
come in a later patch.

This looks fine to me.

> 
> Diffstat:
> ~~~~~~~~~
>  gitweb/README                          |   70 ++++
>  gitweb/cache.pm                        |  655 ++++++++++++++++++++++++++++++++
>  gitweb/gitweb.perl                     |  321 +++++++++++++++-
>  t/gitweb-lib.sh                        |    2 +
>  t/t9500-gitweb-standalone-no-errors.sh |   19 +
>  t/t9503-gitweb-caching.sh              |   32 ++
>  t/t9503/test_cache_interface.pl        |  404 ++++++++++++++++++++
>  t/test-lib.sh                          |    3 +
>  8 files changed, 1486 insertions(+), 20 deletions(-)
>  create mode 100644 gitweb/cache.pm
>  create mode 100755 t/t9503-gitweb-caching.sh
>  create mode 100755 t/t9503/test_cache_interface.pl
> 
