From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/9] Create a listener structure for changes to
	refs and index
Date: Fri, 11 Jul 2008 04:22:51 +0000
Message-ID: <20080711042251.GB32633@spearce.org>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 06:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHAAi-00087B-TS
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 06:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbYGKEWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 00:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbYGKEWw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 00:22:52 -0400
Received: from george.spearce.org ([209.20.77.23]:48089 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYGKEWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 00:22:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7D7C238222; Fri, 11 Jul 2008 04:22:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88078>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This version does not tell you which refs have changed, nor
> what changes have happened. There is not scanning for externally
> initiated changes either, though such changes can be found when
> a JGit client wants to read index or refs information.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> index 9e3e020..4be33b8 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> @@ -81,6 +81,10 @@ class RefDatabase {
>  
>  	private long packedRefsLength;
>  
> +	long lastRefModification;
> +
> +	long lastNotifiedRefModification;
> +
>  	RefDatabase(final Repository r) {
>  		db = r;
>  		gitDir = db.getDirectory();
> @@ -155,6 +161,12 @@ class RefDatabase {
>  		}
>  		if (!lck.commit())
>  			throw new ObjectWritingException("Unable to write " + name);
> +		setModified();
> +		db.fireRefsMaybeChanged();
> +	}
> +
> +	void setModified() {
> +		lastRefModification = System.currentTimeMillis();
>  	}

We don't ever actually need the time here as a time, do we?
Wouldn't a simple counter work just as well, but ensure we don't
lose notifications that occur more frequently then the resolution
of currentTimeMillis()?

-- 
Shawn.
