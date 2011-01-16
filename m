From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: cannot fetch arm git tree
Date: Sun, 16 Jan 2011 13:42:48 +0000
Message-ID: <20110116134248.GD27542@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com> <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, git@vger.kernel.org
To: Jello huang <ruifeihuang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 14:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeStX-0005FT-4G
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 14:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1APNn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 08:43:27 -0500
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56030 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1APNn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
	h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PX/Ol+LKd8mOU9DkzxD/jMJ9raP88H2CRbXMkbcFMe4=;
	b=XXA6daHqKorG25ahgd2OjlFUJY66XyV5CkGlxNk59WiUGipYBPLnaCCvYBQZidoKtybjKaJxxtk7lPoNpnkIXGiGSBQ2RSR53R+sdf4A24Gul3vZ7SsLaBDDc8pZA4ybkvh9fdJqBnKqQ21R6hkzNwcK99Phc577LlsA07V1UNU=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PeSsc-0001Rt-3C; Sun, 16 Jan 2011 13:42:50 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PeSsa-0008I2-Ro; Sun, 16 Jan 2011 13:42:48 +0000
Content-Disposition: inline
In-Reply-To: <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165166>

On Sun, Jan 16, 2011 at 09:10:17PM +0800, Jello huang wrote:
> yes,git doesn't  handle that case and i rename the pack name,but there is
> also the similar error.Now i just delet the git tree and  clone it again
> tonight .

_Always_ without fail fetch Linus' tree before pulling my tree.

My tree is a rsync clone of the objects and pack files in Linus' tree,
plus whatever git decided to build on top of that - for local commits
that's individual object files.  For remote pulls, that's probably a few
small pack files.

There is *no* repacking of my tree.  So the only times it gets 'repacked'
is when Linus repacks his tree.

Let's say you already have a copy of my tree from a month ago, and Linus
has pulled some work from me into his tree, and repacked his tree into one
single pack file.  At the moment, the largest pack file from Linus is
400MB plus a 50MB index.

You already have most of the contents of that 400MB pack file, but if
you're missing even _one_ object which is contained within it, git will
have to download the _entire_ 400MB pack file and index file to retrieve
it.

However, if you first fetch Linus' tree via the git protocol, it can just
request the objects it doesn't have from the git server.  That will mean
you'll have all the objects in the large pack files before you start trying
to pull my tree, and git won't have to download 400MB for the sake of
retrieving just maybe 10k that you didn't have.

This isn't something special with my tree - it's a side effect of the
http protocol git uses.  So, before you fetch _any_ http-based git tree,
first make sure you're up to date with Linus'.

(I update my tree from Linus' in rsync mode to make http-based stuff a
lot more friendly to people using it - some of whom are stuck behind
firewalls which can only do http.  Fetching a constantly repacked git
tree via http results in hundreds of megabytes needing to be fetched
every time.)

So please, whenever possible, always fetch Linus' latest tree _first_
and then mine.  Same goes for any other http based tree which doesn't
auto-repack.
