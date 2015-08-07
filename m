From: perryh@pluto.rain.com (Perry Hutchison)
Subject: resolving a (possibly remote) branch HEAD to a hash
Date: Fri, 07 Aug 2015 02:16:22 -0700
Message-ID: <55c47766.dDi8LaxdDqOeptUd%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 12:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNest-0008J2-7p
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 12:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbbHGK2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 06:28:15 -0400
Received: from agora.rdrop.com ([199.26.172.34]:4898 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbbHGK2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 06:28:14 -0400
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2015 06:28:14 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id t77AAwwQ022337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 7 Aug 2015 03:10:59 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id t77AAwgL022336
	for git@vger.kernel.org; Fri, 7 Aug 2015 03:10:58 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA06157; Fri, 7 Aug 15 02:16:37 PDT
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275465>

Given the name of a branch, which might be in either refs/heads
or refs/remotes, how do I spell a query to obtain the HEAD commit
of the refs/heads instance if it exists, else of the refs/remotes
instance?

If the branch is local, I can get the hash of its HEAD commit using
git rev-parse:

  $ git rev-parse master
  23eba8be773637c1a995a3ffe3aeabe921edef76

However, if I try to do the same thing with a remote branch,
rev-parse barfs:

  $ git rev-parse r5.0.1
  r5.0.1
  fatal: ambiguous argument 'r5.0.1': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

It works if I explicitly specify that I want the remote instance:

  $ git rev-parse origin/r5.0.1
  bb193a818fc984adbfd631951f3c89c16d5d3476

and the reference is, in fact, not ambiguous:

  $ git for-each-ref --format "%(refname)" | grep '/r5\.0\.1$'
  refs/remotes/origin/r5.0.1

Interestingly, master -- the one that works -- _is_ ambiguous:

  $ git for-each-ref --format "%(refname)" | grep '/master$'
  refs/heads/master
  refs/remotes/origin/master

Unfortunately grep is not a usable solution in general because
the branch name may contain . characters which grep (and egrep)
treat specially; nor is fgrep because it does _not_ treat $
specially; and I haven't found a for-each-ref pattern that will
select what I want.

One approach would be "git checkout r5.0.1" followed by
"git rev-parse HEAD", but I really don't want to perform a
checkout (e.g. the working tree is not necessarily clean).
I just want the same "resolve this reference" logic that
checkout clearly has to be using, but as a pure query that
does not change the state of either the repo or the working
tree.
