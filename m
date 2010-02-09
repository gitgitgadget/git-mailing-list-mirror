From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get, set) output caching
Date: Tue,  9 Feb 2010 11:30:21 +0100
Message-ID: <1265711427-15193-5-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenN8-0003mJ-UU
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0BIKa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:56 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37995 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0BIKar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:47 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3026604fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pp9pASM6zV78UXNrp61DLBj5Y7Daoe5uIXpfCyXJ5rA=;
        b=EaL544r1ZV4MMtTkRBsv0ur1tRaYWd7fWOzB0CuB2gj9JGHPCS5fE1C7czUuHeM3FT
         Y7FXyjs3a80YosXq4XgBrrMt5UBkGKSWKx6ype1aYBtzTQz59GoyiObz0dJVBfosuIvh
         VUy9K2IgGbbzgbIlQHavNN8+xFn6uIU7MSDtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LW+6C0MxeTVVkXYLPc8PJLxUWnCMO6kTC5xfbp3dorEr0MdbOVeV4dgrbdOkGjZcxw
         yuivdhF2sDkOTcbg5pgtJoe8tVlj6s85vhZi27EbEIKrcD13tHijSVdLMg5lU2AokbPh
         yaRmx5byjSrGXkQU1OVYx4JZK2F/+JHkcFrKQ=
Received: by 10.87.67.24 with SMTP id u24mr1910092fgk.21.1265711446155;
        Tue, 09 Feb 2010 02:30:46 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:45 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139384>

This commit actually adds output caching to gitweb, as we have now
minimal features required for it in GitwebCache::SimpleFileCache
(a 'dumb' but fast file-based cache engine).  To enable cache you need
at least set $caching_enabled to true in gitweb config, and copy cache.pm
from gitweb/ alongside gitweb.cgi - this is described in more detail
in the new "Gitweb caching" section in gitweb/README

Currently cache support related subroutines in cache.pm (which are
outside GitwebCache::SimpleFileCache package) are not well separated
from gitweb script itself; cache.pm lacks encapsulation.  cache.pm
assumes that there are href() subroutine and %actions variable, and
that there exist $actions{$action} (where $action is parameter passed
to cache_fetch), and it is a code reference (see also comments in
t/t9503/test_cache_interface.pl).  This is remaining artifact from the
original patch by J.H. (which also had cache_fetch() subroutine).

Gitweb itself uses directly only cache_fetch, to get page from cache
or to generate page and save it to cache, and cache_stop, to be used
in die_error subroutine, as currently error pages are not cached.

The cache_fetch subroutine captures output (from STDOUT only, as
STDERR is usually logged) using either ->push_layer()/->pop_layer()
from PerlIO::Util submodule (if it is available), or by setting and
restoring *STDOUT.  Note that only the former could be tested reliably
to be reliable in t9503 test!

Enabling caching causes the following additional changes to gitweb
output:
* Disables content-type negotiation (choosing between 'text/html'
  mimetype and 'application/xhtml+xml') when caching, as there is no
  content-type negotiation done when retrieving page from cache.
  Use 'text/html' mimetype that can be used by all browsers.
* Disable timing info (how much time it took to generate original
  page, and how many git commands it took), and in its place show when
  page was originally generated (in GMT / UTC timezone).

Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.

If PerlIO::Util is available (see comments), test that cache_fetch
behaves correctly, namely that it saves and restores action output in
cache, and that it prints generated output or cached output.


To be implemented (from original patch by J.H.):
* adaptive cache expiration, based on average system load
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v1:
* Commit message is present

* When caching is enabled gitweb outputs the time when page was generated in
  place of timing info (time it took to generate page).  In previous version
  'timed' feature wasn't supported (it was disabled) when caching was turned
  on.

  The 'timed' feature is turned off when caching is enabled for 'blame_data'
  (used by 'blame_incremental' view).

* Capturing gitweb output is done without need to modify gitweb to always
  print explicitly to $out filehandle.  Turning caching off in die_error()
  is now done using cache_stop() subroutine from cache.pm.  See also 
  description of capturing output below.

