From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Removing useless merge commit with "filter-branch"
Date: Thu, 8 Mar 2012 15:21:04 -0800
Message-ID: <CAOMFOmWMsXgepY0-ZWFymd9uHSUmbOk66r75qa-Kv5TWx_U=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 00:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5me2-00052N-Aq
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 00:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089Ab2CHXVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 18:21:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59101 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758603Ab2CHXVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 18:21:05 -0500
Received: by ghrr11 with SMTP id r11so606257ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=iEjhxxgdicvsfwJlBxWe9xiYB+s7UzpeaDbnTVIRzGA=;
        b=d9obIM007Jo+2nxQxVV+r0Nf1KcCrOq12rQhyL3RluHFHJxRNYC05belNzK/2d9b3f
         HpvTuB5eku9NX5YnBb/36u/yCnH6gHE1H7dF656S3PYLd58/GKarVw07pXztv9p0pPCo
         qjfYnF1ZnIbVj3ueuR613J1H0vzecF5tmCPOTl6wXkjWNh5E5veiQI5KH8PNxbMTrBt1
         yuJImSbwjLcQrFprQNuqosNkitKp5ZGButZftROS7sU5tvvxmzsfLPIA7hov35Gq9fGS
         B4MFaU0ZZ+LBjF/IjlbdzsUJxCnxdj4WqDT1Rvt1RX5Yn9gAkIVPyGgAZ/fL16s0j6+E
         eKUA==
Received: by 10.236.157.10 with SMTP id n10mr43700yhk.41.1331248864485; Thu,
 08 Mar 2012 15:21:04 -0800 (PST)
Received: by 10.100.87.10 with HTTP; Thu, 8 Mar 2012 15:21:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192663>

Hi,

I have a large project (~100K commits) and I need to split a part of
it into separate project. What I usually do in this case is

git filter-branch --prune-empty --index-filter 'git rm -rfq --cached
--ignore-unmatch UNNEEDED_DIRECTORIES' HEAD

that works more or less fine for me.

The original project has a lot of merge commits (don't ask me why).
Basically every non-merge commit is merged back to master branch
instead of rebasing on top of the master. In the command above I use
--prune-empty parameter that removes empty commits, but not their
merge points. This leaves a lot of "useless commit points" like this:

|
o =C2=A0 =C2=A0 =C2=A0- merge commit that previously merged feature X
|\
| \
| =C2=A0\
o =C2=A0| =C2=A0 - real commit
| =C2=A0 |
| =C2=A0/
|/
|


As of me such merge left-overs are completely useless and I would like
to remove them. Actually this task can be split into 2 steps:
1) Remove useless parents. A useless part is the one that points to a
commit that is *already* reachable by some other parent. This step
converts useless merge points to regular empty commits.
2) run filter branch with --prune-empty that removes such empty commits=
=2E


So my questions are:
1) What is the best way to remove "useless parents" as in the algorithm=
 above?
2) Should such behavior (remove useless parent/merge commits) be
enabled when flag=C2=A0--prune-empty is used?
