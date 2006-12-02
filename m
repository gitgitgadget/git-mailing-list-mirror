X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 21:16:42 +0100
Organization: At home
Message-ID: <eksmrf$c33$1@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 20:14:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 162
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33040>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbGC-0003nl-Iq for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031778AbWLBUOx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031777AbWLBUOx
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:14:53 -0500
Received: from main.gmane.org ([80.91.229.2]:30354 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031762AbWLBUOw (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:14:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqbG3-0003lg-Cn for git@vger.kernel.org; Sat, 02 Dec 2006 21:14:47 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 21:14:47 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 21:14:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Few thoughts on this topic. Some of those are repeating what
was said eaelier

1. Submodule (subproject) as commit-in-a-tree

Let's try to paint a little diagram (attribution missing):

belonging to:
/--------- supermodule -------\    /---- submodule -------\

commit -> tree +-> blob
  |            +-> tree -> ...
  |            +-----------------> commit -> tree -> ...
  v                                  |
commit -> tree +-> ...               v
  |            +-----------------> commit -> ...
  v                        /         |
commit -> tree +-> ...    /          |
  |            +---------/           v
  |                                commit -> ...
  v                                  |
commit -> tree +-> ...               v
               +-----------------> commit

Both have their independent history, but they are linked as some
submodule versions are part of the supermodule tree.


2. Working area for project with submodules

Submodule as separate repository model
supermodule
+ .git/  <------------------------.
  + HEAD                          |
  + index                         |
  + objects/                      |
  + objects/info/alternates ---.  |
+ subdir1/                     |  |
  + sub1file                   |  ^                   
+ submodule/                   |  |
  + .git                       v  |
    + HEAD                     |  |
    + index                    |  |
    + objects/  <--------------'  |
    +[objects/info/borrowers] ----'
  + subsubdir/
    + submfile
+ file

Embedded submodule model
supermodule
+ .git/
  + HEAD
  + index
  + objects/
  +[refs/submodules/submodule/HEAD]
  +[refs/submodules/submodule/index]
+ subdir1/
  + sub1file
+ submodule/
  + subsubdir/
    + submfile
+ file

The [fictional] borrowers file is for git-prune and friends (also
git-repack with -d option) to not remove objects needed by supermodule
(when for example submodule history got rewritten). But you can do
without it, as long as you don't rewind or don't prune in
supermodule.

The problem with submodule as separate git repository is that if you
move submodule (subproject) somewhere else in the repository (or just
rename it), you have to update alternates file... and this happens not
only on move itself, but also on checkout and reset. But that can be
managed by having in alternates all possible places the submodule ends
into. I don't know if it is truly a problem.

Alternate solution would be to have submodule objects [also] in the
main (superproject) object database (for example fetched from
submodule object repository on supermodule commit with changing
submodule).

Perhaps instead of objects/info/alternates we should use
objects/info/modules, or even modules file (as top .git dir).


The problem with embedded submodule model is ensuring that changes in
submodule go to submodule (using submodule refs; at least HEAD and
submodule index). And there are troubles with treating submodule
separately, for example cloning submodule only, or fetching from
submodule only.


3. Output of git-ls-tree and git-ls-files (git-ls-index ;-) for
project with submodules.

$ git ls-tree HEAD
040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2    subdir1
140000 subm ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7    submodule
100644 blob a57a33b81ac6c9cb5ec0c833edc21bd66428d976    file

$ git ls-tree -r -t HEAD
040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2    subdir1
100644 blob 70d8b9838a7333bc5a1edb93cf0e9abdbcf146cc    subdir1/sub1file
140000 subm ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7    submodule
040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2    submodule/subsubdir
100755 blob 6579f06b05c91f00f4f45015894f2bfab1076bf6    submodule/subsubdir/submfile
100644 blob a57a33b81ac6c9cb5ec0c833edc21bd66428d976    file

$ git ls-files --stages
100644 70d8b9838a7333bc5a1edb93cf0e9abdbcf146cc 0   subdir1/sub1file
140000 ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7 0   submodule
100644 a57a33b81ac6c9cb5ec0c833edc21bd66428d976 0   file


4. Workflow(s) for project with submodules

$ cd submodule
submodule$ edit subsubdir/submfile
submodule$ git update-index subsubdir/submfile  # this updates submodule index
submodule$ git commit -m "Submodule change"     # this changes submodule HEAD
submodule$ cd ..
$ git update-index submodule                    # this updates index 
                                                  to submodule HEAD version
$ git commit -m "Change in submodule"           # this updates HEAD

Of course as usual you should be able to do "git commit -a" to skip
"git update-index". One has to remember that "git update-index
submodule" and "git commit submodule" uses HEAD version of submodule,
not the working area version.

There was an idea to update superproject index not to HEAD version
but to some specified branch version.


5. Extended sha1 syntax for submodules

For [almost] all commands the commit-in-tree should
be viewed as tree-ish, for example in HEAD:submodule/subsubdir (is a
tree), or HEAD:submodule/subsubdir/submfile (is a blob).

Currently a suffix ':' followed by a path names the blob or tree (or
commit) at the given path in the tree-ish object named by the part
before the colon. You cannot currently use it recirsively, i.e. use
<tree-ish>:<path> to refer to tree (or commit), and use ':' after
that, e.g. <tree-ish>:<path>:<subpath>... well, currently this has not
much sense, as you can (and have to) use '/' as a separator.

There was proposal to use '//' as a way to force commit object in the
tree to be treated as commit-ish, not as a tree, so you can apply all
the extended sha1 machinery suitable for commits like ^, ^n, ~n and
also probably ^@, but perhaps not @{n}. Then making ':' resursive
would be useful, for example:

  HEAD^:submodule//~2:subsubdir/submfile


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

