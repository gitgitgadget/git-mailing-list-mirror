From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Gitweb caching, part 2 (long)
Date: Tue, 25 Mar 2008 18:06:56 +0100
Message-ID: <200803251806.58290.jnareb@gmail.com>
References: <200803190154.55532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	"Lars Hjemli" <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 18:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeCdE-0005R9-7H
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 18:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbYCYRHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 13:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbYCYRHH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 13:07:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:17969 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbYCYRHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 13:07:04 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4264473fkr.5
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/reb+7Ui3djY6uFe5lM4jyvuVRN9RFSj7zCZZWP9MMg=;
        b=qyUxikTOT/98DX+Xu/Sd5UrX8tslZs84jw4UEBrIyOSyRS1Z298i6WILFTiaJv7EfWo3lGGynrARsluBaZ27uMGABI90Uf0j6hVq6SoDC+vRaX4mSkqdPwenz786D9HENFctKJiQAwuPNXLG1IMxsGlgGuCz86ABgVaEtToyqnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W2xCUpfADY2Px4dckq69/GfZWR36YJKRVHJlFhp8D9FxFoINCI/Wnn9FRLCbBk0q9UI7Aahc6sQdITyyWKCHnsa3sYey7qYkrAJXzx7HFffOBXkaeef3buZoIEO8+WLS/KIesmmv18ehY/x+QVA4ZmkFN6B7R7mMmTAQdpng5r4=
