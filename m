From: Stefan Beller <sbeller@google.com>
Subject: [RFC] On the --depth argument when fetching with submodules
Date: Fri, 5 Feb 2016 14:48:43 -0800
Message-ID: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:48:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRpBI-0002Pp-TC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbcBEWsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:48:45 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:32783 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbcBEWso (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:48:44 -0500
Received: by mail-ig0-f174.google.com with SMTP id rs20so51454387igc.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BrFFL4ygsNY8wPvBVNgNqwfc2fgvtF+ZX7XuEqhBmoQ=;
        b=ESg67LUM1wjHjv4fLuqknhf3NXDzQrfzJT4ylX9+WKXZdlFlc5mCZb4ryVz4/7j9kK
         nd23mI14/5trPNAonXrxijm/KOUHIDg4saYvOsAV8k4ecRu8J9zXBPEWPXpjJ0xsMfDp
         HPkXVgcVhnSWA+r5vng66ZSEigoW2SdR9K87UghgFQ98F684DFtJ9+HZFCxyDgevrDQ0
         ZcXgaUJyoBevJhBvT/vTEhUA1Fp894LxTjCMU5AkwLGA+qLgsvqv6OQ9EJc/ffAlw35R
         803PX1xDg4JAT9tFqTqz0XaJgx+cjmTtEEkkSLeHmYXKiZLL2Ftcy5xpsLj0WWj42S5H
         kN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=BrFFL4ygsNY8wPvBVNgNqwfc2fgvtF+ZX7XuEqhBmoQ=;
        b=PBNIXdzjY8HOvGKRPKGXnksjHd6kxxM1LzSWj8BicHuRVdzjTO45d96K9COhRaqVV9
         99U8YdWeFB1ASEowyvaOrjfZiOsf6P0vamO5nObosJxNX/3ULc7iMiyHvp1t/p5pCSUu
         Nfp/tWtQpK5FC36xvZMHosnlYi/zxORIe/wgUpbDD8lzAsFavRnx9fHLCKdevBSzOj2j
         p8zc/o1g5HPeeQV2g/Z7M5Z+ZIZEVLHxZ6/K2XvPRIT1xn6fmfUaICy7dBiRYjijpljG
         RDyuBaWQWK/3Hj85/NTnjC5+yKNQGqKi5bAjeLJUYYvHNh267dUE36wVd/MYGTW6Nr95
         UJCw==
X-Gm-Message-State: AG10YOS/hj4eFHKugPKZjRm4/zpRISkbiLotie21nwD5hmEsF80xYxXFZX8HMfKxmGwiLDlUiQXJ1sXVpFZ98Hma
X-Received: by 10.50.88.74 with SMTP id be10mr12616098igb.93.1454712523600;
 Fri, 05 Feb 2016 14:48:43 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 5 Feb 2016 14:48:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285650>

Currently when cloning a project, including submodules, the --depth argument
is passed on recursively, i.e. when cloning with "--depth 2", both the
superproject as well as the submodule will have a depth of 2.  It is not
garantueed that the commits as specified by the superproject are included
in these 2 commits of the submodule.

Illustration:
(superproject with depth 2, so A would have more parents, not shown)

superproject/master: A <- B
                    /      \
submodule/master:  C <- D <- E <- F <- G

(Current behavior is to fetch G and F)

The submodule is referenced at C and E from the two superproject commits.
So it is a reasonable expectation to have C and E included when fetching
the superproject with depth of 2.

So to fetch the correct submodule commits, we need to
* traverse the superproject and list all submodule commits.
* fetch these submodule commits (C and E) by sha1
* in case of shallow clones, I'd propose to have the submodules be shallowed
  with depth 1, i.e. to fetch C and E and no parents thereof
* we need to think of a way to preserve the commits in the submodule for
  later use (i.e. gc must not delete those commits)

For the later I propose to use a ref in the submodule (refs/meta/superproject ?)
which will be an evil merge of all relevant commits to be preserved for the
superproject. It is an evil merge commit as we do not need to store any worktree
at all, but we only care about the parents relationship preventing the gc to
collect data required from the superproject. The parents should contain all
branches or in case of disjoint shallow histories (like in the example above)
all the relevant commits.

Using these ideas we can go a step further in submodules and not need branches,
but only detached heads, which are directed from the superproject.

As for the implementation of these ideas, whenever you commit in the
superproject
with modification to a submodule, the superproject would need to modify the
refs/meta/superproject submodule branch to make sure the submodule is
safe against
garbage collection.

Thanks,
Stefan
