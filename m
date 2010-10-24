From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] Add tests to demonstrate update-index bug with core.symlinks/core.filemode
Date: Sun, 24 Oct 2010 20:53:13 +0200
Message-ID: <1jqvvxl.1e5c93nipc126M%lists@haller-berlin.de>
References: <1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
Cc: Johannes.Schindelin@gmx.de (Johannes Schindelin),
	j.sixt@viscovery.net (Johannes Sixt)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 20:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA5h4-0005BP-Pt
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 20:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859Ab0JXSxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 14:53:16 -0400
Received: from mail.ableton.net ([62.96.12.115]:39187 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757590Ab0JXSxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 14:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=7t85DYpfkMgk9X2lMLanf1U/hhLXsqUN5HM8ZnyliM8=;
	b=oJWtnUP1npMoTcO1zueiDxXFS9h4IYDfQ6ttxyTXa1w+GH0Nf2dHkdfZWzNG0j8xjEwBmYOU+GECJ2dM0oneCJvTgndnDzDoQTL4kdFF/Cpor0XzbB0Cdk4mEasF0GqQynamyBVgPT92hI/6r7pOxTfJLi/vM23iZsUNt8Q0OPM=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PA5gv-0005Mb-Fe; Sun, 24 Oct 2010 20:53:13 +0200
In-Reply-To: <1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159888>

Stefan Haller <lists@haller-berlin.de> wrote:

> Stefan Haller <lists@haller-berlin.de> wrote:
> 
> > There's a bug with the handling of the executable bit when core.filemode
> > is false: when you have an executable file that has unmerged changes,
> > and you stage it with "git update-index", the executable bit is lost.
> > If you stage it with "git add" instead, it works fine.
> 
> It turns out that the same bug exists for symlinks when core.symlink is
> false. Here's a patch that adds two tests that demonstrate the problems.
> (I suspect both have a similar cause, and/or a similar solution.)

OK, so I found commit 2031427 (git add: respect core.filemode with
unmerged entries), and the corresponding email thread at
<http://article.gmane.org/gmane.comp.version-control.git/51182/>, that
fixed the same bug for git add in 2007.

So maybe the fix for update-index is as simple as replacing the
cache_name_pos call in process_path() with index_name_pos_also_unmerged,
but I'm afraid of breaking something else in that area.  Advice welcome.

BTW, I'm not convinced that the logic in index_name_pos_also_unmerged of
always preferring stage 2 over stage 3 is good in all cases.  For the
case where a regular file is changed into a symlink or vice versa it
probably doesn't matter, as the resolution will always require human
intervention, but if the mode just changes from 644 to 755 or back, it
seems wrong to always pick the mode of "ours" over "theirs".  Instead,
it should pick whichever mode differs from stage 1, if the other
doesn't.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
