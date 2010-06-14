From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 00/17] gitweb: Simple file based output caching
Date: Mon, 14 Jun 2010 18:08:12 +0200
Message-ID: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDf-0001Wt-7M
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab0FNQIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0FNQIh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:37 -0400
Received: by fxm8 with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8owukh7JvgV60LLKzLWnQGlH8PGY1Hhb6yB3w2naTEU=;
        b=upPTNgPqoFQUqaPDJOizXsSJVmQEmMJ1E3aO2m/7MFaUExC6xZgE1axAlirzkAeeMk
         9cqcs/vQRffpDx338FnrAGb68hB5nOYZ5FZhLY2w3wVMyNuasqCNJuAmW9aySW2tj0jF
         cp/RYHLRfTVxNxzftw2lRW04Vzu+E+Bz/rQqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rkB05V/dCNrHVhBSpz7R3zkUyd79tTuS5XWoLKW2LqqbQuD0n7xgyVun5H7lYBCHQy
         20A56qG9ZNuL6GeASRrUp2V+y8gSoi6cHwnMBjWz7BVzVivgPJ/zCLQP9a79ZTYq/23E
         pI9LOq9L5PmIHm5WqcJxCdXbhZeVpTv5Y2OM8=
Received: by 10.223.92.153 with SMTP id r25mr5652707fam.76.1276531715482;
        Mon, 14 Jun 2010 09:08:35 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149101>

This 17 patches long patch series is intended (yet again) as preliminary
version for splitting large 'gitweb: File based caching layer (from
git.kernel.org)' mega-patch by John 'Warthog9' Hawley aka J.H., by starting
small and adding features piece by piece.

This is fourth version (fourth release) of this series, and is available on
http://repo.or.cz/w/git/jnareb-git.git as 'gitweb/cache-kernel-v4' branch.
Earlier versions are available there as branches 'gitweb/cache-kernel',
'gitweb/cache-kernel-v2' and 'gitweb/cache-kernel-v3'.  Previous version of
this series was sent to git mailing list as:

* [RFC PATCHv3 00/10] gitweb: Simple file based output caching
  Message-Id: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/140138

This version is based on top of c0cb4ed (git-instaweb: Configure it to work
with new gitweb structure, 2010-05-28), which was merged as 'ps/gitweb-soc'
into next in 5db4adf, on 2010-06-03.  Next version would be rebased on top
of 'next', which would include "sub run" code in 'jn/gitweb-fastcgi', which
would require resolving conflict with this series.

This series of patches does not include comments on individual patches,
comparing them to previous version, and to original series by J.H.  The
next release of this series, hopefully not as RFC, would include them.


The MAIN DIFFERENCE from previous version is that, inspired by splitting
gitweb part of "Splitting gitweb and developing write functionalities
(Integrated web client for git)" Google Summer of Code 2010 project by
Pavan Kumar Sankara, the gitweb output caching code now resides in separate
modules under 'lib/' subdirectory, instead of being all in 'cache.pm' file.

The 'gitweb: href(..., -path_info => 0|1)' which began v3 series is already
merged in, together with other patches from 'jn/gitweb-caching-prep'.

The following changes are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v4


All comments welcome!

