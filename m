From: David Kastrup <dak@gnu.org>
Subject: [PATCH 0/5] git-blame: further performance preview
Date: Mon,  3 Feb 2014 20:14:04 +0100
Message-ID: <1391454849-26558-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 20:14:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAOyM-0008GR-2a
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbaBCTOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:14:18 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:57345 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbaBCTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:14:17 -0500
Received: from localhost ([127.0.0.1]:56388 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAOyG-0007Fr-6E; Mon, 03 Feb 2014 14:14:16 -0500
Received: by lola (Postfix, from userid 1000)
	id CF2D9E09B1; Mon,  3 Feb 2014 20:14:15 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241448>

Ok, I'm progressing rather like molasses with getting -M and -C
options back to work.  In the mean time, here is another performance
preview without them.  The main patch in the middle has basically
gotten some formatting/style fixes as opposed to last time round and
one small bug fix (concerning incremental output).

It still contains a significant amount of dead code: this series is
not supposed to be merged, it's just supposed to be exciting to see
how it performs.

There are two simple performance patches on top of the main patch, the
first of which offers somewhat significant savings in I/O time (which
was quite unaffected by the main rewrite so far).  The gist of that
patch makes convenient use of the changed data layout to avoid
discarding blob data predictably required again right away.

It's likely that this is not the only opportunity to save performance
by better data management.

The second "performance" patch is not likely to measurably affect
overall performance.  Avoiding irrelevant iterations might make
debugging more pleasant, however.

David Kastrup (5):
  builtin/blame.c: struct blame_entry does not need a prev link
  Eliminate same_suspect function in builtin/blame.c
  builtin/blame.c: large-scale rewrite
  Performance improvement: don't drop origin blobs that are going to get
    tested next.
  Avoid queuing commits multiple times for the same origin

 builtin/blame.c | 595 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 371 insertions(+), 224 deletions(-)

-- 
1.8.3.2