* Description of $caching_enabled variable in "Gitweb config file variables"
  section in gitweb/README and adding "Gitweb caching" section.

* No need for changing $/, _input_ record separator, when printing (output).

* $cache can be now set not only to caching engine object (initialized
  instance), but also to class name.  

  Pass Cache::Cache ('default_expires_in') and CHI ('root_dir', 'depth')
  compatible aliases for cache options to the $cache->new(), which is
  invoked when $cache is undefined (GitwebCache::SimpleFileCache is used)
  or when it is class name.

* You can override cache options in $GITWEB_CONFIG by modifying
  %cache_options hash.  All cache options are described in detail in
  comments.

* Gitweb dies with appropriate error message when caching is enabled, but
  $cache_pm cannot be found.  (Note that if the change that automatically
  escapes error message in die_error goes in, this would have to be changed
  to not escape $cache_pm in error message in caller.)

* t/t9500-gitweb-standalone-no-errors.sh tests also the case when data
  is retrieved from cache, not only when it is saved to cache (for
  that expire time is set to never expire).

* t9503 tests also cache_fetch() subroutine, using the same capturing
  mechanism as cache.pm / cache_fetch() itself to check if it produces
  correct output.  As noted in comments, I could make tests only for the
  situation where both tests and cache.pm used PerlIO::Util module (not
  among Perl core modules).

  The need for mockup of gitweb's href() and %actions shows that
  cache_fetch() is not properly encapsulated / separated from inner workings
  of gitweb code.


Differences from relevant parts of J.H. patch:
* cache_fetch() subroutine is much, much simpler.  Well, it lacks most of
  the features of original cache_fetch() by J.H.: it doesn't have adaptive
  cache lifetime, nor locking to prevent 'stampeding herd' problem, nor
  serving stale data when waiting for cache regeneration, nor background
  data generation, nor activity indicator... but the cache_fetch() itself
  doesn't change much, as those features are added mainly via methods
  and subroutines cache_fetch() calls.

* Capturing gitweb output is done without need to modify gitweb to either
  save generated output into $output variable and print it or save in cache
  after it is generated in full (original J.H. patch in "Gitweb caching v2"),
  or changing all print statements to print to explicit filehandle which
  points to STDOUT if caching is disabled and to in-memory file if caching
  is enabled (modified J.H. patch in "Gitweb caching v5").  See also below.

* It introduces $cache_pm variable, to be able to test caching in
  t/t9500-gitweb-standalone-no-errors.sh, but also to be able to install
  cache.pm in some other place than along gitweb.cgi.  There would be no
  such problems if we used 'require GitwebCache' or somesuch, in place of
  'do "cache.pm"' like in original patch by J.H.

  Currently however cache.pm is not independent of gitweb.perl; it requires
  href() subroutine and appropriate %actions hash for dispatch.  Therefore
  we must use 'do $cache_pm;' instead of e.g. 'use cache;'.

* Instead of using "binary" (sic!) valued $cache_enable (which means 0 or 1
  valued $cache_enable), a set of two variables is used.  The $cache
  variable can be used to select alternate caching engine / caching class.
  The $caching_enabled variable is used to actually enable/disable cache.

* The information about the time when page was generated is shown only if
  'timed' feature is enabled in gitweb config, and it is shown in place of
  usual time it took to generate page (shown when caching is not enabled).
  This means tha change to gitweb/gitweb.css was not needed.

* cache_fetch() is run only when $caching_enabled.  Some of cache
  initializations are in gitweb.perl, and not at beginning of cache_fetch()

* Cache options are contained in %cache_options hash, instead of individual
  global variables (which were using non-Perlish camelCase notation).

* There is information about caching in gitweb in gitweb/README

* There are tests of gitweb caching in t9500, and caching API in t9503


Capturing gitweb output
=======================
When output (response) caching is enabled, the caching mechanism has to
capture gitweb output (perhaps while printing it to standard output) to
save it to cache, unless the data is available in cache and not expired.

