From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv6/RFC 00/24] gitweb: Simple file based output caching
Date: Tue,  7 Dec 2010 00:10:45 +0100
Message-ID: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkK1-0002dM-2j
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0LFXSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:18:11 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:57330 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0LFXSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:18:10 -0500
Received: by ewy10 with SMTP id 10so7584639ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hZRsTBkLytDoX1UD4wAAphuZA22ZMmgz2gGlfwTPtYQ=;
        b=wrHICPmp/DqQTGDGFv4c/oKY1VC/E+wAyxUb7YTPNwUrJjERg9//GhfBkBOaiJPmaq
         d1uiUd5vmJbM8rozfHtfGLugsuI5cpz4JeTg3w/U9prfYVxmXlmRzVe+8x2veGjoQuhw
         O28GzD6vXFcpuUw8+VxZO1U/ceXlDseJ/FaKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kL8+XoqbJ0mN0T9wiPGbFxPtyBc8L8XPJJUL/AoTibiJrj/tgim2bR6iozyDZ44wPy
         bq6Qn0FZWnrRLevnMk/opBhsO2N1sp67fu1pXfy5kC7P625/z4JU5OwbkV1sTXVecYKE
         4uk8zHQFpckFQSc7GxM4FJcQ7OWT+WosRI6ao=
Received: by 10.213.36.5 with SMTP id r5mr6603009ebd.3.1291677098941;
        Mon, 06 Dec 2010 15:11:38 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:36 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163052>

[I Cc-ed everybody who *might* be interested in this series.  I am
 sorry if it included somebody by mistake]

This 22+ patches long series (2 last patches are proof of concept) is
intended as replacement (rewrite) of "Gitweb caching v7" series from
John 'Warthog9' Hawley (J.H.):

  http://thread.gmane.org/gmane.comp.version-control.git/160147

This is sixth version (6th release) of this series, and is available
in the following repositories (links are to web interface):

  http://repo.or.cz/w/git/jnareb-git.git
  http://github.com/jnareb/git

as 'gitweb/cache-kernel-v6' branch.  Earlier versions are available at
http://repo.or.cz/w/git/jnareb-git.git as 'gitweb/cache-kernel-v5'
(previous version) to 'gitweb/cache-kernel' (first version).

Previous version of this series was sent to git mailing list as:

  [PATCHv5 00/17] gitweb: Simple file based output caching
  Message-Id: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/158313

You can find link to next to previous version, et cetera.


The main ideas in lifted from J.H. patches are the following
(features in common with "Gitweb caching v7" series by John Hawley):

* caching captured output of gitweb in flat files, without any
  serialization (caching raw data)

* using global (per-cache, not per-entry) expiration time, and
  using difference between mtime of cache file and current time
  for expiration

* using file locking (flock) to prevent 'cache miss stampede'
  problem, i.e. to ensure that only one process is (re)generating
  cache entry

* serving stale but not too old version, and regenerating data
  in background, to avoid waiting for data to be regenerated

* progress info indicator based on http-equiv refresh trick
  (described in more detail how it works in the commit message)

* capturing gitweb output by redirecting STDOUT to cache entry file


The main differences between this patch series and "Gitweb caching v7"
(and my minimal fixups in "Gitweb caching v7.[1-3]") are the following:

* features are added piece by piece in multiple patches (22 patches
  covering v7 features vs 3-4 patches in v7/v7.x series), making it
  hopefully easier to review, as patches are smaller.  OTOH this series
  is much longer...

* In J.H. series subroutines responsible for capturing gitweb output are
  in gitweb.perl, and subroutines responsible for caching are in lib/cache.pl
  (cache.pm in original patch).  cache.pl/cache.pm uses variables and
  subroutines from gitweb script, so it couldn't be made into Perl module;
  therefore we have to use 'do' rather than 'require' to load it.

  In this series GitwebCache::Capture::Simple module is responsible for
  capturing [gitweb] output, GitwebCache::SimpleFileCache and
  GitwebCache::FileCacheWithLocking are responsible for caching, and
  GitwebCache::CacheOutput is about caching captured output (ties them
  together).  This allowed "unit" testing, i.e. testing each module
  in isolation (tests t9503 - t9505).

* GitwebCache::CacheOutput::cache_output (equivalent of cache_fetch from
  cache.pm in J.H. patch) supports any cache supporting ->get / ->set or
  ->compute interface (e.g. Cache::FileCache from Cache::Cache, or CHI
  with 'File' driver, or Cache::FastMmap) - it is described in gitweb/README
  in "Gitweb caching" section.

  For this capturing engine (GitwebCache::Capture::Simple) supports returning
  captured output (via capturing to in-memory file).

  Tested once upon a time with Cache::FileCache $cache.

* There is no difference between treating actions with binary output or
  possibly binary output like 'snapshot' or 'blob_plain' (which use binary
  or ':raw' mode) and other actions (which use text or ':utf8' mode).
  GitwebCache::Capture::Simple captures transformed output i.e. raw bytes,
  so data from cache is dumped to STDOUT (to web browser) in ':raw' mode.

