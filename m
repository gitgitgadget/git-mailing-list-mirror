From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/5] quickdiff - Don't add GitDocument as
	repository listener more than once
Date: Sun, 5 Apr 2009 13:24:00 -0700
Message-ID: <20090405202400.GO23521@spearce.org>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYuZ-0001FC-D0
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbZDEUYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757261AbZDEUYD
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:24:03 -0400
Received: from george.spearce.org ([209.20.77.23]:54867 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358AbZDEUYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:24:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4494038211; Sun,  5 Apr 2009 20:24:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115699>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Doing so was very costly and led to sessions being locked
> for a long time while refreshing the reference document used
> by Eclipse's quickdiff feature.
...
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -1132,6 +1132,7 @@ public File getWorkDir() {
>  	 * @param l
>  	 */
>  	public void addRepositoryChangedListener(final RepositoryListener l) {
> +		assert !listeners.contains(l);
>  		listeners.add(l);
>  	}
>  
> @@ -1150,6 +1151,7 @@ public void removeRepositoryChangedListener(final RepositoryListener l) {
>  	 * @param l
>  	 */
>  	public static void addAnyRepositoryChangedListener(final RepositoryListener l) {
> +		assert !allListeners.contains(l);
>  		allListeners.add(l);
>  	}

That's a race condition.  The two collections are Vectors so another
thread can add the listener between your assertion point and the
add call.

Also, if this really is considered to be very bad behavior on the
part of the application, maybe these should be real tests with
exceptions thrown, so they can't be disabled when assertions are
turned off in the JRE?

-- 
Shawn.
