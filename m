From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Wed, 08 Dec 2010 17:31:27 -0800
Message-ID: <4D00316F.9000305@eaglescrag.net>
References: <201011041721.53371.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVKm-0004bh-EX
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab0LIBaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 20:30:04 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:36894 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0LIBaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 20:30:03 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB91TibO014578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 8 Dec 2010 17:29:44 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <201011041721.53371.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 08 Dec 2010 17:29:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163251>

> 1. Error handling
[...]
>    Note that in my opinion cache should not be initialized if caching is
>    disabled.

Well it wasn't getting initialized in my code if caching was turned off.
 It might have been buffering, but it wasn't mucking with the directory
creation and such...

>    The modern CHI caching interface provides a way to change how runtime
>    errors are handled via 'on_get_error' and 'on_set_error' parameters to
>    constructor.  The default for CHI is to log error, or ignore if no
>    logger is set.  You can provide a coderef (callback).
> 
> 
>    For errors during getting data from cache (case B), we can ignore error
>    which means generating data as if cache was disabled/entry did not
>    exist in cache, or erroring out and showing error to user.  Such errors
>    should be rare, so erroring out might be appropriate reaction.  Note
>    that we have special case of zero sized cache entry file, in which case
>    we treat it as non-existent entry, already.
> 
> 
>    For errors during setting (saving) data to cache (case C), we can
>    ignore error and not re-generate cache (not even calling callback if
>    error is detected early), or error out.  Such errors can happen for
>    example if filesystem gets full.  It might be better to ignore such
>    errore, at least in the case of ENOSPC / ENOMEM.

The potential, at least for the deployed sites who are already using the
gitweb caching, for disaster if caching isn't running is pretty high.  I
would agree that erroring out with a 500 that explains the 'why' behind
the failure is the only real option right now.

The callback mechanism in CHI is nice, but I think for the time being is
a little overkill for what we've got right now.  I also don't see that
many, typical, sysadmins adding in that many error handling hooks and
such into gitweb and/or their infrastructure.  I could be wrong, I just
don't see that as being a common occurrence.

> 2. Progress info and not caching error pages
> 
>    J.H. find out or invented very nice hack to generate progress info
>    page without Ajax (and therefore without need for JavaScript), to make
>    user aware that data is being regenerated, and that he/she should be
>    patient instead of refreshing or complaining.

Not so much found or invented, it's something that's been around since I
started doing any web development back in 1995.  It's a bit old-school,
I'll admit, but it gets the job done still.

[...]
>     JH> There are still a few known "issues" with respect to this:
>     JH> - Code needs to be added to be "browser" aware so
>     JH>   that clients like wget that are trying to get a
>     JH>   binary blob don't obtain a "Generating..." page

I've solved this in v8, there is now an explicit blacklist for clients
that we assume are only there for whatever is getting generated.  Right
now the list is only wget and curl as those are the only two I can think
of immediately that wouldn't be able to parse the meta-equiv refresh.

There is already a special case for feeds to not get this, so those
shouldn't be affected as it is already.

Downside is it's a blacklist, and inherits all the problems of a
blacklist.  Though there really isn't a better way to handle that, given
there's no way to really query a browser and ask what it's capabilities
really are.

