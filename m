From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/13] Sequencer with continuation features
Date: Tue, 21 Jun 2011 13:04:36 +0000
Message-ID: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0dZ-0005k6-Td
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab1FUNEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:04:55 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51876 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1FUNEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:04:53 -0400
Received: by vxb39 with SMTP id 39so1679724vxb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=NPMdsfhs2+f1iWJ5LLZ1icsSVCCSu2HXZiyDLrk73Mk=;
        b=VQRrjfhRiv6wNI27SrqlM6B5DdSuLuCIjufNlLE61XOi+7z/TWuB5RFYsHfpAMiDBd
         4KERezBpPEB7Dos83mWaY6PsscbQsM1tk7r/YhkG/IR7dPA9vlDFoQMAsSpCpp3dLQr7
         dCtwV2z0KeIXxcZdEUj0tzXm7UICCz2XVu8zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A+Vb+qY63mmXFc2MOkrVlyEM54/XcFZ9SUkdp/j7NOfHpzXtl3KIn9PCbOk1lbZdGQ
         M27UmYcoeCPsBC+38S1fcW4VugFgB/ngf/qXPKIsMq3geNYpso3cx6lA3QIdecPLtFJz
         A0eYior/AwQXKflp/xNFBCYxfNT5Iw7iM84V4=
Received: by 10.52.73.65 with SMTP id j1mr2957045vdv.248.1308661492970;
        Tue, 21 Jun 2011 06:04:52 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.04.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:04:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176139>

Hi,

The much awaited cherry-pick --continue and --skip-all are here.  Much
thanks to Jonathan for all his inputs.  I think I can safely say that
I'm quite happy with the general state of this series now.  Apart from
the introduction of the the new features, there have been a few minor
improvements in the rest of the series since the last iteration.
Unfortunately, it's still not ready for inclusion for the following
reasons:
1. --skip-all isn't a great name; maybe --quit as Christian suggested?
2. I don't know what to do when a reset is invoked.  If we do nothing,
we'd break users' habits.  Jonathan suggested that we move
.git/sequencer to .git/sequencer-cancelled on a hard reset, and this
seems like a plausible solution.  More inputs on this?
3. --continue is obviously broken, because of lack of command-line
option support.  I think I should evolve the parser little by little-
first, I can persist the global opts structure, and then start
supporting per-command options.  That way, it'll be easy to get the
parser reviewed.
4. Tests are too basic.  I need to write more elaborate tests.

Thanks for reading.

Note: The series is also available on the 'sequencer-continue' branch of my
GitHub fork: http://github.com/artagnon/git

-- Ram

Ramkumar Ramachandra (13):
  advice: Introduce error_resolve_conflict
  revert: Factor out add_message_to_msg function
  revert: Don't check lone argument in get_encoding
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Rename no_replay to record_origin
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Catch incompatible command-line options early
  revert: Persist data for continuation
  revert: Introduce a layer of indirection over pick_commits
  revert: Introduce --skip-all to cleanup sequencer data
  revert: Introduce --continue to continue the operation

 advice.c                           |   19 +-
 advice.h                           |    1 +
 builtin/revert.c                   |  585 +++++++++++++++++++++++++++---------
 git-rebase--interactive.sh         |   25 ++-
 t/t3032-merge-recursive-options.sh |    2 +
 t/t3501-revert-cherry-pick.sh      |    1 +
 t/t3502-cherry-pick-merge.sh       |    9 +-
 t/t3504-cherry-pick-rerere.sh      |    2 +
 t/t3505-cherry-pick-empty.sh       |   14 +-
 t/t3506-cherry-pick-ff.sh          |    3 +
 t/t3507-cherry-pick-conflict.sh    |   24 ++-
 t/t3510-cherry-pick-sequence.sh    |   79 +++++
 t/t7502-commit.sh                  |    1 +
 13 files changed, 596 insertions(+), 169 deletions(-)
 create mode 100644 t/t3510-cherry-pick-sequence.sh

-- 
1.7.5.GIT
