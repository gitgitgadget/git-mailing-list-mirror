From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Gitweb caching, part 3: examining Perl modules for caching (long)
Date: Sat, 29 Mar 2008 18:13:26 +0100
Message-ID: <200803291813.28393.jnareb@gmail.com>
References: <200803190154.55532.jnareb@gmail.com> <200803251806.58290.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 18:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfedJ-0003GW-3x
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 18:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYC2RNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYC2RNi
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 13:13:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:49480 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbYC2RNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 13:13:36 -0400
Received: by fg-out-1718.google.com with SMTP id l27so873830fgb.17
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=VQ9Lv4IjKAkDWq4zDLp3/spKQwSDn3g0/IeOAnfbU/E=;
        b=I9nmqpNT6U+KlQ42TNEdo4sCrLKD7DcWnWAWuqGu5f1pmZ1mujNONS21vle3wvg/aiTLZb+IavWkBDfS80pQk453NwCa/Ev/BRrzy7PLcntmmeG93YW202giXcLo8TCt7B4vNr4XdnD/J3DH84IzCC2JZ+j4AnA69KbiwetIw50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m1QuG7Zx5BSoGcolHjOaIvrTc6qPlc33Leh51TCiV7qxW9ps/Br6AYDGSlUyTNC4mnaOteJtV1XAYQJo/HcAdzhMmY/dRH/zUn77m6pQedZAVI40jSShpk7fcZm3ecGtUCVGqbtT54vUoDougacChAQOded9Y6LK/eXNE2PpW00=
Received: by 10.86.82.16 with SMTP id f16mr2833848fgb.60.1206810812394;
        Sat, 29 Mar 2008 10:13:32 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.246])
        by mx.google.com with ESMTPS id d4sm3537255fga.2.2008.03.29.10.13.28
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Mar 2008 10:13:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200803251806.58290.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78474>

