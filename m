From: Jeff King <peff@peff.net>
Subject: Re: Removing redundant packs
Date: Sat, 8 Dec 2007 18:44:15 -0500
Message-ID: <20071208234414.GA31121@sigill.intra.peff.net>
References: <20071208125050.GA17478@machine.or.cz> <7vsl2cvpef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 00:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J19Ld-0003kC-Rv
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 00:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXLHXoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 18:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbXLHXoT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 18:44:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2354 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbXLHXoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 18:44:18 -0500
Received: (qmail 22252 invoked by uid 111); 8 Dec 2007 23:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Dec 2007 18:44:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 18:44:15 -0500
Content-Disposition: inline
In-Reply-To: <7vsl2cvpef.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67577>

On Sat, Dec 08, 2007 at 01:37:44PM -0800, Junio C Hamano wrote:

>  (1) In each repository, run "repack -a -d".  That would ensure that
>      everybody has the necessary objects that they themselves need.  By
>      doing this for a repository that borrows from another makes sure
>      pruning the latter would not break the former, so you start from
>      leaves and move on to the repositories they borrow from.

I'm not sure this works. Try this:

# make parent repo with two commits, fully packed
mkdir parent && cd parent && git init &&
echo content >file && git add file && git commit -m added &&
echo more >>file && git commit -m more -a &&
git repack -a -d

# clone child repo with alternates
git clone -s . ../child

# and now forget about the second commit in the parent
git reset --hard HEAD^
rm -rf .git/logs

# at this point the "parent" repo doesn't know anything about the second
# commit, but contains the objects; the child repo does know about it,
# but relies on the pack in the parent for the objects

# so your advice is to "repack -a -d" first in the child, then in the
# parent.
# child first; output will be: "Nothing new to pack."
cd ../child && git repack -a -d
# and then parent, which will lose the objects for the second commit
cd ../parent && git repack -a -d

# and confirm that child is broken
# output is: "fatal: bad object HEAD"
cd ../child && PAGER=cat git show

You seem to think that repacking without "-l" will pull objects from
alternates, but it doesn't (I have also seen "repack -a -d" recommended
for "how do I break alternates dependencies", but it obviously also
doesn't work for that).

-Peff
