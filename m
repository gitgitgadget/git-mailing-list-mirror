From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb: Simple file based output caching - current state of series
Date: Sun, 11 Apr 2010 23:17:54 +0200
Message-ID: <201004112317.55240.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 23:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O14Xw-0000cN-1v
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab0DKVSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 17:18:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54192 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab0DKVSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 17:18:04 -0400
Received: by bwz19 with SMTP id 19so17189bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vLH52H30T9tJDGxh/J/J7obVp9vaBlY2aWE3TPQhGFw=;
        b=sFIsSy6RnT0cEKK48j9p4iRo0ozJ1PpDA6fYr92lTP1YfmUceAJpKxyGVHhNDi1EXv
         K7mvTyPtvnffKwBpiGp2w0fJSRwbH2XHqg+pNMpxSNMSBKIElE9oTZfKr5n/L298/tvm
         Fxv1IvC/MpQ4YMCSYGEtY8qzSTSzPvMjh3aa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=tWUnJMOxk3IiwWdX0R0PqCNZbfG2v7U+ZYFkpU0aY8fRDmElU98gyaWMC5qrUaYeOw
         Nrv5VNysvJ4DqQHhAixNfnKVgI3Wn64yZGu5mkue/7/COX+IQtXhhpeoashA4ayBjgmg
         t8ajn9yew48aivOYKumBOj/t4CFTtrmMXgpCs=
Received: by 10.103.7.31 with SMTP id k31mr1427552mui.132.1271020681159;
        Sun, 11 Apr 2010 14:18:01 -0700 (PDT)
