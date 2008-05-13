From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 05/24] Added WorkTree class which can be constructed over Repository.
Date: Mon, 12 May 2008 20:04:05 -0400
Message-ID: <20080513000405.GZ29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-6-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 02:05:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvi0r-0002oX-46
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 02:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbYEMAEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbYEMAEK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 20:04:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58146 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768AbYEMAEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 20:04:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jvhzo-0005YU-BM; Mon, 12 May 2008 20:03:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 68F6E20FBAE; Mon, 12 May 2008 20:04:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-6-git-send-email-florianskarten@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81971>

Florian Koeberle <florianskarten@web.de> wrote:
> +	public static WorkTree createWorkTree(File workTreeDirectory)

I'm only going to make this remark once for your series: In general I
prefer to mark any method argument, instance field or local variable
that I do not plan on changing within the method or class final.
This has saved me more than once from stupidly changing a parameter
when I meant to change something else.

Its not a hard and fast rule in either jgit or egit; you don't need
to go back and fix every single site.  Just something I have found
useful over the years and now do almost everywhere.

> +			throws IOException {
> +		final File gitDirectory = new File(workTreeDirectory,
> +				Constants.REPOSITORY_DIRECTORY_NAME);
> +		if (gitDirectory.exists()) {
> +			throw new IllegalArgumentException(
> +					"Repository exists in given project directory.");

When we throw an exception like this we should include the path
we are complaining about already existing as part of the message
(see Repository.create() for example).  This way if the message
makes it as far as the end-user (which it probably should, and
then there's translation issues are currently ignoring in jgit)
the user can at least see what path we were trying to operate on.
It may help them to realize they are in the wrong directory, or
made a typo on an input, etc.


Another thing about this method is we cannot supply the WindowCache
that the Repository should use for object data access, which means
this Repository will have its own WindowCache.  Under Eclipse (or
any other larger GUI/IDE) we really want only a single WindowCache
instance for the entire JVM as the heap must be shared across all
Repository instances.

This is actually making me reconsider how the WindowCache is handled.
Maybe we should have a single WindowCache instance down inside
of jgit, but allow the higher level UI (like Eclipse) to tune it
on the fly.  Then we don't have to worry about passing it down to
utility routines like this anytime we open a Repository.

Hmmmm.

-- 
Shawn.
