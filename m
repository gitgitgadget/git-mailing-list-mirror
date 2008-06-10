From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Reset the graph plotter internals when HEAD has changed.
Date: Mon, 9 Jun 2008 20:40:46 -0400
Message-ID: <20080610004046.GE4389@spearce.org>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com> <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rvj-0001LI-KA
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 02:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbYFJAku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 20:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185AbYFJAku
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 20:40:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52057 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYFJAkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 20:40:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K5ruf-0006Zk-Me; Mon, 09 Jun 2008 20:40:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BCEBC20FBAE; Mon,  9 Jun 2008 20:40:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84464>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> When we reset HEAD to an old revision it becomes more visible than when
> we add a new commit. This is an intermediate solution.

Hmm.
 
> @@ -521,8 +524,18 @@ public class GitHistoryPage extends HistoryPage {
>  		if (db == null)
>  			return false;
>  
> +		final AnyObjectId headId;
> +		try {
> +			headId = db.resolve("HEAD");
> +		} catch (IOException e) {
> +			Activator.logError("Cannot parse HEAD in: "
> +					+ db.getDirectory().getAbsolutePath(), e);
> +			return false;
> +		}
> +
>  		if (currentWalk == null || currentWalk.getRepository() != db
> -				|| pathChange(pathFilters, paths)) {
> +				|| pathChange(pathFilters, paths)
> +				|| headId != null && !headId.equals(currentHeadId)) {
>  			currentWalk = new SWTWalk(db);

Tossing the currentWalk just because HEAD changed to a different
commit shouldn't be necessary.  Its very heavy-handed.  Clearly
there is a bug in the plotter code where the reset does not clear
state right.

For now this is a reasonable work around.  I'll try to remember
to come back and debug this case in the future as tossing the
entire SWTWalk does reduce redraw performance.

Thanks for at least coming up with the work-around.

-- 
Shawn.
