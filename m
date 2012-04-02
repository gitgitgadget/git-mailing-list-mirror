From: Florian Achleitner <florian.achleitner@student.tugraz.at>
Subject: GSOC Proposal draft: git-remote-svn
Date: Mon, 02 Apr 2012 10:30:58 +0200
Message-ID: <2487557.B8qfnaixh3@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com> <2148933.pnpYo0xMAP@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 11:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEdS5-0004bJ-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 11:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2DBJVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 05:21:25 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:51949 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2DBJVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 05:21:23 -0400
X-Greylist: delayed 3000 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Apr 2012 05:21:23 EDT
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q328UwMP018879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Apr 2012 10:30:59 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.3 mailrelay2.tugraz.at q328UwMP018879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tugraz.at;
	s=mailrelay; t=1333355460; i=@student.tugraz.at;
	bh=BL7+QdBvOHXTXL5LryHXVgVz89GyKJhpd9qpgi02YqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ATOUrv+08cs+ylp1e9VwpPdDlL2Mfygf9em/ZjTFafUyY7x1lB8p2nSPgofZdIntW
	 wa+tNjDEfx5oZCwV0QRhoDjC57WYZwDvFr/VElb7Za9HuCynvPSbv6H+YbO3LX1Gtf
	 AxOWoqlnHNvFBWH2fWvcMBCePWAElBF4SgJNCziw=
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <2148933.pnpYo0xMAP@flomedio>
X-TUG-Backscatter-control: bt4lQm5Tva3SBgCuw0EnZw
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.4
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194503>

Hi everybody!

Here is my draft of the proposal for the GSoC project. RFC!
Please comment and tell me what you think and if I understood it all right!

I spent a lot of lines with wiriting about the current situation. This is 
mostly because, as a newbee, I spent a lot of time examining what we already 
have and wrote it down finally.

The draft is inlined below. I hope it's not too long to read. I will put it on 
a github wiki later, once i figure out how this works ;)

Florian


==Remote helper for Subversion==

