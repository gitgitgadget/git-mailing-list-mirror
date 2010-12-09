From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 9 Dec 2010 23:30:05 +0100
Message-ID: <201012092330.06688.jnareb@gmail.com>
References: <201011041721.53371.jnareb@gmail.com> <4D00316F.9000305@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 23:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQp0M-0007Dz-KA
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 23:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab0LIWaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 17:30:20 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:47838 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab0LIWaT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 17:30:19 -0500
Received: by bwz16 with SMTP id 16so3293416bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jiv+0EdesfXHdQyVhJJwa//eQ7+NyOe1JZyZPUkloQE=;
        b=OBBJrp5U3YjPRjlBLeneLTpsSlbF5Zo1FljRcCRmdKqMdHqca34NzbT6x2hjF5noLo
         vDqbSHe5OGKTq7Lg8RAWF5Mrw3zqg90R8vplVCly8bAUFiSYOousEERtdKDA7rHwq92G
         7CBbhfIfo1bVDW+SSn1EwIN7Jj5y+PcJKiKlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kZoPlTyo5Jzs9jPpf5Qeg9VDa7ug/gslbjkzxAzEQnk0EuiwY2z4eQVLYG6Nza5IT3
         ccW2mIMpDO9co/n+bUGJTyxo9WVNuWaJwyWUiRllqEdLxlqM3MQ0D4fqHGvG86+pzDoC
         KTTYk9JDVx8ZsDMLMM7/DnV2qncAiLQdgdWzo=
Received: by 10.204.55.129 with SMTP id u1mr13166bkg.43.1291933817607;
        Thu, 09 Dec 2010 14:30:17 -0800 (PST)
