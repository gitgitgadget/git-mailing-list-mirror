From: thomas <trast@student.ethz.ch>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 16:53:27 +0100
Message-ID: <87boa47saw.fsf@linux-k42r.v.cablecom.net>
References: <51531059.8000407@atechmedia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Charlie Smurthwaite <charlie@atechmedia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsfm-0005Rq-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab3C0Pxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:53:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46395 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab3C0Pxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:53:30 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 16:53:23 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 27 Mar 2013 16:53:27 +0100
In-Reply-To: <51531059.8000407@atechmedia.com> (Charlie Smurthwaite's message
	of "Wed, 27 Mar 2013 15:29:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219260>

Charlie Smurthwaite <charlie@atechmedia.com> writes:

> I am experiencing a segmentation fault in various versions of Git using
> different repositories. Specifically, I have reproduced it using a
> public repo and the latest stable Git version. Other repos trigger the
> error on different versions.
>
> Full info can be found below. Thanks,
>
> Charlie
>
>
> Test repository:
> https://github.com/atech/mail
>
> Test Command
> git merge-tree 26bb22a052fef9f74063afd4fc6fc11fe200b19f
> 8d6bdf012941d876b2279994e02f1bb0d5c26e7d
> d5ef97ac407d945f231cd7c8fb1cfe48b3a12083

I happened to walk past on IRC and found I could easily reproduce it, so
I bisected:

  35ffe7583108ab236dcf81226690388491d9962f is the first bad commit
  commit 35ffe7583108ab236dcf81226690388491d9962f
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Thu Dec 13 15:51:29 2012 -0800

      merge-tree: fix d/f conflicts
      
      The previous commit documented two known breakages revolving around
      a case where one side flips a tree into a blob (or vice versa),
      where the original code simply gets confused and feeds a mixture of
      trees and blobs into either the recursive merge-tree (and recursing
      into the blob will fail) or three-way merge (and merging tree contents
      together with blobs will fail).
      
      Fix it by feeding trees (and only trees) into the recursive
      merge-tree machinery and blobs (and only blobs) into the three-way
      content level merge machinery separately; when this happens, the
      entire merge has to be marked as conflicting at the structure level.
      
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

It seems to be a vanilla null dereference:

  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000453bf9 in add_merge_entry (entry=0x0) at builtin/merge-tree.c:24
  24              *merge_result_end = entry;
  (gdb) bt
  #0  0x0000000000453bf9 in add_merge_entry (entry=0x0) at builtin/merge-tree.c:24
  #1  0x00000000004545f4 in unresolved (info=0x7fffffffce90, n=0x7ff7f0) at builtin/merge-tree.c:265
  #2  0x0000000000454741 in threeway_callback (n=3, mask=7, dirmask=7, entry=0x7ff7f0, 
      info=0x7fffffffce90) at builtin/merge-tree.c:330
  #3  0x00000000005233f3 in traverse_trees (n=3, t=0x7fffffffcf10, info=0x7fffffffce90)
      at tree-walk.c:407
  #4  0x0000000000454792 in merge_trees_recursive (t=0x7fffffffcf10, base=0x800530 "lib/mail", 
      df_conflict=1) at builtin/merge-tree.c:341
  #5  0x0000000000454382 in unresolved_directory (info=0x7fffffffd120, n=0x800420, df_conflict=1)
      at builtin/merge-tree.c:216
  #6  0x0000000000454507 in unresolved (info=0x7fffffffd120, n=0x800420) at builtin/merge-tree.c:253
  #7  0x0000000000454741 in threeway_callback (n=3, mask=7, dirmask=7, entry=0x800420, 
      info=0x7fffffffd120) at builtin/merge-tree.c:330
  #8  0x00000000005233f3 in traverse_trees (n=3, t=0x7fffffffd1a0, info=0x7fffffffd120)
      at tree-walk.c:407
  #9  0x0000000000454792 in merge_trees_recursive (t=0x7fffffffd1a0, base=0x7fd170 "lib", df_conflict=1)
      at builtin/merge-tree.c:341
  #10 0x0000000000454382 in unresolved_directory (info=0x7fffffffd3b0, n=0x8069f0, df_conflict=1)
      at builtin/merge-tree.c:216
  #11 0x0000000000454507 in unresolved (info=0x7fffffffd3b0, n=0x8069f0) at builtin/merge-tree.c:253
  #12 0x0000000000454741 in threeway_callback (n=3, mask=7, dirmask=7, entry=0x8069f0, 
      info=0x7fffffffd3b0) at builtin/merge-tree.c:330
  #13 0x00000000005233f3 in traverse_trees (n=3, t=0x7fffffffd450, info=0x7fffffffd3b0)
      at tree-walk.c:407
  #14 0x0000000000454792 in merge_trees_recursive (t=0x7fffffffd450, base=0x5510fc "", df_conflict=0)
      at builtin/merge-tree.c:341
  #15 0x00000000004547bc in merge_trees (t=0x7fffffffd450, base=0x5510fc "") at builtin/merge-tree.c:346
  #16 0x00000000004548ef in cmd_merge_tree (argc=4, argv=0x7fffffffd728, prefix=0x0)
      at builtin/merge-tree.c:373
  #17 0x00000000004056ec in run_builtin (p=0x7a1c88 <commands.20888+1416>, argc=4, argv=0x7fffffffd728)
      at git.c:273
  #18 0x000000000040587f in handle_internal_command (argc=4, argv=0x7fffffffd728) at git.c:434
  #19 0x0000000000405a4b in main (argc=4, argv=0x7fffffffd728) at git.c:523

Unfortunately I'm not familiar with the merge code, but if you can't
reproduce at your end let me know.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
