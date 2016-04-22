From: ELI <eliptus@gmail.com>
Subject: Subtree Split Includes Commits Outside Prefix Directory
Date: Fri, 22 Apr 2016 11:38:35 -0700
Message-ID: <CAKU2X8bAXmVfJz9P7d3k-_d12sjyrzWt+kJCGj8V6fTDAjsFog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 20:39:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfyx-0004L3-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbcDVSi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:38:57 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35399 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbcDVSiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:38:55 -0400
Received: by mail-yw0-f181.google.com with SMTP id g133so115634552ywb.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+7Jo5jUoEZPLSRzfNqTJjtCa2rDRiksuCcCWcWOAs0=;
        b=nj+jm+0MGANeiN6pg4OZXMMdxp8MplI24rVJogCiSOD077ThjIQopw2yqG3B/4z/k1
         47jHJILhVwX5/Wj9ja51xM3Ce3rQ8GqmCMGlLwdNLCDcUKO5rOCZ/e6U6UPOD2oSWHta
         Km1ygLSv1WET0ivKz/g0OwERs1jQCc32c81/FSRR5jWfz3LFWR2sejD9cvQaCpBe0rRA
         srFpceQtpygO2wGr/yCQKEHdqU2gmD7qZ/TZpsqmqcVpC6TK+TiPHyjwJ4OCYUqIKz2r
         4ym9/Ioh/+hLD+A/W3oEPVptfycCPeeI82nLQtvwGEM1ymdCKnClIR30PJ9Kle1FACa4
         b6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+7Jo5jUoEZPLSRzfNqTJjtCa2rDRiksuCcCWcWOAs0=;
        b=C4XFvf1WDJX7dHYBZUfRze9S5p1MKZFA6N5MTC6cKUy64croA63xBccDky/RxZrgve
         Yx9dAKx/M4giU79ZhwkrdiRtO5NfrDa/Au5eN/P2cAnzjDXDzRKE8Kyw3swNkfzLZ03u
         WqiB8QgLv1GnT/e9+8M2da7T9I6Fo6KGrKU4uGQmWWeQ8rjKqSlJ29u4RmraXMBbGnsL
         yN0dq+mIbKz3h8HJub9Uvs9rN9596/K7IuTF70FG3t/zVWBUakZQiZEOu7NaumO6zKLO
         2Bhm3XXyGWt7uwk8m0ENqfHOFbk7risqqp2yxE4njlEyHRoaQZu0L+Rm+HM4uadMTgRp
         g68g==
X-Gm-Message-State: AOPr4FVEGzcH2NSmZRKD7/EMLp20iSW/udmLzMhD6eZjRRpKjHTrKDaCFw63EPIIzd2YQN2U24i0nbbf0wBhPg==
X-Received: by 10.37.24.69 with SMTP id 66mr13192418yby.187.1461350334803;
 Fri, 22 Apr 2016 11:38:54 -0700 (PDT)
Received: by 10.37.19.134 with HTTP; Fri, 22 Apr 2016 11:38:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292242>

I attempt a subtree push to a sub-project which I knew not to have had
any local modification since the last subtree push it had received,
but it failed.

To subproject
 ! [rejected]        5a9ad640651d3d54387afa5b7eaf89ed0b392a01 ->
master (non-fast-forward)
error: failed to push some refs to 'subproject'
hint: Updates were rejected because a pushed branch tip is behind its remote
hint: counterpart. Check out this branch and integrate the remote changes
hint: (e.g. 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.


The first step I took to understand the cause was to do a subtree
split and inspect the commit history of the resulting branch.  I found
that it contained commits that did not touch any files in the
subproject.  Doing a git show on these commits revealed that they were
not empty commits, but contained diff information for paths in the
main project, and in some cases, other subprojects that exist in the
main project.


I then reviewed the commit history of contrib/subtree/git-subtree.sh
and determined that the last successful subtree push was performed
prior to the integration of this change:
https://git.kernel.org/cgit/git/git.git/commit/contrib/subtree/git-subtree.sh?id=933cfeb90b5d03b4096db6d60494a6eedea25d03

As a next step, I reversed that patch on my local install of git
subtree, and the result was a successful subtree push.


Unfortunately, I have not yet reproduced this with a test main project
and subprojects, and I cannot make the project I observed it in
public.


- Harpreet "Eli" Sangha
