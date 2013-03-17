From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] combine-diff: coalesce lost lines optimally
Date: Sun, 17 Mar 2013 14:58:59 +0100
Message-ID: <CALWbr2xWYiFULLDVA7b9WrVtmfdAvZC9SKBHjZE9aRc6kfRMGA@mail.gmail.com>
References: <7vboalw6lt.fsf@alter.siamese.dyndns.org>
	<1363525436-21667-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 17 14:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHE7b-000326-Bm
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 14:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab3CQN7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 09:59:01 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47785 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3CQN7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 09:59:00 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so2311693qcq.19
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XxRThsMgomRIVukrTS+7DEsJZ8ITgNiov7NB11Tzs9A=;
        b=ktel6wSMxtcKt0eVhUcmF8ISsBDRgFjHN0fzTrFXCGb5/viHFHs4lnDfTf3M/G28u3
         UlAY9vEvqqm0eGoMEv6du4yznmECCJxvNNb16rRKq85Nup1619iluYtQRnGpCTBUgIj3
         7rwH8vKafS17sQo0ayqwNJIcABuiaVKXToiP2ZH/nrjoBp78kud6q1rFS38P89LaKvM8
         ebiGbDmH+3yHzvMII3AAquD3VgKM0KdTAMz6qenbXHWxM56Qst2ygM4RR0w2D75BJ+QD
         q8j3RUDb9rPGH4joq+JKg1cPLz4kPqBnYGJzvvXvA9x+A+5jL4pNwjbXgEKYkz6gsawK
         OZcA==
X-Received: by 10.224.122.140 with SMTP id l12mr10110827qar.77.1363528739443;
 Sun, 17 Mar 2013 06:58:59 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 17 Mar 2013 06:58:59 -0700 (PDT)
In-Reply-To: <1363525436-21667-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218364>

> I'm also having a hard time trying it with more than two parents. How I
> am supposed to have more than two parents while octopus merge refuses if
> there are conflicts ?

OK, creating the merge commit myself solves the issue:

git init
>test
git add test
git commit -m initial

seq 100 >test
git commit -m all -a

git checkout -b side1 HEAD^1
seq 1 2 100 >test
git commit -m side1 -a

git checkout -b side2 HEAD^1
seq 1 4 100 >test
git commit -m side2 -a

git checkout -b side3 HEAD^1
seq 1 8 100 >test
git commit -m side3 -a

git checkout -b side4 HEAD^1
seq 1 16 100 >test
git commit -m side4 -a

git checkout master
>test
git add test
TREE=$(git write-tree)
COMMIT=$(git commit-tree $TREE -p master -p side1 -p side2 -p side3 -p
side4 -m merge)
git show $COMMIT

This will work with the basic greedy implementation if all parents are
in this order. But the optimal result will be lost if we change the
order of -p parameters in git-commit-tree.
The patch seems to be correct, always finding the best result (we
always have 100 lines diff) whatever the order of parents.
