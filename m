From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 0/7] rebase -i: Implement `reword` and `squash` in terms
 of `do_pick`
Date: Thu, 19 Jun 2014 05:28:18 +0200
Message-ID: <53A258D2.7080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1W-0002jM-U7
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbaFSD2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:23 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39696 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSD2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:22 -0400
Received: by mail-wi0-f174.google.com with SMTP id bs8so8620006wib.7
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=01GOuMFSZRlQwL3IwykH292QUqds1/lC8upe/ONk1o8=;
        b=cvhlG5ax5RQiAZr9ABX8GCz5Z1MlnGxWqEgOY44YP/C5JKMUhoYG9nLa5o9eiStK4V
         tPDoQ26n9hUNYVo6oxIHxj60SNGn8C91XhGoBQLKKYIExOxl1+FUUtJ13zLec/oQVBA3
         0Lb951lsqLmjDFAiHITY4dzbK9sLvVDMnf+rTk5EiAwVApDSdpGXPcdvz7l6zjUtmV7S
         XhTascxJsssavVlICAiV+tU41Eo7wL/Vc2rxVr6SZo47VfGFFeolchHoEKOjPrqqt93h
         ZFykgcm9kRokWLKontrdzOY5AiEDuv8ZhFi5XIL2jqNAeVxBrmoqQi6OjAl5O/kW3zkd
         AeoA==
X-Received: by 10.180.103.228 with SMTP id fz4mr2605040wib.4.1403148501126;
        Wed, 18 Jun 2014 20:28:21 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id gr6sm7451826wib.10.2014.06.18.20.28.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252088>

Hi,

This patch series is part of the undertaking to add command line options
to to-do list commands. The goal is to be able to write something
similar to

    pick --reset-author --signoff a Some changes
    pick                          b Some more changes
    squash --no-edit              c Ack Some more changes.

The first submission to the mailing list adds options parsing to
`do_pick` and reimplements the current set of to-do list commands in
terms[1] of a parametrized `do_pick`. It neither adds new commands to
to-do lists nor exposes the command line options feature to the user.
Still it makes the implementation of `do_next` slightly more
straight-forward and the function `do_pick` behave more like an internal
git-cherry-pick.

The patches try to accomplish one thing at a time but are not standalone
in the sense that each of them constitutes a frame only in which a
subsequent patch can express its one thing. For instance, only
committing once and not dying in `do_pick` are things specific to
implementing `squash` in terms of `do_pick` but presented as separate
patches so that their correctness can be discussed independently.

The last patch contains some notes about when to run the post-rewrite
hook, something I could not figure out myself.

Thanks for your time,
   Fabian

[1] pick, reword, squash, fixup

Fabian Ruch (7):
  rebase -i: Make option handling in pick_one more flexible
  rebase -i: Teach do_pick the option --edit
  rebase -i: Stop on root commits with empty log messages
  rebase -i: Commit only once when rewriting picks
  rebase -i: Do not die in do_pick
  rebase -i: Prepare for squash in terms of do_pick --amend
  rebase -i: Teach do_pick the options --amend and --file

 git-rebase--interactive.sh    | 194 +++++++++++++++++++++++++++++++-----------
 t/t3404-rebase-interactive.sh |   8 ++
 t/t3412-rebase-root.sh        |  39 +++++++++
 3 files changed, 193 insertions(+), 48 deletions(-)

-- 
2.0.0
