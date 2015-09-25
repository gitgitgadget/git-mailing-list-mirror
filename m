From: Karsten Blees <karsten.blees@gmail.com>
Subject: broken racy detection and performance issues with nanosecond file
 times
Date: Sat, 26 Sep 2015 01:28:10 +0200
Message-ID: <5605D88A.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 01:28:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfcPg-0007pX-4o
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 01:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbbIYX2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 19:28:19 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34453 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbbIYX2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 19:28:18 -0400
Received: by wicfx3 with SMTP id fx3so40129725wic.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=8KVV32KoUwCRxN6qdbdjcHr+DoPwrQpTkx1QNfmSxDY=;
        b=xGwStTsZIu+9mnZZgQeeMBVBQTmUDITmWbWKXjX1r8+MYK1fRGF7yLRAExYRk8WRop
         XswHGp4KCiR9xhef/5P2Chlg189KdyryQYp3uHMMOpeEYDmiHZvJKem7rlEpA1cruIwd
         C0fy/RfkZCKGCDxeQ5XvSjzEILVr0VZ5UpoK8FQ47vL8CWKDBi70SMKUBOqz6N0q9xgd
         Ige9KBuL+JjwJ7MD25YyajKl197My4LiO9la5JZ9vB7/9M5i1bT1i4F4SUdEoCUTyYRJ
         atZ3Iiv6sHwIeSoNxL0P1HyCVouwDskTsTsJ+F5ScjpKkSAusM/CC85fO58UoTOMbD5p
         fcDw==
X-Received: by 10.180.240.172 with SMTP id wb12mr6055927wic.64.1443223697014;
        Fri, 25 Sep 2015 16:28:17 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id wn10sm5562845wjc.46.2015.09.25.16.28.15
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 16:28:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278683>

Hi there,

I think I found a few nasty problems with racy detection, as well as
performance issues when using git implementations with different file
time resolutions on the same repository (e.g. git compiled with and
without USE_NSEC, libgit2 compiled with and without USE_NSEC, JGit
executed in different Java implementations...).

Let me start by listing relevant file time gotchas (skip this if it
sounds too familiar) before diving into problem descriptions. Some
ideas for potential solutions are at the end.


Notable file time facts:
========================

The st_ctime discrepancy:
* stat.st_ctime means "change time" (of file metadata) on POSIX
  systems and "creation time" on Windows
* While some file systems may track all four time stamps (mtime,
  atime, change time and creation time), there are no public OS APIs
  to obtain creation time on POSIX / change time on Windows.

Linux:
* In-core file times may not be properly rounded to on-disk
  precision, causing spurious file time changes when the cache is
  refreshed from disk. This was fixed for typical Unix file systems
  in kernel 2.6.11. The fix for CEPH, CIFS, NTFS, UFS and FUSE will
  be in kernel 4.3. There's no fix for FAT-based file systems yet.
* Maximum file time precision is 1 ns (or 1 s with really old glibc).

Windows:
* Maximum file time precision is 100 ns.

Java <= 6:
* Only exposes mtime in milliseconds (via File.getLastModifiedTime).

Java >= 7:
* Only exposes mtime, atime and creation time, no change time (see
  java.nio.file.attribute.BasicFileAttributes).
* Maximum file time precision is implementation specific (OpenJDK:
  1 microsecond on both Unix [1] and Windows [2]).
* On platforms or file systems that don't support creation time,
  BasicFileAttribtes.creationTime() is implementation specific
  (OpenJDK returns mtime instead). There's no public API to detect
  whether creation time is supported or "emulated" in some way.

Git Options:
* NO_NSEC (git only): compile-time option that disables recording of
  nanoseconds in the index, implies USE_NSEC=false.
* USE_NSEC (git and libgit2 with [3]): compile-time option that
  enables nanosecond comparison in both up-to-date and racy checks.
* core.checkStat=minimal (git, libgit2, JGit): config-option that
  disables nanosecond comparison in up-to-date checks, but not in
  racy checks.

JGit:
* Only uses mtime, rounded to milliseconds. While there is a
  DirCacheEntry.setCreationTime() [4] to set the index entry's ctime
  field, AFAICT its not used anywhere.
