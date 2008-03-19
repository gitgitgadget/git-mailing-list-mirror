From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Gitweb caching, part 1 (long)
Date: Wed, 19 Mar 2008 01:54:53 +0100
Message-ID: <200803190154.55532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4U1-0001jY-6n
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760973AbYCST4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756560AbYCST43
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:56:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21193 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbYCST40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 15:56:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so323505nfb.21
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 12:56:24 -0700 (PDT)
Received: by 10.78.136.9 with SMTP id j9mr4172303hud.13.1205888104345;
        Tue, 18 Mar 2008 17:55:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.227.39])
        by mx.google.com with ESMTPS id 19sm17171590ugl.13.2008.03.18.17.55.01
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Mar 2008 17:55:03 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77529>

[Please Cc: me directly, as I am not subscribed to git mailing list,
 and GMane NNTP (news) interface I use doesn't show currently any new
 posts; I wouldn't want to miss any response.  Thanks in advance.]


This post shows my ideas about how to implement caching in gitweb, my
thoughts on what are the problems, and what solutions (what code) can
we use.

>From what I remember of discussion about gitweb performance and
bottlenecks on git mailing list, the main culprit is projects list
(which perhaps should be redesigned), and summary pages for some of
larger / more popular projects.  Gitweb performance is I/O bound, not
CPU bound, so I guess not all existing caching solutions and ideas
would work with gitweb.

There are some troubles with adding generic (as opposed to
site-specific) caching to gitweb.  First, gitweb should work both with
mod_perl and as CGI (perhaps in the future also FastCGI) script.
Second, the solution should not depend on additional packages, at
least not those that can be found packaged in extras or well trusted
contrib repositories; not all admins allow installing packages from
CPAN.  Third, the solution could be helped but should not depend on
adding helper hooks to users repositories; while hosting sites like
repo.or.cz controls repositories, sites like kernel.org or
freedesktop.org, which give shell access, do not.


Let talk first about what to cache.

1. Support for caching in HTTP (HTTP accelerators, caching engines)

My first idea of adding caching support to gitweb was for it to
generate proper "freshness" caching headers (Last-Modified: and ETag:)
and respond to cache validation requests (If-Modified-Since:,
If-None-Match: etc.), and for reverse proxy, aka. caching engine,
aka. web accelerator/HTTP accelerator (e.g. Varnish or Squid) take
care of caching.  It is better to use existing solution, isn't it?

Unfortunately gitweb to generate date for If-Modified-Since:,
or a tag for If-None-Match: must do hard work; perhaps not as much as
generating the whole page in the term of CPU, but almost the same in
the terms of I/O hit.  So it is not so simple...

Nevertheless even if using reverse proxy for gitweb caching is not so
simple, gitweb should play well with support for caching in HTTP
protocol, so the pages can be cached between gitweb and user, either
in one of intermediate caches, proxy server with caching support, or
browser cache.  Currently gitweb uses 'Expires:' header with expiry of
24h / 1d (IIRC cutoff time for caches; also IIRC forever is half
a year) for pages which we know would not change (using full SHA-1
identifier and all required information filled).  We should probably
generate Last-Modified: and/or ETag: if it is possible.

However if gitweb has some kind of internal caching turned on, it can
respond properly to validation requests with low cost.  This way some
of requests would be handled by intermediate caches, so gitweb
wouldn't have even to access the cache to return an answer.  But IMHO
that is a secondary concern: it could help, but isn't possible to do
well without in-gitweb caching (as far as I can see).

BTW. besides optionally marking result as being retrieved from cache
("stale" or "cached"), gitweb I think should also send appropriate
Warning: header, see sections 13.1.2 and 14.46 of RFC2616, e.g.
  Warning: 110 git.kernel.org "Response is stale"

References:
* "Caching Tutorial for Web Authors"
  http://www.mnot.net/cache_docs/
* HTTP 1.1 Specification (RFC 2616)
  http://www.ietf.org/rfc/rfc2616.txt


2. Caching Perl structures

On of solutions (used for example by Petr 'Pasky' Baudis in his last
post about caching projects list info in gitweb) is be to cache (save)
Perl structures containing information needed to generate response
(web page).  Another solution, discussed below, would be to cache
generated output, i.e. web page, optionally with (some) HTTP headers.

The advantage of storing Perl structures (raw data) in the cache is
that the same data can be reused for different pages (e.g. paging
projects list if/when it gets implemented), same page with varying
part (e.g. content type being text/html or application/xhtml+xml
depending on what web browser prefers, or transparently compressed
output via Transfer-Encoding: depending on web browser capabilities),
and for replying to cache validation requests.  Additionally we can
generate web pages with correct relative (e.g. "5 minutes ago") time
info.  Not that all but first and last are not possible with caching
[final] output, but it would be, I think, much harder...

The disadvantage is that we have to decide is what format to use for
serializing data, i.e. to represent compound complex data as stream of
bytes in cache... unless of course gitweb would rely on one of already
existing caching solutions, which usually take care of this problem
for us: see next section (in next installment).

Formats I was considering were:
 - Data::Dumper
 - Storable (binary)
 - YAML Tiny
 - gitconfig tiny

2.1. Data::Dumper

One of advantages of Data::Dumper format is that it comes with Perl
installation, so there is no problem with installing it (well, at
least it comes with perl-5.8.6-24 RPM on Linux).  Another advantage is
that it is textual format, thus easy to debug in the case of
problems.  

Main problem with Data::Dumper is that it use eval() to thaw (restore)
data from serialized form in cache, which is serious security risk in
less secure environments.

2.2. Storable

Also comes packaged with Perl distribution.  Offers writing to and
restoring from file or to/from opened file handle.  It is fast, from
my unscientific tests around 3-4 times as fast as using eval() to read
Data::Dumper data.

One of disadvantages is the fact that Storable format is binary, so
you would have to write separate Perl script to convert it to
human-readable form (e.g. Data::Dumper form).  Format includes format
and version header, and modern 'file' installations should detect it
correctly, e.g.:
  filename: perl Storable(v0.7) data (major 2) (minor 6)

Another nuisance is the fact that while Storable(3pm) manpage states
that:

     The [retrieve()] routine returns "undef" for I/O problems or
     other internal error, a true value otherwise. Serious errors are
     propagated as a "die" exception.

But 'serious errors' include the fact that file is not in correct
format, so for safety (because server-side script should return page
with error info instead of dying silently) one would have to use "eval
{ ... }" to catch errors.

Used by Cache::Cache and, I think, also by other caching solutions
(packages).


2.3. YAML Tiny (subset of YAML)

YAML was created as human-readable serialization format, easy to parse
by machine.  Unfortunately none of YAML parsing modules (YAML,
YAML::Syck, YAML::Tiny) are packaged with Perl; on the other hand they
can be found in Dries RPM repository, so I guess they fill criteria of
being in extras or trusted contrib package repository.

Additionally at least YAML::Tiny (which implements subset of YAML in
pure Perl code) is slower, around 4-5 times, than even using
Data::Dumper, and more that 10 times slower than using Storable.  This
_might_ have been caused by the choice of module to implement YAML
parsing.

We could write parser (and generator) for even smaller subset of YAML
to use only those features that are truly needed by gitweb... but then
we can go with the next format, which is also text format, and also
doesn't have insecurities of using eval() to thaw data (read from
cache).

