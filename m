From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFH] git-log vs git-rev-list performance
Date: Sat, 29 Dec 2007 13:18:52 +0100
Message-ID: <e5bfff550712290418h22d7f7edqda519e7f4dcd25b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 13:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8aez-0000Ia-IA
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 13:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbXL2MS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 07:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbXL2MS7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 07:18:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:16657 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbXL2MS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 07:18:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3824858rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 04:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LRym8+fhSCF8k9jn/UhYkvzdKhIhN4zPDTEo+zmnPjo=;
        b=jT6DmV+Jb6Gup4Kpku3Zwuw7guyobagW7FAyq3dMmA7x1+UG4jxTjJjVo+1bdN3JLuxtpZ1qqlUopsyrFrTukKct9adezTw6TJSO1Yr2I4uo8MxdGS/cmDlWotdb4JRSq803ibrzoGFHHciI4niMvzpBPxsUDQLxuhl/eaS1RT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W21J2vZk9iqoOUuWRZ6Te35PQh3Z66p3L6al0pfHhi73+gNSAnVAR4hLIew3qpbIapuqP9J5mTGFzWtI9f8cn7g3rg4Nfkq9mLuvzrTL7EVbr77xYTK3WZgpixsQ5IdMZEhtoles2M++gXEduBNxkSRLNxIPUUH3xLOgI3sDge4=
Received: by 10.140.207.3 with SMTP id e3mr1606592rvg.262.1198930732595;
        Sat, 29 Dec 2007 04:18:52 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 04:18:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69312>

Hi all,

   perhaps this will turn out to be a bit academic, anyway...

I'm almost ready to release qgit-2.1, a lot of improvements went in
but still I cannot beat the speed of stable qgit-1.5 series.

I really profiled this puppy and I think qgit-2.1 is _internally_ much
faster then qgit-1.5, but at the end of the day qgit-1.5 is about 13%
faster then the new 2.1 at loading repositories.


The loading speed is the sum of two factors:

- speed of underlying git-rev-list / git-log command

- qgit overhead in parsing and storing the git plumbing outpt


I think qgit-2.0 code is much more efficient then the old one because
the overhead went down from 17% of qgit-1.5 to current 6% of qgit-2.1,
it means that opening and loading a repository with qgit-2.1 is only
6% slower then running the underlying git command from the command
line.


So the problem seems to be in the underlying command that for qgit-1.5
is git-rev-list while for new qgit-2.1 is git-log


To have some numbers I have tested on the Linux repository with the
actual git commands used by the two versions of qgit:

[marco@localhost linux-2.6]$ git --version
git version 1.5.4-rc1.GIT


[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents --boundary -z --log-size
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
3.60user 0.09system 0:03.70elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27156minor)pagefaults 0swaps


[marco@localhost linux-2.6]$ time git rev-list --topo-order --no-color
--parents --boundary -z --header HEAD > /dev/null
2.89user 0.08system 0:02.98elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27156minor)pagefaults 0swaps


[ BTW, yes I have a new laptop! ;-) ]


Note that the output is smaller for git-log because --pretty=format
asks for less info then the --header option used by git-rev-list. To
be precise, output is  57.113.153 bytes for git-rev-list against
41.755.328 bytes for git-log.



So the bottom line is that git-log is 24% slower then git-rev-list
although size of its output is 36% smaller!


Could someone be so kind to explain me why these differences? I'm not
so confident with git-log /git-rev-list internals.


Thanks
Marco
