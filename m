From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Bugs in git filter-branch (git replace related)
Date: Thu, 28 Jan 2016 14:46:40 +0000 (UTC)
Message-ID: <loom.20160128T153147-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 16:05:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOo8T-0004hG-H3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 16:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbcA1PFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 10:05:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:49807 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785AbcA1PFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 10:05:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aOo87-0004NW-Hh
	for git@vger.kernel.org; Thu, 28 Jan 2016 16:05:03 +0100
Received: from fokus169149.fokus.fraunhofer.de ([194.95.169.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 16:05:03 +0100
Received: from anatoly.borodin by fokus169149.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 16:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.95.169.149 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285020>

Hi All!

There are two bugs in `git filter-branch`, present in the most recent
versions (d10e2cb9d0299a26f43d57dd5bdcf2b3f86a30b3), as well as in the old
ones (I couldn't find a version where it works properly).

The script:

#!/bin/sh

set -e

GIT_EXEC_PATH=/tmp/git
export GIT_EXEC_PATH
GIT=$GIT_EXEC_PATH/git

rm -rf a
mkdir a
cd a
$GIT init
echo aaa > a.txt && $GIT add a.txt && $GIT commit -a -m a
echo bbb > a.txt && $GIT add a.txt && $GIT commit -a -m b
echo ccc > a.txt && $GIT add a.txt && $GIT commit -a -m c
$GIT replace f761ec192d9f0dca3329044b96ebdb12839dbff6
72943a16fb2c8f38f9dde202b7a70ccc19c52f34
echo && echo One && $GIT filter-branch --prune-empty -- master
echo && echo Two && $GIT filter-branch --prune-empty -- --all

The output is:

...
One
Rewrite 98af0305b778bf56e25a0d4f85acdf82f435f9b3 (3/3) (0 seconds passed,
remaining 0 predicted)    
WARNING: Ref 'refs/heads/master' is unchanged

Two
Rewrite 98af0305b778bf56e25a0d4f85acdf82f435f9b3 (3/3) (0 seconds passed,
remaining 0 predicted)    
WARNING: Ref 'refs/heads/master' is unchanged
error: object 72943a16fb2c8f38f9dde202b7a70ccc19c52f34 is a blob, not a commit
error: object 72943a16fb2c8f38f9dde202b7a70ccc19c52f34 is a blob, not a commit
fatal: ambiguous argument
'refs/replace/f761ec192d9f0dca3329044b96ebdb12839dbff6^0': unknown revision
or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
WARNING: Ref 'refs/replace/f761ec192d9f0dca3329044b96ebdb12839dbff6' is
unchanged


The `git replace` makes the second commit empty (use the file content from
the first commit). It should disappear after `git filter-branch`, but it
doesn't happen.

Bug 1: the empty commit stays.
Bug 2: the replace refs are not ignored (they can epresent blobs, trees etc,
but even if they represent commits - should they be rewritten?).

Any ideas?

PS I've found http://article.gmane.org/gmane.comp.version-control.git/220931
, seems like the bug 1. But it's old!
