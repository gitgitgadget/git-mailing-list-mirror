From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] rebase no longer omits local commits
Date: Thu, 3 Jul 2014 20:09:17 +0100
Message-ID: <20140703190917.GE13153@serenity.lan>
References: <53B57352.50202@tedfelix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Felix <ted@tedfelix.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:09:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2mNs-0004Kz-K0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 21:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaGCTJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 15:09:25 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:46796 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaGCTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 15:09:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 74A5021851;
	Thu,  3 Jul 2014 20:09:23 +0100 (BST)
X-Quarantine-ID: <A4cMgvHqhmmZ>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A4cMgvHqhmmZ; Thu,  3 Jul 2014 20:09:22 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 11A1B21D1C;
	Thu,  3 Jul 2014 20:09:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <53B57352.50202@tedfelix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252875>

On Thu, Jul 03, 2014 at 11:14:26AM -0400, Ted Felix wrote:
> Starting with git 1.9.0, rebase no longer omits local commits that 
> appear in both the upstream and local branches.
> 
> I've bisected this down to commit bb3f458: "rebase: fix fork-point with 
> zero arguments".  The attached script reproduces the problem.  Reverting 
> the aforementioned commit fixes the problem.
> 
> A failed run of this script will result in conflicts.  A successful run 
> against master with bb3f458 reverted ends as follows:
> 
>  From /tmp/rebase-issue/maint
>     fe401cd..955af04  master     -> origin/master
> fatal: Not a valid object name: ''
> First, rewinding head to replay your work on top of it...
> Applying: Third change
> 
> (I'm not sure if that "fatal: Not a valid object name: ''" is of any 
> concern.  It started appearing for me at some point during the bisect.)

It is the problem that bb3f458 fixes.  The change in behaviour is
actually introduced by ad8261d (rebase: use reflog to find common base
with upstream).

In your example, I think this is working as designed.  You can restore
the previous behaviour either with `git rebase --no-fork-point` or with
`git rebase @{u}`.

The change is designed to help users recover from an upstream rebase, as
described in the "DISCUSSION ON FORK-POINT MODE" section of
git-merge-base(1) and makes `git rebase` match the behaviour of
`git pull --rebase` so that:

	git fetch &&
	git rebase

really is equivalent to:

	git pull --rebase
