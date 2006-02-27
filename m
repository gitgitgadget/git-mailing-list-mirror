From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Mon, 27 Feb 2006 22:17:00 +0000
Message-ID: <44037A5C.6080409@gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 23:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDqg1-0005Dr-8y
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 23:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWB0WRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWB0WRG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 17:17:06 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:57725 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751348AbWB0WRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 17:17:04 -0500
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20060227221703.ROTN29066.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Mon, 27 Feb 2006 22:17:03 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20060227221703.LOLY10548.aamta09-winn.ispmail.ntl.com@[192.168.1.101]>;
          Mon, 27 Feb 2006 22:17:03 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16887>

Karl Hasselstr=F6m wrote:
> If I make a patch series where more than one patch touches the same
> line, I get a lot of merge errors when upstream has accepted them and
> I try to merge them back.

We discussed about this in the thread announcing pg
(http://article.gmane.org/gmane.comp.version-control.git/16247). This i=
s
not easy to fix because StGIT pushes patches one by one and it stops at
the first conflict. Pg was trying to merge two patches at once but this
is not suitable for StGIT since the latter keeps the patches as single
commits.

There is another problem - the same line might have been modified by a
third-party patch merged into the kernel (and the conflict solved by th=
e
maintainer).

> This situation arises for every line that's modified in more than one
> patch, and for every such patch except the last one. And it's really
> annoying, since it's intuitively obvious that there aren't actually
> any conflicts, since upstream accepted my patches verbatim.

Because I found the same situation a bit annoying, I added the --reset
option to resolved. If you know your patch was merged without
modifications, just use "stg resolved --all --reset local".

An idea (untested, I don't even know whether it's feasible) would be to
check which patches were merged by reverse-applying them starting with
the last. In this situation, all the merged patches should just revert
their changes. You only need to do a git-diff between the bottom and th=
e
top of the patch and git-apply the output (maybe without even modifying
the tree). If this operation succeeds, the patch was integrated and you
don't even need to push it. The tool could even fold two consecutive
patches and reverse-apply them. The disadvantage might be the delay whe=
n
pushing patches but we could enable this test only if an option is
passed to the pull command.

If you really want to make StGIT behave intelligently, have a look at
the patch commuting theory in Darcs. It tends to handle this kind of
conflicts easily. StGIT also does some patch commuting but using the
diff3 algorithm and asks the user to fix different conflicts.

Catalin