* Does not compare nanoseconds if the cached value recorded in the
  index is 0, to prevent performance issues with NO_NSEC git
  implementations [5].


Problem 1: Failure to detect racy files (without USE_NSEC)
==========================================================

Git may not detect racy changes when 'update-index' runs in parallel
to work tree updates.

Consider this (where timestamps are t<seconds>.<nanoseconds>):

 t0.0$ echo "foo" > file1
 t0.1$ git update-index file1 &  # runs in background
 t0.2$ # update-index records stats and sha1 of file1 in new index
 t0.3$ echo "bar" > file1
 ....$ # update-index writes other index entries
 t1.0$ # update-index finishes (sets mtime of the new index to t1.0!)
 t1.1$ git status # doesn't detect that file1 has changed

The problem here is that racy checks in 'git status' compare against
the new index file's mtime (t1.0), which may be newer than the last
change of file1.


Problem 2: Failure to detect racy files (mixed USE_NSEC)
========================================================

Git may fail to detect racy conditions if file times in .git/index
have been recorded by another git implementation with better file
time resolution.

Consider the following sequence:

 t0.0$ echo "foo" > file1
 t0.1$ use-nsec-git update-index file1
 t0.2$ echo "bar" > file1
 ....$ sleep 1
 t1.0$ touch file2
 t1.1$ use-nsec-git status # rewrites index, to store file2 change
 t1.2$ git status # doesn't detect that file1 has changed

The problem here is that the first, nsec-enabled 'git status' does
not consider file1 racy (with nanosecond precision, the file is dirty
already (t0.0 != t0.2), so no racy-checks are performed). Thus, it
will not squash the size field (as a second-precision-git would).
However, it will rewrite the index to capture the status change of
file2, and thus create a new index file with mtime = t1.1. Similar
to problem 1, subsequent 'git status' with second-precision has no
way to detect that file1 has changed.

This problem would not be limited to USE_NSEC-enabled/disabled git,
it occurs whenever different file time resolutions are at play, e.g.:
 * second-based git vs. millisecond-based JGit
 * millisecond-based JGit vs. nanosecond-enabled git
 * GIT_WORK_TREE on ext2 (1 s) and GIT_DIR on ext4 (1 ns)
 * JGit executed by different Java implementations (with different
   file time resolutions)


Problem 3: Failure to detect racy files with core.checkStat=minimal
===================================================================

Consider the example above (problem 2). With core.checkStat=minimal,
the nanosecond-enabled git also fails to detect that file1 has
changed.

This is because racy checks are still done with nanosecond precision
(despite checkStat=minimal), and against the *cached* mtime, not the
real one. I.e.:
 * in match_stat_data(), nanoseconds are ignored, and file1 is
   considered unchanged (as t0[.0] == t0[.2]).
 * in ie_match_stat(), we pass the cache entry to is_racy_timestamp()
   (which has mtime == t0.0), even though we know the current mtime
   at this point (t0.2)
 * in is_racy_stat(), file1 is not considered racy, because the index
   file's mtime (t0.1) is newer than the cached mtime (t0.0)


Problem 4: Performance issues with mixed file time resolutions
==============================================================

A git implementation will consider files dirty (i.e. triggering a
content check) if the index entry has been recorded by another git
implementation with lower file time resolution.

Examples:

Git compiled with NO_NSEC writes index entries with nanosecond
fields == 0. A USE_NSEC-enabled git will consider these files dirty
(except in the rare case that on-disk nanoseconds of the file time
are really 0).

JGit writes index entries with mtime nanosecond fields rounded to
milliseconds. Again, a USE_NSEC-enabled git will consider the files
dirty.

JGit writes index entries with ctime seconds and nanoseconds == 0.
All other git implementations will consider such files dirty.


Ideas for potential solutions:
==============================

Performance issues:
-------------------

1. Compare file times in minimum supported precision
   When comparing file times, use the minimum precision supported by
   both the writing and reading git implementations.
