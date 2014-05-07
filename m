From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/20] Untracked cache to speed up "git status"
Date: Wed,  7 May 2014 21:51:40 +0700
Message-ID: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Cc-0005Qt-SM
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbaEGOwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2014 10:52:04 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:61099 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaEGOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:03 -0400
Received: by mail-pd0-f174.google.com with SMTP id w10so1165868pde.33
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=h3ETaV0yYNFoVnLWvafDYCCKRkubxkt6jr4SG8rcD4M=;
        b=IslDoMNI5eWBbHB804CBx8lBmwXt78t0Isuo+Xwg3cVOncxqRhkUpQ2ANj7oBDFLVX
         qzX84eRJKI+TL7313AiK4onbAvIiormkt7+9s69UXBJfWp+AkMVuN8+vpk3rRLX8yrbC
         N/3QZlFXzfU39xpgrGdBtfup12tRctet5mz1TCiNnk7Cg56YN2ARBQDwu2pL40CaGAKN
         WSM9KOETQHSE0voXvkEPk2aMD2MUtlrxHGDHRjVfFXkhnSpbSQ9Z3+A3AFkx37YTx+pm
         +ca0zSsUFYfPcj/HhUlxYLti1FliW0i3ATQaorI76oA9B5Mnp0U3N/7rzsXBzU6nlJQK
         lQYQ==
X-Received: by 10.66.141.144 with SMTP id ro16mr19769841pab.131.1399474321709;
        Wed, 07 May 2014 07:52:01 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id dd5sm3625945pbc.85.2014.05.07.07.51.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:01 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248306>

=46irst of all, thanks for pointing to many more big repos. I'll look a=
t
them tomorrow. End-of-day report (or ranting :D) time.

The series now looks good enough for public eyes. I haven't run the
test suite with untracked cache on by default so confidence level is
not so high. Although I suspect racy timestamp issue will practically
disable the cache anyway.

The idea is as before, exploit directory mtime to cache untracked
files. MSDN tells me NTFS on Windows exposes the "good" dir mtime
behavior, which means this series could speed up Git on Windows (I
think Karsten fscache only deals with slow lstat, untracked files..).

It would be nice if Windows people could try and confirm this. This
could be a good point for untracked cache vs watchman (no windows
support, last time I checked). Usage is very simple, "git update-index
--untracked-cache" and you're ready. Do --no-untracked-cache to revert
back.

The peformance numbers on webkit look good. If we focus on
read_directory time only. Normally it takes 890ms. The first run with
untracked cache goes up to 922ms (filling up the cache, not counting
index write time). The next run goes down to 184ms (best case). The
gain is about 80%. lstat costs on directories only about 20ms out of
that 184ms, so I still need to see if I can lower that number further
down.

"git status" performance gain is less impressive of course. Only about
38% with refresh time now becomes the top offender. With
core.preloadindex on, the gain increases to 50%. There's still room
for improvement to maybe make it to 65% by reducing read time, I think.

But again we may not stay in the best case forever. The more dirs are
damaged, the slower it gets. At the end of the spectrum, all dirs are
damanged, we gain nothing but overhead. This is actually when watchman
shines, although projects that do that may need some improvements.

Another bad point for untracked cache is, the extension data is
so specifiec to core git algorithm that it probably cannot be reused
by other implementations. Again, watchman shines here.

Last note, this series conflicts with split-index due to the
write_cache API change, so not a candidate for 'pu' yet. The series
could also be fetched from

https://github.com/pclouds/git/commits/untracked-cache

except the last few timing/experimental patches.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
  dir.c: coding style fix
  dir.h: move struct exclude declaration to top level
  prep_exclude: remove the artificial PATH_MAX limit
  dir.c: optionally compute sha-1 of a .gitignore file
  untracked cache: record .gitignore information and dir hierarchy
  untracked cache: initial untracked cache validation
  untracked cache: invalidate dirs recursively if .gitignore changes
  untracked cache: record/validate dir mtime and reuse cached output
  untracked cache: mark what dirs should be recursed/saved
  untracked cache: don't open non-existent .gitignore
  untracked cache: save to an index extension
  untracked cache: load from UNTR index extension
  untracked cache: invalidate at index addition or removal
  untracked cache: print untracked statistics with $GIT_TRACE_UNTRACKED
  read-cache.c: split racy stat test to a separate function
  untracked cache: avoid racy timestamps
  status: support untracked cache
  update-index: manually enable or disable untracked cache
  update-index: test the system before enabling untracked cache
  t7063: tests for untracked cache

 .gitignore                                 |   1 +
 Makefile                                   |   1 +
 builtin/commit.c                           |   8 +
 builtin/update-index.c                     | 161 ++++++
 cache.h                                    |   5 +
 dir.c                                      | 853 +++++++++++++++++++++=
++++++--
 dir.h                                      | 120 +++-
 read-cache.c                               |  51 +-
 t/t7063-status-untracked-cache.sh (new +x) | 352 ++++++++++++
 test-dump-untracked-cache.c (new)          |  61 +++
 unpack-trees.c                             |   7 +-
 wt-status.c                                |   6 +
 12 files changed, 1537 insertions(+), 89 deletions(-)
 create mode 100755 t/t7063-status-untracked-cache.sh
 create mode 100644 test-dump-untracked-cache.c

--=20
1.9.1.346.ga2b5940
