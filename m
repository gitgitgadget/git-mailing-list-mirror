From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/19] nd/struct-pathspec (or pathspec unification [1])
Date: Mon, 13 Dec 2010 16:46:37 +0700
Message-ID: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS50f-0004M7-Gx
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab0LMJrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 04:47:51 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:36304 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab0LMJru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:47:50 -0500
Received: by pxi20 with SMTP id 20so1600185pxi.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=EmK25wTcH4g0Ytyte6IUzk9RhFPC8JJGmE/MuU2eA3c=;
        b=cFK23qkNlz8WeM9ooI1IPhkxpW8QVoADXOxFAUpAeHhYBnrgjlKLL5rbs7ktqF0G5F
         PdWE6uL8pJMuQITiaPdyyju11148StecOU+Z8SzH1VBkOXl73sSr12Owfq0RTYC45iI9
         MGPIGcJjMRFrpbLQXXPB3zD+1R5hl4OJXPwtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jWoJtQQx5mpLSl1+pVEkmQAXc3qQJ7Tot2Ozn9UH1vHEZ/SSVZCyNarR9JevT5djs4
         EqHxbikwgtv/Hys4Wt146g9vjgw3N5xhBdY3B6kn76S7+u9mPjOjcgAILY+3wsJjTUAx
         g4NLipTVFA8MRXqodLekhEpnomnJGgSTf9+tE=
Received: by 10.142.164.9 with SMTP id m9mr3017521wfe.97.1292233670059;
        Mon, 13 Dec 2010 01:47:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id b11sm8676781wff.21.2010.12.13.01.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:47:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:46:57 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163530>

Background:

pathspecs in git can be handled differently in three places

 1. log family uses tree_entry_interesting() and ce_path_match()
 2. most index-related operations use match_pathspec()
 3. grep uses its own pathspec_matches()

Out of three, #3 provides the most advanced functionalities, while #1
has a few good optimizations, but not as powerful as #3. #2 is sort of
trade-off between the other two.

This series brings all the #3 goodness to #1 and #2, then kills #3. I
don't want to kill #2 because it takes a list as input, while #1 takes
trees (ce_path_match() takes list though). There could be different
optmizations based on different input type.

Summary of patches:

  Add struct pathspec
  diff-no-index: use diff_tree_setup_paths()
  pathspec: cache string length when initializing pathspec
  Convert struct diff_options to use struct pathspec
  tree_entry_interesting(): remove dependency on struct diff_options
  Move tree_entry_interesting() to tree-walk.c and export it

This is unchanged from nd/struct-pathspec in pu. There is one patch
from pu replaced later.

  glossary: define pathspec

This is what I am aiming to. If I make mistakes, blame Jonathan
because he mis-specifies it ;-)

  pathspec: mark wildcard pathspecs from the beginning

>From old nd/struct-pathspec, to recognize potential wildcard pathspecs
early.

  tree-diff.c: reserve space in "base" for pathname concatenation

The (probably most) used operation in traversing trees is concatenate
dirname and basename into full path (especially for wildcard matching).
This requires a new buffer every time. This patch ensures that the
caller prepares a writable buffer with dirname already filled. If the
callee wants full path, it does not have to allocate another buffer
(and does shorter memcpy).

This patch is not strictly needed though.

  tree_entry_interesting(): factor out most matching logic

For readibility of the next patches.

  tree_entry_interesting: support depth limit

Goodness from #3.

  tree_entry_interesting(): support wildcard matching
  tree_entry_interesting(): optimize fnmatch when base is matched

This is something t_e_i() lacks for so long. However, in order to make
log family commands work properly, ce_path_match() also needs to learn
wildcards.

This changes tree_entry_interesting() interface, therefore breaks
en/object-list-with-pathspec. I'll send fixes shortly.

  Convert ce_path_match() use to match_pathspec()

So that log family now works with wildcards.

  pathspec: add match_pathspec_depth()

This is new match_pathspec(). I don't want to replace the old one
because it changes more places. But once it works, another patch to
kill match_pathspec() should be easy.

  grep: convert to use struct pathspec
  grep: use match_pathspec_depth() for cache grepping
  grep: use preallocated buffer for grep_tree()
  grep: drop pathspec_matches() in favor of tree_entry_interesting()

grep (especially t7810) is how I test all these. I need to write more
tests to make sure things work. But for now t7810 passes.

Hopefully I did not lose any optimizations in pathspec_matches().

It's time to rebase negative pathspec patches on top and get back to
my narrow clone.

[1] https://git.wiki.kernel.org/index.php/SoC2010Ideas#Unify_Pathspec_Semantics

 Documentation/glossary-content.txt |   23 ++++
 builtin/diff-files.c               |    2 +-
 builtin/diff.c                     |    4 +-
 builtin/grep.c                     |  200 ++++++++---------------------
 builtin/log.c                      |    2 +-
 cache.h                            |   14 ++
 diff-lib.c                         |    2 +-
 diff-no-index.c                    |   13 +-
 diff.h                             |    4 +-
 dir.c                              |   98 ++++++++++++++
 dir.h                              |    4 +
 read-cache.c                       |   20 +---
 revision.c                         |    6 +-
 t/t4010-diff-pathspec.sh           |   14 ++
 tree-diff.c                        |  246 ++++++++----------------------------
 tree-walk.c                        |  186 +++++++++++++++++++++++++++
 tree-walk.h                        |    2 +
 17 files changed, 461 insertions(+), 379 deletions(-)

-- 
1.7.3.3.476.g10a82
