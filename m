From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix recursive-merge of empty files with different
 permissions
Date: Thu, 13 Mar 2008 16:19:35 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803131607030.1656@racer.site>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Mar 13 16:20:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZpE4-0007BA-6t
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 16:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYCMPTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 11:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbYCMPTa
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 11:19:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:53187 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752447AbYCMPT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 11:19:29 -0400
Received: (qmail invoked by alias); 13 Mar 2008 15:19:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 13 Mar 2008 16:19:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MzAVRKumMsKKGDyeCpPqS88Hua4l1x7MIf8qmmH
	x91MRX8Jj43dtx
X-X-Sender: gene099@racer.site
In-Reply-To: <20080313125229.GA24758@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77095>

Hi,

[Junio, there is a bugfix at the end of this mail.]

On Thu, 13 Mar 2008, Clemens Buchacher wrote:

> Hi,
> 
> On Sat, Mar 08, 2008 at 06:17:26PM +0100, Clemens Buchacher wrote:
> > If git-merge-recursive attempts to merge two empty new files with 
> > different executable flags, eventually xdl_merge() is called and 
> > produces empty diffs for both files and therefore does not choose 
> > either file as successor. Make xdl_merge() choose one of the files 
> > instead.
> 
> On Sat, Mar 08, 2008 at 06:51:48PM +0100, Johannes Schindelin wrote:
> > On Sat, 8 Mar 2008, Clemens Buchacher wrote:
> > > I do not understand why, but this does not happen if the file 
> > > permissions are the same.
> > 
> > I think this is the biggest problem.
> > 
> > >  t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
> > >  xdiff/xmerge.c             |   30 ++++++++++++++----------------
> > 
> > ... because xdiff/xmerge.c is definitely the wrong place to "fix" this 
> > issue.  xdl_merge() does not even _know_ about permissions.
> 
> After analyzing the problem in greater detail, I have to disagree. It is 
> true, of course, that xdl_merge() does not and should not know about 
> permissions at all. However, the bug is still in xdl_merge(). Different 
> permissions are only the trigger of the problem, because only then will 
> xdl_merge() be called at all.
> 
> What happens is this. Before looking at the file contents directly 
> merge_trees() attempts to resolve the merge trivially. If both sha1 and 
> mode of the head and remote entries match, the merge will be resolved as 
> per case #5ALT (see Documentation/trivial-merge.txt), i.e. head is 
> chosen as the merge result.
> 
> If either sha1 _or_ mode differ between the head and remote entries, 
> however, merge_trees() will use xdl_merge() to merge the file content 
> and the remote entry's mode will be chosen as result mode.
> 
> One could argue that it would be better to mark the mismatching 
> permissions as a conflict.

Right you are.  Your whole "it still is xdl_merge()s fault" point was just 
contradicted by your own analysis.  Calling xdl_merge() when the sha1 does 
_not_ differ is _a mistake_.  _That_ is the bug.  Not xdl_merge() 
returning 0 (because there were 0 conflicts).

> However, this is how the merge currently silently succeeds _unless_ both 
> files are empty. If they are, xdl_merge() will effectively exit with an 
> error status and git-merge-recursive will fail with an internal error 
> (as shown in the testcase).
> 
> In any case, I think it is reasonable to expect xdl_merge() to work with 
> empty files. Whether or not the current "mode merging" behavior is 
> desired is a different matter.

I just tested.  xdl_merge() is _just fine_ with empty files.  However, 
git-merge-file was not.  Fixed by this:

-- snipsnap --
[PATCH] merge-file: handle empty files gracefully

Earlier, it would error out while trying to read and/or writing them.
Now, calling merge-file with empty files is neither interesting nor
useful, but it is a bug that needed fixing.

Noticed by Clemens Buchacher.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-merge-file.c |    3 ++-
 xdiff-interface.c    |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index adce6d4..cde4b2c 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -57,7 +57,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 		if (!f)
 			ret = error("Could not open %s for writing", filename);
-		else if (fwrite(result.ptr, result.size, 1, f) != 1)
+		else if (result.size &&
+				fwrite(result.ptr, result.size, 1, f) != 1)
 			ret = error("Could not write to %s", filename);
 		else if (fclose(f))
 			ret = error("Could not close %s", filename);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index bba2364..61dc5c5 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -152,8 +152,8 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	if ((f = fopen(filename, "rb")) == NULL)
 		return error("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
-	ptr->ptr = xmalloc(sz);
-	if (fread(ptr->ptr, sz, 1, f) != 1)
+	ptr->ptr = xmalloc(sz ? sz : 1);
+	if (sz && fread(ptr->ptr, sz, 1, f) != 1)
 		return error("Could not read %s", filename);
 	fclose(f);
 	ptr->size = sz;
-- 
1.5.4.4.706.ga822
