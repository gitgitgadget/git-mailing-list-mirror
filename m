From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] build: get rid of the notion of a git library
Date: Sat,  8 Jun 2013 12:29:34 -0500
Message-ID: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 19:31:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMzD-0002ra-QD
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab3FHRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:31:27 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36168 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3FHRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:31:26 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so8148198obc.10
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nvcAkW3nAXh3HShCixAwpPdq9Ta08mcRqWxquhwmv3Q=;
        b=0EpOojIeeGP2pn2ARP8ictmOsItW5CAbmS7jpTvQtKiAipQF+PAVH/BjZdHEQti7fo
         SwkyboDRzs9xdkIPwGlM4f9wpUC4k9I7NT0dKol3n5Zt1ZC8Cx5l8oB2SG9dSLgX1k3k
         fC1ZDrCRafz5SbRZUZR9tky2Z8ICUaWGBCmlco+xgfZix2d7mvijpvJTlz8m1If0JEEA
         kFUxwTTGqyxqByZi5z+klsXZ9Eknq6Z0vwmLp3POeuENHsooc5z9tl1q5OwZV0mKuj8p
         R/a5FX/hhBEFQxTiWs5XTkK2pdGyKwSSp5Gq8LPI3xcFJAyVF2iglibv8K6jdQN50uy5
         7b4g==
X-Received: by 10.182.40.202 with SMTP id z10mr2755221obk.74.1370712685729;
        Sat, 08 Jun 2013 10:31:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kz3sm7121111obb.6.2013.06.08.10.31.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 10:31:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226845>

There's no libgit, and there will never be, every object file in Git is
the same, and there's wish to organize them in any way; they are *all*
for the 'git' binary and its builtin commands.