1a. Simplest variant: Don't compare nanoseconds if the field in the
   cached index entry is 0. JGit already does this [5], but at the
   same time it is very unfriendly to USE_NSEC-enabled git by storing
   only milliseconds in the nanosecond field. This "simple" solution
   implies that git implementations that cannot provide full
   nanosecond precision must leave the nanosecond field empty.
1b. More involved: Store the precision in the index entry.
   We only need 30 bits to encode nanoseconds, so the high 2 bits of
   the nanosecond field could be used as follows:
   00: second precision (i.e. ignore, for backward compatibility)
   01: millisecond precision
   10: microsecond precision
   11: nanosecond precision
   When reading the index, USE-NSEC-enabled git implementations would
   do dirty checks with the minimum precision supported by themselves
   and the creator of the index entry.


2. Don't use ctime in dirty checks if ctime.sec == 0.


Racy detection:
---------------

3. Minimal racy solution
   * Do all racy checks with second-precision only.
   * When committing an index.lock file, reset mtime to the time
     before git started reading the old index (i.e. time(null) when
     calling read_cache()).

   I believe this should fix all three racy problems described above,
   although restraining ourselves to second-precision somewhat
   thwarts the ability to track nanoseconds in the first place.
   
   The problem with this solution is that files changed by git itself
   will appear racy to the next git process, thus increasing the
   performance penalty after e.g. a large checkout. Although I think
   that re-reading the file after the file's mtime is the only way to
   be really sure it hasn't been changed.


4. More ideas to solve the racy problem
   Conceptually, any changes that happen at the same time or after we
   start capturing information about a file may be missed by the
   recording process. Thus, a "safe" way to use file times for racy /
   dirty checks would be as follows:

     start_capture = filesystem(file).now()
     oid = read_sha1(file)
     mtime1 = lstat(file).mtime
     racy = mtime1 >= start_capture
     ...
     mtime2 = lstat(file).mtime
     check_content = mtime1 != mtime2 || racy

   Whereas Git currently does something like this:

     mtime1 = lstat(file).mtime
     oid = read_sha1(file)
     ...
     end_capture = lstat(index).mtime
     mtime2 = lstat(file).mtime
     check_content = mtime1 != mtime2 || mtime1 >= end_capture   

   One problem with this is that end_capture is only known after
   closing the index file, which is why currently, racy checks can
   only be done by the next git process that reads the index.

   Additionally, rewriting the index file changes its mtime and thus
   deprives subsequent git processes from doing racy checks. This is
   currently solved by squashing the size field of racy entries.
   Which means that a third git process needs to fill the size back
   in, rewriting the index again...

   I suspect that we could get away with fewer index rewrites if we
   did racy checks in the git process that initially updates the
   index entry. I.e.:
    * get start_capture from index.lock immediately after creating it
      (this ignores that index.lock may be on another file system
      with different file time precision than the work tree)
    * do racy checks immediately and store the results in the entry
    * to accommodate different file time precisions, the racy "flag"
      could indicate at which file time precision the entry would
      have to be considered racy. E.g.
        if (mtime1.sec < start_capture.sec)
          return NOT_RACY;
	else if (mtime1.sec > start_capture.sec || 
                 mtime1.nsec >= start_capture.nsec)
          return ALWAYS_RACY;
        else if (mtime1.nsec / 1000 == start_capture.nsec / 1000)
          return RACY_AT_USEC_MSEC_SEC;
        else if (mitme1.nsec / 1000000 == start_capture.nsec / 1000000)
          return RACY_AT_MSEC_SEC;
        else
          return RACY_AT_SEC;
    * for backward compatibility, we could still squash the size and
      store the original size + racy info in an index extension - on
      the other hand, reliable change detection is so fundamental to
      an SCM that we may want to keep racy info in the core index
      entry structure, probably even if it means a format change

   An advantage of this would be that when rewriting the index, git
   is no longer required to treat racy entries in any special way -
   if the git command is not interested in the racy entry, it can
   simply copy it to the next index file, without checking file
   content or squashing the size field. Commands like git status
   would only need to rewrite the index if the racy info changes
   (i.e. enough time has passed).


Please let me know what you think of this...maybe I've completely
screwed up and can no longer see the forest for all the trees.

TIA,
Karsten
