From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/14] Introduce a tempfile module
Date: Mon,  8 Jun 2015 11:07:31 +0200
Message-ID: <cover.1433751986.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2G-0002HN-SD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbbFHJH4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 05:07:56 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45959 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054AbbFHJHy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:07:54 -0400
X-AuditID: 12074411-f796c6d000000bc9-d2-55755b68f2a8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 00.DB.03017.86B55755; Mon,  8 Jun 2015 05:07:52 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojO010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:51 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1M2ILg01ePzE1KLrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdsfvfSaaC
	fuOKEz+0Gxh/yHcxcnJICJhIHJp/mQ3CFpO4cG89kM3FISRwmVHi6esXzBDOCSaJox96WUCq
	2AR0JRb1NDOB2CICjhInHlxnBbGZBRwkNn9uZASxhQWMJK5ufQJUz8HBIqAq8X5DGUiYV8Bc
	YkXLByaIZXIS54//ZIaIC0qcnAlRziygLrF+nhDERHmJ5q2zmScw8s1CUjULoWoWkqoFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUICU3AH44yTcocYBTgYlXh4Dywq
	CRViTSwrrsw9xCjJwaQkyvsxojRUiC8pP6UyI7E4I76oNCe1+BCjBAezkggvkwVQjjclsbIq
	tSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwWseBdQoWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4q5+GJg1IGkeID2NoC08xYXJOYCRSFaTzHqcvy41LiYSYglLz8v
	VUqc91skUJEASFFGaR7cClgaesUoDvSxMK8NyCgeYAqDm/QKaAkT0JLvX4tBlpQkIqSkGhjT
	Aj73hts8nPvksQHTqvZiocvaMwWj7G82PJXZV3p2gdOOXz9r+Oy3cLh6e8fP2K9hvGnBux/b
	yhqWO3jsZcs+e11qfvetAxy9S8PjduTdZ/TLl0i5JMv54v/a3xY5i2Wfruh5dMxC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270998>

We have spent a lot of effort defining the state diagram for lockfiles
and ensuring correct, race-resistant cleanup in all circumstances. Now
let's abstract out part of the lockfile module so that it can be used
to clean up arbitrary temporary files.

This patch series

* implements a new "tempfile" module

* re-implements the "lockfile" module on top of tempfile

* changes a number of places in the code that manage temporary files
  to use the new module.

This project was suggested by Peff as a 2014 GSoC project [1], but
nobody took it up. It was not suggested again as a project for GSoC
2015.

There are still a number of other call sites that could be rewritten
to use the new module. But I think it's better to get the new module
out there and rewrite the other call sites as time allows rather than
for me to keep sitting on these patches in the naive hope that I will
get around to rewriting all possible users.

Patch 06/14 adds a number of mkstemp()-like functions that work with
tempfile objects rather than just returning paths. Since wrapper.c
already contains many variants of mkstemp()-like functions, the new
module does as well. These functions basically have four switches that
can be turned on/off independently:

* Can the caller specify the file mode of the new file?

* Does the filename template include a suffix?

* Does the filename template include the full path to the file, or is
  the file created in a temporary directory?

* Does the function die on failure?

Hopefully the new module will be easier to use, not only because it
takes care of cleaning the temporary file up automatically, but also
because its functions are named more systematically. The following
table might help people trying to make sense of things:

| wrapper function  | die? | location | suffix? | mode? | tempfile func=
tion |
| ----------------- | ---- | -------- | ------- | ----- | -------------=
---- |
| mkstemp           |      |          |         |       | mks_tempfile =
     |
