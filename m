From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Wed, 17 Nov 2010 10:22:02 +0100
Message-ID: <AANLkTin3vbW7LFjJrS8yAyrWxVU=zorawAQAs8F1siSF@mail.gmail.com>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
	<20101116112406.GA18259@do>
	<AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
	<AANLkTimp1ZvVLnRQa+LssbeO7F=9MrA56aZgFHQnbZCK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 10:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIeDV-0006ZU-Su
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 10:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934644Ab0KQJWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 04:22:06 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52023 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934634Ab0KQJWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 04:22:04 -0500
Received: by bwz15 with SMTP id 15so1361450bwz.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 01:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wXXDj2CZkZ6LhQcoR6m74fvJtZCDZ161N2PZfUGCqCU=;
        b=obfv1TLme7ooh/8grd4J2YAQ7xZ1L/UOAaX33hKBHeifOBbHgPrLtGz+V/USQpM/Rz
         MJiW9GdA3x6aspC7edYG3jae/588O2noz+fqihSxV7+UYpCsG720pTvhLjCB5jKt7FJI
         RtdSyeGvYSpWO2MhjejBiNW5ge5qojlrJhZxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hxk4dqeKt9waywJmeP8Wff+3pb+59Yvof4zAImLJfQs27tAWTrUmJ2PIDhWx/r1q5S
         oYnaZWcOKnXNLkNvYJHpJfkmlr8521i0RhQM1OjnATASleDo2SGrVDjThIoxKJAFgGhV
         GgDllwAmtKQusjblAMAGA8cFT8icLLt3vn4V0=
Received: by 10.223.108.147 with SMTP id f19mr6676228fap.68.1289985722912;
 Wed, 17 Nov 2010 01:22:02 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Wed, 17 Nov 2010 01:22:02 -0800 (PST)
In-Reply-To: <AANLkTimp1ZvVLnRQa+LssbeO7F=9MrA56aZgFHQnbZCK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161605>

On Wed, Nov 17, 2010 at 09:37, demerphq <demerphq@gmail.com> wrote:

> Im hoping that if someone thinks that such a patch would be dismissed
> out of hand that they will let me know....

I don't think it should be dismissed, but it's interesting to look
forward a bit and think how clever we really want to be.

E.g. if I have a tracked file "tracked" in my repository and do:

    echo Uncommited >>tracked &&
    git rebase -i HEAD~3

We'll error out with:

    tracked: needs update
    Working tree is dirty

Although we could be smarter and scan HEAD~3..HEAD and figure out that
none of them changes "tracked" and go ahead with the rebase.

But arguably it would be more user friendly in the long term to lead
users in the direction of always having clean working trees before
they do operations like these. E.g. that users would turn your
original example into:

    git status &&                      # reports no changes / modified files
    git tag before-reset-and-merge &&  # for ease of getting back / safe from gc
    git reset --hard HEAD^ &&          # no untracked files with --hard
    git merge some-branch              # clean merge

In which case the user would be accustomed to a workflow where he's
guaranteed not to lose data, because Git is always tracking it.

But maybe we should just allow users to be more clever, and try really
hard to find out if they can be clever without screwing up their
working tree.
