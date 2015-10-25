From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Sun, 25 Oct 2015 13:49:50 +0100 (CET)
Message-ID: <cover.1445777347.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 13:50:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqKkf-0004uk-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 13:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbbJYMuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 08:50:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:55923 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbbJYMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 08:50:12 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0M2nfO-1agMnr0DAc-00sfyo;
 Sun, 25 Oct 2015 13:50:05 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TwOqA17UbWJMjy+9oLinIw84lbD4tGCOdFWghuRlxPvjBUf6jLm
 gzoc98xYAZFh6Nn2QTXATlkx1+caPnk2AmVKKMhLfUviqj2DfEC0MsLKhcgB2Qr9FanyP9n
 5dwm+4u1fzktST/Ap5in/O7144o0uXkeTp9YX5TkQ26Ir5BY73gY5ViqTbyf/891eyYZoku
 sSexpAdaegUqIVzd/sXiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NUP7JSxLo00=:Kuo0N8h6dJF9Ida5ymD8Je
 KygPhXmLSeF6hpJ1TMLr4QNuO6ujdVEMvEZrpDjxgiLJVc5jWPQm2fJbgrLI3SPxYuoC4NGNI
 W8p6HSI/bESyXewu/LFS/qAmgAew+2M9+8Hl1QuK55ltPE8gPSdXQh2mdimwY9JrtqRtCta73
 kYGVz6blvr1gWOXNiNdoqkPLhh9K4IcqRPOhNNIOIu9ag0Z70iDkKOyuL/jWbUwfoAzNlK6xO
 Dfjlkkqh4nJJ0WhgLENZ07OjnS5qVGelardJ20dhyoUj35rlUxB/u7UOX0ApNLiVWDZflhysi
 MhdDmRogAt/r3B3hmQuEWPFgQF8Ld/vMOpat6l54HqAunGBocN8N/sgEFB1bSouDSyu103Z6U
 1gOwcl3syQQ1dNBk+sqmR+rIx79AIsmnKm7G/RdKs/ilUhyKOjdAwpbmDDGDeWTmUARE5UNUx
 e9MntKX0rVt4KnkkOaiHrqaQWeNFcim1D1GhjrZ5or7h1QRaMCRdcUVB8+S1xSQnm6lkQ4bms
 i6U7QHFExcsTVa77eGBU1ni8oaiSOb4vFTW6sFoppNcK9E0u+Jzrz/1TDpRy8027EDznfubN3
 aERwK2YwxgNOem0vpcu+J1I6zqEUK67eKXpRxvapUdBXsauRuCr09JXH+tDrnEgyjrq+Q3831
 4KR8BoQf+eR27xG5PE7nK4iflhU4TsyjFqVZj+NEw6z+OtJdm7GkMIpSJDpp8o0+RqIV5+hUQ
 GdFfFiPZn8aN/Z9rPke9YRejjK1NEIA6v+GuV45rvxiGfMlB4Wr6T9qBYLxLYcwwAbOP43LW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280142>

Chad Boles reported that `git rebase -I` recently started producing
errors when the editor saves files with DOS line endings. The symptom
is:

	Warning: the command isn't recognized in the following line:
	 -

	You can fix this with 'git rebase --edit-todo'.
	Or you can abort the rebase with 'git rebase --abort'.

The real bummer is that simply calling `git rebase --continue` "fixes"
it.

Turns out that we now check whether a single Carriage Return is a valid
command. This new check was introduced recently (1db168ee9, ironically
named "rebase-i: loosen over-eager check_bad_cmd check").

The proposed fix is to teach *all* shell scripts in Git to accept CR as
a field separator. Since LF is already specified as such, it should be
an uncontentious change.


Johannes Schindelin (2):
  Demonstrate rebase fails when the editor saves with CR/LF
  sh-setup: explicitly mark CR as a field separator

 git-sh-setup.sh               |  2 +-
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.1.4
