From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4 v2] fetch-pack: Finish negotation if remote replies "ACK %s ready"
Date: Mon, 14 Mar 2011 17:59:37 -0700
Message-ID: <1300150780-7487-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 01:59:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzIc3-0003Mb-3L
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 01:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab1COA7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 20:59:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47557 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab1COA7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 20:59:44 -0400
Received: by gwaa18 with SMTP id a18so34710gwa.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 17:59:43 -0700 (PDT)
Received: by 10.150.148.21 with SMTP id v21mr6599009ybd.354.1300150783216;
        Mon, 14 Mar 2011 17:59:43 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id q29sm5805316yba.14.2011.03.14.17.59.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 17:59:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.35.ga52fb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169038>

If multi_ack_detailed was selected in the protocol capabilities
(both client and server are >= Git 1.6.6) the upload-pack side will
send "ACK %s ready" when it knows how to safely cut the graph and
produce a reasonable pack for the want list that was already sent
on the connection.

Upon receiving "ACK %s ready" there is no point in looking at
the remaining commits inside of rev_list.  Sending additional
"have %s" lines to the remote will not construct a smaller pack.
It is unlikely a commit older than the current cut point will have
a better delta base than the cut point itself has.

The original design of this code had fetch-pack empty rev_list by
marking a commit and its transitive ancestors COMMON whenever the
remote side said "ACK %s {continue,common}" and skipping over any
already COMMON commits during get_rev().  This approach does not
work when most of rev_list is actually COMMON_REF, commits that
are pointed to by a reference on the remote, which exist locally,
and which have not yet been sent to the remote as a "have %s" line.

Most of the common references are tags in the ref/tags namespace,
using points in the commit graph that are more than 1 commit apart.
In git.git itself, this is currently 340 tags, 339 of which point to
commits in the commit graph.  fetch-pack pushes all of these into
rev_list, but is unable to mark them COMMON and discard during a
remote's "ACK %s {continue,common}" because it does not parse through
the entire parent chain.  Not parsing the entire parent chain is
an optimization to avoid walking back to the roots of the repository.

Assuming the client is only following the remote (and does not make
its own local commits), the client needs 11 rounds to spin through
the entire list of tags (32 commits per round, ceil(339/32) == 11).
Unfortunately the server knows on the first "have %s" line that
it can produce a good pack, and does not need to see the remaining
320 tags in the other 10 rounds.

Over git:// and ssh:// this isn't as bad as it sounds, the client is
only transmitting an extra 16,000 bytes that it doesn't need to send.

Over smart HTTP, the client must do an additional 10 HTTP POST
requests, each of which incurs round-trip latency, and must upload
the entire state vector of all known common objects.  On the final
POST request, this is 16 KiB worth of data.

Fix all of this by clearing rev_list as soon as the remote side
says it can construct a pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Fixed bad indentation that appeared in v1.

 builtin/fetch-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b999413..5173dc9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -379,6 +379,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 					retval = 0;
 					in_vain = 0;
 					got_continue = 1;
+					if (ack == ACK_ready)
+						rev_list = NULL;
 					break;
 					}
 				}
-- 
1.7.4.1.35.ga52fb.dirty
