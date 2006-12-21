From: David Tweed <tweed314@yahoo.co.uk>
Subject: git-add,& "file vanishing" -> need git-add again?
Date: Thu, 21 Dec 2006 14:13:35 +0000 (GMT)
Message-ID: <20061221141335.65170.qmail@web86902.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Dec 21 15:13:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOg2-0004fY-EI
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 15:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWLUONi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 09:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWLUONi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 09:13:38 -0500
Received: from web86902.mail.ukl.yahoo.com ([217.12.13.54]:39806 "HELO
	web86902.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964956AbWLUONh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 09:13:37 -0500
Received: (qmail 65173 invoked by uid 60001); 21 Dec 2006 14:13:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v/jlfx/HwjH0H2B0hg8G8BMEsG88I1ghY8FOmFHB/XpYotlcBQG4+frb+ZzaV342XIdvcMIfEBwCUvxA21vw5ZgqaURNCRFPo0/pWvMTUgkVdwx6fKLV1vRh1lxM/eD8Nmil0zPaHRXthLwn5G4MU8ZW9TYwfq6xEgD0SUenCgQ=  ;
Received: from [134.225.1.161] by web86902.mail.ukl.yahoo.com via HTTP; Thu, 21 Dec 2006 14:13:35 GMT
To: git@vger.kernel.org, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35070>

Hi, I'm working on using git for chronological backups (think selective P9 venti),
which I've almost got working. (I know I'm using git for something it wasn't
designed for, and is arguably perverse.) I've been trying to figure out why files which "ought"
to be tracked weren't in the database in certain commits and I think I've figured out why.
Can someone confirm the following: with the set of operations

git-init-db
....
git-add path/to/fileX
git-commit -a -m blah <1>
..... changes to things including fileX and commits
[file X vanishes from the tree being tracked, but nothing mentioned to git] <2>
..... changes to things and commits
[file X reappears in the tree being tracked]
<3>
git-commit -a -m blah <4>

the git trees from <1> to <2> all contain fileX, even if its contents haven't changed. Between
<2> and <4> the git tree doesn't contain fileX (perfectly properly). From <4> onwards fileX
still doesn't appear in the git trees recorded from the working directory even though fileX is
there again. If I want fileX tracked I have to explicitly git-add it again
at <3>. (Ie, git-commit -a when it detects a file have vanished from the working tree removes
it from the files git will look at in future for changes to commit.)

Is it also correct that this behaviour ("forget" about a tracked file when it disappear from the
working tree in a commit) would be difficult to change without major surgery to git?
Would there be any problems with git-add'ing every file you want the tree to track before every
commit?

(I'm currently working on code to keep track of things that have ever been tracked, and whether
they're currently in the tree, in my scripts outside git but obviously partially duplicating stuff git
has in its datastructures has the potential for subtle bugs when they diverge.)

Long story:
---------------

I'm trying to move a snapshotting-style system from my personal hack-job to git. As well as
manual snapshots there's a cron job that runs every hour to snapshot stuff. Consequently
there will be "automatic commits" when you wouldn't have made one if you were doing normal
source control, eg, after you've wrongly deleted a file and before you've noticed & restored it
from the database an automatic commit can come in (and even more kinky situations you
don't want to know about) and so sees the file "gone".

Sidenote: I'm moving the database from the old format to the new one by repeatedly unpacking
the old database for snapshot X, git-add'ing any file names which have _never_ been in any snapshot
before, git-commit -a, git-tag, then remove all the files unpacked by the
old database and move onto snapshot X+1. This takes less than a second per snapshot. I understand
this shouldn't be a problem but just to let people know the timestamps on the files aren't what
would be expected.

Many thanks for any insight,
cheers, dave tweed




Send instant messages to your online friends http://uk.messenger.yahoo.com 
