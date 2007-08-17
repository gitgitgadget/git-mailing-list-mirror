From: Mike Hommey <mh@glandium.org>
Subject: Rewriting history with git-filter-branch and leaking objects (?)
Date: Fri, 17 Aug 2007 19:18:51 +0200
Organization: glandium.org
Message-ID: <20070817171851.GB13891@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 19:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5Tv-0005rl-Cq
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685AbXHQRTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757786AbXHQRTZ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:19:25 -0400
Received: from vawad.err.no ([85.19.200.177]:56878 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757600AbXHQRTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:19:24 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM5Tm-0008H9-12
	for git@vger.kernel.org; Fri, 17 Aug 2007 19:19:25 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM5TH-0003fM-20
	for git@vger.kernel.org; Fri, 17 Aug 2007 19:18:51 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56071>

Hi,

I've been playing with git-filter-branch, and was wondering how objects
from the original branch are supposed to be removed.

It looks like removing the refs/original/* refs is not enough.

And it also looks like when all references seem to be removed, git-prune
doesn't fully do its job...

See the following transcript:

$ git init
Initialized empty Git repository in .git/
$ echo a > a ; echo b > b
$ git add a b
$ git commit -m "add a b"
Created initial commit b8875b1: add a b
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 a
 create mode 100644 b
$ echo a >> a
$ git commit -a -m "update a"
Created commit fd97ed9: update a
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git-filter-branch --index-filter 'git-update-index --remove b' HEAD
Rewrite fd97ed9a2fef62eca824361fb62269e3c1fc0fb8 (2/2)
Ref 'refs/heads/master' was rewritten

These refs were rewritten:
fatal: Not a git repository: '/tmp/test/.git-rewrite/t/../../.git'

(This is a message that happens when GIT_DIR is not set, I guess the
patches that were sent a few days ago on the list fix this issue)

$ git-cat-file commit b8875b1
tree 3683f870be446c7cc05ffaef9fa06415276e1828
author Mike Hommey <mh@namakemono.glandium.org> 1187369087 +0200
committer Mike Hommey <mh@namakemono.glandium.org> 1187369087 +0200

add a b

(not a surprise, since we still have the refs/original/refs/heads/master
ref)

$ git-update-ref -d refs/original/refs/heads/master fd97ed9
$ git-cat-file commit b8875b1
tree 3683f870be446c7cc05ffaef9fa06415276e1828
author Mike Hommey <mh@namakemono.glandium.org> 1187369087 +0200
committer Mike Hommey <mh@namakemono.glandium.org> 1187369087 +0200

add a b
$ git fsck

(okay, so it is still here, and obviously still referenced ; it appears
to be referenced in .git/logs/...)

$ rm .git/logs/refs/heads/master 
$ rm .git/logs/HEAD
$ git fsck
dangling commit fd97ed9a2fef62eca824361fb62269e3c1fc0fb8

(finally ! So here is a first question: is there a proper way to clean
this out ? rm of the logs sounds brutal...)

$ git-prune -n
3683f870be446c7cc05ffaef9fa06415276e1828 tree
b8875b1095616c1e7e8f8ffce8ebc172059367ea commit
fd97ed9a2fef62eca824361fb62269e3c1fc0fb8 commit
$ git-cat-file commit fd97ed9a2fef62eca824361fb62269e3c1fc0fb8
tree c1f89248e4b6e47a4529d50d37b0840a14d2efb0
parent b8875b1095616c1e7e8f8ffce8ebc172059367ea
author Mike Hommey <mh@namakemono.glandium.org> 1187369110 +0200
committer Mike Hommey <mh@namakemono.glandium.org> 1187369110 +0200

update a

(Why doesn't prune -n tell me it would remove
c1f89248e4b6e47a4529d50d37b0840a14d2efb0, which it should, AFAIK ?)

Mike
