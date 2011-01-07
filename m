From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] My thoughts about implementing gitweb output caching
Date: Sat, 8 Jan 2011 00:42:34 +0100
Message-ID: <201101080042.36156.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 00:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLxQ-0005Rf-Ay
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab1AGXms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 18:42:48 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57015 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1AGXmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:42:47 -0500
Received: by wwi17 with SMTP id 17so979845wwi.1
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 15:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gvIK5P8+2yLy+NEzqrTbVKtGI+aLXHgkWWc8AOVfPak=;
        b=h8eJyjDv/N0WyLDRDefWEoElE283ZAbmWhe2TSHwJbFgP+IVDdGRbJI1B+Cy0Gdngi
         elhBSMnVudd39FDAa6MKohNNKpaNxvH7Z/hJJqycVhcKxq8A0P6K71SM1knvi/+ghnWv
         seoc99PaMlKxevBD8g8r2Q6nPF6VXZmWpnZow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Jcd6jEdaM960ihY9AI3iKKBwqPRdxkrcRiDzww1y0gXOSY/EVwltsANNNAYNfqwPGH
         pVWYjkiHFnSt7Ql2h6ONT7cGKzXTcEi2RaOOVV2VaU/I+L9k0YgN++b3utYxy0Zb2I0i
         iX1DGET/NBj4EB6zM/5sPvw4+0MdxlHpVsmvU=
Received: by 10.227.143.79 with SMTP id t15mr5739624wbu.95.1294443765791;
        Fri, 07 Jan 2011 15:42:45 -0800 (PST)
Received: from [192.168.1.13] (abvf4.neoplus.adsl.tpnet.pl [83.8.203.4])
        by mx.google.com with ESMTPS id 11sm18074384wbj.7.2011.01.07.15.42.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 15:42:42 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164788>

Those are my thoughts on gitweb output caching, brought by working on
my rewrite of gitweb output caching, based on ideas (and some code)
from John 'Warthog9' Hawley (J.H.) series, and on reviewing J.H. code.

I'd apreciate very much comments on this

Table of contents:
~~~~~~~~~~~~~~~~~~
 1. Splitting gitweb (and infractructure for it)
 2. require Gitweb::Cache vs do 'cache.pl'
 3. cache key (href(-replay =3D> 1,...) vs $cgi->self_url())
 4. caching, error handling, progress info and persistent environments
    (blocking progress info via parameter, or referer, or ...)
 5. capturing and saving STDOUT by redirection vs select(FH) or print $=
out
 6. being able to use other caching engines, and capturing to scalar
    capturing to memory vs capturing to file,=20
 7. saving in text or binary; printing data from cache in binary mode
 8. atomic file write and locking
 9. background cache generation
10. HTTP aware output caching, HTTP aware caching engine (c.f. CHI)



1. Splitting gitweb (and infractructure for it)

Because gitweb is getting quite large (7341 lines, in byte size next
to largest in git.git repository after gitk-git/gitk), and caching is
meant to be optional, therefore (most of) code related to gitweb
caching should be put in a separate file.

This means that adding support for caching to gitweb should bring
infrastructure that will be required for splitting gitweb for easier
maintenance and extending.  Which is a good side effect of adding
caching support to gitweb.

One question remains: current infrastructure supports having gitweb
modules (or "modules", see the next item) in 'lib/' subdirectory
alongside gitweb.cgi, and in directories in PERL5LIB or PERLLIB.
There was request to support installing gitweb modules in a separate
directory, but that would require changes to "gitweb: Prepare for
splitting gitweb" patch (but it is doable).  Is there wider interest
in supporting such feature?


2. require Gitweb::Cache vs do 'cache.pl'

One of the differences between original J.H. code and my rewrites of
it is that in J.H. patches caching code is in 'cache.pm' file and must
be loaded using "do 'cache.pm'", while in my rewrite caching is put
into proper Perl module and can be loaded using something like
"require Gitweb::Cache".

(Digression: the name 'cache.pm' is bad because of two reasons.
=46irst, the *.pm extension sugests that it is a proper Perl module,
with a separate namespace, that can be loaded using "require".
Second, it is good practice to restrict all lowercase package names to
pragma-like modules, like 'strict', 'warnings' or 'namespace::clean'.
That is why in "minimal fixup" response to J.H. patches I renamed
it from cache.pm to cache.pl (or rather lib/cache.pl).)

