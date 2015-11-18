From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG] pre-applypatch can no longer add to staging area
Date: Wed, 18 Nov 2015 15:15:41 +1300
Message-ID: <CAFOYHZB_2EfFkO0_PtQXYmh9wbUcZPEtEFDiE-mzotgmm+3TCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 03:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZysHi-000625-Sp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 03:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbbKRCPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 21:15:42 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33006 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbbKRCPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 21:15:42 -0500
Received: by igvi2 with SMTP id i2so109934657igv.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 18:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=JbyYTeYlS4N/H66GdU2c4yJYIlWVzUiN0an+AA0dLXQ=;
        b=T5PxNno9Hm8GUuXlXUPvMBHeF77AatuUFEJ8MLxgtnaDh0PURZJqz6QStV+3ZUQjBD
         jyLUtoygZkFP6WgoZDIMcbhhSvQYtN0YOfCCT+8ixkD2gPq1x22pXP9KNoFFp1sW+8TG
         V8076aldsQJzaSMvxypuSPIkMqxbSUSRRpwIN5V8zUufDvkImsjSLZNfx79Qtj6QCWCj
         hcTcRJwIr8Jc9NnPX/Rii8X/bkgR+lETpPYrddrSmfkm2V/V7MSndI2eY6raoHtL+im3
         9OZHTXZCQ1OSbsvtYXWSxj3Sr8iPSkf04QyuCVV6EWtsJxrrX9pbOtlQuP0yCUA2uS+K
         vurg==
X-Received: by 10.50.4.33 with SMTP id h1mr761269igh.24.1447812941455; Tue, 17
 Nov 2015 18:15:41 -0800 (PST)
Received: by 10.79.84.195 with HTTP; Tue, 17 Nov 2015 18:15:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281437>

Hi,

At $dayjob we've been using a pre-applypatch hook to keep an eye on
some software metrics as sub-area maintainers receive changes from
developers. When a particular metric goes up we inform the maintainer
that they should reject the patch and stop 'git am' from continuing.
When the metric goes down automatically update the stored metric count
and include that change in the commit. Prior to git 2.6.3 this was
working, its probably prior to 2.6.0 the last version I know worked
was 2.5.3

Consider the following pre-applypatch hook to stop people adding more
uses of strcpy() to an existing code base.

  #/bin/sh
  current=$(cat .count)
  new=$(git grep -c strcpy)
  if test "$new" -gt "$current"; then
    echo "Bad patch"
    exit 1
  fi

  if  test "$new" -lt "$current"; then
     echo "Awesome patch"
     echo "$new" >.count
     git add .count
  fi

  exit 0

When a maintainer runs 'git am patch.patch' the hook would run and
record the new metric value in the staging area before the commit is
created.

Based on my reading of the pre-applypatch documentation I think this
is a valid use-case. The hook is invoked with the changes applied but
before they are committed so it should be OK to add additional changes
to the staging area as part of the hook. Interestingly with the newer
git version the change is not even staged.

Thanks,
Chris
