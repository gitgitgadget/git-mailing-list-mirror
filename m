From: Yann Dirson <ydirson@altern.org>
Subject: diffcore and directory renames
Date: Mon, 1 Sep 2008 23:39:04 +0200
Message-ID: <20080901213904.GP4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaH7r-0003nj-Ay
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYIAVit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYIAVit
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:38:49 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:43331 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYIAVit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:38:49 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 53C3732A853
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 23:38:46 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 279EE32A815
	for <git@vger.kernel.org>; Mon,  1 Sep 2008 23:38:46 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id BDE9CA003; Mon,  1 Sep 2008 23:39:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94612>

I often found myself lost when looking at a diff where a couple of
large dirs where renamed, and a handful of files were modified to take
the rename into account - not a rare situation, I'd say.  In such a
case, the diffs themselves are mostly hidden among numerous rename
entries.

To that, I felt that git ought to know better, and could easily
present a directory rename as such.  Among the advantages of having
such "dir rename detection", aside from readability which we should
not neglect, we'd have more accurate "svn dcommit" for such renames
and, and better decisions made when merging a branch with adds a file
into a dir, with a branch which renames that dir (ok, maybe not that
frequent, but still).


Looking closer at the current behaviour, I realized that git-diff-tree
*is* already able to report such renames in raw mode :

$ ./git-diff-tree 0f1027 -M
0f1027e1aceb4bc5fa682776ab9f72935e2cd1b3
:040000 040000 6f6159f0245784352414ff38ffb68bae80f30bd6 6f6159f0245784352414ff38ffb68bae80f30bd6 R100   ppc     moved

... but patch output breaks this into file moves, and even other
commands which I would have expected to display the same do in fact
not (eg. "git show --raw").  Is there any reason for this ?  I would
have expected git-show to do the same as diff-tree, and it would not
be so much of a problem to introduce a special form of the "rename"
chunk to handle dir renames ?


Since current diff-tree behaviour is based on comparing tree hashs, it
only detects 100%-similarity renames, and naturally diff-index and
diff-files cannot even do that much yet.  However, an optional
factorization pass following rename detection could quite easily
detect if, when a containing directory disappears because of a set of
renames - this is what I have started to look at.

Since what I propose is indeed just a factorization of file renames,
it could be adequate to represent them as such instead of directory
renames, so as to read something like:

|diff --git a/ppc/* b/moved/
|rename from ppc/*
|rename to moved/

This would have the additional advantage of also working when the
target destination was pre-existing, and when merging several dirs
into a single one - while at the same time to mistaking the reader too
much into thinking that git cares about directories so much ;)

Callers should also be careful about interpreting the output when
mixing this behaviour with file filtering, obviously, so it is not
meant to be activated by default.

Does any of this sound sensible ?


On the technical side, I figured out that the best way to plug the
factorization was inside diffcore_rename to take advantage of the fact
it has a list of all renames, that's not going to be published out of
this function - that only left me the "cleanup:" label as insertion
point, not that I find it conceptually very comfortable :)

But if I have understood correctly, diffcore only gets access to
changed filepairs, and does not know about the trees it is comparing.

The most sensible way to go I can think of would be to give to
diffcore enough information (src and dst tree-hash|"INDEX"|"WORKING
COPY") to be able to know for directory existence.  I'd rather check
it does not sound completely wrong to anyone before going into that -
opinions ?

Best regards,
-- 
Yann
