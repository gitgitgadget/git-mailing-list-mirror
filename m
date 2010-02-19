From: Gabriel <g2p.code@gmail.com>
Subject: Writing git remote helpers
Date: Fri, 19 Feb 2010 16:15:41 +0100
Message-ID: <20100219161541.272c688f@gmail.com>
References: <4B7D8358.1080108@gmail.com>
	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	<4B7E3856.3080609@gmail.com>
	<fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com>
	<loom.20100219T134421-90@post.gmane.org>
	<fabb9a1e1002190538q4600f8c7kb8b2a6345ef3cc33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 16:16:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiUaJ-0006wr-I7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 16:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab0BSPP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 10:15:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:33849 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab0BSPP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 10:15:57 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6DA3D8181ED;
	Fri, 19 Feb 2010 16:15:50 +0100 (CET)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 665EF818174;
	Fri, 19 Feb 2010 16:15:48 +0100 (CET)
In-Reply-To: <fabb9a1e1002190538q4600f8c7kb8b2a6345ef3cc33@mail.gmail.com>
X-Mailer: Claws Mail 3.7.2 (GTK+ 2.18.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140456>

Sverre Rabbelier:
> Heya,
> 
> On Fri, Feb 19, 2010 at 13:52, Gabriel <g2p.code@gmail.com> wrote:
> > FWIW, I'm interested in that remote-vcs code, but never figured out
> > where it was published. TIA for pushing it.
> 
> The remote-helpers code is already in git.git, and has been since git
> 1.6.6 with some improvements now in 1.7.0.

Yes, good; I meant I haven't found example uses of that code. I'm aware
of work on a cvs helper and an hg helper. Users of the python library
would be extra convenient.

> > I'll be using it to better integrate fast-import based backup
> > scripts.
> 
> Do you mean that you'll write a remote helper to import your backups?
> If so then my code could be useful as a demonstration on how to hook
> up a fast-import stream.

I think so.

I'm using fast-import to break down a big json file into a tree, and
slurp the tree into git. I'm doing this read only. This gives me a
history of the file, compact, human-readable with git log, with an
incremental remote mirror.

I expect making it work with remote-helpers (I'll need to rebuild json
from the git input to also handle push, I don't know what else is
required) will give me convenient push-pull semantics and I'll be able
to sync that file across machines, taking advantage of git's merging
abilities.
I imagine this kind of sync use case would also work with something
like CouchDB or MongoDB, but git has a low barrier to entry for me, and
I'm not sure how well the others handle tree merging, that sometimes
requires human intervention, in a multi-master replication setup.

Speaking of remote-helpers requirements, besides the fast-import
stream, what else do I need? I imagine I'll do some book-keeping to
note when the current import was last modified (and avoid reimporting
it when unchanged), and the last hash that was pushed (and avoid
re-exporting it needlessly).

When pushing, how do I tell that the current push is a non
fast-forward? I can look for the hash of the json file in the history
of the pushed branch; if it isn't there I'll refuse the push. Do I keep
json hashes in log messages like git-svn does?
Or do I store a commit_id -> json hash mapping next to the json file?
Do I use git notes for that mapping? How do I index back from json hash
to matching commit to commits having the matching commit in their
ancestry?

When pulling, how do I tell there's nothing further to import? Same
approach as for push: look for the json hash in the history or in a
local mapping, import nothing if found?

Thinking about it some more, those two operations need a json_hash ->
commit_id lookup followed by a commit_id, commit_id -> bool DAG ancestry
test. Is that something the support library provides, or would welcome?
