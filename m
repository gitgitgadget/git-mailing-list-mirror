From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Wed, 30 Mar 2011 20:37:57 -0500
Message-ID: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56q3-0003MT-Cr
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834Ab1CaBiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933810Ab1CaBiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:06 -0400
Received: by iwn34 with SMTP id 34so1864765iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=qQK06UF5EeAILWSSvOvX7hNz6mxKFWJ6/5nTmIiC7aA=;
        b=SApyOKyAbrMl34cVnhFJhcg+8LoIVc6DgFpy1SWjaXHHPpf/VnIosvl1A3AS0DqfRq
         ipzHxRCeksDrkrJuEzgZ5Wk5KeN1W6qegGDuxKTGA88KMsTSBpMPHRsg9qtfNuQxeqAe
         OphCUbeWaNXXD+ZoHq3tMmPg8R6UThR7PIcto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NqssuSJ1KTu/b5B9NW63irulXUt1sl0/FEf9ZaeMGJIa9Iu7Kc0fyLAPh4tMPGZCxu
         nM97TqCGptm/p8MiyuHYEdiq4Vd+IuKIQppBk0tDYjs5KnYTSvbzBZ3+IixRrfAgDqxs
         nI9Nmkn4eMwsRcMOtXDD//LXt2jqOT2TkTOno=
Received: by 10.43.47.134 with SMTP id us6mr2134417icb.152.1301535485664;
        Wed, 30 Mar 2011 18:38:05 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id he40sm379584ibb.67.2011.03.30.18.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170441>

This was seen to happen in some invocations of git-log with a filtered
path. Only do it if we are not recursively descending, as otherwise we
mess with copy and rename detection in full tree moves.

We need to exclude times when FIND_COPIES_HARDER is enabled as the diff
machinery requires traversal of all files in this case to find copies
from files that did not change at all in the given revision.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

These next few patches are all derived from trying to make operations on this
repository a bit faster:
    http://projects.archlinux.org/svntogit/packages.git/

As far as a different shape of repository, this one qualifies. Some stats from
after running `git gc --prune` and looking at things from count-objects among
others:

                    arch-packages   linux-2.6
in-pack:                   496718     1979274
size-pack:                 112582      513977
ls | wc -l:                  2401          34
ls-tree -r | wc -l          14039       36706
ls-tree -r -t | grep ' tree ' | wc -l
                            11211        2256
time git log -- zzzzz_not_exist >/dev/null
                          35.558s      0.976s

I didn't find some golden switch to turn that made things instantly fast, but
these patches did at least give some speedups. Suggestions/feedback/etc.
welcome. Most profiling was done with `valgrind --tool=callgrind` and then
using kcachegrind to chase down slow spots.

 tree-diff.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 76f83fc..ab90f1a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -286,6 +286,9 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	unsigned long size1, size2;
 	int retval;
 
+	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(old, new))
+		return 0;
+
 	tree1 = read_object_with_reference(old, tree_type, &size1, NULL);
 	if (!tree1)
 		die("unable to read source tree (%s)", sha1_to_hex(old));
-- 
1.7.4.2
