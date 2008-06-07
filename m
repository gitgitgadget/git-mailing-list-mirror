From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: stg pull/rebase
Date: Sat, 7 Jun 2008 19:22:02 +0200
Message-ID: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 19:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5288-0004U5-HB
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 19:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760891AbYFGRWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759762AbYFGRWL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 13:22:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3361 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760839AbYFGRWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 13:22:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K5278-0001kr-00; Sat, 07 Jun 2008 18:22:02 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84218>

As I said, I've been thinking a bit about stg pull and stg rebase
recently (though I haven't written any code; I don't want to be
juggling too many balls at once).

Currently, there's stg rebase which only does rebasing, and stg pull
which does either rebase or merge depending on a config option. And on
top of that there's config stuff like stgit.pullcmd that is invoked in
some cases but not others.

What I think I'd like is the following:

  * Just one command, stg pull. stg rebase is removed.

  * When pull is invoked, the following happens:

      1. The branch we pull from may be updated, depending on the
         configuration. (e.g. git fetch or git svn fetch)

      2. Depending on the configuration (overridable by the
      --fast-forward, --rebase, and --merge options), one of these
      three things happen:

         1. We pop all patches, fast-forward to the new base, and push
            them back. If it's not a fast-forward, we error out.

         2. We pop all patches, reset to the new base, and push them
            back.

         3. We pop all patches, merge with the other branch, then push
            the patches back.

      Fast-forward is the default if no configuration or command-line
      flag is given.

I've personally never had a need for the merge case, but I recall you
arguing to keep it, Catalin?

The benefits of this organisation are

  * Configuration of how to update the remote prior to pulling and
    ff/rebase/merge configuration are orthogonal.

  * The default action is to fast-forward, which is probably what most
    users want -- merge is very likely to do the wrong thing, and
    rebase can lose changes.

  * The remote updating is entirely separated from the actual pushing
    and popping of patches, since it runs to completion before we do
    anything else. This means that we can pop, change the base and
    push in a single transaction.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
