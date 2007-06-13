From: Gerrit Pape <pape@smarden.org>
Subject: unexpected git-cherry-pick conflict
Date: Wed, 13 Jun 2007 09:16:24 +0000
Message-ID: <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
References: <20070405071615.2915.6837.reportbug@acer> <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org> <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 417885@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 11:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyOxd-0005Ys-A4
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbXFMJQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbXFMJQH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:16:07 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:44212 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755356AbXFMJQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:16:06 -0400
Received: (qmail 26464 invoked by uid 1000); 13 Jun 2007 09:16:24 -0000
Mail-Followup-To: git@vger.kernel.org, 417885@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50035>

On Thu, Jun 07, 2007 at 11:52:19AM +0200, Remi Vanicat wrote:
> how to reproduce :
> create a repos with a link in it, then in a branch, remove the link,
> and add a directory in place of the link (same name).
> 
> Then try to cherry pick a commit from a branch where there is the
> directory into a branch where there is the link : it failed even if
> the modification ave nothing to do with said link/directory.

Hi, please see http://bugs.debian.org/417885

This is how I can reproduce the conflict, and I too didn't expect that.
The link/dir that conflicts is not changed in the commit that's
cherry-pick'ed:

 $ mkdir repo && cd repo
 $ git init
 Initialized empty Git repository in .git/
 $ echo foo >file
 $ ln -s dangling link
 $ git add .
 $ git commit -mfoo
 Created initial commit c6a9189: foo
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 file
  create mode 120000 link
 $ git checkout -b branch
 Switched to a new branch "branch"
 $ git rm link
 rm 'link'
 $ git commit -mremovelink
 Created commit 2c60f15: removelink
  1 files changed, 0 insertions(+), 1 deletions(-)
  delete mode 120000 link
 $ mkdir link
 $ echo bar >link/file
 $ git add link
 $ git commit -m adddir
 Created commit d3b30b5: adddir
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 link/file
 $ echo bar >>file
 $ git commit -mfile file
 Created commit 8ddc4d5: file
  1 files changed, 1 insertions(+), 0 deletions(-)
 $ git checkout master
 Switched to branch "master"
 $ git cherry-pick 8ddc4d5
 CONFLICT (file/directory): There is a directory with name link in
 8ddc4d5... file. Added link as link~HEAD
 Automatic cherry-pick failed.  After resolving the conflicts,
 mark the corrected paths with 'git-add <paths>'
 and commit the result.
 When commiting, use the option '-c 8ddc4d5' to retain authorship and
 message.
 $ 

Thanks, Gerrit.