Received: from [192.168.1.13] (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id d11sm1218108bkd.22.2010.12.09.14.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 14:30:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D00316F.9000305@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163353>

On Thu, 9 Dec 2010, J.H. wrote:
> > 1. Error handling
> [...]
> >    Note that in my opinion cache should not be initialized if cachi=
ng is
> >    disabled.
>=20
> Well it wasn't getting initialized in my code if caching was turned o=
ff.
> It might have been buffering, but it wasn't mucking with the director=
y
> creation and such...

What I wanted to say here was that, in my opinion, adding support for
caching to gitweb shouldn't change gitweb behavior in the case when
caching is enabled (and should modify gitweb code only minimally). =20

The original v7 series ran capture_fetch also when caching was disabled=
,
and in such case captured gitweb to in-memory file to print it at end.
This was fixed (well, fixed if we consider this a bug/misfeature, which
I do) in v7.1, and finally done without errors in v7.4

> >    The modern CHI caching interface provides a way to change how ru=
ntime
> >    errors are handled via 'on_get_error' and 'on_set_error' paramet=
ers to
> >    constructor.  The default for CHI is to log error, or ignore if =
no
> >    logger is set.  You can provide a coderef (callback).
> >=20
> >=20
> >    For errors during getting data from cache (case B), we can ignor=
e error
> >    which means generating data as if cache was disabled/entry did n=
ot
> >    exist in cache, or erroring out and showing error to user.  Such=
 errors
> >    should be rare, so erroring out might be appropriate reaction.  =
Note
> >    that we have special case of zero sized cache entry file, in whi=
ch case
> >    we treat it as non-existent entry, already.
> >=20
> >=20
> >    For errors during setting (saving) data to cache (case C), we ca=
n
> >    ignore error and not re-generate cache (not even calling callbac=
k if
> >    error is detected early), or error out.  Such errors can happen =
for
> >    example if filesystem gets full.  It might be better to ignore s=
uch
> >    errore, at least in the case of ENOSPC / ENOMEM.
>=20
> The potential, at least for the deployed sites who are already using =
the
> gitweb caching, for disaster if caching isn't running is pretty high.=
  I
> would agree that erroring out with a 500 that explains the 'why' behi=
nd
> the failure is the only real option right now.
>=20
> The callback mechanism in CHI is nice, but I think for the time being=
 is
> a little overkill for what we've got right now.  I also don't see tha=
t
> many, typical, sysadmins adding in that many error handling hooks and
> such into gitweb and/or their infrastructure.  I could be wrong, I ju=
st
> don't see that as being a common occurrence.

Well, we would of course provide default callback that uses die_error,
see for example

  [PATCHv6/RFC 21/24] gitweb: Wrap die_error to use as error handler fo=
r caching engine
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=3D=
163043
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/9e8e92f318c6b776486=
ab19509326f0b470d491d

What I want to avoid is using die_error in caching module; this entangl=
es
caching module code with gitweb code, and makes it much more difficult =
to
do unit tests / test caching code in isolation (die_error would have to=
 be
mocked).  This would also prevent making caching engine a proper Perl=20
module, I think...


There is also another issue: with error handler passed as callback we
can for example use CHI as caching engine (with any of its drivers:
=46ile, FastMmap, Memcached) with our own/gitweb error reporting.


> > 2. Progress info and not caching error pages
> >=20
> >    J.H. find out or invented very nice hack to generate progress in=
fo
> >    page without Ajax (and therefore without need for JavaScript), t=
o make
> >    user aware that data is being regenerated, and that he/she shoul=
d be
> >    patient instead of refreshing or complaining.
>=20
> Not so much found or invented, it's something that's been around sinc=
e I
> started doing any web development back in 1995.  It's a bit old-schoo=
l,
> I'll admit, but it gets the job done still.

Nice idea, anyway.  I do wonder though if all web browsers follow this
behavior, and is this behavior documented / required...

> [...]
> >     JH> There are still a few known "issues" with respect to this:
> >     JH> - Code needs to be added to be "browser" aware so
> >     JH>   that clients like wget that are trying to get a
> >     JH>   binary blob don't obtain a "Generating..." page
>=20
> I've solved this in v8, there is now an explicit blacklist for client=
s
> that we assume are only there for whatever is getting generated.  Rig=
ht
> now the list is only wget and curl as those are the only two I can th=
ink
> of immediately that wouldn't be able to parse the meta-equiv refresh.

In my rewrite

  [PATCHv6 17/24] gitweb: Show appropriate "Generating..." page when re=
generating cache
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=3D=
163040
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/48679f7985ccda16dc5=
4fda97790841bab4a0ba2#patch1

(see the browser_is_robot() subroutine:

  http://repo.or.cz/w/git/jnareb-git.git/blob/48679f7985ccda16dc54fda97=
790841bab4a0ba2:/gitweb/gitweb.perl#l870

I use HTTP::BrowserDetect package if available and it's ->robot() metho=
d.

The fallback is to use *whitelist*, assuming that it would be better to
not show "Generating..." page rather than download the wrong thing.
I also guess that most (all?) web browsers use "Mozilla compatibile"
somewhere in their User-Agent string, thus matching 'Mozilla'.

>=20
> There is already a special case for feeds to not get this, so those
> shouldn't be affected as it is already.

Yes, it is true that you limit actions that are affected.  I also
use whitelist in my rewrite, allowing only actions which output HTML
to use "Generating..." page.  Perhaps that's too strict.
=20
> Downside is it's a blacklist, and inherits all the problems of a
> blacklist.  Though there really isn't a better way to handle that, gi=
ven
> there's no way to really query a browser and ask what it's capabiliti=
es
> really are.

Well, we can always use whitelist instead, see above.

> >    there is additional problem, at least in my rewrite.  (I didn't =
follow
> >    the code flow in J.H. v7 patch series to check if it also affect=
ed).
> >=20
> >=20
> >    Let's assume that 'progress_info' feature is turned on, and that=
 cache
> >    is generated in background.  Let's assume that error pages (die_=
error)
> >    are not cached.
> >=20
> >    Now client tries to access page which would/will result in an er=
ror.
> >    With caching it acquires exclusive (writers) lock, check that th=
ere
> >    are no stale data (error pages are never cached), checks that it=
 is
> >    provided with 'generating_info' subroutine, so it forks a proces=
s to
> >    generate data in background.
> >=20
> >    Background process detaches, tries to generate data to cache,
> >    die_error is called.  die_error turns off capturing, and prints =
to
> >    STDOUT.  At the end of die_error there is jump to outer scope to
> >    DONE_GITWEB; therefore $lock_fh goes out of scope and lockfile i=
s
> >    closed, and lock released.  Background process finishes.
> >=20
> >    Parent process runs 'generating_info' subroutine.  Now if it wai=
ts a
> >    bit like in my rewrite before employing trick mentioned above, a=
nd
> >    does not print anything if lockfile is released before startup d=
elay,
> >    _and_ die_error finishes within this delay, then everything is a=
ll
> >    right: the error message is sent to client.
> >=20
> >    If die_error doesn't finish before git_generating_data_html prin=
ts
> >    meta refresh, or there is no startup delay, then error pages wou=
ld get
> >    infinite redirects (remember: there is never anything in cache f=
or
> >    error pages).  This is a bad thing.
> >=20
> >=20
> >    One possible solution for this problem (beside employing startup
> >    delay) is to have tee output, i.e. print it as it is being captu=
red.
> >    Streamed (partial) response would serve as progress indicator fo=
r
> >    process (re)generating cache; only parallel processes waiting fo=
r
> >    cache would show 'generating_info'.
> >=20
> >    I think that in current implementation of capturing it would be =
as
> >    simple as not closing STDOUT, but I'd have to check that.
>=20
> Actually in reading through this I thought of a better way to get the
> error message cleanly passed from the backend process to the frontend
> waiting processes.
>=20
> It's implemented in v8, but it basically boils down to, strangely
> enough, caching the error. (I've got a hammer, it clearly solves all
> problems!).  It's not a full cache (like what I'm doing with the rest=
 of
> the cache) but it basically generates a file that can be used to shor=
t
> circuit things a bit.