Because die_error uses 'exit', and because it uses git_header_html and
other printing subroutines (which output has to be captured in other
situations), it needs to disable caching, unless we are "tee"-ing.
Otherwise we would get no output from die_error (because it is captured),
but also we would not get data to be saved in cache and printed, because
'exit' in die_error would exit capture, too.  This restricts methods and
modules that can be used to capture output.

Below there are presented various considered and used ways of capturing the
output, or "tee"-ing it (capturing while printing), with their advantages
and disadvantages.


Capturing output (capture)
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Modify gitweb to save its output to variable before printing it, which
   means changing 'print <sth>' to '$output .= <sth>', and 'printf <sth>'
   to '$output .= sprintf <sth>'.

   This was the approach taken in last patch in "Gitweb caching v2" series
   by J.H.  It has the disadvantage of requiring large patch to gitweb;
   it also makes gitweb output data only after it is generated in full,
   even if caching is disabled (data is streamed now).  It also requires
   taking care of printing in die_error and after running action, and
   using correct mode (':utf8' or ':raw' aka binary mode) both when printing
   to cache file, and when printing to STDOUT in die_error.

   This approach got superceded by the next method.


2. Modify gitweb to print to explicit filehandle (instead of implicitly to
   STDOUT), which means changing 'print <sth>' to 'print $out <sth>' (or to
   'print {$out} <sth>', 'printf <sth>' to 'printf $out <sth>', and last
   'binmode STDOUT <mode>' to 'binmode $out <mode>'.

   This was the approach taken in previous version of this series, and also
   in last patch in "Gitewb caching v5" by J.H.  It has the disadvantage of
   requiring large patch to gitweb, but on the other hand the base change
   itself is just simple mechanical change (plus optionally whitespace-only
   reindent change, and optionally re-wrapping too long lines).  It is very
   easy to capture output: just set $out to in-memory file opened for
   reading (or even point $out directly to cache file / temporary file).  It
   is also easy to stop capturing: just set $out to \*STDOUT (or *STDOUT).

   Should we chose this method (now that it is shown that you can do without
   changes to gitweb, and what needs then to be done to capture output)?


3. The recommended module for capturing output in Perl is Capture::Tiny.  It
   has nice and simple API: to capture output you use 'capture \&code',
   which is prototyped to allow to be called in block form:

     ($stdout, $stderr) = capture {
          # your code here ...
     };

   It is a minor annoyance that it captures all output also in scalar
   context, i.e. when called as '$stdout = capture \&code;', so one would
   need to 'print STDERR $stderr;' after capture.  But what is more
   important is the fact that it doesn't offer any mechanism to turn off
   capturing inside called code... which is required for die_error, at least
   the way it works now (see above).

   Nevertheless the API is clean and I think worth emulating, which I did
   with cache_capture(&) subroutine in cache.pm.  Also the problems vanish
   in "tee" mode, i.e. for '$stdout = tee \&code;', see the next subsection.
   
   Capture::Tiny distribution is only 28K packed.  There exist
   perl-Capture-Tiny RPM for Fedora:
     http://spreadsheets.google.com/pub?key=tVoSlaYU1SGovwwjV0fqt9Q&output=html


4. I have found PerlIO::Util as a way of capturing output when searching the
   way to tee output: PerlIO::Util distribution contains PerlIO::tee module.
   Actually 'scalar' layer to write to in-memory file is implemented in
   PerlIO, which is a core Perl module.  Unfortunately PerlIO lacks API to
   add layer which needs parameters.  You can open in-memory file using
   
     open my $data_fh, '>', \$data

   you can request using given output layer on output with e.g. '>:utf8'
   as mode, you can add a layer with binmode, e.g. 'binmode $out, ":utf8";'
   but you can't add layer which requires extra parameter which is not
   a string (like in the case of ':encoding(<encoding>)' layer).  So you
   can't just add scalar layer to STDOUT to redirect it to in-memory file
   (to a scalar variable).  For that you need PerlIO::Util.  

   The PerlIO manpage talks about ':pop' pseudo layer, and how "a more
   elegant (and safer) interface is needed." - PerlIO::Util is such
   interface.

   To start capturing output to a scalar variable (in-memory file) with
   PerlIO::Util, you just need to

     *STDOUT->push_layer(scalar => \$data);

   To stop capturing you do

     *STDOUT->pop_layer();

   Pushing yet another layer works as it should, therefore my tests of
   cache_fetch() subroutine in t9503 require PerlIO::Util (and do not run if
   it is not present) - I couldn't get to do the test with capture within
   capture using he method described below.  (There is Test::Output module
   that could have been used in tests, or I could have used Capture::Tiny.)

   I haven't found RPM module for PerlIO::Util (but nowadays I install
   modules from CPAN using local::lib and cpan client).


