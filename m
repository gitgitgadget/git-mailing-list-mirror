From: Tomas Carnecky <tom@dbservice.com>
Subject: [RFC] New type of remote helpers
Date: Sun, 03 Oct 2010 13:33:38 +0200
Message-ID: <4CA86A12.6080905@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 03 13:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2MpH-0005RE-0x
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 13:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0JCLdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 07:33:50 -0400
Received: from office.neopsis.com ([78.46.209.98]:48324 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab0JCLdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 07:33:49 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.000,BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for git@vger.kernel.org;
	Sun, 3 Oct 2010 13:33:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157860>

My work has the goal of making interaction with foreign SCMs more
natural. The work that was done on remote helpers is the right
direction. But the 'import' and 'export' commands are the wrong approach
I think. The problem I have with 'import' is that updating the refs is
left up to the remote helper (or git-fast-import). So you lose the nice
output from ls-remote/fetch: non-ff and other warnings etc. I slightly
modified how the remote helpers (and fast-import) work, now they behave
exactly like 'core' git when fetching: Git tells the remote helper to
fetch some refs, the helper does that and creates a pack and git then
updates the refs (or not, depending on fast-forward etc). To test this
approach I created a simple remote helper for svn.

The work is available in the 'remote-helper-fixups' branch at
http://github.com/wereHamster/git. No end-user or technical
documentation is available as of yet. The svn remote helper is only an
example how remote helpers can use the new commands. You can see it as a
'technology preview', use with caution.

Here is an example session of how I think foreign SCMs should integrate
with git. For each command I explain what changes were needed. This is
not just some theoretical output. This is a real, working example. I did
not modify any of the output text.

$ git ls-remote svn::/Volumes/Dump/Source/Mirror/Transmission/
r1017 (impure)                            trunk
r919 (impure)                             branches/nat-traversal
r480 (impure)                             branches/0.6

Git learned to understand version numbers from foreign SCMs. Git
displays those as 'impure' because it knows that version exists but does
not know yet which git commit that version maps to.


$ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
*:refs/remotes/svn/*
From svn::/Volumes/Dump/Source/Mirror/Transmission
 * [new branch]      trunk      -> svn/trunk
 * [new branch]      branches/nat-traversal -> svn/branches/nat-traversal
 * [new branch]      branches/0.6 -> svn/branches/0.6

Git tells the remote helper to 'fetch r1017 trunk'.  The remote helper
does that, creates the pack and then tells git that it imported r1017 as
commit c5fed7ec. This is done with a new reply to the 'fetch' command:
'map r1017 c5fed7ec'. The remote helper can use that to inform core git
as which git commit the impure ref was imported. Git can then update the
refs. At no point does the remote helper manipulate refs directly.

The pack is created by a heavily modified git-fast-import. The existing
fast-import not only creates the pack but also updates the refs. This is
no longer desired as git is in charge of updating the refs. My modified
fast-import works like this: After creating a commit, it writes it's git
object name to stdout. That way the remote helper can figure out as
which git commits the svn revisions were imported and relay that back to
core git using the above described 'map' reply.


$ git show --show-notes=svn svn/trunk
commit c5fed7ecc318363523d3ea2045e1c16a378bb10c
Author: livings124 <livings124@localhost>
Date:   Wed Oct 18 13:57:19 2006 +0000

    more traditional toolbar icons for those afraid of change

Notes (svn):
    b4697c4a-7d4c-4a30-bd92-6745580d73b3/trunk@1017

The svn helper needs to be able to map svn revisions to git commits.
git-svn does this by adding the 'git-svn-id' line to each commit
message. I'm using git notes for that and it seems to work just fine.
The note contains the repo UUID, path within the repo and revision.

There was a challenge how to update the notes ref (refs/notes/svn). As
with fast-import, I did not want the remote helper to do it. Neither the
remote helper nor fast-import should be writing any refs. But core git
can only update refs which were discovered during transport->fetch(). I
modified the remote helper 'fetch' command and the transport->fetch()
function to return an optional list of refs. These are the refs that the
remote helper wants to update but which should not be presented to the
user (because these are internally used refs, such as my svn notes).

So the whole session between git and my svn remote helper looks like this:
> list
< :r1017 trunk
> fetch :r1017 trunk
[helper creates the pack including history up to r1017 and associated
svn notes]
< map r1017 <commit corresponding to r1017>
< silent refs/notes/svn <new commit which stores the updated svn notes>


$ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
*:refs/remotes/svn/*
From svn::/Volumes/Dump/Source/Mirror/Transmission
   c5fed7e..228eaf3  trunk      -> svn/trunk

$ git fetch svn::/Volumes/Dump/Source/Mirror/Transmission/
*:refs/remotes/svn/*
From svn::/Volumes/Dump/Source/Mirror/Transmission
   228eaf3..207e5e5  trunk      -> svn/trunk
 * [new branch]      branches/scrape -> svn/branches/scrape
 * [new branch]      branches/multitracker -> svn/branches/multitracker
 * [new branch]      branches/io -> svn/branches/io

Updating the svn branches works like expected. The remote helper
automatically detects which branches it already imported (by going
through all refs and the attached svn notes) and creates a new pack with
the new commits. New branches are also detected. The svn notes are
updated accordingly.

tom
