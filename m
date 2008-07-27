From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem using jgit
Date: Sat, 26 Jul 2008 22:21:07 -0500
Message-ID: <20080727032107.GC17425@spearce.org>
References: <p06240809c4a9d887fda4@[192.168.1.106]> <488467E3.7000107@gmail.com> <488482A2.4000601@gmail.com> <20080722165831.GA11173@spearce.org> <4889E88E.8000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Bannasch <stephen.bannasch@deanbrook.org>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 05:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMwpl-0007Dw-Qi
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 05:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbYG0DVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 23:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYG0DVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 23:21:09 -0400
Received: from george.spearce.org ([209.20.77.23]:47277 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYG0DVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 23:21:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 98B39383A5; Sun, 27 Jul 2008 03:21:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4889E88E.8000701@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90302>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Shawn O. Pearce wrote:
>> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>>> 
>>> It's caused by 14a630c3: Cached modification times for symbolic refs too
>>> Changes introduced by this patch made Repository#getAllRefs() 
>>> including  Ref objects with null ObjectId in case of unresolvable 
>>> (invalid?) HEAD  symbolic ref, and null Ref for HEAD  when it doesn't 
>>> exist. Previous  behavior was just not including such refs in result.
>>
>> My intention here was that if a ref cannot be resolved, it should
>> not be reported. [...]
>  
> Beside of my temporary fix for that that filters null Ref and Ref with  
> null objectId, I think that 2 more issues may need to be resolved:

Well, I think your temporary fix is correct.  I don't see another way
to implement around it.

> 1) readRefBasic() method is used for reading arbitrary refs, potentially  
> not only those from well-known prefixes as readRefs() does. Is calling  
> setModified()  appropriate for those other refs?

Yes.  If we read something and it is different from what we have cached
we need to signal that the cached data is invalid (which is setModified).
Doing so allows listeners to (eventually) find out that there are changes
made on disk which their subscribers don't know about, but may need to be
informed of.  This way we can identify changes made by command line tools
to a repository that egit has open in the workbench.

> 2) Am I wrong that setModified() is not called in all cases? Consider  
> empty ref file and just...
> if (line == null || line.length() == 0)
>            return new Ref(Ref.Storage.LOOSE, name, null);
>

In this case (and the other like it) we don't call setModified
because there hasn't been a change on disk.  The file wasn't
previously in our cache and the file is empty now.  Either way
the ref has no data so there is no need to notify listeners.

Now there may be other cases that are missing, but this one
is fine as is.

So I'm thinking of applying this:

--8<--
From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [PATCH] Fix Repository.getAllRefs to skip HEAD if it points to an unborn branch

If HEAD is a symbolic reference pointing to an unborn branch (branch
not yet created) we get a Ref object back for it supplying the name
of the branch, but its ObjectId is null as the branch file itself is
not present in the repository.  In such cases we should not include
the HEAD reference in the returned output.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 82b995e..b9c8c8c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -209,7 +209,9 @@ class RefDatabase {
 		readPackedRefs(avail);
 		readLooseRefs(avail, REFS_SLASH, refsDir);
 		try {
-			avail.put(Constants.HEAD, readRefBasic(Constants.HEAD, 0));
+			final Ref r = readRefBasic(Constants.HEAD, 0);
+			if (r != null && r.getObjectId() != null)
+				avail.put(Constants.HEAD, r);
 		} catch (IOException e) {
 			// ignore here
 		}
-- 
1.6.0.rc0.182.gb96c7


-- 
Shawn.