Shortlog:
~~~~~~~~~
 1. gitweb: Return or exit after done serving request

    This patch was generated in response to noticing the following kind of
    errors in /var/log/httpd/error_log:

      [Sun Jun 13 11:58:02 2010] gitweb.cgi: Subroutine git_atom redefined
      at /var/www/perl/gitweb/gitweb.cgi line 6804.

    when running gitweb under mod_perl (with ModPerl::Registry handler).
    After this patch I didn't see such errors... but I failed to reproduce
    this error without this patch.

    This patch was sent separately to git mailing list as
      http://thread.gmane.org/gmane.comp.version-control.git/149040
    but should probably be skipped.

 2. gitweb: Fix typo in hash key name in %opts in git_header_html

    This patch was sent separately to git mailing list and is already
    present in 'master' as ad709ea (gitweb: Fix typo in hash key name in
    %opts in git_header_html, 2010-06-13).

 3. gitweb: Prepare for splitting gitweb

    IMPORTANT!!!

    This patch is the main reason this series is CC-ed to Pavan Kumar
    Sankara (student) and Christian Couder (mentor) of "Integrated web
    client for git" GSoC2010 project, which includes splitting gitweb.

    As you can see later in series it makes it very easy to add new gitweb
    modules which are to be installed.  Just add

      GITWEB_MODULES += lib/Module/Foo.pm

    to gitweb/Makefile for Module::Foo.

 4. gitweb/lib - Very simple file based cache
 5. gitweb/lib - Stat-based cache expiration

    The major change is that the code is now in GitwebCache::SimpleFileCache
    module in gitweb/lib/GitwebCache/SimpleFileCache.pm file, instead of
    being in gitweb/cache.pm file.

    Other change is removing using File::Spec to manipulate pathnames,
    using faster concatenation instead.  Using File::Spec do not bring us
    extra portability, as gitweb itself assumes '/' as path separator.
    It should be tiny little bit faster without File::Spec::catfile etc.

 6. gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)

    This is new patch, not present in previous series.  Note that you have
    to run benchmark manually; it is not run by t9503 test.

    The t/t9503/benchmark_caching_interface.pl includes example benchmark
    results at the end of the file.

 7. gitweb/lib - Simple select(FH) based output capture

    The major change is that the code is now in GitwebCache::Capture and
    GitwebCache::Capture::SelectFH modules which are in *separate* files
    (one file per module), instead of being all in gitweb/cache.pm

 8. gitweb/lib - Alternate ways of capturing output

    This is new patch, not present in previous series.  It includes new
    test (not run by t9503) and new benchmark.

 9. gitweb/lib - Cache captured output (using get/set)

    The major change is that the code is now in GitwebCache::CacheOutput
    module in gitweb/lib/GitwebCache/CacheOutput.pm file.

10. gitweb: Add optional output caching

    "use lib __DIR__.'/lib';" is now added by earlier patch in series.
    It uses new infrastructure instead of 'bag of modules' cache.pm file.

11. gitweb/lib - Adaptive cache expiration time
12. gitweb/lib - Use CHI compatible (compute method) caching interface

    Similar to what was in previous version of this series.

13. gitweb/lib - Use locking to avoid 'cache miss stampede' problem
14. gitweb/lib - Serve stale data when waiting for filling cache
15. gitweb/lib - Regenerate (refresh) cache in background


    The major change is that the code is now in new (not present in
    previous version) GitwebCache::FileCacheWithLocking module (in its own
    file), which is derived from GitwebCache::SimpleFileCache.  This allow
    to choose whether to use locking (and other features that require
    locking) or not.

16. gitweb: Show appropriate "Generating..." page when regenerating cache
17. gitweb: Add startup delay to activity indicator for cache

    No major changes, I think (besides using new infrastructure).

 gitweb/Makefile                                |   10 +
 gitweb/README                                  |   62 ++++
 gitweb/gitweb.perl                             |  333 +++++++++++++++++--
 gitweb/lib/GitwebCache/CacheOutput.pm          |   93 ++++++
 gitweb/lib/GitwebCache/Capture.pm              |   66 ++++
 gitweb/lib/GitwebCache/Capture/PerlIO.pm       |   79 +++++
 gitweb/lib/GitwebCache/Capture/SelectFH.pm     |   82 +++++
 gitweb/lib/GitwebCache/Capture/TiedCapture.pm  |  149 +++++++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  264 +++++++++++++++
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |  417 ++++++++++++++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh         |   19 +
 t/t9503-gitweb-caching.sh                      |   38 +++
 t/t9503/benchmark_caching_interface.pl         |  132 ++++++++
 t/t9503/benchmark_capture_implementations.pl   |  198 +++++++++++
 t/t9503/test_cache_interface.pl                |  409 +++++++++++++++++++++++
 t/t9503/test_cache_output.pl                   |   66 ++++
 t/t9503/test_capture_interface.pl              |   76 +++++
 17 files changed, 2468 insertions(+), 25 deletions(-)

 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/PerlIO.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/SelectFH.pm
 create mode 100644 gitweb/lib/GitwebCache/Capture/TiedCapture.pm
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm
 create mode 100644 gitweb/lib/GitwebCache/SimpleFileCache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/benchmark_caching_interface.pl
 create mode 100755 t/t9503/benchmark_capture_implementations.pl
 create mode 100755 t/t9503/test_cache_interface.pl
 create mode 100755 t/t9503/test_cache_output.pl
 create mode 100755 t/t9503/test_capture_interface.pl
