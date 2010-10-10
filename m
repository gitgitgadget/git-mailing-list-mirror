From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Possible improvements for output caching in gitweb
Date: Sun, 10 Oct 2010 22:32:07 +0200
Message-ID: <201010102232.08924.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog' Hawley" <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, Petr Baudis <pasky@suse.cz>,
	admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 22:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52ZV-0007CK-Ma
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab0JJUcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:32:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53928 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0JJUcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:32:21 -0400
Received: by bwz15 with SMTP id 15so1322848bwz.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=O+3EumQhNJMdM76EnyJbX7fbVZn/1wLC9jiJ1b15AgQ=;
        b=P+VzMgxLxONDODhuHKGyGW6n4k5RG/OAc5vGl9xpu0RuB2D0Sv2Bbc/cpHosyGGi5e
         R1svEoyt1ANIKHMemDp66YDyAPRwldBSM1tKGuRjrv9cgsy+CEoJdqqkrrFrPGkcyf2J
         kqXcgidtDyXwYSSDsRAX2bViItBv5aFQ+yXaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=QEMAHCFcWhRW65B0xxbWRwGhjuC9NwRwZ2zwhrUVyj5P7YgTSCnRUS7u9+e2SurETT
         AoR6cezVUFs8m0DLWB3UsyJotigOoc1RRGGLCeNUi8w6NONiZ6tXKZBmFE/YE3k4BP3c
         3T0vHP6lAd6HnuKGOWknJxJh/GRfeFcwAmzA8=
Received: by 10.204.68.145 with SMTP id v17mr4430563bki.81.1286742736481;
        Sun, 10 Oct 2010 13:32:16 -0700 (PDT)
Received: from [192.168.1.13] (abvy23.neoplus.adsl.tpnet.pl [83.8.222.23])
        by mx.google.com with ESMTPS id a25sm2926922bks.8.2010.10.10.13.32.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 13:32:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158701>

On Thu, 7 Oct 2010, Jakub Narebski wrote:

> TODO list and areas of possible improvements would be send in separate
> email.

Here they are.  What do you think about them; which are needed, which 
ones would be nice to have, which are not worth the trouble, and what's 
perhaps most important: which ones are missing.  Also in what order of 
importance should they be worked upon.

Note that in the list below there are deliberately missing improvements
to the code (which were already commented on; thanks again).


New features and improvements related directly to cache or capture:

* Ajax-y progress indicator (perhaps inside skeleton of page)
  see 9982b6f (gitweb: Ajax-y "Generating..." page when regenerating
  cache (WIP), 2010-01-24) on 'gitweb/cache-kernel' branch in the
  http://repo.or.cz/w/git/jnareb-git.git repository.

  Instead of relying on http-equiv refresh trick (which uses the fact
  that web browsers render inclomplete page, and that refresh is done
  only after page is received in full), use XMLHttpRequest to get
  (re)generated version of the page, displaying progress info while at
  it, and redraw page when data is received in full.  All of this only
  when JavaScript is enabled, so I guess old trick should be kept as 
  fallback.

  This of course assumes that progress info indicator is important...


* error handler, like in CHI

  Instead of using 'die <message>' and relying on CGI.pm and gitweb
  catching the exception and displaying it (set_message from CGI.pm),
  pass error handler (wrapped die_error) to cache constructor.  In the
  case of CHI caching framework, there are 'on_get_error' and
  'on_set_error' options.

  In the original patches by J.H. subroutines from cache.pm used
  die_error directly; this was possible only because the file was
  loaded using "do 'cache.pm';" as a kind of mixin / role into gitweb
  code.


* $capture option to cache_output()

  Currently in GitwebCache::OutputCache the capture engine used to
  capture gitweb output to cache it is hardcoded; mind you, one would
  need to change code only in two places to use different compatibile
  caching engine, but still it would require changing code.  It would
  be better to pass $capture as parameter to cache_output(), just like
  $cache is.


* POD documentation instead of comments + make doc

  Currently gitweb caching modules  are documented (like original
  cache.pm by J.H.) only in comments, and a bit in gitweb/README.
  Though those modules are used only internally, it might be better
  to use POD (perlpod) for documentation, like in Git.pm.

  We migth also want to add 'doc' target in gitweb/Makefile, though
  it might be difficult (see perl/Makefile.PL and generated perl.mak).


* cache expire variation a la CHI

  CHI (caching interface in Perl) supports 'expires_variance' parameter,
  which according to documentation:

   "Controls the variable expiration feature, which allows items to
    expire a little earlier than the stated expiration time to help
    prevent cache miss stampedes.
       
    Value is between 0.0 and 1.0, with 0.0 meaning that items expire
    exactly when specified (feature is disabled), and 1.0 meaning that
    items might expire anytime from now til the stated expiration time.
    The default is 0.0. A setting of 0.10 to 0.25 would introduce a
    small amount of variation without interfering too much with intended
    expiration times."

  See http://p3rl.org/CHI (or CHI manpage, if you have it installed).
  This feature is about *avoiding* cache miss stampede, while locking
  is used to ensure that only one process is regenerating cache for
  a given entry.


