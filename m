From: Daniele Segato <daniele.segato@gmail.com>
Subject: possible bug of git stash deleting uncommitted files in corner case
Date: Fri, 22 Apr 2016 13:46:50 +0200
Message-ID: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 13:46:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atZY1-0008PG-NM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 13:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcDVLqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 07:46:53 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35237 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcDVLqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 07:46:52 -0400
Received: by mail-lf0-f54.google.com with SMTP id c126so77797991lfb.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=yto5K8dueqZYh1zXr6UZY4hoKxmzyX8TYxprR4IqHsw=;
        b=RVamkkMCGkPASEVYRmJOCUDcP200SiuY5iq+JIVO4GWaMah7BZU4y4RsOX6rr1g9M2
         lcRVJcYU18QcCenWw1ZTUtuN99ohtO/zdrHKAjN0O5KoKeaJKOlaJPcv///5vr0YpxfL
         UzwCI9N+aazn+4bna4AJrIFrsEVrTHTQCJ7geqUVyXpixm/AMdw/L9bnQbEM4dz/xFc8
         YZou5VwSX+hcjhv1XQi+0IGqSgZfUujHT0vJCoiHozkr/UZ0H/XHkkZMEsUTYTDqdaIv
         hg8wuI/zQJRLsMX1vwpAK8fjVDJgLBSVhBl2VPZHPiMeWC5LnHznertNCrK6OKm33DOV
         NK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=yto5K8dueqZYh1zXr6UZY4hoKxmzyX8TYxprR4IqHsw=;
        b=GTj0QwiDBUGvMbjmPdruFUcuYU/Y00F74D7MG/DwxjCH1343cOIPc+jbCm5EovPhKr
         NtgSkrN93+GPl6V0dA0fcGn6N4ZG0xExmivVXvMLl6/y658KRqPmMHG1+CiXtmVJ4RGU
         mrzEbMGw11IkDxOThqwyEjXYYuGuWUxbuxvsmXDEiWpAPxDUmn6i02HdomTBfFvNPPQ+
         U61+Ep+Q/dXghK91RXr5zWk6FIerYV83ccNRGOzfFamQHLCzklx0bqjaXV+pkLwH2yvQ
         UzLbvCq+2hhauvuDEK+M4tIhu/R7HyrePIVpBhiCw7Mzn3HSDSk0cMYrJPOOXfXN19+u
         ed2g==
X-Gm-Message-State: AOPr4FVqLqEFMPklWgmnUsbNfYWy6AXtL9Jr+2WAkXUASaByg8C95lcoeWZ5Zxk1hHDnnAezvM6UJHLAeYutBA==
X-Received: by 10.25.88.85 with SMTP id m82mr9203360lfb.93.1461325610853; Fri,
 22 Apr 2016 04:46:50 -0700 (PDT)
Received: by 10.112.143.97 with HTTP; Fri, 22 Apr 2016 04:46:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292184>

Hi,

my coworker today claimed git stash deleted his files, I made him
explain me what he did and I think it could actually be a bug even if
happening only in a corner case better explained with code to
reproduce:

git init
echo 'X' > foo
git add foo
git commit -m 'foo file committed'


what follow is the corner case I'm talking about: he deleted the file,
created a directory with THE SAME name and added lot of files in it,
in this example I'll only add one


rm foo
mkdir foo
echo 'B' > foo/bar


at this point the working directory looks like this:

 $ tree
=2E
=E2=94=94=E2=94=80=E2=94=80 foo
    =E2=94=94=E2=94=80=E2=94=80 bar

1 directory, 1 file


but apparently git status does not seem to see foo directory at all:


$ git status
On branch master
Changes not staged for commit:

          deleted:    foo

no changes added to commit (use "git add" and/or "git commit -a")


I expected something more like:


$ git status
On branch master
Changes not staged for commit:

          deleted: foo

Untracked files:

          foo/

no changes added to commit (use "git add" and/or "git commit -a")


Anyway he went on and decided to stash his work:


git stash


at this point stash deleted the "bar" file, in his case all the work
on the previous couple of hours, but he didn't know yet


$ git stash show stash@{0}
foo | 1 -
1 file changed, 1 deletion(-)


the foo directory was gone, replaced by the foo file


git stash pop


did not complained and deleted foo file again


I know my co-worker shouldn't had created a directory with the same
file he was deleting but I also think git shouldn't have allowed him
to stash at all, or should have been cleaver enough to actually stash
the directory with its files.


Regards,
Daniele Segato