[Hopefully this resend wouldn't be stopped by vger antispam filter]

In previous parts:

What to cache.
1. Support for caching in HTTP (external caching).
2. Caching Perl structures (and serialization).
3. Caching gitweb output: formatted pages.

Cache (in)validation and lifetime
1. Static cache, external refreshing (invalidation).
2. Checking filesystem (stat and/or inotify).
3. Cache lifetime (timing-out cached info).
4. LRU (Least Recently Used) and others <- to be written

In this part I will write about existing caching solutions, or to be
more exact about CPAN packages implementing caching or cache interface
in Perl.

Note that not on all sites one can install packages from CPAN; only
packages from main packages repository, from extras repository, or
sometimes from trusted contrib repository are possible (see J.H. post
about this problem).  From mentioned packages only Cache::Cache and
Cache::Mmap are available in contrib repositories for Aurox 11.1
distribution (based on Fedora Core 4): Cache::Cache distribution as
perl-Cache-Cache in Dries RPM Repository, and Cache::Mmap as
perl-Cache-Mmap in both Dries and Dag Wieers RPM repositories.


1. Cache::Cache (standard)

Implements Cache::MemoryCache, Cache::SharedMemoryCache (using
IPC::ShareLite), Cache::FileCache and Cache::SizeAwareFileCache.  This
is the standard: various other modules often say that they implement
Cache::Cache interface.  

It shows a bit its age, so various improvements exists, including CHI
- unified cache interface (which can use Cache::Cache modules, and
also other caching backends like Cache::FastMmap in a unified way),
and Cache - the cache interface, which tries to improve Cache::Cache
but is not yet complete.

Here is some sample code for instantiating and using file system based
cache (it uses Storable for serialization, IIRC).

  use Cache::FileCache;

  my $cache = new Cache::FileCache({default_expires_in => "15 minutes"});

  my $customer = $cache->get($name);

  if (not defined $customer)  {
    $customer = get_customer_from_db($name);
    $cache->set($name, $customer, "10 minutes");
  }

  return $customer;

Cache::Cache distribution can be found (at least on RPM based Linux
distributions) in perl-Cache-Cache package (e.g. in Dries RPM
repository).

Various other modules implements Cache::Cache interface, for example
Cache::BerkeleyDB (compare with Cache::BDB).


2. CHI - Unified cache interface

CHI provides a unified caching API.  The CHI interface is implemented
by driver classes that support fetching, storing and clearing of data.

CHI is intended as an evolution (and successor) of DeWitt Clinton's
Cache::Cache package, adhering to the basic Cache API but adding new
features and addressing limitations in the Cache::Cache implementation.

Main goals of CHI were performance (minimizing method calls,
serializing data only when necessary) and making the creation of new
drivers as easy as possible.  

The latter had lead to wrapping most popular caches available on CPAN in
CHI interface (CHI handles serialization and expiration times) with
CHI::Driver::CacheCache, CHI::Driver::FastMmap, CHI::Driver::Memcached.
"Native" CHI drivers include 'File' (one file per entry), 'Memory'
(per-process) and 'Multilevel' (two or more CHI caches, e.g. memcached
bolstered by a local memory cache).  'DBI' and 'BerkeleyDB' are
planned...

CHI provides expire_if [CODEREF] for additional check if cache expired,
busy_lock [DURATION] to set expiration time to current time plus
specified duration if value has expired to prevent "cache stampede", and
expires_variance [FLOAT] to allow items to expire little earlier to
prevent cache miss stampedes (favored over busy_lock).  Even if gitweb
wouldn't use CHI interface directly, those ideas are worth considering.

In addition to standard get() and set() methods it implements
compute() method which combines get and set operations in a single
call.  It also has some methods to process multiple keys and/or values
at once.

Here is some sample code for instantiating and using file system based
cache.

    use CHI;

    # Choose a standard driver
    #
    my $cache = CHI->new(driver => 'File', 
                         cache_root => '/tmp/cache');

    # Basic cache operations
    #
    my $customer = $cache->get($name);
    if (!defined $customer) {
        $customer = get_customer_from_db($name);
        $cache->set($name, $customer, "10 minutes");
    }

    # or simply
    my $customer = $cache->compute($name, \&get_customer_from_db,
                                   "10 minutes");


3. Cache - the Cache interface 

The Cache modules are a total redesign and reimplementation of Cache::Cache
and thus not directly compatible.  Contrary to Cache::Cache get() and
set() methods do not serialize complex data types; you have to freeze()
and thaw() data explicitely, instead of set/get.  You can get IO::Handle
by which data can be read from, or written to cache, e.g. when using
Cache::File.  There is no concept of 'namespace' in the basic cache
interface.  Purging is done automatically in current implementation.

Currently only Cache::File (filesystem based implementation, could be
done more efficiently, currently supports only LOCK_NFS locking) and
Cache::Memory (per-process memory based implemetation; with namespaces)
drivers are implemented.

In Cache modules one can select removal strategy for the cache.  By
default FIFO (First In First Out: remove oldest) and LRU (Least Recently
Used: remove stalest) strategies are available (when cache has size
limit?).

Cache modules provide callback interface: load_callback to be called
anytime when a get() is issued for a data that does not exist in cache,
and validate_callback (for example storing and checking timestamp or
similar).  This means that sample code for instantiating and using file
system based cache can be written as below.

  use Cache::File;

  my $cache = Cache::File->new(cache_root => '/tmp/cacheroot');
  $cache->set_load_callback(\&get_customer_from_db);

  # calls get_customer_from_db() if needed
  my $customer = $cache->get($name);

The Cache classes can be used via the tie interface, as shown below.
This allows the cache to be accessed via a hash.  All the standard
methods for accessing the hash are supported, with the exception
of the 'keys' or 'each' call.

  tie %hash, 'Cache::File', { cache_root => $tempdir };

  $hash{'key'} = 'some data';
  $data = $hash{'key'};

The tie interface is especially useful with the load_callback to
automatically populate the hash.


Even if gitweb wouldn't use Cache modules (perhaps because lack of
matority, or/and the fact that they ar not in extras or trusted
contrib packages repository) the idea of selectable removal strategy
and the idea of callback interface are worth considering; perhaps even
tie interface.  Whether to serialize explicitely or not... that is
also to be decided.


4. Other interesting caching packages

4.1. Cache::Adaptive for adaptive cache lifetime control

Cache::Adaptive is a cache engine with adaptive lifetime control.  Cache
lifetimes can be increased or decreased by any factor, e.g. load
average, process time for building the cache entry, etc.  Can use almost
any Cache::Cache object as backend (the update algorithm needs reliable
set() method, so Cache::SizeAwareFileCache cannot be used).

Cache::Adaptive::ByLoad is a subclass of Cache::Adaptive, which adjusts
cache lifetime by two factors; the load average of the platform and the
percentage of the total time spent by the builder.

Cache::Adaptive Introduces additional 
  access({ key => cache_key, builder => sub { ... } })
method, which returns cached entry if possible, or builds the entry by
calling the builder function, and optionally stores the build entry to
cache.  Compare with compute() method from CHI, or callback interfaces.

Worth examining (both interface and implementation) if/when implementing
cache lifetime control based on load average, like kernel.org gitweb
tries to do.  J.H. (kernel.org) fork of gitweb uses longer lifetime
under heavier load (within specified bounds).


4.2. Cache::Memcached and/or Cache::Swifty for caching using cache daemon

