From: Michel Lespinasse <walken@zoy.org>
Subject: proposal: delta based git archival
Date: Fri, 22 Apr 2005 02:03:41 -0700
Message-ID: <20050422090341.GC22479@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 22 11:00:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOu0V-0000hP-VZ
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 10:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVDVJDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 05:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVDVJDy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 05:03:54 -0400
Received: from netblock-66-245-252-131.dslextreme.com ([66.245.252.131]:39392
	"EHLO Angel.zoy.org") by vger.kernel.org with ESMTP id S261996AbVDVJDm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 05:03:42 -0400
Received: from Angel.zoy.org (localhost [127.0.0.1])
	by Angel.zoy.org (Postfix) with ESMTP id 1845E5F837
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 02:03:42 -0700 (PDT)
Received: by Angel.zoy.org (Postfix, from userid 1000)
	id 081465F836; Fri, 22 Apr 2005 02:03:42 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I noticed people on this mailing list start talking about using blob deltas
for compression, and the basic issue that the resulting files are too small
for efficient filesystem storage. I thought about this a little and decided
I should send out my ideas for discussion.

In my proposal, the current git object storage model (one compressed object
per file) remains as the primary storage mechanism, however there would be
some kind of backup mechanism based on multiple deltas grouped in one file.

For example, suppose you're looking for an object with a hash of
eab75ce51622aa312bb0b03572d43769f420c347

First you'd look at .git/objects/ea/b75ce51622aa312bb0b03572d43769f420c347 -
if the file exists, that's your object.

If the file does not exist, you'd then look for .git/deltas/ea/b,
.git/deltas/ea/b7, .git/deltas/ea/b75, .git/deltas/ea/b75c, ...
up to some maximum search path lenght. You stop at the first file you can
find.

Supposing that file is .git/deltas/ea/b7, it would contain a diff
(let's assume unified format for now, though ideally it'd be better to
have something that allows binary file deltas too) of many archived
objects with hashes starting with eab7, compared to a different object
(presumably some direct or indirect ancestor):

diff -u 8f5ba0203e31204c5c052d995a5b4449226bcfb5 eab75ce51622aa312bb0b03572d43769f420c347
--- 8f5ba0203e31204c5c052d995a5b4449226bcfb5
+++ eab75ce51622aa312bb0b03572d43769f420c347
@@ -522,7 +522,7 @@
....
diff -u 77dc2cb94930017f62b55b9706cbadda8c90f650 eab71c51dbc62797d6c903203de44cc6a734c05c
--- 77dc2cb94930017f62b55b9706cbadda8c90f650
+++ eab71c51dbc62797d6c903203de44cc6a734c05c
@@ -560,13 +563,17 @@
...

Based on this delta file, we'd then look for the object
8f5ba0203e31204c5c052d995a5b4449226bcfb5 (this process could require
recursively rebuilding that object) and try to build
eab75ce51622aa312bb0b03572d43769f420c347 by applying the delta and then
double checking the hash.

To me the strenghts of this proposal would be:
* It does not muddy the git object model - it just acts independently of it,
  as a way to rebuild git objects from deltas
* Old objects can be compressed by creating a delta with a close ancestor,
  then erasing the original file storage for that object. The object delta
  can be appended to an existing delta file (which avoids the small-file
  storage issue), or if the delta file gets too big, it can be split off
  into 16 smaller files based on the hashes of the objects this file stores
  deltas for.
* The system is flexible enough to explore different delta
  strategies. For example one could decide to keep one object every 10
  in the database and store other 9 as deltas based on the immediate
  object ancestor, or any other tradeoff - and the system would still
  work the same (with different performance tradeoffs though).

Does this sound insane ? Too complicated maybe ?

Is there any kind of semi-standard binary-capable multiple-file diff format
that could be used for this application instead of unified diffs ?

-- 
Michel "Walken" Lespinasse
"Bill Gates is a monocle and a Persian cat away from being the villain
in a James Bond movie." -- Dennis Miller
