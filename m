From: David Kastrup <dak@gnu.org>
Subject: git-rm semantics (was: The philosophy behind my directory proposal in a nutshell)
Date: Sun, 22 Jul 2007 01:40:23 +0200
Message-ID: <85bqe5qqag.fsf@lola.goethe.zz>
References: <85fy3hqtwl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 01:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICOZ6-0002Bd-8W
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 01:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXGUXke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 19:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbXGUXke
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 19:40:34 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60389 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbXGUXkd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 19:40:33 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id AB41415C4A2
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 01:40:32 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 9DEA45BD63
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 01:40:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 431E41D3161
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 01:40:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D8E271D1E182; Sun, 22 Jul 2007 01:40:23 +0200 (CEST)
In-Reply-To: <85fy3hqtwl.fsf@lola.goethe.zz> (David Kastrup's message of "Sun\, 22 Jul 2007 00\:22\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3721/Sun Jul 22 00:17:47 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53197>


Following up on the git-rm note:

>     [As a note aside: working directories get removed when their
>     corresponding tree collapses and disappears from the
>     repository.  I should think it only consistent if the same
>     happened with git-rm: let the file by default disappear at
>     the moment when it gets removed from the repository,
>     implying --cached.  Namely, let
>
>     git-rm some-file
>     git-add some-file
>
>     be a noop, regardless whether the file was registered
>     previously.  This also implies that git-rm will always leave
>     unregistered files alone.]

Ok, this is somewhat incorrect: if we call git-rm and the file still
exists, this is strictly speaking the same situation as calling
git-add when a file does not exist.

And that gives:
fatal: pathspec 'geo' did not match any files
whether or not the repository has an idea about the file.

So in analogy, git-rm on an existing file could possibly made to barf.

Anyway, the following appears inconsistent to me:

touch geo
git-add geo
git-commit -m xxx -a
git-rm geo
[Now geo is gone]
git-add geo
[geo is complained about as unknown]
git-checkout geo
[geo is complained about as unknown!]

Now the last complaint clearly is quite a nuisance, because
git-checkout .
_will_ resurrect geo.

So for consistency's sake, it would appear that git-rm should really
only schedule a removal, and pull through only at the moment where the
file is actually removed from the repository.  There is a slight
discordance with git-add in that git-add requires the existence of the
file at the time of the add.  That is inevitable since git records the
_contents_ of the file at the time of the add.  git-rm does not need
any such information.

Now what if a file disappears before we commit, namely
touch woozle
git add woozle
rm woozle
?

Woozle will in that case get committed if and only if the commit is
done without the -a option.

Makes sense.  So in a nutshell: git-rm should not look at the working
directory.  That's the business of the commit.  When the repository
copy gets removed, this is the right time to remove the corresponding
file, and this is perfectly equivalent with the case for trees.

What _is_ strange is that a git-rmed file can't be restored by naming
it for a checkout.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