For larger installations, when there is needed caching not only for
gitweb, it might be worth examining cache daemon solutions, like
memcached (and Cache::Memcached, Cache::Memcached::Fast or CHI
equivalent), a distributed memory cache daemon; or swifty (and
Cache::Swifty), a very fast shared memory cache, in early alpha stages.

The Cache::Memcached api, besides set/get methods and administrative
methods provide add() and replace() methods to set() conditionally, if
value doesn't exists, or does exists in the cache.

Memcached was created to reduce load on high-trafic site with a hight
database load that contains mostly read threads, so it might be not
approproate for gitweb, where I/O load is of most concern, not CPU.
The main advantage of memcached is its ability to scale out.  Usually
you can run memcached together with web serever or database server, as
memcached is CPU lean and memory hungry, and web/database server the
reverse: CPU hungry and usually memory lean.  Note that gitweb (or
rather git access to repositories in gitweb) is I/O hungry.


4.3. Cache::FastMmap (also example of callbacks),
     and caching benchmark mentioned there

Cache::FastMmap uses an mmap'ed file to act as a shared memory
interprocess cache.  It uses fcntl locking to ensure multiple processes
can safely access the cache at the same time. It uses a basic LRU
algorithm to keep the most used entries in the cache, plus (optionally)
cache timeout.

Cache::FastMmap was created to be very fast.

The class also supports read-through, and write-back or write-through
callbacks to access the real data if it's not in the cache.  With those
the code to deal with cache can be written simply as

  Cache::FastMmap->new(
    ...
    context => $RealDataSourceHandle,
    read_cb  => sub { $_[0]->get($_[1]) },
    write_cb => sub { $_[0]->set($_[1], $_[2]) },
  );

  ...

  my $value = $cache->get($key);

  $cache->set($key, $newvalue);

It also supports get_and_set() subroutine to atomically retrieve and set
value of given key, and has methods dealing with multiple keys at once.
There is also Cache::FastMmap::Tie module to use tie interface to
Cache::FastMap.  Even if gitweb wouldn't use this module, the callback
based interface is worth considering to implement.


4.4. CGI::Cache to help cache output of time-intensive CGI scripts
     with minimal changes to CGI script code.

This module is intended to be used in CGI scripts that may benefit from
caching; it is written in such a way that existing CGI code could get
caching added with minimal changes to script.  Here's a simple example:

  #!/usr/bin/perl

  use CGI;
  use CGI::Cache;

  # Set up cache
  CGI::Cache::setup();

  my $cgi = new CGI;

  # CGI::Vars requires CGI version 2.50 or better
  CGI::Cache::set_key($cgi->Vars);

  # This should short-circuit the rest of the loop if a cache value is
  # already there
  CGI::Cache::start() or exit;

  print $cgi->header, "\n";

  #...

  print <<EOF;
  This prints to STDOUT, which will be cached.
  If the next visit is within 24 hours, the cached STDOUT
  will be served instead of executing this 'print'.
  EOF

CGI::Cache module ties the output file descriptor (usually STDOUT) to an
internal variable to which all output is saved.  This trick (technique)
is worth considering if we decide on caching final output in gitweb, or
final output without HTTP headers.


5. Summary

If it is decided that gitweb would do caching of Perl structures, we
would certainly use Storable, which should be installed as part of Perl
installation on most systems.  Perhaps gitweb could use Cache::Cache
packages in general (and Cache::FileCache in particular), as it should
fill "extras or trusted contrib" criterion, but I'd rather not add
another dependency to gitweb, especially that not all installations need
caching.  It could be good solution for gitweb fork, and I guess
kernel.org gitweb could use it.

If gitweb is to implement it's own solutions to not introduce extra
dependencies, and it would cache Perl structures, implementing
Cache::Cache get/set interface, with possible improvements of callback
interface would be a good idea.  For very large installations it would
be good to check memcached solution (or multilevel cache, see CHI).

If gitweb is to use caching of output, or output without HTTP headers,
either using CGI::Cache or using its technique would be a good idea.

Gitweb caching is meant to reduce load (mainly I/O load according to
some mails send on this mailing list by J.H., kernel.org gitweb admin,
and Pasky, repo.or.cz gitweb admin).  I think it would be good to try
and check, benchmarking if possible, different solutions to "thundering
horde" aka "cache stampede" problem, and to adaptive cache lifetime
control (see Cache::Adaptive).

Thoughts? Comments?

%%
In the next part I'd like to have thoughts and ideas for gitweb caching
from J.H. and Petr 'Pasky' Baudis...


References:
===========
[1] http://search.cpan.org
[2] http://code.google.com/p/perl-cache
[3] http://www.danga.com/memcached/
[4] http://cpan.robm.fastmail.fm/cache_perf.html

-- 
Jakub Narebski
Poland