The main advantage of 'cache.pl' solution is that you don't need to
separate gitweb parts from caching parts, and you don't need to
carefully design API for interaction between caching layer and
application layer.  For example in J.H.'s patches cache.pm uses
variables and subroutines from gitweb.perl, e.g. $my_url or %actions,
and die_error.  This allow for fast no-design development... leading
to (somewhat at least) spaghetti code.

But this is also main disadvantage of this method.  Without proper
separation (proper encapsulation) of caching layer testing the caching
engine separately would be difficult, if at all possible (perhaps with
mocking...).  In my rewrite caching engine has a separate set of
tests checking its behavior; in J.H. series it doesn't.

Currently 'cache.pl' is loaded in "minimal fixup" version using the
following code

  if (!exists $INC{'cache.pl'}) {
    my $return =3D do 'cache.pl';
    die $@ if $@;
    die "Couldn't read 'cache.pl': $!" if (!defined $return);
  }

though nowadays I think that "require 'cache.pl';" could be enough.

Removing some of entaglements is quite easy: instead of calculating key
based on $my_url or $cgi in cache_fetch, calculate it in caller i.e. in
gitweb; instead of passing $action and using $actions{$action}->(), jus=
t
pass code reference i.e. $actions{$action} as parameter; pass options i=
n
a hash or hashref.  Removing other dependencise is harder: to remove
dependency on die_error you need either 'on_error' handler, or extract
error handling in separate package and use it (which is harder than it
looks, at least with current error handling, but see below).

There is also additional advantage in putting caching layer into
separate Perl package: there is possibility of (re)using it outside of
gitweb.  But this is rather minor issue...


3. cache key (href(-replay =3D> 1,...) vs $cgi->self_url())

The key used for gitweb caching, to find apropriate cache entry, is
based on URL of current page.  The question is if some URLs are to be
considered equivalent, and what class of URL do we consider equivalent,
i.e. having the same key.

Simplest solution is to use $cgi->self_url() (note that what J.H. v8
uses, i.e.: "$my_url?". $ENV{'QUERY_STRING'}, where $my_url is just
$cgi->url() is not enough - it doesn't take path_info into account).

Alternate solution, which I used in my rewrite, is to come up with
"canonical" URL, e.g. href(-replay =3D> 1, -full =3D> 1, -path_info =3D=
> 0);
with this solution using path_info vs query parameters or reordering
query parameters still gives the same key.


4. caching, error handling, progress info and persistent environments
   (blocking progress info via parameter, or referer, or ...)

This needs an intro:

J.H. gitweb caching series introduced non-JavaScript HTML-only progress
indicator, to notify user that there is data being (re)generated.  It i=
s
based on the trick that HTML redirection via http-equiv=3D"Refresh" met=
a
header is done only after connection is closed / HTML page is rendered
in full.  So by not printing final '</html>' and closing connection, an=
d
by printing e.g. '.' every few seconds to prevent closing connection, w=
e
can have simple progress indicator.

Other solution, presented in one of first versions of my rewrite, would
be to use Ajax based progress indicator.  The problem with this solutio=
n
is that you need to guess if web browser (client) supports JavaScript
from server side; though there are tricks to do that (see
'blame_incremental' support).

J.H. patches up and including v7, and my rewrite up and including v6,
excluded error pages from caching.  I think that the original resoning
behind choosing to do it this way was that A.), each of specific error
pages is usually accessed only once, so caching them would only take up
space bloating cache, but what is more important B.) that you can't
cache errors from caching engine.

Error handling in gitweb is done using die_error() subroutine (renamed
from error_page() very, very early in gitweb history).  It is used
similarly to how "die" could be used in an ordinary application; in
place of for example

  open my $fh, '<', $filename
  	or die "Can't open $filename: $!"

gitweb uses

  open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
  	or die_error(500, "Open git-ls-tree failed");

Because gitweb is not a simple web application, and error can occur
quite deep in the call stack, having to check if each subroutine ended
in an error is impractical: it is much easier to rely on the fact that
calling die_error() ends current request.


Description of problem:

The problem is interaction with HTML-only progress indicator, and
non-cached pages.  When the "Generating..." page starts to be send to
web browser (in my rewrite there was initial delay; if non-cached page
started to be generated within this initial delay then "Generating..."
page was not displayed at all), it means that page we wait for has to b=
e
generated in background process.  When the page is finished,
"Generating..." page would force redirection... but if page it was
waiting for is not saved in cache, the same thing would repeat: again
running generating data in background, again "Generating..." page.