5. Without 'print <sth>' to 'print $out <sth>' change to gitweb, one can try
   manipulating *STDOUT directly, first saving *STDOUT or \*STDOUT to some
   variable, then setting *STDOUT = $data_fh, where $data_fh is filehandle
   opened to in-memory file.

   This seems to work, does not require large patch to gitweb, and does not
   require extra (non-core) Perl module.  Nevertheless it seems fragile with
   respect to restoring STDOUT, and even though basic tests (not included)
   of this mechanism producted expected result, I wasn't able to write
   working tests when using this method.

   We could probably examine how Capture::Tiny does it, and reuse (copy)
   relevant parts of code, perhaps duplicating STDOUT, closing it and then
   reopening as in-memory filehandle.

   YMMV (Your Mileage May Vary).


Saving output while printing (tee)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Instead of capturing gitweb output (except die_error, which displays error
and exists), and then saving it to cache and displaying it, we can capture
(save) output while it is being displayed, somewhat similar to what tee(1)
UNIX (coreutils) command does.  

This has the advantage that for the client that generates data (see further
commit in series about using locking to avoid cache miss stampede) that it
serves as acrivity indicator by itself.  On the other hand achieving this
effect in other processes that wait for the data to be generated would be, 
I think, quite complicated (a `tail -f' like behavior).

Because the original patch by J.H. (both versions) did capturing then
displaying, "tee"-ing data was not added to this series.  Nevetheless this
is something to consider for the future.

1. While using 'capture' from Capture::Tiny would have difficulties (if it
   was at all possible) for gitweb as it is now, using 'tee' from the same
   module would be quite simple:

     $data = tee {
          # generate gitweb output
     };
     # save $data to cache

   die_error would not be a problem in this situation: data would be
   displayed, even if not saved to cache.

2. One of the easiest way of adding output (response) caching to a CGI
   script in Perl is in my opinion using CGI::Cache module.  Modifying
   CGI.pm script (like gitweb) to make use of CGI::Cache requires adding
   only a few lines to script source.

   While relying on non-core module (which I have not found RPM for) makes
   this solution less feasible, its use of slow Cache::SizeAwareFileCache
   (from Cache::Cache) makes its not good for gitweb.  Also CGI::Cache
   requires Tie::Restore to be able to restore ties to filehandles it
   watches... something that gitweb doesn't need.

   Nevetheless we can borrow some code from CGI::Cache, replacing cache
   engine with something more efficient.  CGI::Cache is GPL licensed.

   Internally, the CGI::Cache module ties the output file descriptor
   (usually STDOUT) to an internal variable to which all output is saved.
   And that leads us to the next method.

3. tie filehandle (*STDOUT or $out) so that when we are printing to
   filehandle, it would also save data in a scalar variable (or duplicate it
   to other filehandle).  See perltie(1) and Tie::Handle.

4. Multiplexing output stream like tee(1) with PerlIO::tee from PerlIO::Util
   is very simple: to start saving output while it is being printed, just do

     *STDOUT->push_layer(tee => \$data);

   The source, beside scalar reference as above, may be a file name, or a
   filehandle.  To stop multiplexing, just do

     *STDOUT->pop_layer();

   I haven't found RPM module for PerlIO::Util (which includes PerlIO::tee).


 gitweb/README                          |   70 +++++++++++++++++++++
 gitweb/cache.pm                        |   78 +++++++++++++++++++++++
 gitweb/gitweb.perl                     |  106 ++++++++++++++++++++++++++++----
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 ++++++
 t/t9503/test_cache_interface.pl        |   93 ++++++++++++++++++++++++++++
 6 files changed, 355 insertions(+), 13 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..53759fc 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,11 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $caching_enabled
+   If true, gitweb would use caching to speed up generating response.
+   Currently supported is only output (response) caching.  See "Gitweb caching"
+   section below for details on how to configure and customize caching.
+   The default is false (caching is disabled).
 
 
 Projects list file format
@@ -305,6 +310,71 @@ You can use the following files in repository:
    descriptions.
 
 
+Gitweb caching
+~~~~~~~~~~~~~~
+
+Currently gitweb supports only output (HTTP response) caching, similar
+to the one used on git.kernel.org.  To turn it on, set $caching_enabled
+variable to true value in gitweb config file, i.e.:
+
+   our $caching_enabled = 1;
+
+You can choose what caching engine should gitweb use by setting $cache
+variable either to _initialized_ instance of cache interface, e.g.:
+
+   use CHI;
+   our $cache = CHI->new( driver => 'Memcached',
+   	servers => [ "10.0.0.15:11211", "10.0.0.15:11212" ],
+   	l1_cache => { driver => 'FastMmap', root_dir => '/var/cache/gitweb' }
+   );
+
+Alternatively you can set $cache variable to the name of cache class, in
+which case caching engine should support Cache::Cache or CHI names for cache
+config (see below), and ignore unrecognized options, e.g.:
+
+   use Cache::FileCache;
+   our $cache = 'Cache::FileCache';
+
+Such caching engine should implement (at least) ->get($key) and
+->set($key, $data) methods (Cache::Cache and CHI compatible interface).
+
+If $cache is left unset (if it is left undefined), then gitweb would use
+GitwebCache::SimpleFileCache from cache.pm as caching engine.  This engine
+is 'dumb' (but fast) file based caching layer, currently without any support
+for cache size limiting, or even removing expired / grossly expired entries.
+It has therefore the downside of requiring a huge amount of disk space if
+there are a number of repositories involved.  It is not uncommon for
+git.kernel.org to have on the order of 80G - 120G accumulate over the course
+of a few months.  It is therefore recommended that the cache directory be
+periodically completely deleted; this operation is safe to perform.
+Suggested mechanism (substitute $cachedir for actual path to gitweb cache):
+
+   # mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+
+For gitweb to use caching it must find 'cache.pm' file, which contains
+GitwebCache::SimpleFileCache and cache-related subroutines, from which
+cache_fetch and cache_stop are used in gitweb itself.  Location of
+'cache.pm' file is provided in $cache_pm variable; if it is relative path,
+it is relative to the directory gitweb is run from.  Default value of
+$cache_pm assumes that 'cache.pm' is copied to the same directory as
+'gitweb.cgi'.
+
+Currently 'cache.pm' is not a proper Perl module, because it is not
+encapsulated / it is not separated from details of gitweb.  That is why it
+is sourced using 'do "$cache_pm"', rather than with "use" or "require"
+operators.
+
+Site-wide cache options are defined in %cache_options hash.  Those options
+apply only when $cache is unset (GitwebCache::SimpleFileCache is used), or
+if $cache is name of cache class (e.g. $cache = 'Cache::FileCache').  You
+can override cache options in gitweb config, e.g.:
+
+   $cache_options{'expires_in'} = 60; # 60 seconds = 1 minute
+
+Please read comments for %cache_options entries in gitweb/gitweb.perl for
+description of available cache options.
+
+
 Webserver configuration
 -----------------------
 
diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index b59509f..64c333b 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -296,4 +296,82 @@ sub compute {
 1;
 } # end of package GitwebCache::SimpleFileCache;
 
+# human readable key identifying gitweb output
+sub gitweb_output_key {
+	return href(-replay => 1, -full => 1, -path_info => 0);
+}
+
+
+our $perlio_util = eval { require PerlIO::Util; 1 };
+our $STDOUT = *STDOUT; #our $STDOUTref = \*STDOUT;
+our $data_fh;
+
+# Start caching data printed to STDOUT
+sub cache_start {
+	my $data_ref = shift;
+
+	if ($perlio_util) {
+		*STDOUT->push_layer(scalar => $data_ref);
+
+	} else {
+		open $data_fh, '>', $data_ref
+			or die "Can't open memory file: $!";
+		# matches "binmode STDOUT, ':uft8'" at beginning
+		binmode $data_fh, ':utf8';
+		*STDOUT = $data_fh;
+
+	}
+}
+
+# Stop caching data (required for die_error)
+sub cache_stop {
+
+	if ($perlio_util) {
+		*STDOUT->pop_layer()
+			if ((*STDOUT->get_layers())[-1] eq 'scalar');
+
+	} else {
+		close $data_fh
+			or die "Error closing memory file: $!";
+		*STDOUT = $STDOUT;
+
+	}
+}
+
+# Wrap caching data; capture only STDOUT
+sub cache_capture (&) {
+	my $code = shift;
+	my $data;
+
+	cache_start(\$data);
+	$code->();
+	cache_stop();
+
+	return $data;
+}
+
+sub cache_fetch {
+	my ($cache, $action) = @_;
+
+	my $key = gitweb_output_key();
+	my $data = $cache->get($key);
+
+	if (defined $data) {
+		# print cached data
+		binmode STDOUT, ':raw';
+		print STDOUT $data;
+
+	} else {
+		$data = cache_capture {
+			$actions{$action}->();
+		};
+
+		if (defined $data) {
+			$cache->set($key, $data);
+			binmode STDOUT, ':raw';
+			print STDOUT $data;
+		}
+	}
+}
+
 1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 97ea3ec..f02ead9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -227,6 +227,44 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
+# This enables/disables the caching layer in gitweb.  Currently supported
+# is only output (response) caching, similar to the one used on git.kernel.org.
+our $caching_enabled = 0;
+# Set to _initialized_ instance of cache interface implementing (at least)
+# get($key) and set($key, $data) methods (Cache::Cache and CHI interfaces).
+# If unset, GitwebCache::SimpleFileCache would be used, which is 'dumb'
+# (but fast) file based caching layer, currently without any support for
+# cache size limiting.  It is therefore recommended that the cache directory
+# be periodically completely deleted; this operation is safe to perform.
+# Suggested mechanism:
+# mv $cachedir $cachedir.flush && mkdir $cachedir && rm -rf $cachedir.flush
+our $cache;
+# Locations of 'cache.pm' file; if it is relative path, it is relative to
+# the directory gitweb is run from
+our $cache_pm = 'cache.pm';
+# You define site-wide cache options defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %cache_options = (
+	# The location in the filesystem that will hold the root of the cache.
+	# This directory will be created as needed (if possible) on the first
+	# cache set.  Note that either this directory must exists and web server
+	# has to have write permissions to it, or web server must be able to
+	# create this directory.
+	# Possible values:
+	# * 'cache' (relative to gitweb),
+	# * File::Spec->catdir(File::Spec->tmpdir(), 'gitweb-cache'),
+	# * '/var/cache/gitweb' (FHS compliant, requires being set up),
+	'cache_root' => 'cache',
+	# The number of subdirectories deep to cache object item.  This should be
+	# large enough that no cache directory has more than a few hundred
+	# objects.  Each non-leaf directory contains up to 256 subdirectories
+	# (00-ff).  Must be larger than 0.
+	'cache_depth' => 1,
+	# The (global) expiration time for objects placed in the cache, in seconds.
+	'expires_in' => 20,
+);
+
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -964,7 +1002,34 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
-$actions{$action}->();
+
+if ($caching_enabled) {
+	die_error(500, 'Caching enabled and "'.esc_path($cache_pm).'" not found')
+		unless -f $cache_pm;
+	do $cache_pm;
+	die $@ if $@;
+
+	# $cache might be initialized (instantiated) cache, i.e. cache object,
+	# or it might be name of class, or it might be undefined
+	unless (defined $cache && ref($cache)) {
+		$cache ||= 'GitwebCache::SimpleFileCache';
+		$cache = $cache->new({
+			%cache_options,
+			#'cache_root' => '/tmp/cache',
+			#'cache_depth' => 2,
+			#'expires_in' => 20, # in seconds (CHI compatibile)
+			# (Cache::Cache compatibile initialization)
+			'default_expires_in' => $cache_options{'expires_in'},
+			# (CHI compatibile initialization)
+			'root_dir' => $cache_options{'cache_root'},
+			'depth' => $cache_options{'cache_depth'},
+		});
+	}
+	cache_fetch($cache, $action);
+} else {
+	$actions{$action}->();
+}
+
 exit;
 
 ## ======================================================================
@@ -3169,7 +3234,9 @@ sub git_header_html {
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
 	# we have to do this because MSIE sometimes globs '*/*', pretending to
 	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') &&
+	# Disable content-type negotiation when caching (use mimetype good for all).
+	if (!$caching_enabled &&
+	    defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
 	    $cgi->Accept('application/xhtml+xml') != 0) {
 		$content_type = 'application/xhtml+xml';
@@ -3342,17 +3409,25 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
-	if (defined $t0 && gitweb_check_feature('timed')) {
+	# timing info doesn't make much sense with output (response) caching,
+	# so when caching is enabled gitweb prints the time of page generation
+	if ((defined $t0 || $caching_enabled) &&
+	    gitweb_check_feature('timed')) {
 		print "<div id=\"generating_info\">\n";
-		print 'This page took '.
-		      '<span id="generating_time" class="time_span">'.
-		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
-		      ' seconds </span>'.
-		      ' and '.
-		      '<span id="generating_cmd">'.
-		      $number_of_git_cmds.
-		      '</span> git commands '.
-		      " to generate.\n";
+		if ($caching_enabled) {
+			print 'This page was generated at '.
+			      gmtime( time() )." GMT\n";
+		} else {
+			print 'This page took '.
+			      '<span id="generating_time" class="time_span">'.
+			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
+			      ' seconds </span>'.
+			      ' and '.
+			      '<span id="generating_cmd">'.
+			      $number_of_git_cmds.
+			      '</span> git commands '.
+			      " to generate.\n";
+		}
 		print "</div>\n"; # class="page_footer"
 	}
 
@@ -3402,6 +3477,10 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
+
+	# Do not cache error pages (die_error() uses 'exit')
+	cache_stop() if ($caching_enabled);
+
 	git_header_html($http_responses{$status});
 	print <<EOF;
 <div class="page_body">
@@ -5050,7 +5129,8 @@ sub git_blame_common {
 			or print "ERROR $!\n";
 
 		print 'END';
-		if (defined $t0 && gitweb_check_feature('timed')) {
+		if (!$caching_enabled &&
+		    defined $t0 && gitweb_check_feature('timed')) {
 			print ' '.
 			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..b7c2937 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -27,6 +27,8 @@ our \$export_ok = '';
 our \$strict_export = '';
 our \$maxload = undef;
 
+our \$cache_pm = '$TEST_DIRECTORY/../gitweb/cache.pm';
+
 EOF
 
 	cat >.git/description <<EOF
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 2fc7fdb..41c1119 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -639,4 +639,23 @@ test_expect_success \
 	 gitweb_run "p=.git;a=summary"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+cat >>gitweb_config.perl <<\EOF
+$caching_enabled = 1;
+$cache_options{'expires_in'} = -1; # never expire cache for tests
+EOF
+rm -rf cache
+
+test_expect_success \
+	'caching enabled (project summary, first run)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (project summary, second run)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
 test_done
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 8700b71..42c49e9 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -7,9 +7,36 @@ use strict;
 use Test::More;
 use Data::Dumper;
 
+# Modules that could have been used to capture output for testing cache_fetch
+#use Capture::Tiny;
+#use Test::Output qw(:stdout);
+# Modules that could have been used in $cache_pm for cache_fetch
+#use IO::Capture
+
 # test source version; there is no installation target for gitweb
 my $cache_pm = "$ENV{TEST_DIRECTORY}/../gitweb/cache.pm";
 
+# ......................................................................
+
+# Setup mockup of gitweb's subroutines and variables used in $cache_pm;
+# must be done before loading $cache_pm.  (This probably means that
+# gitweb.perl and cache.pm are too tightly coupled.)
+sub href {
+	return 'href';
+}
+my $action = 'action';
+my $fake_action_output = <<'EOF';
+# This is data to be cached and shown
+EOF
+sub fake_action {
+	print $fake_action_output;
+}
+our %actions = (
+	$action => \&fake_action,
+);
+
+# ......................................................................
+
 unless (-f "$cache_pm") {
 	plan skip_all => "$cache_pm not found";
 }
@@ -22,6 +49,7 @@ ok(!$@,              "parse gitweb/cache.pm")
 ok(defined $return,  "do    gitweb/cache.pm");
 ok($return,          "run   gitweb/cache.pm");
 
+# ......................................................................
 
 # Test creating a cache
 #
@@ -88,6 +116,71 @@ $cache->set_expires_in(0);
 is($cache->get_expires_in(), 0,          '"expires in" is set to now (0)');
 $cache->set($key, $value);
 ok(!defined($cache->get($key)),          'cache is expired');
+$cache->set_expires_in(-1);
+
+# ......................................................................
+
+# Prepare for testing cache_fetch from $cache_pm
+my $test_perlio_util = eval { require PerlIO::Util; 1 };
+my $cached_output = <<"EOF";
+$fake_action_output# (version recovered from cache)
+EOF
+$key = gitweb_output_key();
+
+# Catch output printed by cache_fetch
+# Test all ways of capturing output in cache_fetch
+our ($perlio_util, $STDOUT);
+my ($test_data, $test_data_fh, $test_STDOUT);
+sub capture_cache_fetch_output {
+	$test_data = '' if defined $test_data;
+
+	if ($perlio_util) { # or $test_perlio_util
+		*STDOUT->push_layer(scalar => \$test_data);
+
+		cache_fetch($cache, $action);
+
+		*STDOUT->pop_layer();
+
+	} else {
+		diag("PerlIO::Util not available, not all tests run");
+		$test_STDOUT = *STDOUT;
+		open $test_data_fh, '>', \$test_data;
+		$STDOUT = *STDOUT = $test_data_fh; # $STDOUT is from $cache_pm
+
+		cache_fetch($cache, $action);
+
+		*STDOUT = $test_STDOUT;
+
+	}
+}
+
+
+# Due to some bad interaction between double capturing, both if second
+# capture (for this test) is done using PerlIO layers (via PerlIO::Util),
+# and if it is done using *STDOUT manipulation, tests below do not work if
+# $perlio_util is false, i.e. if cache_fetch() uses *STDOUT manipulation.
+# Earlier manual test shown that cache_fetch() *STDOUT manipulation seems
+# to work all right... but this test would fail when 'if' is replaced by
+# (currently commented out) 'for'.
+
+#for my $use_perlio_util (0..$test_perlio_util) {
+if ((my $use_perlio_util = $test_perlio_util)) {
+	$perlio_util = $use_perlio_util;
+	diag(($perlio_util ? "Use" : "Don't use")." PerlIO::Util");
+
+	# clean state
+	$cache->remove($key);
+
+	# first time (if there is no cache) generates cache entry
+	capture_cache_fetch_output();
+	is($test_data, $fake_action_output,        'action output is printed (generated)');
+	is($cache->get($key), $fake_action_output, 'action output is in cache (generated)');
+
+	# second time (if cache is set/valid) reads from cache
+	$cache->set($key, $cached_output);
+	capture_cache_fetch_output();
+	is($test_data, $cached_output,             'action output is printed (from cache)');
+}
 
 done_testing();
 
-- 
1.6.6.1