>    there is additional problem, at least in my rewrite.  (I didn't follow
>    the code flow in J.H. v7 patch series to check if it also affected).
> 
> 
>    Let's assume that 'progress_info' feature is turned on, and that cache
>    is generated in background.  Let's assume that error pages (die_error)
>    are not cached.
> 
>    Now client tries to access page which would/will result in an error.
>    With caching it acquires exclusive (writers) lock, check that there
>    are no stale data (error pages are never cached), checks that it is
>    provided with 'generating_info' subroutine, so it forks a process to
>    generate data in background.
> 
>    Background process detaches, tries to generate data to cache,
>    die_error is called.  die_error turns off capturing, and prints to
>    STDOUT.  At the end of die_error there is jump to outer scope to
>    DONE_GITWEB; therefore $lock_fh goes out of scope and lockfile is
>    closed, and lock released.  Background process finishes.
> 
>    Parent process runs 'generating_info' subroutine.  Now if it waits a
>    bit like in my rewrite before employing trick mentioned above, and
>    does not print anything if lockfile is released before startup delay,
>    _and_ die_error finishes within this delay, then everything is all
>    right: the error message is sent to client.
> 
>    If die_error doesn't finish before git_generating_data_html prints
>    meta refresh, or there is no startup delay, then error pages would get
>    infinite redirects (remember: there is never anything in cache for
>    error pages).  This is a bad thing.
> 
> 
>    One possible solution for this problem (beside employing startup
>    delay) is to have tee output, i.e. print it as it is being captured.
>    Streamed (partial) response would serve as progress indicator for
>    process (re)generating cache; only parallel processes waiting for
>    cache would show 'generating_info'.
> 
>    I think that in current implementation of capturing it would be as
>    simple as not closing STDOUT, but I'd have to check that.

Actually in reading through this I thought of a better way to get the
error message cleanly passed from the backend process to the frontend
waiting processes.

It's implemented in v8, but it basically boils down to, strangely
enough, caching the error. (I've got a hammer, it clearly solves all
problems!).  It's not a full cache (like what I'm doing with the rest of
the cache) but it basically generates a file that can be used to short
circuit things a bit.

> 3. Using generic cache engine and memory consumption
> 
>    Most Perl caching interfaces support only $cache->set($key, $data),
>    where $data is a Perl variable, and $data = $cache->get($key), or
>    their equivalents.  Even for file-based cache drivers you save from
>    memory and read into memory.  
> 
>    The only exception I know of is Cache interface with Cache::File
>    driver, that provides $cache->handle($key [, $mode]), where optional
>    $mode argument can be any of mode strings that can be used in 'open'
>    function, or one of fopen(3) modes.  (Of course for memory-based or
>    network-based (like memcached) caches it might not make sense to
>    provide such interface).
> 
>    The most often recommended capture module, Capture::Tiny, allows only
>    capturing into scalar (into memory) 
> 
>      $stdout = capture \&code;
> 
>    or (using its prototype)
>      
>      $stdout = capture { <code> };
> 
>    Well, it is *::Tiny, so it supports minimal API.  From the list of
>    different capture modules, that allow capturing of Perl code output,
>    with different interfaces (API), in "See also" section of
>    Capture::Tiny documentation[3], only IO::CaptureOutput allow capturing
>    into specified file:
> 
>      capture \&code, \$stdout, undef, $outfile;
> 
>    [3] http://p3rl.org/Capture::Tiny
> 
> 
>    J.H.'s gitweb output caching v7 captures output directly ito cache
>    files.  The problem with doing it in my rewrite is to allow capturing
>    directly into cache entry file without losing ability to select
>    different caching engine, which might be not file-based (like
>    e.g. memcached-based).

One of the big things that my caching engine now stops is the stampeding
herd problem, basically by locking everyone out of the cache for that
entry till it's prepared.  Assuming that can be preserved with any
arbitrary caching engine, then capturing directly to the file isn't that
big of a deal.

If that can be preserved in your full re-write, then it doesn't really
matter how or when the data makes it into the caching system be it
memory, disk, /dev/random or collapsing quantum wave form

I'm going to try and get v8 out tomorrow morning, and I'm going to let
this stew on kernel.org overnight.  It's looking like 18 patches (which
includes Jakub's v7.2, since I was building straight on top of that).

In poking around, I'll admit, I keep finding things I'd love to fix /
cleanup throughout the entirety of the code base.  I'm kinda hoping to
finally get caching dealt with and merged so I can start scratching
those other itches.  Mind you this has been 4+ years in the making
already...

- John 'Warthog9' Hawley

P.S. Most of this e-mail was written a couple of weeks ago, I found it
in my drafts folder and wanted to get it out along with a note that I've
got v8 percolating. -JH
