From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/16] blame: accept multiple -L ranges
Date: Tue,  6 Aug 2013 09:59:33 -0400
Message-ID: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hoN-0003LT-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab3HFOA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:27 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53642 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab3HFOAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:25 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so875307obc.26
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=xUfwN3FjmtYm5AZNxJNgr6p3e7vqk2jm1cKEDzTL9IU=;
        b=WiOjRYEJubRwMVxuhXJa7l5mTPNn3312jqv+IgMVSM8129AUJQdI9f+gdyzoqQW7pi
         sbcH/J2Mfz+IMdRwkDs2hwzS5SbCH04flbzs5ZxR/Sk/27IbflcVqzF79fzEZ4TbFFT7
         /Fnch9tisAcvdLRwgfvwsI1uncdlqnzGUhpnCuJln+njNhKbOm8wuAPq+RCQwJx6NghZ
         /8WpKUFV8bCWakyWKEf7U8tO4b+VsVGpmbz3GkpsQb/0HYHCTCsNwJBf8hN6At9VuKF8
         dwIPxDAt9bjyRm2tWhgMWti2D9CHS7BtpRaZSkLAWS4IQvphIx4QFM+ugBvIX6m8wb/H
         pTow==
X-Received: by 10.182.215.193 with SMTP id ok1mr1083549obc.78.1375797623847;
        Tue, 06 Aug 2013 07:00:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231739>

This is a re-roll of [1] which teaches git-blame to accept multiple -L
ranges. It is built atop [6] (es/blame-L-more in 'pu').

The series is longer than expected since it includes a few more cleanup
patches beyond those already posted separately [2], [3], [4], [5], [6];
and because it implements relative /RE/ searches requested by Junio [7],
and brings git-log's multiple -L behavior in line with git-blame's.
Despite the length of the series, the patches are mostly small and
simple.


Changes since v1:

* Make /RE/ searches relative to end of previous -L, if any [7]. Ditto
  for :RE searches.

* Introduce ^/RE/ and ^:RE to search from start of file.

* Add (lots of) tests.

* Update documentation.

* Collect ranges via 'struct range_set' rather than (ab)using
  blame.c:coalesce() and add_blame_range().


Quick overview of patches:

1-2: More cleanups akin to [2], [3], [4], [5], [6].

3-7: Implement git-blame multiple -L support; add tests; update
  documentation.

8-14: Make /RE/ and :RE searches relative; introduce ^/RE/ and ^:RE to
  search from start of file; add tests; update documentation.

15-16: Reject bogus -L inputs for line numbers less than 1. This comes
  late in the series because this case becomes much easier to detect
  following patch 8.


[1]: http://thread.gmane.org/gmane.comp.version-control.git/229755
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229917
[3]: http://thread.gmane.org/gmane.comp.version-control.git/230532
[4]: http://git.661346.n2.nabble.com/PATCH-0-6-fix-blame-L-regression-add-tests-tp7592174.html
[5]: http://thread.gmane.org/gmane.comp.version-control.git/231035
[6]: http://thread.gmane.org/gmane.comp.version-control.git/231412
[7]: http://article.gmane.org/gmane.comp.version-control.git/229966


Eric Sunshine (16):
  git-log.txt: place each -L option variation on its own line
  line-range-format.txt: clarify -L:regex usage form
  range-set: publish API for re-use by git-blame -L
  blame: inline one-line function into its lone caller
  blame: accept multiple -L ranges
  t8001/t8002: blame: add tests of multiple -L options
  blame: document multiple -L support
  line-range: teach -L/RE/ to search relative to anchor point
  blame: teach -L/RE/ to search from end of previous -L range
  log: teach -L/RE/ to search from end of previous -L range
  line-range-format.txt: document -L/RE/ relative search
  line-range: teach -L^/RE/ to search from start of file
  line-range: teach -L:RE to search from end of previous -L range
  line-range: teach -L^:RE to search from start of file
  t8001/t8002: blame: add tests of -L line numbers less than 1
  line-range: reject -L line numbers less than 1

 Documentation/blame-options.txt     |  10 +--
 Documentation/git-blame.txt         |  10 ++-
 Documentation/git-log.txt           |   5 +-
 Documentation/line-range-format.txt |  16 +++--
 builtin/blame.c                     |  93 ++++++++++++++------------
 line-log.c                          |  25 ++++---
 line-log.h                          |  12 ++++
 line-range.c                        |  62 +++++++++++++----
 line-range.h                        |   5 +-
 t/annotate-tests.sh                 | 130 ++++++++++++++++++++++++++++++++++--
 t/t4211-line-log.sh                 |   2 +-
 11 files changed, 282 insertions(+), 88 deletions(-)

-- 
1.8.4.rc1.409.gbd48715
