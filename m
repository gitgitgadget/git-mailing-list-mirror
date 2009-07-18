From: "Christian Jaeger" <pflanze@gmx.ch>
Subject: [BUG(s)?] dangling symref breaks filter-branch
Date: Sat, 18 Jul 2009 04:11:44 +0200
Message-ID: <20090718021144.162050@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 04:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRzP3-0002pH-4v
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 04:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbZGRCLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 22:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbZGRCLs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 22:11:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:57157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752646AbZGRCLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 22:11:47 -0400
Received: (qmail 5384 invoked by uid 0); 18 Jul 2009 02:11:46 -0000
Received: from 132.204.252.212 by www108.gmx.net with HTTP;
 Sat, 18 Jul 2009 04:11:44 +0200 (CEST)
X-Authenticated: #1695648
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX19l4gtBvyZlvqieW7FJTTLY8Y63AnLFYUgwSHvvWO
 TcTxt82G7MGYB+8d4IrcOfRxnOANhHmZ1gRw== 
X-GMX-UID: BksJB3ZebHIhQtLnIDQ04ekiJihyahCW
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123505>

Hello

$ git branch -a
  master
* stablepatches
  work
  remotes/origin/origin/master
  remotes/origin/stablepatches
  remotes/origin/work

$ git filter-branch --env-filter '..somecode..'
fatal: missing object 0000000000000000000000000000000000000000 for refs/remotes/origin/HEAD

Same thing happened with whatever additional argument (rev-list) I would give to git filter-branch.

When I cloned this repo and run the filter-branch in the clone, it worked.

git fsck --all on the faulty repo reported nothing but a couple dangling objects.

I used git version 1.6.3.3 and then 1.6.4.rc1 (same problem). Further digging has revealed:

$ cat .git/refs/remotes/origin/HEAD
ref: refs/remotes/origin/master
$ cat .git/refs/remotes/origin/master
cat: .git/refs/remotes/origin/master: No such file or directory

$ git rev-parse refs/remotes/origin/HEAD
said "dangling symref refs/remotes/origin/HEAD."

$ rm .git/refs/remotes/origin/HEAD
has made filter-branch work again.


So, issue one I'm wondering about: how comes I had this dangling symbolic ref? If it makes git tools break, shouldn't those refs be updated in a safe way (so that interruption can't leave those behind), or maybe should the tools be fixed for not handling them correctly.

Issue two (maybe not an issue) is why git filter-branch thought it should look at refs/remotes/origin/HEAD at all--I didn't tell it to, after all (right? I've spent time going through my config because I thought it would be taking this idea from there somehow, but couldn't see anything obvious).

(Issue three, maybe, why fsck didn't report any problem.)

Christian.
Note: I'm not subscribed to the ml currently.

-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
