From: Junio C Hamano <junkio@cox.net>
Subject: Re: Terminology
Date: Sun, 31 Jul 2005 11:33:24 -0700
Message-ID: <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 20:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzIdU-0001LR-I8
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 20:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVGaSdn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 14:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVGaSdn
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 14:33:43 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35232 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261866AbVGaSd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 14:33:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731183326.GGZK7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 14:33:26 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Sun, 31 Jul 2005 15:52:25 +0200 (CEST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe we should decide on a common terminology before kicking out 1.0, and
> look through all files in Documentation/ to have a consistent vocabulary.
> And poor me does not get confused no more.

Glad to see you started the discussion on this one.  I have a
slight worry and suspicion that this might open a can of worms,
but I agree we need to get this done.  We probably would end up
spliting the Terminology section in Documentation/git.txt into a
separate "Glossary" document.

Care to volunteer drafting a strawman, listing the concepts we
need terms for, marking the ones we seem to use the same word
for?   You do not have to suggest which candidate term to use
for all of them.  Something along these lines...

 - The unit of storage in GIT is called "object"; no other word
   is used and the word "object" is used only for this purpose
   so this one is OK.
  
 - A 20-byte SHA1 to uniquely identify "objects"; README and
   early Linus messages call this "object name" so does
   tutorial.  Many places say "object SHA1" or just "SHA1".

 - An "object database" stores a set of "objects", and an
   individial object can be retrieved by giving it its object
   name.

 - Storing a regular file or a symlink in the object database
   results in a "blob object" created.  You cannot directly
   store filesystem directory, but a collection of blob objects
   and other tree objects can be recorded as a "tree object"
   which corresponds to this notion.

 - $GIT_INDEX_FILE is "index file", which is a collection of
   "cache entries".  The former is sometimes called "cache
   file", the latter just "cache".

 - the directory which corresponds to the top of the hierarchy
   described in the index file; I've seen words like "working
   tree", "working directory", "work tree" used.

 - When the stat information a cache entry records matches what
   is in the work tree, the entry is called "clean" or
   "up-to-date".  The opposite is "dirty" or "not up-to-date".

 - An index file can be in "merged" or "unmerged" state.  The
   former is when it does not have anything but stage 0 entries,
   the latter otherwise.

 - An merged index file can be written as a "tree object", which
   is technically a set of interconnected tree objects but we
   equate it with the toplevel tree object with this set.

 - A "tree object" can be recorded as a part of a "commit
   object".  The tree object is said to be "associated with" the
   commit object.

 - A "tag object" can be recorded as a pointer to another object
   of any type. The act of following the pointer a tag object
   holds (this can go recursively) until we get to a non-tag
   object is sometimes called "resolving the tag".

 - The following objects are collectively called "tree-ish": a
   tree object, a commit object, a tag object that resolves to
   either a commit or a tree object, and can be given to
   commands that expect to work on a tree object.

 - The files under $GIT_DIR/refs record object names, and are
   called "refs".  What is under refs/heads/ are called "heads",
   refs/tags/ "tags".  Typically, they are either object names
   of commit objects or tag objects that resolve to commit
   objects, but a tag can point at any object.

 - A "head" is always an object name of a commit, and marks the
   latest commit in one line of development.  A line of
   development is often called a "branch".  We sometimes use the
   word "branch head" to stress the fact that we are talking
   about a single commit that is the latest one in a "branch".

 - Combining the states from more than one lines of developments
   is called "merging" and typically done between two branch
   heads.  This is called "resolving" in the tutorial and there
   is git-resolve-script command for it.

 - A set of "refs" with the set of objects reachable from them
   constitute a "repository".  Although currently there is no
   provision for a repository to say that its objects are stored
   in this and that object database, multiple repositories can
   share the same object database, and there is not a conceptual
   limit that a repository must retrive its objects from a
   single object database.

 - The act of finding out the object names recorded in "refs" a
   different repository records, optionally updating a local
   "refs" with their values, and retrieving the objects
   reachable from them is called "fetching".  Fetching immediately
   followed by merging is called "pulling".

 - The act of updating "refs" in a different repository with new
   value and populating the object database(s) associated with
   the repository is called "pushing".

 - Currently refs/heads records branch heads of both locally
   created branches and branches fetched from other
   repositories.

 - Currently, fetching always happen against a single branch
   head on a remote repository, and (a remote repository, name
   of the branch) is stored in $GIT_DIR/branches/ as a
   short-hand mechanism.  A file in this directory identifies
   a remote repository by its URL, and the branch to fetch/pull
   from is identified with the URL fragment notation, absense of
   which makes it default to "master".

-jc