YAML was designed from the ground up to be an excellent syntax for
configuration files.  Not necessarily so for cache.

References:
* http://en.wikipedia.org/wiki/YAML
* YAML::Tiny(3pm)
  http://search.cpan.org/dist/YAML-Tiny/lib/YAML/Tiny.pm
* YAML Ain't Markup Language (YAML^TM) Version 1.1, Working Draft
  http://yaml.org/spec/current.html

2.4. gitconfig tiny (subset of ini-like gitconfig format).

What, I think, we would want to cache is usually list of records, or
in Perl terminology array of hashes; usually ordering of array doesn't
matter.

Because of that I think it would be possible to represent data to be
saved (cached) in the ini-like extended git config format.  Then
gitweb could either (re)use config parser in Perl used by
git-cvsserver (which accepts subset of valid config format), or 
"git config --file=<path> -z -l" to slurp data in more parseable
format... but if we do that, we could choose this format or variation
of it as our serialization format.

The cache file could look like this:

   [gitweb "<primary key value>"]
   	key1 = value1
   	key2 = "value with spaces"

where for list of projects info primary key might be path (relative to
projectroot) to the repository.


3. Caching output: formatted pages

Alternate solution to caching Perl structures is caching final output,
with or without (some/all) HTTP headers.  It has the advantage that it
is simple to implement, and that the same code can be used to cache
all the pages.  (But we could get similar result by creating something
similar to Tie::Memoize, tying hash or array so it automatically get
data either from git command, or from cache... or we can implement
universal API, like Cache::Cache API.)

This is from what I understand what kernel.org (warthog9) gitweb uses;
I don't know what cgit (web interface in C) which also has some
caching support uses: does it cache data or output?

How one can simply extend CGI script with support for caching is shown
by the CGI::Cache (non-standard CPAN Perl module).  On the other hand
gitweb can afford more extensive surgery.

References:
* CGI::Cache(3pm)
  http://search.cpan.org/~dcoppit/CGI-Cache-1.4200/lib/CGI/Cache.pm


To be continued...

%% .................................................................. %%
In next parts:

Cache lifetime and invalidation
1. static cache, external refreshing e.g. by hooks
2. stat and/or inotify, to check if repository changed
3. cache lifetime (trying to avoid "thundering horde" problem)

CPAN packages we could use, or take inspiration from
1. Cache::Cache (standard)
2. CHI, Unified caching interface
3. Cache
4. other (e.g. Cache::Adaptive, using Cache::Cache)

-- 
Jakub Narebski
Poland