So let's shatter any hopes of ever having a library, and be clear about
it; both the top-level objects (./*.o) and the builtin objects
(./builtin/*.o) go into git.a, which is not a library, merely a
convenient way to stash objects together.

This way there will not be linking issues when top-level objects try to
access functions of builtin objects.

LIB_OBJS and LIB_H imply a library, but there isn't one, and never will
be; so give them proper names; just a bunch of headers and objects.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 564 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 283 insertions(+), 281 deletions(-)

diff --git a/Makefile b/Makefile
index 03524d0..63451b1 100644
--- a/Makefile
+++ b/Makefile
@@ -435,8 +435,8 @@ XDIFF_OBJS =
 VCSSVN_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
-LIB_H =
-LIB_OBJS =
+HEADERS =
+OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
@@ -629,270 +629,270 @@ endif
 export PERL_PATH
 export PYTHON_PATH
 
-LIB_FILE = libgit.a
+GIT_LIB = git.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
 GENERATED_H += common-cmds.h
 
-LIB_H += advice.h
-LIB_H += archive.h
-LIB_H += argv-array.h
-LIB_H += attr.h
-LIB_H += bisect.h
-LIB_H += blob.h
-LIB_H += branch.h
-LIB_H += builtin.h
-LIB_H += bulk-checkin.h
-LIB_H += bundle.h
-LIB_H += cache-tree.h
-LIB_H += cache.h
-LIB_H += color.h
-LIB_H += column.h
-LIB_H += commit.h
-LIB_H += compat/bswap.h
-LIB_H += compat/cygwin.h
-LIB_H += compat/mingw.h
-LIB_H += compat/obstack.h
-LIB_H += compat/poll/poll.h
-LIB_H += compat/precompose_utf8.h
-LIB_H += compat/terminal.h
-LIB_H += compat/win32/dirent.h
-LIB_H += compat/win32/pthread.h
-LIB_H += compat/win32/syslog.h
-LIB_H += connected.h
-LIB_H += convert.h
-LIB_H += credential.h
-LIB_H += csum-file.h
-LIB_H += decorate.h
-LIB_H += delta.h
-LIB_H += diff.h
-LIB_H += diffcore.h
-LIB_H += dir.h
-LIB_H += exec_cmd.h
-LIB_H += fetch-pack.h
-LIB_H += fmt-merge-msg.h
-LIB_H += fsck.h
-LIB_H += gettext.h
-LIB_H += git-compat-util.h
-LIB_H += gpg-interface.h
-LIB_H += graph.h
-LIB_H += grep.h
-LIB_H += hash.h
-LIB_H += help.h
-LIB_H += http.h
-LIB_H += kwset.h
-LIB_H += levenshtein.h
-LIB_H += line-log.h
-LIB_H += line-range.h
-LIB_H += list-objects.h
-LIB_H += ll-merge.h
-LIB_H += log-tree.h
-LIB_H += mailmap.h
-LIB_H += merge-blobs.h
-LIB_H += merge-recursive.h
-LIB_H += mergesort.h
-LIB_H += notes-cache.h
-LIB_H += notes-merge.h
-LIB_H += notes.h
-LIB_H += object.h
-LIB_H += pack-revindex.h
-LIB_H += pack.h
-LIB_H += parse-options.h
-LIB_H += patch-ids.h
-LIB_H += pathspec.h
-LIB_H += pkt-line.h
-LIB_H += progress.h
-LIB_H += prompt.h
-LIB_H += quote.h
-LIB_H += reachable.h
-LIB_H += reflog-walk.h
-LIB_H += refs.h
-LIB_H += remote.h
-LIB_H += rerere.h
-LIB_H += resolve-undo.h
-LIB_H += revision.h
-LIB_H += run-command.h
-LIB_H += send-pack.h
-LIB_H += sequencer.h
-LIB_H += sha1-array.h
-LIB_H += sha1-lookup.h
-LIB_H += shortlog.h
-LIB_H += sideband.h
-LIB_H += sigchain.h
-LIB_H += strbuf.h
-LIB_H += streaming.h
-LIB_H += string-list.h
-LIB_H += submodule.h
-LIB_H += tag.h
-LIB_H += tar.h
-LIB_H += thread-utils.h
-LIB_H += transport.h
-LIB_H += tree-walk.h
-LIB_H += tree.h
-LIB_H += unpack-trees.h
-LIB_H += url.h
-LIB_H += userdiff.h
-LIB_H += utf8.h
-LIB_H += varint.h
-LIB_H += vcs-svn/fast_export.h
-LIB_H += vcs-svn/line_buffer.h
-LIB_H += vcs-svn/repo_tree.h
-LIB_H += vcs-svn/sliding_window.h
-LIB_H += vcs-svn/svndiff.h
-LIB_H += vcs-svn/svndump.h
-LIB_H += walker.h
-LIB_H += wildmatch.h
-LIB_H += wt-status.h
-LIB_H += xdiff-interface.h
-LIB_H += xdiff/xdiff.h
-LIB_H += xdiff/xdiffi.h
-LIB_H += xdiff/xemit.h
-LIB_H += xdiff/xinclude.h
-LIB_H += xdiff/xmacros.h
-LIB_H += xdiff/xprepare.h
-LIB_H += xdiff/xtypes.h
-LIB_H += xdiff/xutils.h
-
-LIB_OBJS += abspath.o
-LIB_OBJS += advice.o
-LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
-LIB_OBJS += archive.o
-LIB_OBJS += archive-tar.o
-LIB_OBJS += archive-zip.o
-LIB_OBJS += argv-array.o
-LIB_OBJS += attr.o
-LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blob.o
-LIB_OBJS += branch.o
-LIB_OBJS += bulk-checkin.o
-LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
-LIB_OBJS += color.o
-LIB_OBJS += column.o
-LIB_OBJS += combine-diff.o
-LIB_OBJS += commit.o
-LIB_OBJS += compat/obstack.o
-LIB_OBJS += compat/terminal.o
-LIB_OBJS += config.o
-LIB_OBJS += connect.o
-LIB_OBJS += connected.o
-LIB_OBJS += convert.o
-LIB_OBJS += copy.o
-LIB_OBJS += credential.o
-LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
-LIB_OBJS += decorate.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += dir.o
-LIB_OBJS += editor.o
-LIB_OBJS += entry.o
-LIB_OBJS += environment.o
-LIB_OBJS += exec_cmd.o
-LIB_OBJS += fetch-pack.o
-LIB_OBJS += fsck.o
-LIB_OBJS += gettext.o
-LIB_OBJS += gpg-interface.o
-LIB_OBJS += graph.o
-LIB_OBJS += grep.o
-LIB_OBJS += hash.o
-LIB_OBJS += help.o
-LIB_OBJS += hex.o
-LIB_OBJS += ident.o
-LIB_OBJS += kwset.o
-LIB_OBJS += levenshtein.o
-LIB_OBJS += line-log.o
-LIB_OBJS += line-range.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += ll-merge.o
-LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
-LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
-LIB_OBJS += merge.o
-LIB_OBJS += merge-blobs.o
-LIB_OBJS += merge-recursive.o
-LIB_OBJS += mergesort.o
-LIB_OBJS += name-hash.o
-LIB_OBJS += notes.o
-LIB_OBJS += notes-cache.o
-LIB_OBJS += notes-merge.o
-LIB_OBJS += object.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += pager.o
-LIB_OBJS += parse-options.o
-LIB_OBJS += parse-options-cb.o
-LIB_OBJS += patch-delta.o
-LIB_OBJS += patch-ids.o
-LIB_OBJS += path.o
-LIB_OBJS += pathspec.o
-LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
-LIB_OBJS += progress.o
-LIB_OBJS += prompt.o
-LIB_OBJS += quote.o
-LIB_OBJS += reachable.o
-LIB_OBJS += read-cache.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
-LIB_OBJS += remote.o
-LIB_OBJS += replace_object.o
-LIB_OBJS += rerere.o
-LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
-LIB_OBJS += run-command.o
-LIB_OBJS += send-pack.o
-LIB_OBJS += sequencer.o
-LIB_OBJS += server-info.o
-LIB_OBJS += setup.o
-LIB_OBJS += sha1-array.o
-LIB_OBJS += sha1-lookup.o
-LIB_OBJS += sha1_file.o
-LIB_OBJS += sha1_name.o
-LIB_OBJS += shallow.o
-LIB_OBJS += sideband.o
-LIB_OBJS += sigchain.o
-LIB_OBJS += strbuf.o
-LIB_OBJS += streaming.o
-LIB_OBJS += string-list.o
-LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
-LIB_OBJS += trace.o
-LIB_OBJS += transport.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += tree-diff.o
-LIB_OBJS += tree.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += unpack-trees.o
-LIB_OBJS += url.o
-LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
-LIB_OBJS += varint.o
-LIB_OBJS += version.o
-LIB_OBJS += walker.o
-LIB_OBJS += wildmatch.o
-LIB_OBJS += wrapper.o
-LIB_OBJS += write_or_die.o
-LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
+HEADERS += advice.h
+HEADERS += archive.h
+HEADERS += argv-array.h
+HEADERS += attr.h
+HEADERS += bisect.h
+HEADERS += blob.h
+HEADERS += branch.h
+HEADERS += builtin.h
+HEADERS += bulk-checkin.h
+HEADERS += bundle.h
+HEADERS += cache-tree.h
+HEADERS += cache.h
+HEADERS += color.h
+HEADERS += column.h
+HEADERS += commit.h
+HEADERS += compat/bswap.h
+HEADERS += compat/cygwin.h
+HEADERS += compat/mingw.h
+HEADERS += compat/obstack.h
+HEADERS += compat/poll/poll.h
+HEADERS += compat/precompose_utf8.h
+HEADERS += compat/terminal.h
+HEADERS += compat/win32/dirent.h
+HEADERS += compat/win32/pthread.h
+HEADERS += compat/win32/syslog.h
+HEADERS += connected.h
+HEADERS += convert.h
+HEADERS += credential.h
+HEADERS += csum-file.h
+HEADERS += decorate.h
+HEADERS += delta.h
+HEADERS += diff.h
+HEADERS += diffcore.h
+HEADERS += dir.h
+HEADERS += exec_cmd.h
+HEADERS += fetch-pack.h
+HEADERS += fmt-merge-msg.h
+HEADERS += fsck.h
+HEADERS += gettext.h
+HEADERS += git-compat-util.h
+HEADERS += gpg-interface.h
+HEADERS += graph.h
+HEADERS += grep.h
+HEADERS += hash.h
+HEADERS += help.h
+HEADERS += http.h
+HEADERS += kwset.h
+HEADERS += levenshtein.h
+HEADERS += line-log.h
+HEADERS += line-range.h
+HEADERS += list-objects.h
+HEADERS += ll-merge.h
+HEADERS += log-tree.h
+HEADERS += mailmap.h
+HEADERS += merge-blobs.h
+HEADERS += merge-recursive.h
+HEADERS += mergesort.h
+HEADERS += notes-cache.h
+HEADERS += notes-merge.h
+HEADERS += notes.h
+HEADERS += object.h
+HEADERS += pack-revindex.h
+HEADERS += pack.h
+HEADERS += parse-options.h
+HEADERS += patch-ids.h
+HEADERS += pathspec.h
+HEADERS += pkt-line.h
+HEADERS += progress.h
+HEADERS += prompt.h
+HEADERS += quote.h
+HEADERS += reachable.h
+HEADERS += reflog-walk.h
+HEADERS += refs.h
+HEADERS += remote.h
+HEADERS += rerere.h
+HEADERS += resolve-undo.h
+HEADERS += revision.h
+HEADERS += run-command.h
+HEADERS += send-pack.h
+HEADERS += sequencer.h
+HEADERS += sha1-array.h
+HEADERS += sha1-lookup.h
+HEADERS += shortlog.h
+HEADERS += sideband.h
+HEADERS += sigchain.h
+HEADERS += strbuf.h
+HEADERS += streaming.h
+HEADERS += string-list.h
+HEADERS += submodule.h
+HEADERS += tag.h
+HEADERS += tar.h
+HEADERS += thread-utils.h
+HEADERS += transport.h
+HEADERS += tree-walk.h
+HEADERS += tree.h
+HEADERS += unpack-trees.h
+HEADERS += url.h
+HEADERS += userdiff.h
+HEADERS += utf8.h
+HEADERS += varint.h
+HEADERS += vcs-svn/fast_export.h
+HEADERS += vcs-svn/line_buffer.h
+HEADERS += vcs-svn/repo_tree.h
+HEADERS += vcs-svn/sliding_window.h
+HEADERS += vcs-svn/svndiff.h
+HEADERS += vcs-svn/svndump.h
+HEADERS += walker.h
+HEADERS += wildmatch.h
+HEADERS += wt-status.h
+HEADERS += xdiff-interface.h
+HEADERS += xdiff/xdiff.h
+HEADERS += xdiff/xdiffi.h
+HEADERS += xdiff/xemit.h
+HEADERS += xdiff/xinclude.h
+HEADERS += xdiff/xmacros.h
+HEADERS += xdiff/xprepare.h
+HEADERS += xdiff/xtypes.h
+HEADERS += xdiff/xutils.h
+
+OBJS += abspath.o
+OBJS += advice.o
+OBJS += alias.o
+OBJS += alloc.o
+OBJS += archive.o
+OBJS += archive-tar.o
+OBJS += archive-zip.o
+OBJS += argv-array.o
+OBJS += attr.o
+OBJS += base85.o
+OBJS += bisect.o
+OBJS += blob.o
+OBJS += branch.o
+OBJS += bulk-checkin.o
+OBJS += bundle.o
+OBJS += cache-tree.o
+OBJS += color.o
+OBJS += column.o
+OBJS += combine-diff.o
+OBJS += commit.o
+OBJS += compat/obstack.o
+OBJS += compat/terminal.o
+OBJS += config.o
+OBJS += connect.o
+OBJS += connected.o
+OBJS += convert.o
+OBJS += copy.o
+OBJS += credential.o
+OBJS += csum-file.o
+OBJS += ctype.o
+OBJS += date.o
+OBJS += decorate.o
+OBJS += diffcore-break.o
+OBJS += diffcore-delta.o
+OBJS += diffcore-order.o
+OBJS += diffcore-pickaxe.o
+OBJS += diffcore-rename.o
+OBJS += diff-delta.o
+OBJS += diff-lib.o
+OBJS += diff-no-index.o
+OBJS += diff.o
+OBJS += dir.o
+OBJS += editor.o
+OBJS += entry.o
+OBJS += environment.o
+OBJS += exec_cmd.o
+OBJS += fetch-pack.o
+OBJS += fsck.o
+OBJS += gettext.o
+OBJS += gpg-interface.o
+OBJS += graph.o
+OBJS += grep.o
+OBJS += hash.o
+OBJS += help.o
+OBJS += hex.o
+OBJS += ident.o
+OBJS += kwset.o
+OBJS += levenshtein.o
+OBJS += line-log.o
+OBJS += line-range.o
+OBJS += list-objects.o
+OBJS += ll-merge.o
+OBJS += lockfile.o
+OBJS += log-tree.o
+OBJS += mailmap.o
+OBJS += match-trees.o
+OBJS += merge.o
+OBJS += merge-blobs.o
+OBJS += merge-recursive.o
+OBJS += mergesort.o
+OBJS += name-hash.o
+OBJS += notes.o
+OBJS += notes-cache.o
+OBJS += notes-merge.o
+OBJS += object.o
+OBJS += pack-check.o
+OBJS += pack-revindex.o
+OBJS += pack-write.o
+OBJS += pager.o
+OBJS += parse-options.o
+OBJS += parse-options-cb.o
+OBJS += patch-delta.o
+OBJS += patch-ids.o
+OBJS += path.o
+OBJS += pathspec.o
+OBJS += pkt-line.o
+OBJS += preload-index.o
+OBJS += pretty.o
+OBJS += progress.o
+OBJS += prompt.o
+OBJS += quote.o
+OBJS += reachable.o
+OBJS += read-cache.o
+OBJS += reflog-walk.o
+OBJS += refs.o
+OBJS += remote.o
+OBJS += replace_object.o
+OBJS += rerere.o
+OBJS += resolve-undo.o
+OBJS += revision.o
+OBJS += run-command.o
+OBJS += send-pack.o
+OBJS += sequencer.o
+OBJS += server-info.o
+OBJS += setup.o
+OBJS += sha1-array.o
+OBJS += sha1-lookup.o
+OBJS += sha1_file.o
+OBJS += sha1_name.o
+OBJS += shallow.o
+OBJS += sideband.o
+OBJS += sigchain.o
+OBJS += strbuf.o
+OBJS += streaming.o
+OBJS += string-list.o
+OBJS += submodule.o
+OBJS += symlinks.o
+OBJS += tag.o
+OBJS += trace.o
+OBJS += transport.o
+OBJS += transport-helper.o
+OBJS += tree-diff.o
+OBJS += tree.o
+OBJS += tree-walk.o
+OBJS += unpack-trees.o
+OBJS += url.o
+OBJS += usage.o
+OBJS += userdiff.o
+OBJS += utf8.o
+OBJS += varint.o
+OBJS += version.o
+OBJS += walker.o
+OBJS += wildmatch.o
+OBJS += wrapper.o
+OBJS += write_or_die.o
+OBJS += ws.o
+OBJS += wt-status.o
+OBJS += xdiff-interface.o
+OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -990,7 +990,9 @@ BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o
 
-GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
+OBJS += $(BUILTIN_OBJS)
+
+GITLIBS = $(GIT_LIB) $(XDIFF_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -1365,16 +1367,16 @@ else
 endif
 endif
 ifdef NO_INET_NTOP
-	LIB_OBJS += compat/inet_ntop.o
+	OBJS += compat/inet_ntop.o
 	BASIC_CFLAGS += -DNO_INET_NTOP
 endif
 ifdef NO_INET_PTON
-	LIB_OBJS += compat/inet_pton.o
+	OBJS += compat/inet_pton.o
 	BASIC_CFLAGS += -DNO_INET_PTON
 endif
 ifndef NO_UNIX_SOCKETS
-	LIB_OBJS += unix-socket.o
-	LIB_H += unix-socket.h
+	OBJS += unix-socket.o
+	HEADERS += unix-socket.h
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
 endif
@@ -1397,13 +1399,13 @@ endif
 
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
-	LIB_OBJS += block-sha1/sha1.o
-	LIB_H += block-sha1/sha1.h
+	OBJS += block-sha1/sha1.o
+	HEADERS += block-sha1/sha1.h
 else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	LIB_H += ppc/sha1.h
+	OBJS += ppc/sha1.o ppc/sha1ppc.o
+	HEADERS += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
@@ -1442,7 +1444,7 @@ ifdef NO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)
 	EXTLIBS += $(PTHREAD_LIBS)
-	LIB_OBJS += thread-utils.o
+	OBJS += thread-utils.o
 endif
 
 ifdef HAVE_PATHS_H
@@ -1590,7 +1592,7 @@ LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	$(COMPAT_CFLAGS)
-LIB_OBJS += $(COMPAT_OBJS)
+OBJS += $(COMPAT_OBJS)
 
 # Quote for C
 
@@ -1677,7 +1679,7 @@ strip: $(PROGRAMS) git$X
 
 # The generic compilation pattern rule and automatically
 # computed header dependencies (falling back to a dependency on
-# LIB_H) are enough to describe how most targets should be built,
+# HEADERS) are enough to describe how most targets should be built,
 # but some targets are special enough to need something a little
 # different.
 #
@@ -1712,9 +1714,9 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(ALL_LDFLAGS) $(LIBS)
 
 help.sp help.s help.o: common-cmds.h
 
@@ -1892,7 +1894,7 @@ VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
-OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+OBJECTS := $(OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
 	git.o
@@ -1998,7 +2000,7 @@ else
 # should _not_ be included here, since they are necessary even when
 # building an object for the first time.
 
-$(OBJECTS): $(LIB_H)
+$(OBJECTS): $(HEADERS)
 endif
 
 exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
@@ -2066,8 +2068,8 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
+$(GIT_LIB): $(OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(OBJS)
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
@@ -2102,7 +2104,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
-LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
+LOCALIZED_C := $(C_OBJ:o=c) $(HEADERS) $(GENERATED_H)
 LOCALIZED_SH := $(SCRIPT_SH)
 LOCALIZED_PERL := $(SCRIPT_PERL)
 
@@ -2480,7 +2482,7 @@ profile-clean:
 
 clean: profile-clean coverage-clean
 	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+		builtin/*.o $(GIT_LIB) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers $(dep_dirs)
-- 
1.8.3.698.g079b096
