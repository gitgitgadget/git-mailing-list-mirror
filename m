From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 00/10] gitweb: Simple file based output caching
Date: Tue, 16 Feb 2010 20:36:35 +0100
Message-ID: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTED-00027Q-J0
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab0BPTg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:36:57 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34515 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab0BPTgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:36:55 -0500
Received: by bwz5 with SMTP id 5so2280988bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=v1uLqvJxSXWFZlrWc9/+lVjjwm+hy85LUWbE8EaVpjI=;
        b=iyn9BtYCwOpP/b3Ks+6EcolLDsl/tgfAaBURGYHgmctmG7ud3ZZxY+YFqA415CHiAE
         ZYH+NN4a+r+CgOHRxH8LCxTFCd2B0Le+vEHnS8yqzePM0JTCCWJDeObSSLv93WqQeik+
         PcxPYpNwe84YnNDt6J3XSCGL2P95nDiSOxv9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bCKgdbx+p/KAVNGdNHElqsaZF6iBuZQvAsPsg/GcOfi1b4tuGGq73GDb2kgVNgDv8Z
         5lg+pBYPRgP+kxo1l/X4W3WuHgrJj8OxvUSrOkjoIBXo9hONoceWlsHeMzNsXdbTUn5z
         n1iRn8udp3sW/pH9PBM8c4psutVJkwQypKN+Q=
Received: by 10.204.48.197 with SMTP id s5mr4547217bkf.177.1266349012600;
        Tue, 16 Feb 2010 11:36:52 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.36.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:36:50 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140138>

This 10 patches long patch series is intended (yet) as preliminary version
for splitting large 'gitweb: File based caching layer (from git.kernel.org)'
mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
adding features piece by piece.

This is third version (third release) of this series, and is available on
http://repo.or.cz/w/git/jnareb-git.git as 'gitweb/cache-kernel-v3' branch.
Earlier versions are available there as branches 'gitweb/cache-kernel'
and 'gitweb/cache-kernel-v2'.  Previous version of this series was sent
to git mailing list as:
* [RFC PATCHv2 00/10] gitweb: Simple file based output caching
  Message-Id: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/139382

This version tries to do without 
  gitweb: Print to explicit filehandle (preparing for caching)
patch (or its equivalent).  It does it by "capturing" output by changing
default filehandle (used for "print", "printf" and "write" without explicit
filehandle) via 'select($data_fh);' to point to in-memory file.  This is
simplest possible solution, and does not require extra Perl modules.

Among other solutions are tie-ing *STDOUT to a class that captures output
(similar to what CGI::Cache does), or using PerlIO layers via push_layer() /
pop_layer() methods from (non-core) PerlIO::Util module (from CPAN).

This version also includes thorough (perhaps too thorough) error checking,
it has much more comments, should work correctly when two clients access the
same URL with an error condition (die_error is called), and it detaches
background process so even with mod_perl it would not generate zombies.

This version was tested a bit running under mod_cgi: that it generates page
correctly, that it gets page from cache, that cache expires correctly, that
stale page is being served, that "Generating..." page is generated correctly
and that it works.


There are a few KNOWN ISSUES: 'blame_incremental' action is not incremental
and does not work (perhaps JavaScript-based actions should be turned off
with current implementation of output cache?), and "Generating..." page
somehow does not get additional "." when waiting (but it works).


The following changes since commit 7e5eb8f1834722507e2d2171a253b78b1d924458
(in the 'master' branch of git.git repository):
  Junio C Hamano (1):
        Merge branch 'maint'

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v3

Shortlog:
~~~~~~~~~
Jakub Narebski (10):
  gitweb: href(..., -path_info => 0|1)
  gitweb/cache.pm - Very simple file based cache
  gitweb/cache.pm - Stat-based cache expiration
  gitweb: Use Cache::Cache compatibile (get, set) output caching
  gitweb/cache.pm - Adaptive cache expiration time
  gitweb: Use CHI compatibile (compute method) caching
  gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
  gitweb/cache.pm - Serve stale data when waiting for filling cache
  gitweb/cache.pm - Regenerate (refresh) cache in background
  gitweb: Show appropriate "Generating..." page when regenerating cache

Diffstat:
~~~~~~~~~
 gitweb/README                          |   70 ++++
 gitweb/cache.pm                        |  655 ++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl                     |  321 +++++++++++++++-
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 +
 t/t9503-gitweb-caching.sh              |   32 ++
 t/t9503/test_cache_interface.pl        |  404 ++++++++++++++++++++
 t/test-lib.sh                          |    3 +
 8 files changed, 1486 insertions(+), 20 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

-- 
Jakub Narebski

git version 1.6.6.1