So what's the solution?  One would be to actually cache error pages.
This is not easy with die_error() both printing error page (sending it
to web browser after turning off capturing), and ending request,
originally by the way of exit(0) (note: ModPerl::Registry redefines it
to end request and not worker process), later with nonlocal goto to
END_GITWEB or (in one of my unapplied patches) a bit later to
END_REQUEST label.  The proposed solution is to actually separate the
creating and throwing error from generating an error page; this should
allow easy caching of error pages -- gitweb would use die/eval to throw
and catch exceptions (similar to what SVN::Web does).

Possible improvement, but an additional complication, would be to make
cached error pages shorl lived, perhaps cleaning them up after using
them.  This might be done via HTTP awareness, see below.

Another possible solution I have just thought about is to ensure someho=
w
that page (re)loaded from "Generating..." page has progress info
disabled.  But that means that error page would get generated twice,
second time without progress indicator.

This is cerrtainly an issue that needs some thought.


5. capturing and saving STDOUT by redirection vs select(FH) or print $o=
ut

One of the goals in designing capturing mechanism for caching engine to
be used in gitweb output caching is that when caching is disabled gitwe=
b
behaviour should not change at all (or at least the change should be
minimal).  That means not collecting output to print it or save it to
cache at the end, as this would change bahvior from current streaming,
print as you go behavior... and make 'blame_data' part of
'blame_incremental' useless.

The solution with changing every 'print LIST' to 'print $out LIST' was
discarded because it would mean changes in almost all of gitweb,
resulting in very large patch.

The solution finally chosen is to redirect STDOUT to a file (reopen to =
a
file), while duplicating it to save it for later restoring.  This is th=
e
same solution that Capture::Tiny uses.

Alternate solution is to use select(FH) to change default filehandle fo=
r
'print' and 'printf'... but this seems less elegant solution.


6. being able to use other caching engines, and capturing to scalar
   capturing to memory vs capturing to file,=20

The standard API to access cache supported by various Perl caching
engines (Cache::Cache, Cache, CHI, Cache::FastMmap, Cache::Memcached) i=
s
based around $cache->get($key) and $cache->set($key, $data) methods:

  my $data =3D $cache->get($key);

  if (!defined $data) {
    $data =3D compute_data($key);
    $cache->set($key, $data);
  }

Some caching engines support single instruction "get and set" equivalen=
t
to above code, by providing code callback to generate data if it is not
in cache, though it is not as standardized as ->get/->set methods API.
CHI for example has $cache->compute($key, $code) method.

Note that $data might be a reference to a more complicated Perl
structure (ir might be arrayref or hashref) -- the usual example is to
cache results of a database query.  This means that $data must be
serialized before writing to cache, though some cache implementations
allow to cache raw, unserialized data.  This is complicated even more b=
y
the fact that some caching engines wrap $data in a cache entry object
which stores entry-specific options, e.g. expiration time for cache
entry, so we need serializing even if $data is scalar.

More important issue is that (with sole exception of old Cache engine)
caching is done for data stored in memory.  For caching captured output=
,
while using file-based cache, this means that when generating data we
have to capture output to variable (e.g. by capturing it to in-memory
file, or capturing to temporary file and slurping it to variable / to
memory), and then dump (spew) this variable to cache entry file (perhap=
s
with serialization as intermediate step).  For when data exist in file
based cache this means slurping contents of cache entry file to variabl=
e
/ to memory (perhaps with deserialization in between), then dumping
(spewing) this content to STDOUT.

This means that to support existing caching engines (Cache::Cache, CHI,
Cache::FastMmap, Cache::Memcached, Cache::Ref, etc.) we need to support
capturing output to scalar, and dumping data to STDOUT.

If caching driver gitweb uses is file based, if data being cached is
unstructured and by itself does not require serialization, and if
capturing output is based on redirecting STDOUT to a file (perhaps
in-memory file), then this intermediate step of in-memory representatio=
n
(of storing captured output in variable) seems wasteful.  Why not
capture directly to cache entry file, or dump / copy contents of cache
entry file directly to STDOUT?  The problem is to design a good API tha=
t
allows separation of caching, capturing, cache management and gitweb
itself.

In my rewrite I have chosen to model API after

  my $data =3D $cache->compute($key, $code);

The difference is that instead of returning scalar value (from cache or
calculated by $code), ->compute_fh() method returns a pair of filehandl=
e
(opened for reading) and filename:

  my ($fh, $filename) =3D $cache->compute_fh($key, $code_fh);

The $code_fh is coderef, which instead of returning value to be cached,
is passed filehandle opened for writing and filename to write to.


7. saving in text or binary; printing data from cache in binary mode