Received: from [192.168.1.13] (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id i7sm14168531mue.4.2010.04.11.14.17.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 14:18:00 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144686>

I am still working on adding support for output (response) caching to
gitweb, based originally on patch series by John 'Warthog9' Hawley aka J.H.
The idea was to start small, and add features piece by piece for easier
review.  As you can see the idea snowballed a bit, with 16 patches in
the series now (4 of those are more or less independent of caching support).

Current version of my work on simple file based output caching in
gitweb can be found at:
  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-pu

  http://repo.or.cz/w/git/jnareb-git.git/log/refs/heads/gitweb/cache-kernel-pu

Note that 'gitweb/cache-kernel-pu' will be undergoing rewriting!
Previous versions of my take on series can be found as branches
'gitweb/cache-kernel', 'gitweb/cache-kernel-v2', 'gitweb/cache-kernel-v3'.
J.H. series can be found in git://git.kernel.org/pub/scm/git/warthog9/gitweb.git
as branches 'gitweb-ml-v2', 'gitweb-ml-v3', 'gitweb-ml-v4'.

Shortlog:
~~~~~~~~~
   1. Export more test-related variables when running external tests

      This patch is actually independent of caching.  I needed 
      TEST_DIRECTORY to find gitweb/cache.pm for later tests of
      caching (which are written in Perl).

   2. gitweb: href(..., -path_info => 0|1)

      This is needed to have unique key for a gitweb page, independently
      on whether we used query string or path_info URL to arrive at it.
      In other words it is used to implement canonical URL for a gitweb
      page, which would not depend on gitweb configuration.

   3. gitweb: Add custom error handler using die_error (WIP)

      This patch was created for gitweb to provide similar output for its
      errors (thrown using die_error() subroutine), and errors from the
      caching layer (thrown using simply "die"), and errors from Perl
      (like Perl errors, or mkdir from File::Path, or tempfile from
      File::Temp.  The idea was to use die_error as error handler for
      the CGI layer via set_message from CGI::Carp.

      Unfortunately I have not realized until later that error message
      handler set using set_message from CGI::Carp is responsible only
      for the HTTP response body part: you can't set HTTP headers in
      CGI::Carp error handler (fatalsToBrowser case).

      Therefore this patch, if it is to stay, should be fixed so that
      die_error does not produce HTTP headers when invoked as error handler,
      and not explicitely.

      Note also that due to the fact that die_error uses exit, errors
      handled by die_error as error handler would not be logged.  Fixing
      *this* would require additional patch, removing 'exit' from gitweb
      and replacing it by non-local jump (non-local goto)... which I guess
      would also improve gitweb performance in persistent environments
      such as mod_perl, mod_perlite (WIP), or (if gitweb would in the
      future support it) FastCGI.

   4. gitweb/cache.pm - Very simple file based cache
   5. gitweb/cache.pm - Stat-based cache expiration

      Those two patches didn't change much from previous versions.
      The idea is to provide Cache::Cache and CHI caching interface
      compatibile file-based cache package, so that one would be able
      to use CHI or Cache::Cache instead of it.

      I have this time actually tested that Cache::FileCache seems to
      work as gitweb caching engine.

   6. gitweb/cache.pm - Simple select(FH) based output capture

      Compared to previous versions, this time capturing is separated
      into two packages.  One implements capturing interface, second
      is select(FH)-based driver that actually does "capturing".

      The idea is to be able to replace simplistic select(FH)-based
      "capturing" with capturing using tied filehandle, or capturing
      using push_layer method from non-standard PerlIO::Util module.

   7. gitweb/cache.pm - Cache captured output (using get/set)
   8. gitweb: Add optional output caching (from gitweb/cache.pm)

      Compared to previous version of gitweb caching series, adding
      caching captured output (as yet another package in gitweb/cache.pm)
      is separated from adding output caching to gitweb itself.

      In this point of series out simple file-based cache has enough
      features to be useful for caching gitweb output.

   9. gitweb/cache.pm - Adaptive cache expiration time

      Not changed much from previous version.  The idea is to lengthen
      cache expiration time when there is heavy load on server.  More
      configurable that in original patch by J.H.  Compare Cache::Adaptive.

  10. gitweb/cache.pm - Use CHI compatibile (compute method) caching
                        interface

      Just updated to newer way of capturing output.  It is needed because
      locking requires ->compute API, and would not work with only 
      ->get / ->set API.

  11. gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
  12. gitweb/cache.pm - Serve stale data when waiting for filling cache
  13. gitweb/cache.pm - Regenerate (refresh) cache in background

      Those three patches didn't change much from previous versions.  

      Note that compared to original J.H. patches caching engine now
      daemonizes process that does bacground cache generation; this should
      make it work correctly also in persistent environments like mod_perl
      (and perhaps in the future also FastCGI).

  14. gitweb: Move generating page title to separate subroutine

      This patch is actually independent of caching, although without
      "progress info" support for cache in subsequent patches the new
      subroutine would be used only in one place, in git_header_html().
      Nevertheless refactoring title generation allows to reduce indent
      level.

  15. gitweb: Show appropriate "Generating..." page when regenerating cache

      It should actually work now.  The problem was that flock can be
      interrupted by SIGALRM from timer used to print progress info.

      Might need extra tests not that of generic support for
      generating_info subroutine in caching engine, but that subroutine
      similar to git_generating_html in gitweb works correctly.

  16. gitweb: Add startup delay to activity indicator for cache

      In previous version of series it was lumped together in previous
      patch, even though it is a new feature, not present in original
      patch series by J.H.

      This feature was inspired (semi-requested) by comments from Petr
      'Pasky' Baudis during discussion on some previous version of my
      series, or J.H. series about gitweb caching.

Diffstat:
~~~~~~~~~
 gitweb/INSTALL                         |    6 +
 gitweb/README                          |   70 +++
 gitweb/cache.pm                        |  779 ++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl                     |  391 ++++++++++++++--
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 +
 t/t9503-gitweb-caching.sh              |   38 ++
 t/t9503/test_cache_interface.pl        |  339 ++++++++++++++
 t/t9503/test_cache_output.pl           |   76 +++
 t/t9503/test_capture.pl                |   74 +++
 t/test-lib.sh                          |    3 +
 11 files changed, 1756 insertions(+), 41 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl
 create mode 100755 t/t9503/test_cache_output.pl
 create mode 100755 t/t9503/test_capture.pl

-- 
Jakub Narebski
