From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix new-workdir (again) to work on bare repositories
Date: Wed, 22 Aug 2007 01:33:49 -0400
Message-ID: <20070822053349.GO27913@spearce.org>
References: <20070822015012.GA11085@spearce.org> <7v1wdwntc6.fsf@gitster.siamese.dyndns.org> <20070822033625.GN27913@spearce.org> <7v3ayckx1m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 07:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INiqx-000300-Hu
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 07:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbXHVFdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 01:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbXHVFdy
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 01:33:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38899 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbXHVFdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 01:33:54 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INiql-0003NR-BE; Wed, 22 Aug 2007 01:33:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C1C8C20FBAE; Wed, 22 Aug 2007 01:33:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3ayckx1m.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56353>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > So removing that core.bare thing makes the magic work.
> 
> Ok, that is better than the response I sent (our messages
> crossed).  In that case, perhaps you would want a warning or a
> suggestion at the end of new-workdir script, probably before
> checkout, to teach the user about that magic?

-->8--
Suggest unsetting core.bare when using new-workdir on a bare repository

If core.bare is set to true in the config file of a repository that
the user is trying to create a working directory from we should
abort and suggest to the user that they remove the option first.

If we leave the core.bare=true setting in the config file then
working tree operations will get confused when they attempt to
execute in the new workdir, as it shares its config file with the
bare repository.  The working tree operations will assume that the
workdir is bare and abort, which is not what the user wants.

If we changed core.bare to be false then working tree operations
will function in the workdir but other operations may fail in the
bare repository, as it claims to not be bare.

If we remove core.bare from the config then Git can fallback on
the legacy guessing behavior.  This allows operations in the bare
repository to work as though it were bare, while operations in the
workdirs to act as though they are not bare.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/workdir/git-new-workdir |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 119cff9..c6e154a 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -33,6 +33,14 @@ case "$git_dir" in
 	;;
 esac
 
+# don't link to a configured bare repository
+isbare=$(git --git-dir="$git_dir" config --bool --get core.bare)
+if test ztrue = z$isbare
+then
+	die "\"$git_dir\" has core.bare set to true," \
+		" remove from \"$git_dir/config\" to use $0"
+fi
+
 # don't link to a workdir
 if test -L "$git_dir/config"
 then
-- 
1.5.3.rc6


-- 
Shawn.