| git_mkstemp_mode  |      |          |         | yes   | mks_tempfile_=
m    |
| mkstemps          |      |          | yes     |       | mks_tempfile_=
s    |
| gitmkstemps (=E2=80=A0)   |      |          | yes     |       | mks_t=
empfile_s    |
| git_mkstemps_mode |      |          | yes     | yes   | mks_tempfile_=
sm   |
| git_mkstemp       |      | $TMPDIR  |         |       | mks_tempfile_=
t    |
| N/A               |      | $TMPDIR  |         | yes   | mks_tempfile_=
tm   |
| git_mkstemps      |      | $TMPDIR  | yes     |       | mks_tempfile_=
ts   |
| N/A               |      | $TMPDIR  | yes     | yes   | mks_tempfile_=
tsm  |
| xmkstemp          | yes  |          |         |       | xmks_tempfile=
     |
| xmkstemp_mode     | yes  |          |         | yes   | xmks_tempfile=
_m   |

If the large number of new functions is too intimidating (even though
most of the functions are inline), it would be possible to decrease
the number. For example, we could add a "flags" argument that covers
"location" and "die?". We could also get rid of the no-suffix
variants, requiring all callers to use the suffix variant, setting
suffixlen to 0 if no suffix is desired.

These patches are also available from my GitHub repo [2], branch
"tempfile".

[1] http://git.github.io/SoC-2014-Ideas.html
[2] https://github.com/mhagger/git

Michael Haggerty (14):
  Move lockfile API documentation to lockfile.h
  tempfile: a new module for handling temporary files
  lockfile: remove some redundant functions
  commit_lock_file(): use get_locked_file_path()
  register_tempfile_object(): new function, extracted from
    create_tempfile()
  tempfile: add several functions for creating temporary files
  register_tempfile(): new function to handle an existing temporary fil=
e
  write_shared_index(): use tempfile module
  setup_temporary_shallow(): use tempfile module
  diff: use tempfile module
  lock_repo_for_gc(): compute the path to "gc.pid" only once
  gc: use tempfile module to handle gc.pid file
  credential-cache--daemon: delete socket from main()
  credential-cache--daemon: use tempfile module

 Documentation/technical/api-lockfile.txt | 220 ----------------------
 Makefile                                 |   1 +
 builtin/add.c                            |   1 +
 builtin/apply.c                          |   1 +
 builtin/checkout-index.c                 |   1 +
 builtin/checkout.c                       |   1 +
 builtin/clone.c                          |   1 +
 builtin/commit.c                         |  15 +-
 builtin/describe.c                       |   1 +
 builtin/diff.c                           |   1 +
 builtin/gc.c                             |  32 +---
 builtin/merge.c                          |   1 +
 builtin/mv.c                             |   1 +
 builtin/read-tree.c                      |   1 +
 builtin/receive-pack.c                   |   1 +
 builtin/reflog.c                         |   1 +
 builtin/reset.c                          |   1 +
 builtin/rm.c                             |   1 +
 builtin/update-index.c                   |   1 +
 bundle.c                                 |   3 +-
 cache-tree.c                             |   1 +
 config.c                                 |  15 +-
 credential-cache--daemon.c               |  25 +--
 credential-store.c                       |   3 +-
 diff.c                                   |  29 +--
 fast-import.c                            |   3 +-
 fetch-pack.c                             |   1 +
 lockfile.c                               | 198 +++-----------------
 lockfile.h                               | 260 +++++++++++++++++++----=
---
 merge-recursive.c                        |   1 +
 merge.c                                  |   1 +
 read-cache.c                             |  42 +----
 refs.c                                   |  23 +--
 rerere.c                                 |   1 +
 sequencer.c                              |   1 +
 sha1_file.c                              |   1 +
 shallow.c                                |  41 +---
 tempfile.c                               | 231 +++++++++++++++++++++++
 tempfile.h                               | 310 +++++++++++++++++++++++=
++++++++
 test-scrap-cache-tree.c                  |   1 +
 40 files changed, 857 insertions(+), 617 deletions(-)
 delete mode 100644 Documentation/technical/api-lockfile.txt
 create mode 100644 tempfile.c
 create mode 100644 tempfile.h

--=20
2.1.4
