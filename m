From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: rsync vs. git-push/pull ? (+kudus)
Date: Wed, 10 Sep 2008 09:05:28 +0200
Message-ID: <vpqej3sa3bb.fsf@bauges.imag.fr>
References: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ramagudi Naziir" <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 09:08:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdJoT-0008Kd-Ow
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 09:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbYIJHHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 03:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbYIJHHS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 03:07:18 -0400
Received: from imag.imag.fr ([129.88.30.1]:34090 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYIJHHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 03:07:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8A75Xlq016235
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Sep 2008 09:05:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KdJlY-0006Fg-GS; Wed, 10 Sep 2008 09:05:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KdJlY-0003Tz-E6; Wed, 10 Sep 2008 09:05:28 +0200
In-Reply-To: <dfb262380809062311i3fffb900m5d73f5396b403dbe@mail.gmail.com> (Ramagudi Naziir's message of "Sun\, 7 Sep 2008 09\:11\:47 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 10 Sep 2008 09:05:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95489>

"Ramagudi Naziir" <naziirr@gmail.com> writes:

> Hi all,
>
> I have several local git repositories on my machine. I'm the only
> user, and use them only locally. Now, sometimes when I need to work
> remotely, I just rsync my repositories to my laptop, and keep working
> there. When I finish (few hours, days or sometimes weeks later), I
> just rsync everything back to my local git repositories on my main
> workstation, and continue working there.
>
> Now I was wondering whether it's OK or whether there are bad

Clearly, it's more risky to use rsync: git knows which repository is
ahead of the other, knows it has to do a merge in case the two
diverged, ... but if you really know what you're doing, this should be
OK.

Technically, there's at least one case which can be problematic if you
"rsync" without "--delete": packed references. For example, the tip of
the master branch is normally stored in .git/refs/heads/master, but
after packing, git removes this file, and puts all the references in
.git/packed-refs (so it's just 1 file, eats less inodes, less
round-trips for HTTP fetch, ...). Then, if .git/refs/heads/master is
re-created, it takes precedence over .git/packed-refs. So if you 
"git gc" locally, and then "rsync remote/ local/", you'll end up with
an old .git/refs/heads/master that overrides the new .git/packed-refs,
and git will behave as if you went backwards in history.

Easily fixable, but I've been hit by this once and took time to
understand what was happening ;-).

-- 
Matthieu