Hmmm... I'll take a look at your solution then.  Looks like it can be
interesting.  I can think of capturing die_error output to in-memory
file (doing caching of its output in-memory), but I don't see how you
can change "goto DONE_GITWEB" (or in patch[1] sent to git mailing list
"goto DONE_REQUEST") to exit action subroutine but not exit cache_fetch
so gitweb would be able to display catched output.

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/162156
     "[PATCH/RFC] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in=
 die_error"

> > 3. Using generic cache engine and memory consumption
> >=20
> >    Most Perl caching interfaces support only $cache->set($key, $dat=
a),
> >    where $data is a Perl variable, and $data =3D $cache->get($key),=
 or
> >    their equivalents.  Even for file-based cache drivers you save f=
rom
> >    memory and read into memory. =20
> >=20
> >    The only exception I know of is Cache interface with Cache::File
> >    driver, that provides $cache->handle($key [, $mode]), where opti=
onal
> >    $mode argument can be any of mode strings that can be used in 'o=
pen'
> >    function, or one of fopen(3) modes.  (Of course for memory-based=
 or
> >    network-based (like memcached) caches it might not make sense to
> >    provide such interface).
> >=20
> >    The most often recommended capture module, Capture::Tiny, allows=
 only
> >    capturing into scalar (into memory)=20
> >=20
> >      $stdout =3D capture \&code;
> >=20
> >    or (using its prototype)
> >     =20
> >      $stdout =3D capture { <code> };
> >=20
> >    Well, it is *::Tiny, so it supports minimal API.  From the list =
of
> >    different capture modules, that allow capturing of Perl code out=
put,
> >    with different interfaces (API), in "See also" section of
> >    Capture::Tiny documentation[3], only IO::CaptureOutput allow cap=
turing
> >    into specified file:
> >=20
> >      capture \&code, \$stdout, undef, $outfile;
> >=20
> >    [3] http://p3rl.org/Capture::Tiny
> >=20
> >=20
> >    J.H.'s gitweb output caching v7 captures output directly ito cac=
he
> >    files.  The problem with doing it in my rewrite is to allow capt=
uring
> >    directly into cache entry file without losing ability to select
> >    different caching engine, which might be not file-based (like
> >    e.g. memcached-based).
>=20
> One of the big things that my caching engine now stops is the stamped=
ing
> herd problem, basically by locking everyone out of the cache for that
> entry till it's prepared.  Assuming that can be preserved with any
> arbitrary caching engine, then capturing directly to the file isn't t=
hat
> big of a deal.

Well, the recommended mechanism that one can use to prevent 'cache miss
stampede' problem in CHI[2] caching interface (though not the more gene=
ric
'stampeding herd' problem) is to use "expires_variance" option.  From
CHI manpage:

  expires_variance [FLOAT]

     Controls the variable expiration feature, which allows items to ex=
pire
     a little earlier than the stated expiration time to help prevent c=
ache
     miss stampedes.

     Value is between 0.0 and 1.0, with 0.0 meaning that items expire
     exactly when specified (feature is disabled), and 1.0 meaning that
     items might expire anytime from now til the stated expiration time=
=2E
     The default is 0.0. A setting of 0.10 to 0.25 would introduce a sm=
all
     amount of variation without interfering too much with intended
     expiration times.

     The probability of expiration increases as a function of how far a=
long
     we are in the potential expiration window, with the probability be=
ing
     near 0 at the beginning of the window and approaching 1 at the end=
=2E

     [...]

