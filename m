From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/16] Introduce a tempfile module
Date: Mon, 10 Aug 2015 11:47:35 +0200
Message-ID: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjgY-0001oa-3a
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbbHJJr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:47:58 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47155 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751523AbbHJJr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:47:57 -0400
X-AuditID: 12074411-f797e6d000007df3-7c-55c8734c5d4d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.D6.32243.C4378C55; Mon, 10 Aug 2015 05:47:56 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswo021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:47:55 -0400
X-Mailer: git-send-email 2.5.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqOtTfCLU4M8uPYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGYevrmIt
	+ClX8fzADMYGxlliXYycHBICJhKPT3xigbDFJC7cW8/WxcjFISRwmVHicH8PK4Rzgkli16dP
	zCBVbAK6Eot6mplAbBEBNYmJbYfAupkF0iVOLGgHs4UFTCX2bJ7PCGKzCKhK/OnuZAexeQXM
	Jf4tXAgU5wDaJiex4EL6BEbuBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNK
	NzFCwkFwB+OMk3KHGAU4GJV4eGdsPh4qxJpYVlyZe4hRkoNJSZTXIv9EqBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3vgMoBxvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoND
	SYL3XiFQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo0OOLgaEOkuIB2mtXBLK3
	uCAxFygK0XqKUVFKnPcPyFwBkERGaR7cWFiUv2IUB/pSmHcPSBUPMEHAdb8CGswEMjgQbHBJ
	IkJKqoHR4Pv+1pzK+5fdtjBMNVVMtPPela/7buXOJ2EGO/8X/ct++vL+IYcNm6a3JpVMX/LS
	oiNmDd/XWIPGW4EXPduvLH5n/yrnabdo0LOJu6uVS2OqVb4FKh4tvLaCUSFh8q8rf8IEhC2m
	TjxT8+Y6t0Hxt6Z8zuA2kYIt/ib2FT8z7X5kRT+XmTNLiaU4I9FQi7moOBEAZpvy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275587>

This is a re-roll of the tempfile patch series [1]. I'm sorry for the
long delay getting v2 out. Thanks to Junio and Johannes Sixt for their
feedback about v1. I think I have addressed all of their points.

This version is very similar to v1 in spirit, though quite a few
details have changed. The main difference is that I add some more
wrapper functions for both lockfile and tempfile (a) to add some
abstraction and (b) so that users of the former don't need to know
that it is based on the latter:

* Add new lockfile wrappers around the corresponding tempfile
  functions:

  * lockfile:
    * fdopen_lock_file()
    * close_lock_file()
    * reopen_lock_file()

* Add accessors:

  * lockfile:
    * get_lock_file_path()
    * get_lock_file_fd()
    * get_lock_file_fp()

  * tempfile:
    * is_tempfile_active()
    * get_tempfile_path()
    * get_tempfile_fd()
    * get_tempfile_fp()

Other changes in this version:

* Make some trivial wrapper functions inline.

* Change create_bundle() to dup() the file descriptor that it passes
  to write_pack_data() so that it doesn't have to tinker with
  lock->tempfile.fd to prevent the file from being closed twice.

* Move some docs about the implementation from tempfile.h to
  tempfile.c.

* Rename register_tempfile_object() to prepare_tempfile_object() to
  reduce confusion with register_tempfile(). Remove its "path"
  parameter and add a docstring.

* Simplify some `die("BUG:...")` error messages.

This series applies to the same commit as v1, namely
v2.4.3-368-g7974889. There is one small conflict when merging to
master or next or (pu minus gitster/mh/tempfile).

This patch series is also available from my GitHub fork [2] as branch
"tempfile".

[1] http://thread.gmane.org/gmane.comp.version-control.git/270998
[2] https://github.com/mhagger/git

Michael Haggerty (16):
  Move lockfile documentation to lockfile.h and lockfile.c
  create_bundle(): duplicate file descriptor to avoid closing it twice
  lockfile: add accessors get_lock_file_fd() and get_lock_file_fp()
  lockfile: add accessor get_lock_file_path()
  commit_lock_file(): use get_locked_file_path()
  tempfile: a new module for handling temporary files
  prepare_tempfile_object(): new function, extracted from
    create_tempfile()
  tempfile: add several functions for creating temporary files
  register_tempfile(): new function to handle an existing temporary file
  write_shared_index(): use tempfile module
  setup_temporary_shallow(): use tempfile module
  diff: use tempfile module
  lock_repo_for_gc(): compute the path to "gc.pid" only once
  gc: use tempfile module to handle gc.pid file
  credential-cache--daemon: delete socket from main()
  credential-cache--daemon: use tempfile module

 Documentation/technical/api-lockfile.txt | 220 --------------------
 Makefile                                 |   1 +
 builtin/commit.c                         |  15 +-
 builtin/gc.c                             |  32 +--
 bundle.c                                 |  26 ++-
 config.c                                 |  14 +-
 credential-cache--daemon.c               |  25 +--
 credential-store.c                       |   2 +-
 diff.c                                   |  29 +--
 lockfile.c                               | 205 +++----------------
 lockfile.h                               | 336 +++++++++++++++++++++++++------
 read-cache.c                             |  40 +---
 refs.c                                   |  18 +-
 shallow.c                                |  41 +---
 tempfile.c                               | 305 ++++++++++++++++++++++++++++
 tempfile.h                               | 271 +++++++++++++++++++++++++
 16 files changed, 951 insertions(+), 629 deletions(-)
 delete mode 100644 Documentation/technical/api-lockfile.txt
 create mode 100644 tempfile.c
 create mode 100644 tempfile.h

-- 
2.5.0