==Introduction==
{ for non-insiders }
Git [1] is a powerful distributed version control system (DVCS). "Distributed" 
means that everybody works on a full featured repository. To collaborate with 
other user's repositories git can fetch and pull from remote repositories 
using several transports (http://, ssh://, git://, ...). Git has a very 
powerful and useful concept of branches. They are lightweight pointers to 
commits (heads).

Subversion (svn) [2] was created as a successor of CVS, both follow a strict 
client-server design, where the repository exclusively lives on the central 
server and every client only checks out a copy of a single revision at a time. 
SVN doesn't truly have a concept of branches. SVN branches are a copy of a 
directory (so are tags).

==What we want (the general goal)==
short: 
git clone svn://<url>
git push
git fetch

A full-featured bi-directional remote helper for svn that allows git to use a 
svn repository as a remote, mostly like a remote git repo.
Remote helpers are separate programs invoked by git to communicate with 
foreign repositories. They are used by transceiving a command and data stream 
via stdin and stdout.

The remote helper interface [2] supports commands that deliver a git-fast-
import stream from the remote repo.

git-fast-import [4] is a format to serialize a git repository into a text 
format. It is used by the tools git-fast-import and git-fast-export.

The remote helper has to convert the foreign protocol and data (svn) to the 
git-fast-import format.

==What are the challenges? ==
To summarize: The way git tracks the state of the working tree and svn's way 
are different in several aspects. This makes a direct mapping impossible.
There are lots of discussions about these issues on the git mailing list [5].

Some aspects: (I'm sure this is incomplete)
- svn commit and file metadata, it's symlink and permission representation have 
to to be mapped to git.

- svn history can only be extracted from the server (we have svnrdump for 
that)

- svn commits are only possible after updating the working copy first, i.e. 
fetching and merging new revisions on the server. This is like implicitly 
rebasing your local work on the remote head before pushing to an svn 
repository.
In git there is of course no such restriction.

- and the most challenging: mapping subversion branches to git branches. 
In svn a branch is created by copying a directory with 'svn copy'. svn doesn't 
have a concept of branches by itself. 

Branches exist due to the convention of having branches/, trunk/, and tags/ 
directories in a repository, so do tags. But this is not mandatory and 
therefore there are many different layouts. It follows that in svn it is also 
possible to commit across branches. This means that a single commit can change 
files on more than one branch (accidentally or deliberately).
To convert svn branches to git we have to detect branch semantics by examining 
the svn tree's structure and it's metadata (it has a 'copyfrom' property). 
Previous efforts show that this will not be possible fully automatically 
without configuration and interaction with the user.

This brings us to:
==What we have: (existing work)==
Andrew Sayers is currently developing a language to describe svn to git branch 
mapping [6]. I plan to use the language as a configuration for the remote 
helper that specifies unclear aspects.

"esr" developed a tool to manipulate and export subversion repositories [7] 
that should be able to detect branches, but it's sources are not available 
yet.

In git's tree there is git-svn, a huge Perl script used to convert svn to git. 
It detects branches, but with problems. It also supports some kind of pushing 
commits to svn using a separate command. It's problem: it's unmaintainable, 
bugs are hard to locate and to fix.

There are several other one-way conversion tools, e.g. svn-fast-export, 
svn2git.py.

In git's source tree we have a vcs-svn/, a set of functions to convert svn 
dumps to git-fast-import streams. Those are used by svn-fe to one-way import 
svn history to git. svn-fe doesn't do branch mapping yet.

We have Ramkumar Ramachandra's svnrdump [8] which now lives in the svn source 
tree. It can create dump files [9] from remote svn servers and load dump files 
up to svn server.
It practically provides read-write access to svn using a text format.

There is a prototype remote helper from Dmitry Ivankov. A bash script 
providing one way fetching from svn via svnrdump and svn-fe.

{ did I miss something important? }

==Project outline==
Please look at the drawing on:
http://filestore.mg34.vc-graz.ac.at/flo/drawing.svg

1. Write a new bi-directional remote helper in C. 
  - It uses vcs-svn utilities to convert svn dumps to git-fast-import and 
vice-versa.
  - It calls svnrdump as a backend to communicate with svn.
  - It reads a configuration file containing branch mappings according to [6]. 
These mapping have to be pre-generated using tools developed along with the 
language. The remote helper has no way of asking the user what to do. It will 
fail if a mapping is unclear.
  - Because generating the branch mapping configuration already requires that 
you have a dump of the svn repo, the helper should probably be able to read 
from a file in place of svnrdump too.
  - Using the config the helper translates svn branches/tags to git 
branches/tags and converts other metadata as applicable. It probably has to 
store some information about the mapping in a file in .git to allow a 
reconstruction on subsequent invocations. I think this is especially important 
when pushing to branches (does it already exist in svn, and where? is it new).
  - It communicate with git via the fast-import format. The remote helper 
interface (will have)|has commands for that.

2. Extend the remote helper interface as necessary to read and write fast-
import streams to remote helpers

3. Add output capabilities to vcs-svn. Currently the code in vcs-svn can only 
convert svn to git. To push to svn we also need conversion and mapping from 
git to svn. The actual mapping code for branches should also be placed here 
{??} and called by the remote helper.

{ Hmm.. so it looks like thats a lot? what do you think? }

Timeline
{ Still to come !}

About me
{ I sent an introduction to the list already, so I'll not copy it here. But it 
will be in the application on GSOC site.}

[1] http://git-scm.com/
[2] http://subversion.tigris.org/
[3] git sources git/Documentation/git-remote-helpers.html
[4] git sources git/Documentation/git-fast-import.html
[5] http://thread.gmane.org/gmane.comp.version-control.git/192106
[6] https://github.com/andrew-sayers/SVN-Branching-Language
[7] http://esr.ibiblio.org/?p=4071
[8] http://svnbook.red-bean.com/en/1.7/svn.ref.svnrdump.html
[9] svn sources subversion/notes/dump-load-format.txt
[10] https://github.com/divanorama/git/blob/remote-svn-alpha/contrib/svn-
fe/git-remote-svn-alpha
