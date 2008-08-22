From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/4] Ensured that RefUpdate cannot delete current
	branch
Date: Fri, 22 Aug 2008 16:22:26 -0700
Message-ID: <20080822232226.GP3483@spearce.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org> <1219445147-6801-2-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfyd-0002Gb-V9
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbYHVXW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYHVXW2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:22:28 -0400
Received: from george.spearce.org ([209.20.77.23]:44090 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbYHVXW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:22:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 05A8738375; Fri, 22 Aug 2008 23:22:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219445147-6801-2-git-send-email-charleso@charleso.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93397>

Charles O'Farrell <charleso@charleso.org> wrote:
> If attempted it will return a REJECTED_CURRENT_BRANCH Result.
 
> @@ -323,6 +330,9 @@ public Result update(final RevWalk walk) throws IOException {
>  	 * @throws IOException
>  	 */
>  	public Result delete() throws IOException {
> +		if (name.substring(Constants.R_HEADS.length()).equals(
> +				db.getRepository().getBranch()))
> +			return Result.REJECTED_CURRENT_BRANCH;
>  		try {
>  			return updateImpl(new RevWalk(db.getRepository()),
>  					new DeleteStore());

I'm squashing this into the patch, as I think its a safer (and
faster) way to evaluate what the current branch is.  We have a
cache in RefDatabase showing the current value of HEAD.  We also
don't look at .git/head-name, which happens during a bisection.

But I also don't think we want to mess around with this test if
we are dealing with refs/remotes or refs/tags.  Really it is only
refs/heads/ that should typically appear in HEAD, so we only need
to guard against that case.  If the user knows enough to make HEAD
point at something else, maybe they will also know enough to not
delete the damn thing out from under themselves.  If we did fix it
to test for all refs, its just a matter of removing the first if.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index aa2cecb..77dada0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -330,9 +330,12 @@ public Result update(final RevWalk walk) throws IOException {
 	 * @throws IOException
 	 */
 	public Result delete() throws IOException {
-		if (name.substring(Constants.R_HEADS.length()).equals(
-				db.getRepository().getBranch()))
-			return Result.REJECTED_CURRENT_BRANCH;
+		if (name.startsWith(Constants.R_HEADS)) {
+			final Ref head = db.readRef(Constants.HEAD);
+			if (head != null && name.equals(head.getName()))
+				return Result.REJECTED_CURRENT_BRANCH;
+		}
+
 		try {
 			return updateImpl(new RevWalk(db.getRepository()),
 					new DeleteStore());

-- 
Shawn.
