From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 16:23:52 -0500
Message-ID: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 22:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSNg-0007JM-Le
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab1BOVYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:24:16 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44934 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab1BOVYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:24:15 -0500
Received: by vws16 with SMTP id 16so442004vws.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 13:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=XIPcUQX+oePW4YUniVsCx+d58gbK+DICEHTcNeUOub8=;
        b=Os7R50K4/brsySgv0T0RBfzgdMQ9SY2R6m1XFHWxGX4mdqn1YH5cnY9w/jsMjEIBys
         6HQa7psx+ybiYOwReVrtpTBrz3BU158nIlOGoRDFKaFBLAsdcc35hY+G92lvLX6O27Yh
         IaHB69I6B22H/9SW6o0canh6TgQPQBVB8v2Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Phr/cMCJNB42/ANNlPJvl+v8Vb1caOByQEMfKYX4nQyAgEvU/I0Sq/trzGYJ+6zuFh
         55WBTwM7qCSZdE2ojhW9bDukgMJU46OT4Io9CYKUdSVz5JirMP5zWCZ5gLAudVatMAif
         7KNcOm4uR8SJFyFmsthdhJgSf+I+Wuj0UJ5Ek=
Received: by 10.220.70.211 with SMTP id e19mr1556020vcj.204.1297805054464;
        Tue, 15 Feb 2011 13:24:14 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id y15sm1437629vch.29.2011.02.15.13.24.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 13:24:13 -0800 (PST)
X-Mailer: git-send-email 1.7.4.5.g9affb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166878>

The user-experience after a cherry-pick conflicts is suboptimal.
The user has two choices for committing the resolved state:

1. To retain the original authorship and commit message, the user can
   'git commit -c <original commit id>'. This is what cherry-pick itself
   advises. In this case MERGE_MSG (generated during the cherry-pick) is
   ignored. That's bad since MERGE_MSG contains the list of conflicts 
   which is nice to have in the new commit. If 'cherry pick -x' was used,
   the -x annotation is lost. Asking the user to remember the original
   commit id is also a bit harsh.

2. To reset the authorship, the user can 'git commit'. This will use the
   MERGE_MSG, but the original authorship is lost.

We fix both of these issues by recording the original commit in CHERRY_HEAD
if a conflict occurs during cherr-pick. We teach commit to use CHERRY_HEAD
to retrieve the original authorship (unless --reset-author is used), but
take the commit message from MERGE_MSG.

A further improvement would be to teach cherry-pick --continue and --abort
options a la rebase, but I think that should be prototyped in shell-script.

Jay Soffian (2):
  Introduce CHERRY_HEAD
  Teach commit to handle CHERRY_HEAD automatically

 Documentation/git-commit.txt           |    7 +++--
 branch.c                               |    1 +
 builtin/commit.c                       |   36 ++++++++++++++++++++++++++-----
 builtin/revert.c                       |   20 ++++++++++++++++-
 contrib/completion/git-completion.bash |    2 +
 5 files changed, 55 insertions(+), 11 deletions(-)

-- 
1.7.4.5.g9affb
