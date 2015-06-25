From: Mikael Knutsson <mikael.knutsson@quinyx.com>
Subject: [BUG] git describe returns wrong tag as closest tag
Date: Thu, 25 Jun 2015 09:20:25 +0200
Message-ID: <CADVPA6CXqr6yuQ5Mb_vyhtrfin1jQskF6YDTRZWVHfQjZrnwng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 09:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z81Sr-00065w-Px
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 09:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbbFYHUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 03:20:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37191 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbFYHUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 03:20:45 -0400
Received: by igblr2 with SMTP id lr2so49779128igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 00:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=J+2YErsvupFS1yi6NOQWpD/2oEYuwY+DXfpV2pmASbg=;
        b=eSCnnXMgic1xBNoSebag6D9bL/UdzpqAW8sSl9IlybtbS0gVdP1SDdLRT7d01P30Sw
         9NbZ0v3Rdu8j9+cxQOojJrAU8Q8Xq6f5+3u5IXkcCeUUj7t0zT+mjZDY4adKLiwLbEnp
         RwQumJBDv3jzzUmZ+unwv7gftktO2N9dVVBDudGszsGGEwiVtdSqN0ZBh/aWh6rSW7oZ
         FXR4tZZ9W0NnANYtp9KniqQTMmEfHmVvD94nSA7OqxfrEbPQtlm+G8z7wB0UDn20mwDy
         LXPp428AtTmB3LhtCkhvtixQIdzW+C0G7PFvPmESt2vkRga2jGOiJNKWOTjmoWfwipfN
         KeZg==
X-Gm-Message-State: ALoCoQkZA3DsUkDtcZWGEWCg/JCFn+4oCpwoMGAJfhriooFFmV+5bXjgaijFqjoFLf82BBMov+nh
X-Received: by 10.107.151.75 with SMTP id z72mr57554509iod.46.1435216844387;
 Thu, 25 Jun 2015 00:20:44 -0700 (PDT)
Received: by 10.36.133.86 with HTTP; Thu, 25 Jun 2015 00:20:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272634>

Hi!

I've discovered that if you have two non-rewinding branches that you
merge between you can get the wrong tag as closest tag if the
COMMITTER_DATE of any of the commits after the branch split is before
the date of the branch split. You can end up in this state simply by
having a committer doing a rebase after a branch split and pushing
their code. (This is an assumption of what happened when we saw the
behaviour)

Reproduction case:
mkdir testcase
cd testcase
git init
git commit --allow-empty -m init
git tag -a -m 'Test tag 1' 1
git branch tagerror
git checkout tagerror
git commit --allow-empty -m test01
git commit --allow-empty -m test02
git checkout master
GIT_COMMITTER_DATE=`date --date '-10 min'` git commit --allow-empty -m
test03 # this is what causes the error
git tag -a -m 'Test tag 2' 2
git checkout tagerror
git commit --allow-empty -m test04
git checkout master
git merge --no-ff tagerror
git describe --long # (expected output is '2-4-COMMITHASH', output is
'1-5-COMMITHASH')

If you remove the GIT_COMMITTER_DATE from the repro, you'll notice
that you get the expected output.
You can verify the ANY part by adding a commit on each branch before
the COMMITTER_DATE like this:
mkdir testcase
cd testcase
git init
git commit --allow-empty -m init
git tag -a -m 'Test tag 1' 1
git branch tagerror
git checkout tagerror
git commit --allow-empty -m test01
git commit --allow-empty -m test02
git commit --allow-empty -m test03
git checkout master
git commit --allow-empty -m test04
git tag -a -m 'Test tag 2' 2
GIT_COMMITTER_DATE=`date --date '-10 min'` git commit --allow-empty -m
test05 # this is what causes the error
git checkout tagerror
git commit --allow-empty -m test06
git checkout master
git merge --no-ff tagerror
git describe --long # (expected output is '2-4-COMMITHASH', output is
'1-5-COMMITHASH')

If you run a "git describe --long --first-parent", you'll notice that
it does actually pick up the correct tag in both above cases.

It seems to me that in the source code for describe, it relies on
sorting the commits on a strict date basis, rather than sorting them
in traversal order:
https://github.com/git/git/blob/master/builtin/describe.c#L204

Caveats to the reproduction case:
In our "real" case, the date of the commit causing the issue is before
the last commit before the branch split, but not before the root
commit nor before tag "1" in the repro case.
The distance to the tag that is erroneously picked up is much greater
than the closest tag (around 1200 commits more).

I'm sadly not very well-versed in C nor in the Git source code, so I'm
not sure how the appropriate fix would look like - that's why I'm not
also submitting a patch to fix this. :)

// Mikael K.