[2]: http://p3rl.org/CHI


Though with locking we can for example lock whole cache instead of sing=
le
entry when average load gets too high (but lower than $maxload, when gi=
tweb
returns '503 - The load average on the server is too high' (custom vers=
ion
of '503 Service Unavailable' HTTP error code/status)).


I think that CHI can be extended (via roles perhaps) to use locking:
flock for 'File' driver, IPC::Lock::Memcached or similar for 'Memcached=
'
driver, get_and_set from Cache::FastMmap which IIUC uses fcntl to lock
fragments of mmapped file for 'FastMmap' driver.

Cache::File driver from Cache package (http://p3rl.org/Cache) supports
locking by itself:

  lock_level

     Specify the level of locking to be used. There are three different
     levels available:

     Cache::File::LOCK_NONE()

         No locking is performed. Useful when you can guarantee only on=
e
         process will be accessing the cache at a time.

    Cache::File::LOCK_LOCAL()

        Locking is performed, but it is not suitable for use over NFS
        filesystems. However it is more efficient.

    Cache::File::LOCK_NFS()

        Locking is performed in a way that is suitable for use on NFS
        filesystems.


  [...]

  locking efficiency

    Currently LOCK_LOCAL is not implemented (if uses the same code as
    LOCK_NFS).

    There are two points of locking in Cache::File, index locking and
    entry locking. The index locking is always exclusive and the lock
    is required briefly during most operations. The entry locking is
    either shared or exclusive and is also required during most operati=
ons.
    When locking is enabled, File::NFSLock is used to provide the locki=
ng
    for both situations. This is not overly efficient, especially as th=
e
    entry lock is only ever grabbed whilst the index lock is held.

> If that can be preserved in your full re-write, then it doesn't reall=
y
> matter how or when the data makes it into the caching system be it
> memory, disk, /dev/random or collapsing quantum wave form

In my rewrite I use the same flock-based locking mechanism... just
rewritten.  From the cover letter:

JN> The main ideas in lifted from J.H. patches are the following
JN> (features in common with "Gitweb caching v7" series by John Hawley)=
:
JN>
JN> * caching captured output of gitweb in flat files, without any
JN> =A0 serialization (caching raw data)
JN>
JN> * using global (per-cache, not per-entry) expiration time, and
JN> =A0 using difference between mtime of cache file and current time
JN> =A0 for expiration
JN>
JN> * using file locking (flock) to prevent 'cache miss stampede'
JN> =A0 problem, i.e. to ensure that only one process is (re)generating
JN> =A0 cache entry
JN>
JN> * serving stale but not too old version, and regenerating data
JN> =A0 in background, to avoid waiting for data to be regenerated
JN>
JN> * progress info indicator based on http-equiv refresh trick
JN> =A0 (described in more detail how it works in the commit message)
JN>
JN> * capturing gitweb output by redirecting STDOUT to cache entry file


> I'm going to try and get v8 out tomorrow morning, and I'm going to le=
t
> this stew on kernel.org overnight.  It's looking like 18 patches (whi=
ch
> includes Jakub's v7.2, since I was building straight on top of that).

Hmmm... I was thinking about doing rewrite of rewrite, keeping only
parts which are actually used.  Instead of 22 patches it would be
4-9 patches:

  * capturing output to file or filehandle
  * caching with locking, using 'compute_fh' interface
  * module implementing cache_output subroutine, joining those two
  * adding caching support to gitweb

where the following patches might be extracted as additional patches

  * adaptive cache lifetime
  * zero-size file check
  * "Generating..." page for cache and for gitweb

perhaps also with separating

  * serving stale data
  * background cache generation
=20
> In poking around, I'll admit, I keep finding things I'd love to fix /
> cleanup throughout the entirety of the code base.  I'm kinda hoping t=
o
> finally get caching dealt with and merged so I can start scratching
> those other itches.  Mind you this has been 4+ years in the making
> already...

I am thinking about adding support for "tee" in addition to "capture",
i.e. printing when capturing, and using it in cache...
=20
> - John 'Warthog9' Hawley
>=20
> P.S. Most of this e-mail was written a couple of weeks ago, I found i=
t
> in my drafts folder and wanted to get it out along with a note that I=
've
> got v8 percolating. -JH

This email was written before v8 appeared on git mailing list...


P.S. Did you had a chance to read mine rerwite of gitweb output caching
"[PATCHv6/RFC 00/24] gitweb: Simple file based output caching"?

--=20
Jakub Narebski
Poland
