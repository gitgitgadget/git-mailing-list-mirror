From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] checkout_entry: only try to create directories when no file existed there
Date: Wed, 08 Aug 2007 23:27:53 +0200
Message-ID: <85y7glpvhi.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708082200240.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIt4b-0004mH-0y
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765540AbXHHV2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763702AbXHHV2C
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:28:02 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:38845 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763008AbXHHV2A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 17:28:00 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id EC04912CDD;
	Wed,  8 Aug 2007 23:27:56 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id D719812DF0B;
	Wed,  8 Aug 2007 23:27:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 932141D3164;
	Wed,  8 Aug 2007 23:27:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3B3C61C3C79D; Wed,  8 Aug 2007 23:27:54 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708082200240.14781@racer.site> (Johannes Schindelin's message of "Wed\, 8 Aug 2007 22\:00\:53 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3898/Wed Aug  8 20:20:48 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55371>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It is obvious that we do not have to create directories when the file we
> want to check out already existed.
>
> Besides, it fixes the obscure use case, where you want to track a
> file which is _outside_ of your working tree, by creating a symbolic
> link to the directory it lives in, and adding the file with
> something like "git add symlink/file".  Without this patch, "git
> checkout symlink/file" would actually _replace_ "symlink" by a
> directory of the same name.

Uh, when git is tracking symlinks (and it does by default), this is
quite the correct thing to do.  Of course, it should rather barf with
a merge conflict.  But it has no business following links and doing
potential damage either outside or inside of the work tree, by
confusing the target of a link with the link itself.  For example, I
can easily relocate a complete git work tree with "mv" in the
directory hierarchy.  Should an update/commit/whatever then start
wreaking havoc in places that incidentally don't point to the same
location anymore?

My vote here is emphatically "no".  Just maintain the links, not
whatever they point to.

I can think of only a single reasonable exception: if the symlink
itself is _not_ registered (because is has been explicitly entered
into a .gitignore file or never added for other reasons), but its
target _has_ been added explicitly _dereferencing_ the symlink.  This
difference can only occur with directory symlinks since file symlinks
can't be distinguished in this manner from the name of the link
itself.

It would be good if somebody brought this to Johannes' attention, even
if just replying with a quotation: he chose to killfile me.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