I'd like to repeat what I have written a few times earlier: if we take
care that PerlIO ':utf8' or ':raw' layers are applied correctly during
capture, then the data saved to cache can be treated as binary.  This
means that we can read cache entry file in ':raw' mode and dump it to
STDOUT which is also in ':raw' (binary mode), regardless whether output
was done in text or binary mode.

This means that there is no need to special case in the caching layer
actions which output or can write binary (':raw') output.


8. atomic file write and locking

There is yet another are where original J.H. patches and my rewrite
differs, namely in using atomic file write and in locking.

In my code caching engine writes data to temporary file (File::Temp
without locking, <entry>.tmp with locking), then it gets [atomically]
renamed to final destination.  This means that if there is data in cach=
e
(possibly stale), we can read it *without locking*.

Locking in my rewrite is needed only to chose one of clients as the one
that would be (re)generating data in cache, which is done via non
blocking writer (exclusive) lock, and to notify other clients when data
is ready (written to cache), via blocking reader (shared) lock.

Sidenote: CHI has different mechanism to avoid cache miss stampedes
(though it doesn't protect against generic concurrent access when there
is no data in cache), namely the 'expires_variance' mechanism, see CHI
documentation, e.g. http://p3rl.org/CHI.  It is meant to protect agains=
t
stampede at the end of cache expiration time, via "smearing" expiration
time: it allows items to expire a little earlier than the stated
expiration time.


9. background cache generation

In my rewrite caching engine first checks if forking a background
process is needed (it is configurable), and only then fork() is used.

There are two slightly different situations where background cache
generation can be used.  First is when there is stale (but not too
stale) data to be served.  In this case caching engine runs process
generating data in background, and foreground process (all foreground
processes: the one responsible for regenerating data (got lock) and
others) returns stale data.  Foreground process doesn't, and shouldn't,
wait for background process.  This means that background process has to
be detached as to not generate zombie processes.  I do this in my
rewrite.

Second is if there is no stale data to serve (or data is too stale), bu=
t
we have progress indicator.  In this case the foreground process is
responsible for rendering progress indicator, and background process is
responsible for generating data.  In this case foreground process waits
for data to be generated (unless progress info subroutine exits), so
strictly spaking we don't need to detach background process in this
case.


10. HTTP aware output caching, HTTP aware caching engine (c.f. CHI)

In one of additional patches sent in last version (v7) of my (shortened=
)
rewrite I have make use of the fact that what gitweb caches is HTTP
response.

One of things that were done in this patch was adding 'Content-Length'
header if it was not present already.  In the case of this header, it
can be added when printing data from cache, or it can be added when
saving data to cache.  In the case of adding it when saving data to
cache it can be done by caching engine itself, or it can be done by
output caching "middleware".  (In the case of patch in question it is
added during printing by output caching middleware.)

Other such header is 'Expires' header (or 'Cache-Control: max-age=3D').
It can be used when printing data from cache to reflect _current_
expiration time (which depends on current load in the case of adaptive
cache lifetime), like it is done in my patch.  On the other hand it can
be used by caching engine to store per-entry expiration time: current
code only supports global (per-cache) expiration time.

There are however two complications with 'Expires' header.  First, it
should never be in the past - this might happen when we are serving
stale data while waiting for data in cache to be regenerated,... or if
gitweb set some expire time, like when it knows that the data would
never change, because link uses SHA-1 identifier.  Second, when gitweb
sets expire time then outpot cahcing middleware should probably rewrite
it to be maximum of gitweb's expire at the time of generation and cache
entry expire... or gitweb can be modified to use Cache-Control: max-age
instead.

Perhaps we could also add 'Last-Modified' header, setting it to the dat=
e
of cache generation; maybe even add support for If-Modified-Since
conditional request, though I am not sure where in the layer it should
be added: perhaps yet another middleware between gitweb and output
caching?

With output caching gitweb can also support 'Range' requests, which
means that it would support resumable download.  This would mean hat we
would be able to resume downloading of snapshot (or in the future
bundle)... if we cannot do this now.  This would require some more code
to be added.

We might also want to compress body (payload) of HTTP response, and add
'Content-Encoding: gzip' header... perhaps supporting transparent
decompression in the case when web browser doesn't support required
encoding.  In this case we must do compression and adding of header whe=
n
saving data to cache, and must do transparent decompression (if needed)
on sending data to browser.

Another HTTP header that could be added is 'X-Sendfile' or
'X-Accel-Redirect', though I think that it needs to be done in the
output caching middleware (i.e. cache_output subroutine in
GitwebCache::CacheOutput in my rewrite).

--=20
Jakub Nar=C4=99bski
Poland
