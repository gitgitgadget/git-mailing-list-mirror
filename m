From: Kirill Smelkov <kirr@nexedi.com>
Subject: [ANNOUNCE] Git-backup - Backup set of Git repositories & just files;
 efficiently
Date: Wed, 27 Jan 2016 18:09:01 +0300
Message-ID: <20160127150900.GB32669@teco.navytux.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kazuhiko Shiozaki <kazuhiko@nexedi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 16:17:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aORoB-0002vC-QV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529AbcA0POz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 10:14:55 -0500
Received: from mail2.tiolive.com ([94.23.229.207]:58257 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677AbcA0POw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:14:52 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2016 10:14:52 EST
Received: from teco.navytux.spb.ru (95-55-9-117.dynamic.avangarddsl.ru [95.55.9.117])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 48B06BF021B;
	Wed, 27 Jan 2016 16:09:04 +0100 (CET)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.86)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1aORiP-00052S-6D; Wed, 27 Jan 2016 18:09:01 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284913>

https://lab.nexedi.com/kirr/git-backup.git

This program backups files and set of bare Git repositories into one Git repository.
Files are copied to blobs and then added to tree under certain place, and for
Git repositories, all reachable objects are pulled in with maintaining index
which remembers reference -> sha1 for all pulled repositories.

This allows to leverage Git's good data deduplication ability, especially for
cases when there are many hosted repositories which are forks of each other,
and for backup to have history and be otherwise managed as a usual Git
repository.  In particular it is possible to use standard git pull/push to
synchronize backups in several places.

Backup workflow is:

1. create backup repository::

     $ mkdir backup
     $ cd backup
     $ git init         # both bare and non-bare possible

2. pull files and Git repositories into backup repository::

     $ git-backup pull dir1:prefix1 dir2:prefix2 ...

   This will pull bare Git repositories & just files from `dir1` into backup
   under `prefix1`, from `dir2` into backup prefix `prefix2`, etc...

3. restore files and Git repositories from backup::

     $ git-backup restore <backup-state-sha1> prefix1:dir1

   Restore Git repositories & just files from backup `prefix1` into `dir1`,
   from backup `prefix2` into `dir2`, etc...

   Backup state to restore is taken from <backup-state-sha1> which is sha1 or
   ref pointing to backup repository state.

4. backup repository itself can be managed with Git. In particular it can be
   synchronized between several places with standard git pull/push, be
   repacked, etc::

     $ git push ...
     $ git pull ...


Technical overview of how it works
----------------------------------

After objects from backuped Git repositories are pulled in, we create new
commit which references tree with changed backup index and files, and also has
all head objects from pulled-in repositories in its parents(*). This way backup
has history and all pulled objects become reachable from single head commit in
backup repository. In particular that means that the whole state of backup can
be described with only single sha1, and that backup repository itself could be
synchronized via standard git pull/push, be repacked, etc.

Restoration process is the opposite - from a particular backup state, files are
extracted at a proper place, and for Git repositories a pack with all objects
reachable from that repository heads is prepared and extracted from backup
repository object database.

Data for all backuped files and repositories can be accessed if one has access
to backup repository, so either they all should be in the same security domain,
or extra care has to be taken to protect access to backup repository.

File permissions are not managed with strict details due to inherent
nature of Git. This aspect can be improved with e.g. etckeeper-like
(http://etckeeper.branchable.com/) approach if needed.

NOTE the idea of pulling all refs together is similar to git-namespaces
     http://git-scm.com/docs/gitnamespaces

(*) Tag objects are handled specially - because in a lot of places Git insists and
    assumes commit parents can only be commit objects. We encode tag objects in
    specially-crafted commit object on pull, and decode back on backup restore.

    We do likewise if a ref points to tree or blob, which is valid in Git.
