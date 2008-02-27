From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 0/9] More on worktree fixes
Date: Wed, 27 Feb 2008 23:37:52 +0700
Message-ID: <20080227163752.GA27998@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPJ8-0001Gm-Us
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbYB0QiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbYB0QiB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:38:01 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:56726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbYB0QiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:38:00 -0500
Received: by an-out-0708.google.com with SMTP id d31so645074and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=61Zn43pd+q3+SV5YgJ4yQZsRqsmq/AkMVTmyJ0F6mFE=;
        b=dr8UrexBelssMdfneCb96gt4UdYSLIE4ZCQXuj6JwoBVqj97nl0fcTxtXq2inrwBwusURby00Ab0KWkXZc0IgYWW7BWfWAuRGTvRV8x1pheFq283+ASVgI/DUYrkSToQ3pnHsSMKYzH54YRB2AV4Y9OtHMrnYvffoS4mlhw75UE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=hxQFy0ADbIhnEoXQ7S0XatJOMGDZ0+f0kY9ZYenDS/H76KMNtUG1pDJnkSRS2LWHXt+8+GSXP9+A2njGEQOMyDZT3lDY0c0gyYuN1GyRkh0fEyfiZE3kWaPb8AHoQRd9NtQIu0klyBOwgaQorFjOaCdxx9exHEnp4DclRTsw8pM=
Received: by 10.100.206.11 with SMTP id d11mr12642600ang.92.1204130278637;
        Wed, 27 Feb 2008 08:37:58 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id c37sm13058490ana.9.2008.02.27.08.37.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:37:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:37:52 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75233>

This series cleans up setup.c and makes git handle worktree better.
The series deprecates my patch "Move worktree setup out of..."
Main points:

 - get_git_dir() is now always absolute path.

 - setup_git_directory_gently() will no longer do
   any worktree setup. If you want worktree with
   setup_git_directory_gently(), call setup_work_tree().

 - setup_git_directory() will still setup worktree if found. The
   behavior is a bit more consistent as it will setup worktree no
   matter where it comes from. GIT_WORK_TREE, core.worktree or
   autodetection are treated the same.

 - Document setup api along the way.

"make test" was run on each patch. Hopefully the series won't break
anything. Tests will come later, my brain has been overheated.

Remaining problems I'm aware of:

 - prefix when running a command from outside worktree (currently NULL)
 - cmd_update_index() needs setup_work_tree()

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
      "git read-tree -m" and the like require worktree
      Make sure setup_git_directory is called before accessing reposito=
ry
      Make get_git_dir() and 'git rev-parse --git-dir' absolute path
      Make setup_work_tree() return new prefix
      http-push: Avoid calling setup_git_directory() twice
      Completely move out worktree setup from setup_git_directory_gentl=
y()
      builtin-archive: mark unused prefix "unused_prefix"
      Make setup_git_directory() auto-setup worktree if found
      Documentation: update api-builtin and api-setup

 Documentation/technical/api-builtin.txt |   10 +++
 Documentation/technical/api-setup.txt   |   70 +++++++++++++++++--
 builtin-apply.c                         |    7 ++-
 builtin-archive.c                       |    6 +-
 builtin-blame.c                         |    4 +-
 builtin-bundle.c                        |    9 +--
 builtin-config.c                        |   15 ++---
 builtin-diff-files.c                    |   12 ++--
 builtin-diff.c                          |   13 ++--
 builtin-ls-files.c                      |   10 ++--
 builtin-read-tree.c                     |    3 +
 builtin-rev-parse.c                     |   23 ++----
 builtin-rm.c                            |    5 +-
 builtin-upload-archive.c                |    4 +-
 cache.h                                 |    4 +-
 environment.c                           |    1 +
 fast-import.c                           |    1 +
 git.c                                   |    8 +--
 hash-object.c                           |   14 +---
 http-push.c                             |    4 +-
 index-pack.c                            |    2 +
 setup.c                                 |  114 +++++++++++------------=
-------
 t/t1300-repo-config.sh                  |    2 +-
 t/t1400-update-ref.sh                   |    4 +-
 t/t9300-fast-import.sh                  |    2 +-
 25 files changed, 184 insertions(+), 163 deletions(-)
