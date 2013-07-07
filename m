From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 00/22] Index v5
Date: Sun,  7 Jul 2013 10:11:38 +0200
Message-ID: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5U-0005m8-NI
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3GGIM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:12:26 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:47236 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab3GGIMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:23 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so2280059eak.4
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=L7avsRzMdgBYRNZwPhr8AByxWEEH27N2XJ1f7giaLeQ=;
        b=MJPgnSbrA0oUaXpI/XqJYWb7Zfd4EzLi59WRbQvOvK2Ku9bsEVYi05vp3CP6awcC2i
         k3yP4KjP4ARVtMVaLmoWnhpDr3Vcy6aLCHBb7GHf9NNSY7r6lL+fbwyo8eeBv/9bYLO+
         wE14S05RlLvLIcP5osbBs887rj1x1PwUeFdNGwTYCw82oebd2ZJQuS5T5qAS7AdbZkoA
         pOa9gmpbD0OhOMXCLHV1BREYzBBlim0ga0n6afPfu0FmI6Qj39spIV8ABTjPW/q8cE25
         8aCs/ui1j3gGn1TR6ggEnEz0ZtFYqac0oRGYH70os+Vw0udRy92bBIckuPgIXr04QX3c
         PX+w==
X-Received: by 10.15.55.199 with SMTP id v47mr19313543eew.41.1373184741783;
        Sun, 07 Jul 2013 01:12:21 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id bj46sm30666080eeb.13.2013.07.07.01.12.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229732>

Hi,

This is a follow up for last years Google Summer of Code (late I know
:-) ), which wasn't merged back then.  The previous rounds of the
series are at $gmane/202752, $gmane/202923, $gmane/203088 and
$gmane/203517.

Since then I added a index reading api, which allows certain parts of
Git to take advantage of the the partial reading capability of the new
index file format now.  In this series the grep and the ls-files and
the code-paths used by them are switched to the new api.

Another goal for the api is to hide the open coded loops and accesses
to the in-memory format, to make it simpler to change the in-memory
format to a version that fits the new on-disk format better.

Except for the new patches, mostly the "read-cache: read index-v5"
patch changed, as the possibility to read the index partially was
added.

The first patch for t2104 makes sense without the rest of the series,
as it fixes running the test-suite with index-v4 as the default index
format.

Below are the timings for the WebKit repository.  c4b2d88 is the
revicion before adding anything, while HEAD are the times at the last
patch in the series.  The slower times in update-index come from the
update-index patch so they are no problem (in c4b2d88 the index is
only read, while in HEAD it's read and written).  The increase in time
in the ls-files test come from the not having the prune_cache function
in the index api.

I have not added this function as it only seems of use in ls-files,
but it can still be added if this increase is a problem.

Test                                        c4b2d88           HEAD                   
-------------------------------------------------------------------------------------
0003.2: v[23]: update-index                 0.11(0.06+0.04)   0.22(0.15+0.05) +100.0%
0003.3: v[23]: grep nonexistent -- subdir   0.12(0.08+0.03)   0.12(0.09+0.02) +0.0%  
0003.4: v[23]: ls-files -- subdir           0.11(0.08+0.01)   0.12(0.08+0.03) +9.1%  
0003.6: v4: update-index                    0.09(0.06+0.02)   0.18(0.14+0.03) +100.0%
0003.7: v4: grep nonexistent -- subdir      0.10(0.08+0.02)   0.10(0.07+0.02) +0.0%  
0003.8: v4: ls-files -- subdir              0.09(0.07+0.01)   0.10(0.08+0.01) +11.1% 
0003.10: v5: update-index                   <missing>         0.15(0.10+0.03)        
0003.11: v5: grep nonexistent -- subdir     <missing>         0.01(0.00+0.00)        
0003.12: v5: ls-files -- subdir             <missing>         0.01(0.01+0.00)        

And for reference the times for a synthetic repository with a 470MB
index file, just to demonstrate the improvements in large repositories.

Test                                        c4b2d88           HEAD                   
-------------------------------------------------------------------------------------
0003.2: v[23]: update-index                 1.50(1.18+0.30)   3.18(2.55+0.60) +112.0%
0003.3: v[23]: grep nonexistent -- subdir   1.62(1.28+0.32)   1.66(1.28+0.36) +2.5%  
0003.4: v[23]: ls-files -- subdir           1.49(1.21+0.26)   1.62(1.28+0.32) +8.7%  
0003.6: v4: update-index                    1.18(0.89+0.28)   2.68(2.22+0.44) +127.1%
0003.7: v4: grep nonexistent -- subdir      1.29(1.00+0.28)   1.30(1.04+0.24) +0.8%  
0003.8: v4: ls-files -- subdir              1.20(0.95+0.23)   1.30(0.98+0.30) +8.3%  
0003.10: v5: update-index                   <missing>         2.12(1.63+0.48)        
0003.11: v5: grep nonexistent -- subdir     <missing>         0.08(0.04+0.02)        
0003.12: v5: ls-files -- subdir             <missing>         0.07(0.05+0.01)        


Thomas Gummerer (21):
  t2104: Don't fail for index versions other than [23]
  read-cache: split index file version specific functionality
  read-cache: move index v2 specific functions to their own file
  read-cache: Re-read index if index file changed
  read-cache: add index reading api
  make sure partially read index is not changed
  dir.c: use index api
  tree.c: use index api
  name-hash.c: use index api
  grep.c: Use index api
  ls-files.c: use the index api
  read-cache: make read_blob_data_from_index use index api
  documentation: add documentation of the index-v5 file format
  read-cache: make in-memory format aware of stat_crc
  read-cache: read index-v5
  read-cache: read resolve-undo data
  read-cache: read cache-tree in index-v5
  read-cache: write index-v5
  read-cache: write index-v5 cache-tree data
  read-cache: write resolve-undo data for index-v5
  update-index.c: rewrite index when index-version is given

Thomas Rast (1):
  p0003-index.sh: add perf test for the index formats

 Documentation/technical/index-file-format-v5.txt |  296 +++++
 Makefile                                         |    3 +
 builtin/grep.c                                   |   71 +-
 builtin/ls-files.c                               |  213 ++-
 builtin/update-index.c                           |    8 +-
 cache-tree.c                                     |    2 +-
 cache-tree.h                                     |    6 +
 cache.h                                          |  158 ++-
 dir.c                                            |   33 +-
 name-hash.c                                      |   11 +-
 read-cache-v2.c                                  |  651 +++++++++
 read-cache-v5.c                                  | 1536 ++++++++++++++++++++++
 read-cache.c                                     |  752 ++++-------
 read-cache.h                                     |   69 +
 t/perf/p0003-index.sh                            |   59 +
 t/t2104-update-index-skip-worktree.sh            |    1 +
 test-index-version.c                             |    7 +-
 tree.c                                           |   38 +-
 18 files changed, 3183 insertions(+), 731 deletions(-)
 create mode 100644 Documentation/technical/index-file-format-v5.txt
 create mode 100644 read-cache-v2.c
 create mode 100644 read-cache-v5.c
 create mode 100644 read-cache.h
 create mode 100755 t/perf/p0003-index.sh

-- 
1.8.3.453.g1dfc63d