* Instead of disabling caching of 'blame_incremental' action (so it is
  used without caching), this alternate to plain 'blame' action is
  disabled if caching is turned off.

  In the future 'blame_interactive' would use cache for caching its
  initial output and for caching 'blame_data' it uses.

* Configuring cache is done via %cache_options (and %generating_options)
  instead of via gitweb config variables.  For example instead of 
  $minCacheTime there is $cache_options{'expires_min'}.

  It is also more configurable than in J.H. patch; more parameters can be
  changed (like e.g. factor multiplying get_loadavg() in adaptive cache
  lifetime; 'check_load', 'generating_info', 'on_error' are configurable
  callbacks).

  "gitweb: Support legacy options used by kernel.org caching engine"
  patch in this series makes this rewrite support configuration variables
  used by "Gitweb caching v7" series.

* This rewrite uses lexical filehandles, i.e.

    open my $fh, '>', $filename

  instead of globals that J.H. patch uses

    open FH, '>', $filename

  (though it hides it in "open(cacheFile, '<', $filename)").  J.H. is
  working on "Gitweb caching v8" and I think he would address that issue
  there.

* When generating cache in background process, the background process
  daemonizes itself.  Therefore it should be safe to enable / use
  'background_cache' also for persistent environments, like mod_perl via
  ModPerl::Registry, FastCGI when run as gitweb.fcgi, PSGI via gitweb.psgi
  wrapper that git-instaweb generates.

- Other changes might be mentioned in comments to individual patches

Two last patches in this series introduce proof of concept cache
administration page, where you can currently check how much file space is
used by cache, and where you can also safely clean cache (remove all
entries).  Those two patches are slightly outside scope of "gitweb output
caching", and that is why I refer to this series as 22+ patches long
(there are 24 patches in total).

Previous version of this series had
  gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)
  gitweb/lib - Alternate ways of capturing output
as two last patche in the series.  They are missing in this release.


The following changes since commit 0b0cd0e0a29a139f418991dd769ea4266ffec370:

  Merge branch 'jn/ignore-doc' (2010-12-03 16:13:06 -0800)

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v6

Jakub Narebski (24):
  t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
  gitweb: Prepare for splitting gitweb
  gitweb/lib - Very simple file based cache
  gitweb/lib - Stat-based cache expiration
  gitweb/lib - Regenerate entry if the cache file has size of 0
  gitweb/lib - Simple output capture by redirecting STDOUT
  gitweb/lib - Cache captured output (using get/set)
  gitweb: Add optional output caching
  gitweb/lib - Adaptive cache expiration time
  gitweb/lib - Use CHI compatibile (compute method) caching interface
  gitweb/lib - capture output directly to cache entry file
  gitweb/lib - Use locking to avoid 'cache miss stampede' problem
  gitweb/lib - No need for File::Temp when locking
  gitweb/lib - Serve stale data when waiting for filling cache
  gitweb/lib - Regenerate (refresh) cache in background
  gitweb: Introduce %actions_info, gathering information about actions
  gitweb: Show appropriate "Generating..." page when regenerating cache
  gitweb/lib - Configure running 'generating_info' when generating data
  gitweb: Add startup delay to activity indicator for cache
  gitweb/lib - Add support for setting error handler in cache
  gitweb: Wrap die_error to use as error handler for caching engine
  gitweb: Support legacy options used by kernel.org caching engine
  gitweb/lib - Add clear() and size() methods to caching interface
  gitweb: Add beginnings of cache administration page (proof of
    concept)

 gitweb/Makefile                                |   23 +-
 gitweb/README                                  |   62 +++
 gitweb/gitweb.perl                             |  544 +++++++++++++++++++-
 gitweb/lib/GitwebCache/CacheOutput.pm          |  131 +++++
 gitweb/lib/GitwebCache/Capture/Simple.pm       |  110 ++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  376 ++++++++++++++
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |  592 ++++++++++++++++++++++
 t/gitweb-lib.sh                                |   12 +
 t/t9500-gitweb-standalone-no-errors.sh         |   20 +
 t/t9501-gitweb-standalone-http-status.sh       |   21 +
 t/t9502-gitweb-standalone-parse-output.sh      |   33 ++
 t/t9503-gitweb-caching-interface.sh            |   34 ++
 t/t9503/test_cache_interface.pl                |  647 ++++++++++++++++++++++++
 t/t9504-gitweb-capture-interface.sh            |   34 ++
 t/t9504/test_capture_interface.pl              |  108 ++++
 t/t9505-gitweb-cache.sh                        |   39 ++
 t/t9505/test_cache_output.pl                   |   86 ++++
 t/test-lib.sh                                  |    4 +-
 18 files changed, 2850 insertions(+), 26 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/Simple.pm
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm
 create mode 100644 gitweb/lib/GitwebCache/SimpleFileCache.pm
 create mode 100755 t/t9503-gitweb-caching-interface.sh
 create mode 100755 t/t9503/test_cache_interface.pl
 create mode 100755 t/t9504-gitweb-capture-interface.sh
 create mode 100755 t/t9504/test_capture_interface.pl
 create mode 100755 t/t9505-gitweb-cache.sh
 create mode 100755 t/t9505/test_cache_output.pl

-- 
1.7.3
