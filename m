From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/3] Fix ObjectWalk to handle single-entry
	subtrees correctly
Date: Fri, 13 Mar 2009 11:37:03 -0700
Message-ID: <20090313183703.GG22920@spearce.org>
References: <1236967912-15088-1-git-send-email-spearce@spearce.org> <1236967912-15088-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 19:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiCHC-00011U-9H
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 19:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581AbZCMShH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbZCMShG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 14:37:06 -0400
Received: from george.spearce.org ([209.20.77.23]:46400 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZCMShF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 14:37:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 505E338211; Fri, 13 Mar 2009 18:37:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236967912-15088-2-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113218>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
> index 8028b14..5c331ca 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
> @@ -145,8 +145,19 @@ public CanonicalTreeParser resetRoot(final Repository repo,
>  
>  	/** @return this iterator, or its parent, if the tree is at eof. */
>  	public CanonicalTreeParser next() {
> -		next(1);
> -		return eof() && parent != null ? (CanonicalTreeParser) parent : this;
> +		CanonicalTreeParser p = this;
> +		for (;;) {
> +			p.next(1);
> +			if (p.eof() && parent != null) {
> +				// Parent was left pointing at the entry for us; advance
> +				// the parent to the next entry, possibly unwinding many
> +				// levels up the tree.
> +				//
> +				p = (CanonicalTreeParser) p.parent;
> +				continue;
> +			}
> +			return p;
> +		}

The parent != null test is wrong, we need "p.parent" here:

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
index 5c331ca..7f89cff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreeParser.java
@@ -148,7 +148,7 @@ public CanonicalTreeParser next() {
 		CanonicalTreeParser p = this;
 		for (;;) {
 			p.next(1);
-			if (p.eof() && parent != null) {
+			if (p.eof() && p.parent != null) {
 				// Parent was left pointing at the entry for us; advance
 				// the parent to the next entry, possibly unwinding many
 				// levels up the tree.
-- 
Shawn.
