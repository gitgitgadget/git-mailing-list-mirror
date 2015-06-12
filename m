From: "Andres G. Aragoneses" <knocte@gmail.com>
Subject: RFC: reverse history tree, for faster & background clones
Date: Fri, 12 Jun 2015 13:26:42 +0200
Message-ID: <mlefli$h6v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 13:26:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3N6u-0001J2-G6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 13:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbFLL0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 07:26:52 -0400
Received: from plane.gmane.org ([80.91.229.3]:51522 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbbFLL0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 07:26:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z3N6m-0001Dy-TY
	for git@vger.kernel.org; Fri, 12 Jun 2015 13:26:49 +0200
Received: from 46.24.152.62 ([46.24.152.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 13:26:48 +0200
Received: from knocte by 46.24.152.62 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 13:26:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.24.152.62
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271480>

Hello git devs,

I'm toying with an idea of an improvement I would like to work on, but=20
not sure if it would be desirable enough to be considered good to merge=
=20
in the end, so I'm requesting your opinions before I work on it.

AFAIU git stores the contents of a repo as a sequence of patches in the=
=20
=2Egit metadata folder. So then let's look at an example to illustrate =
my=20
point more easily.

Repo foo contains the following 2 commits:

1 file, first commit, with the content:
+First Line
+Second Line
+Third Line

2nd and last commit:
  First Line
  Second Line
-Third Line
+Last Line

Simple enough, right?

But, what if we decided to store it backwards in the metadata?

So first commit would be:
1 file, first commit, with the content:
+First Line
+Second Line
+Last Line

2nd commit:
  First Line
  Second Line
-Last Line
+Third Line


This would bring some advantages, as far as I understand:

1. `git clone --depth 1` would be way faster, and without the need of=20
on-demand compressing of packfiles in the server side, correct me if I'=
m=20
wrong?
2. `git clone` would be able to allow a "fast operation, complete in th=
e=20
background" mode that would allow you to download the first snapshot of=
=20
the repo very quickly, so that the user would be able to start working=20
on his working directory very quickly, while a "background job" keeps=20
retreiving the history data in the background.
3. Any more advantages you see?


I'm aware that this would have also downsides, but IMHO the benefits=20
would outweigh them. The ones I see:
1. Everytime a commit is made, a big change of the history-metadata tre=
e=20
would need to happen. (Well but this is essentially equivalent to=20
enabling an INDEX in a DB, you make WRITES more expensive in order to=20
improve the speed of READS.)
2. Locking issues? I imagine that rewriting the indexes would open=20
longer time windows to have locking issues, but I'm not an expert in=20
this, please expand.
3. Any more downsides you see?


I would be glad for any feedback you have. Thanks, and have a great day=
!

   Andr=C3=A9s

--=20