* benchmarks for different caches under light and under heavy load;
  profiling of gitweb with caching using Devel::NYTProf.
  
  The problem is to both prepare repositories, and to generate traffic
  (or generate IO pressure) to represent real-life situation, where
  supposedly gitweb is IO bound, rather than CPU bound.


-------------------------------------------------------------
Below there are cache related improvements that require for 
GitwebCache::CacheOutput to be aware that it caches HTTP response,
which consist of HTTP headers (text) separated by an empty line
from a body of a request (which can be binary).

This can be done either by parsing response or a retrieved cache entry, 
or by storing headers and body separately, or by using some Perl data 
structure (like for example the one used by PSGI) and storing it 
serialized (though serialization can affect performance).


* X-Sendfile (or equivalent) support

  Web server encountering such HTTP header will discard all output and
  send the file specified by that header instead using web server
  internals including all optimizations like caching-headers and
  sendfile or mmap if configured.  For Apache it requires mod_xsendfile
  module (https://tn123.org/mod_xsendfile/), lighttpd has it build in
  (at least for FastCGI) but disabled by default; in Nginx similar
  feature is called X-Accel-Redirect.

  The idea is to use cache file for X-Sendfile contents; though this
  might require storing headers and body of response separately, and
  might be not much of speedup.


* compressed cache entries (transfer-encoding) (?)

  To reduce size taken by cache, and also reduce bandwidth taken by
  serving gitweb requests, save body of response compressed.  Then,
  if browser supports it, send compressed data with the HTTP header
  'Transfer-Encoding:' set to appriopriate value.

  The complication which, I think, we have to take into account is
  that some (hopefully small amount) of web browsers and net downloaders
  doesn't support transfer-encoding we plan to use (gzip or deflate).
  Also gitweb should compress file which it knows to not compress well,
  like already compressed snapshots (zip, tar.gz, tar.bz2) or images.

  There was patch " gitweb: Enable transparent compression for HTTP
  output" sent to git mailing list (using PerlIO::gzip), but in the
  cached case we pay CPU cost only *once*.


* Replace text/html with application/xml+xhtml in header
  when reading from cache.

  In the non-cached case, gitweb served page using either plain
  'text/html' content type, or if web browser accepts it more advanced
  'application/xhtml+xml' content type.  When caching is enabled, we
  had to always use 'text/html', because web browser (e.g. lynx) might
  not accept the other... but with cache being HTTP-aware, we can
  replace 'text/html' with 'application/xhtml+xml' in 'Content-Type:'
  HTTP header.


* Expires-In / cache-age synchronized with cache lifetime,
  Last-Modified synchronized with cache entry creation time.

  Currently all cache entries have the same global (per cache instance)
  expiration time.  The Expire header is not correlated with it.

  There are two issues: when storing data in cache, we can set Expire
  header (or cache-age pragma in Cache-Control header) to the expiration
  time of cache entry and set Last-Modified to the time cache entry was
  (re)generated (unless it is already set by gitweb).

  The other issue is that some data doesn't change, ever.  We set expire
  time to '+1d' (one day) in such case.  If we could mark those cache
  entries as having longer / infinite lifetime to not regenerate them...


* support for If-Modified-Since (external/browser caches)

  When caching is enabled, we know when page was created.  We could
  check for If-Modified-Since conditional request header, and return
  '304 Not Modified' HTTP response if we would serve from the same
  cache entry.  It would save bandwidth, and a bit of I/O.


* ETag support - gitweb version + cache key hash, possibly also Range
  requests.

  We can compose strong ETag validator from cache key hash and gitweb
  version string.  Maybe it would make possible to respond to Range
  requests for resuming download of e.g. large snapshot file...

  But it might be the fact that those features are unrelated...  


----------------------------------------------------------------------
Below there are proposed gitweb improvements and features, which would 
also improve caching support in gitweb:

* Time::HiRes is in core + simplify progress indicator

  Time::HiRes was first released with perl 5.007003 (5.7.3).  Because
  gitweb requires at least Perl 5.8 for its Unicode / UTF-8 support,
  we can assume that it is present.

  This would simplify code in git_generating_data_html()


* $per_request_config = 0/1 (default)/coderef
  or just $per_request_config = coderef

  If it would be possible to have config read only once in persistent
  environments such as mod_perl and FastCGI, and not once per request,
  it would improve performance when caching engine used has slow
  initialization / creation time, like Moose-based CHI.

  The basic idea is to put parts of config that change per request (like
  e.g. gitosis or gitolite uses) in coderef in $per_request_config
  variable; this coderef would be invoked once per config.  Example
  configuration:

    our $per_request_config = sub {
       $ENV{GL_USER} = ($cgi && $cgi->remote_user) || "gitweb";
    };


* authenthication / authorization for admin stuff

  Some kind of authenthications support would be needed for edit / write
  support in gitweb, and also for controlling access to the cache
  administration page.  We don't want anyone to be able to clear cache.

  In the current proof-of-concept patch the cache administration page
  is restricted to people accessing gitweb pages from localhost, or
  running gitweb as a standalone script.


* mod_perl handler

  It might be possible with altering / modifying gitweb only slightly to
  make it work *also* as native mod_perl handler, and not only via
  ModPerl::Registry.  

  This would make possible to initialize cache once per process
  lifetime, and not once per request.

-- 
Jakub Narebski
Poland