Received: by 10.82.152.16 with SMTP id z16mr21599931bud.36.1206464822785;
        Tue, 25 Mar 2008 10:07:02 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.226.89])
        by mx.google.com with ESMTPS id g9sm16215597gvc.4.2008.03.25.10.06.59
        (version=SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 10:07:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200803190154.55532.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78197>

In previous part:

What to cache.
1. Support for caching in HTTP (external caching)
2. Caching Perl structures (and serialization)
3. Caching gitweb output: formatted pages


TO WHOM IT MAY CONCERN:  John 'Warthog9' Hawley (J.H.) who created
caching for gitweb at kernel.org; Petr 'Pasky' Baudis who maintains
repo.or.cz fork of gitweb and lately added caching of projects list
info; Lars Hjemli who is the author of cgit, git web interface in C
which includes some caching.  (BTW. I'd like to hear your thoughs on
git web interface caching, and about solutions you have implemented).


This is continuation of my thoughts about how to implement caching in
gitweb, what problems we could encounter, and what existing solutions
(what code/what packages) can we (re)use.


One of the more important issues to think about when implementing
caching is to decide when to regenerate cache, i.e. issues of cache
(in)validation and lifetime.


1. Static cache, external refreshing (invalidation).

The easiest situation is when cache can be invalidated (removed)
externally; caching support in gitweb would then need only to either
use cached information or cached output if it exists, and generate
information and/or output and cache appropriate things if cache
doesn't exist.

In closed-up git hosting system like repo.or.cz new contents can
appear in repository only via push (if repo is manually updated) or
via automated fetch (if repo is mirrored automatically).  This means
that it is known when infomration about given repository gets stale
(out of sync).  It would be then enought to make 'update' or
'post-receive' hook to delete cache, or invalidate parts of cached
info about given repository.  Creation and deletion of repositories
should also be handled by scripts; they affect caching too.

This of course assumes that we can control repository hooks (perhaps
git should learn hook multiplexing first, as proposed some time ago on
a mailing list).  This is not the case when developers are given shell
access, and gitweb is offered as a part of service rather than as a
part of git hosting; repositories are not under web administrator
control.  This is the case (according to J.H. on git mailing list) for
kernel.org.

So we have to examine also more generic solutions.


2. Checking filesystem (stat and/or inotify).

If new objects come to repository via commit or via fetch it is enough
(I guess) to watch for modifications of GIT_DIR of a project (I think
due to doing atomic writes via "create temporary file, then rename it
to final filename" of files in GIT_DIR: COMMIT_MSG and FETCH_HEAD).
So it should be enough to check and compare stat info for GIT_DIR of a
project, or of possible implement some inotify (or equivalent on other
operating systems than Linux) checking, to see if cache can contain
stale info.  In practice what we can truly check is that nothing
changed with repo.

Unfortunately the above is not the case if objects come to repository
via push.  Note that both push resulting in crating a pack (this I
think could use the same mechanism, only checking GIT_DIR/objects/pack
directory), and push resulting in creation of loose objects has to be
supported; additionally the refs pushed can have deeply hierarchical
names.

I would be grateful if somebody could think a way to check if anything
could have changed for such situation... but as it is now we have to
go to more complicated ways of cache invalidation.


3. Cache lifetime.

Finally, for cases such as gitweb where validating cache (checking if
the cached information isn't stale, out of sync with reality) is
almost as costly as calculating the whole information without using
cache at all, there is one possible solution to cache validation:
simply keep cache for some time.  For longer cache lifetimes gitweb
perhaps should put some notification that information is from cache,
perhaps with the time in human readable form how much time ago was
this information generated (human readable means no "1325 seconds ago"
info ;-).  And if we want to be thorough, put it also in the HTTP
header "Warning:" (at least for HTTP/1.1, see sections 13.1.2 and
14.46 of RFC 2616), e.g.:

  Warning: 110 git.kernel.org "Response is stale"

The question is what timeout, or how to choose lifetime of a cache.
J.H. kernel.org's gitweb tries to adjust cache lifetime to server
load, making cache lifetime longer if server load is higher, but
ensuring that cache lifetime stays within specified bounds.  

I have found among CPAN modules Cache::Adaptive where you can also
specify bounds for expire time and subroutine to adjust cache
lifetime, e.g. according to load average, process time for building
the cache entry, etc. (it can use specified backend, for example
Cache::FileCache from Cache::Cache distribution).  Its subclass
Cache::Adaptive::ByLoad which tries to adjust cache lifetime for
bottlenecks under heavy load.  Neither of modules I think is
distributed as ready package in extras on trusted contrib packages
repositories.  Nevertheless we can "borrow" the algorithms used by
those modules.

We should also try to avoid 'thundering herd' problem, namely that
cache expires, gitweb gets N requests before cache gets re-created,
and [poorly designed] cache architecture makes all N do the work
regenerating cache.  There are several ideas of how to deal with this
problem:

 * If (part of) cache has expired, set its expiration time to the
   current time plus specified duration (slop) needed to regenerate
   cache.  It was used by original Pasky solution (and is used by
   further solutions for caching projects list sent here); in can be
   used by CHI (caching infrastructure) with busy_lock option... well,
   kind of.

 * Use some kind of locking so only one process does the work and
   updates the cache.  From what I've briefly checked that is what
   kernel.org gitweb does (using flock()).

   The patch implementing projects list info caching does protect
   using O_EXCL on temporary/lock file against more than one process
   writing the cache, but doesn't protect against more than one
   process doing the work, unformtunately.

 * Allows items to expire a little earlier than the stated expiration
   time to help prevent cache miss stampedes.  This is what CHI module
   does with expires_variance option.

   The probability of expiration increases as a function of how far
   along we are in the potential expiration window, with the
   probability being near 0 at the beginning of the window and
   approaching 1 at the end.

If cache size becomes issue there will be additional complications
like which entries (which cached values) to remove first when we go
over the cache size limit; but lets us leave it for later, if it would
be needed at all.

%%
In next part:

CPAN packages we could use, or take inspiration from
1. Cache::Cache (standard)
2. CHI - Unified cache interface
3. Cache - the Cache interface 
4. other interesting packages
  * Cache::Adaptive for adaptive cache lifetime solutions
  * Cache::Memcached and/or Cache::Swifty
    for caching using cache daemon 
  * Cache::FastMmap (also example of callbacks),
    and caching benchmark mentioned there

-- 
Jakub Narebski
Poland
