From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 00/10] gitweb: Simple file based output caching
Date: Tue,  9 Feb 2010 11:30:17 +0100
Message-ID: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenMk-0003al-8i
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab0BIKal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:41 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57151 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0BIKak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:40 -0500
Received: by fxm20 with SMTP id 20so3026581fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/7JAYgsB+0w4RdWNbRQBFsXllnrCDerS9PA28Cyp9S8=;
        b=rPbfqz8sKPxm5g6Rf1mtRfYTkrGR50kw5Q/JET4xXfyIKskMoGAWQNyASwqlhsW1r3
         J0OkVsJ5bxWlseE3gjKhQF9w7nJvJ530KG9EuXGFV/Fp2/1LDUBQPS+3rjPUUhuQvCdu
         /1HpHrhrRMCM+0TLl4nAODPbF/PnVS7Nsg+eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sfd8wGuezHaSpWNeh705F8W481QZ70bjbQCqLCRpYZfL6G6qL0GE97sjB1KyCikcsB
         Bg3TE6ifc7gGv9fOpNDcJPvE8VM5upwqewF7A00LoSBwM1W5z1HvJYlS9fI/bpfEgLUL
         cwrh4nWsE83gyjCumBFl/n18QsGRwwIHuBZyo=
Received: by 10.223.10.220 with SMTP id q28mr104086faq.46.1265711438692;
        Tue, 09 Feb 2010 02:30:38 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:37 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139382>

This 10 patches long patch series is intended as preliminary version
for splitting large 'gitweb: File based caching layer (from git.kernel.org)'
mega-patch by John 'Warthog9' Hawley aka J.H., by starting small and
adding features piece by piece.

This is second version (second release) of this series; previous is
available at http://repo.or.cz/w/git/jnareb-git.git as 'gitweb/cache-kernel'
branch.  It was sent as:
* [RFC PATCH 00/10] gitweb: Simple file based output caching
  Message-Id: <cover.1264198194.git.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/136913/focus=136917
(note however that v1 series of emails is lacking one of patches because
it was over VGER anti-spam size limit for messages).

This version tries to do without 
  gitweb: Print to explicit filehandle (preparing for caching)
patch, by capturing output using either PerlIO layers manipulated
using PerlIO::Util if this module is available, or direct manipulation
of *STDOUT if PerlIO::Util isn't available.  One of the goals of this
series is then decide whether it is worth to have explicit filehandle
in print statements in gitweb, or not; if the complexity is worth not
having to deal with straightforward but quite intrusive (and large)
patch.

As the earlier version was inspired by file-based caching in
Cache::Cache, this one is inspired by file-based caching in more
modern CHI (unified cache interface).

It still lacks POD for gitweb/cache.pm (would it be needed, or would
comments be enough), and gitweb/cache.pm still ties rather heavily
into gitweb (following still what was in original J.H. (mega)patch).

It *does* have quite detailed commit messages, as opposed to v1 of
this series, where some commits were described only in comment section
of emails containing them.  It is also very configurable (Pasky, this
would probably be of interest to you, as you didn't want to have 
"Generating..." pages enabled), even more than in original patch
by J.H.


NOTE: there are quite a bit of _API_ tests, but I have not tested gitweb
output with caching enabled extensively (thats how bug in "Generating..."
slipped through - for details see comments in last patch).  I have tested
that caching works around 4th patch in series, in that it doesn't cause
errors and displays page (here the lack of error handling is decidely
unhelpful), and that it displays the time when page was generated.  As I
have installed PerlIO::Util using local::lib, i.e. locally in ~/perl5,
I think that what I have been testing was the "*STDOUT munging" method
of capturing gitweb output.  (See "Capturing gitweb output" section
in PATCHv2 04/10).


This series is based on commit 8424981934c415bd20643de9cc932bd348dfb115:
(in the 'master' branch of git.git repository)
  Jeff King (1):
        Fix invalid read in quote_c_style_counted

and is available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-v2

Jakub Narebski (10):
  gitweb: href(..., -path_info => 0|1)
  gitweb/cache.pm - Very simple file based caching
  gitweb/cache.pm - Stat-based cache expiration
  gitweb: Use Cache::Cache compatible (get, set) output caching
  gitweb/cache.pm - Adaptive cache expiration time
  gitweb: Use CHI compatible (compute method) caching
  gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
  gitweb/cache.pm - Serve stale data when waiting for filling cache
  gitweb/cache.pm - Regenerate (refresh) cache in background
  gitweb: Show appropriate "Generating..." page when regenerating cache

Note that compared to previous version of this series, this version
lacks initial commit.
  gitweb: Print to explicit filehandle (preparing for caching)
This is a bit of an experiment if we can do caching without large patch
to gitweb upfront, and to decide whether tradeoff (more complicated
capturing) is worth it.

Also, one of the commits:
  gitweb/cache.pm - Serve stale data when waiting for filling cache (WIP)
was split into two separate commits:
  gitweb/cache.pm - Serve stale data when waiting for filling cache
  gitweb/cache.pm - Regenerate (refresh) cache in background
one serving stale data (in processes waiting for cache to be filled, 
aka readers), and one adding background cache regeneration. 

After previous series I have sent additional (PATCH 11/10) patch:
  gitweb: Ajax-y "Generating..." page when regenerating cache (WIP)
This patch would require rework to apply to this new series.

Diffstat:
~~~~~~~~~
 gitweb/README                          |   70 +++++
 gitweb/cache.pm                        |  530 ++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl                     |  305 +++++++++++++++++-
 t/gitweb-lib.sh                        |    2 +
 t/t9500-gitweb-standalone-no-errors.sh |   19 ++
 t/t9503-gitweb-caching.sh              |   32 ++
 t/t9503/test_cache_interface.pl        |  380 +++++++++++++++++++++++
 t/test-lib.sh                          |    3 +
 8 files changed, 1325 insertions(+), 16 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl
