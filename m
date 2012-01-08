From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] The move to sequencer.c
Date: Sun,  8 Jan 2012 17:57:27 +0530
Message-ID: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrsK-0008F4-El
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab2AHM3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2AHM3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:09 -0500
Received: by iaeh11 with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cLsK8W7gkIBMtlDcZCStEKu123qtKSFW9F6yTs5AM9k=;
        b=aYgtkHRUnaZ04paiOojEV7KuO3+JIRAwR/0j0tXdKw9q7utR41Ir5P0LC2xTsD4TX4
         avGB+zt6xfwmKodDQJLJ0xQRa9QiWUv80LZs7chNRovn6fQK4Ny58n3CRvExvfS6OhR0
         ttK2gYRlXp3a7mMENnfrZo84bQkcCojMQF9Wo=
Received: by 10.50.219.225 with SMTP id pr1mr5480253igc.21.1326025747698;
        Sun, 08 Jan 2012 04:29:07 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:06 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188106>

Hi,

I've tried a slightly different approach: the objective of the patches
seem to be much clearer this time.

[1/6] revert: move replay_action, replay_subcommand to header
[2/6] revert: decouple sequencer actions from builtin commands
[3/6] revert: don't let revert continue a cherry-pick
[4/6] revert: allow mixing "pick" and "revert" actions
[5/6] revert: report fine-grained error messages from insn parser
[6/6] sequencer: factor code out of revert builtin


[1/6] first moves out a couple of data structures to the header

[2/6] decouples "actions" from a "commands" completely.  Although this
sort of separation might not be necessary at this stage (because we
just have a couple of actions that directly correspond to builtin
commands), I think it makes [4/6] much easier to read.

[3/6] mainly exists so that [4/6] doesn't allow 'git revert
--continue' to continue a 'git cherry-pick' and viceversa.  Note that
a 'git revert --continue' can execute an instruction sheet with "pick"
instructions and viceversa after [4/6].

[4/6] should be very clear this time: do_pick_commit() takes an extra
argument "action", and checks that instead of the "opts->command"
everywhere.  The parser is also updated to parse into (commit, action)
pairs.

[5/6] is fairly straightforward.

[6/6] makes the final move.  This is something I've been pushing for
quite some time: exciting things like 'git continue' will follow this.

Cheers!

 builtin/revert.c                |  959 +-------------------------------------
 sequencer.c                     |  987 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                     |   49 ++
 t/t3510-cherry-pick-sequence.sh |   57 ++-
 4 files changed, 1088 insertions(+), 964 deletions(-)

-- 
1.7.8.2
