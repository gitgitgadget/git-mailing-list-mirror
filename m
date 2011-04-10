From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 0/3] --dirstat fixes
Date: Mon, 11 Apr 2011 00:48:49 +0200
Message-ID: <1302475732-741-1-git-send-email-johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93Rs-0006aH-4v
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab1DJWte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 18:49:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49073 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750Ab1DJWtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:49:33 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG004IGKQI5670@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:30 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5423C1EF0067_DA233FAB	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 26A951EEFFEB_DA233FAF	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:30 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG00KXIKQDX600@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:30 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <7vtye834al.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171293>

Here's a reroll of the previous series. Changes since v1:

- Adopt Junio's phrasing of the differences between --dirstat and
  regular diff (--stat)

- Detect and ignore pure renames in the diff queue. This is done by
  comparing the SHA1s of each file pair, and if they are equal, we
  know the files are identical, and should not show up in --dirstat.

  As an extra bonus in this version, when the SHA1s do match, we can
  bypass the usual --dirstat analysis, because we know it would find
  no changes. Instead, we can directly set damage = 0 in that case.

I've looked at the contents of the diff queue and resulting output in
a variety of cases:

- files with no changes, rearranged lines, and other changes
- files that are copied, moved, or not moved
- unstaged changes, staged changes, committed changes
- diff options: (none), --stat, --dirstat, and --dirstat-by-file
- diff options: (none), -M, and -C -C

(324 variations in total) and I'm fairly sure about the current patches
and how they interact with the diff queue.

A remaining question AFAICS is if there's a different (i.e. better) way
to (cheaply) estimate the damage contributed by code movements within a
file. The current "damage = 1" approach is somewhat crude, but IMHO
still better that ignoring code movements altogether.


Have fun! :)

...Johan


Johan Herland (3):
  --dirstat: Describe non-obvious differences relative to --stat or regular diff
  --dirstat-by-file: Make it faster and more correct
  Teach --dirstat to not completely ignore rearranged lines within a file

 Documentation/diff-options.txt                     |    4 ++
 diff.c                                             |   40 ++++++++++++++++++--
 t/t4013-diff-various.sh                            |   27 ++++++++++---
 .../diff.diff_--dirstat-by-file_initial_rearrange  |    3 +
 t/t4013/diff.diff_--dirstat_initial_rearrange      |    3 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    2 +-
 t/t4013/diff.log_--decorate=full_--all             |    6 +++
 t/t4013/diff.log_--decorate_--all                  |    6 +++
 8 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat-by-file_initial_rearrange
 create mode 100644 t/t4013/diff.diff_--dirstat_initial_rearrange

-- 
1.7.5.rc1.3.g4d7b
