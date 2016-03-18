From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Fri, 18 Mar 2016 11:15:30 +0900
Message-ID: <56EB64C2.4090405@f2.dion.ne.jp>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net> <56E999C3.4040802@f2.dion.ne.jp>
 <56EA3DBD.2070105@web.de> <56EA4230.7010501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 03:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agjyX-0004PU-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 03:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbcCRCRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 22:17:13 -0400
Received: from mail-ae2-f131.auone-net.jp ([111.87.219.131]:44225 "EHLO
	dmta03.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751465AbcCRCRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 22:17:12 -0400
Received: from amlmta050.auone-net.jp (amlmta050-MM [10.188.23.89])
	by dmta03.auone-net.jp (au one net mail) with ESMTP id DEC50DA07CA
	for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:17:09 +0900 (JST)
Received: from [0.0.0.0] ([65.19.167.130])
	by amlmta050.auone-net.jp id 56eb65220009f045000055dd00007da3a0000adecc5b;
	Fri, 18 Mar 2016 11:17:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <56EA4230.7010501@web.de>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289177>

On 2016/03/17 14:35 +0900, Torsten B=C3=B6gershausen wrote:
> On 2016-03-17 06.16, Torsten B=C3=B6gershausen wrote:
=2E..
> And the pathch is here:
> <https://github.com/tboegi/git/commit/866dfc192a0d4428aebfc7242f51348=
99b6dafd4>
>=20
> Kazutoshi, could you re-test on your environment ?

The test 11,12 was skipped on my environment, too:
> $ ./t9115-git-svn-dcommit-funky-renames.sh
> ok 1 - load repository with strange names
> ...
> ok 10 - git svn rebase works inside a fresh-cloned repository
> ok 11 # skip svn.pathnameencoding=3Dcp932 new file on dcommit (missin=
g FS_CP932 of UTF8,FS_CP932)
> ok 12 # skip svn.pathnameencoding=3Dcp932 rename on dcommit (missing =
=46S_CP932 of UTF8,FS_CP932)
> # passed all 12 test(s)
> 1..12

That's because the check for FS_CP932 runs under LC_ALL=3DC environment
which affects how filenames are treated. See the comment on #11 for mor=
e
details.

Setting LC_ALL before the check works for me.

 test_lazy_prereq FS_CP932 '
        # check whether FS allows filenames from cp932
+       prepare_a_utf8_locale
+       LC_ALL=3D$a_utf8_locale &&
+       export LC_ALL &&
        neq=3D$(printf "\201\202")

But it looks a bit strange to do "prepare_a_utf8_locale" here because i=
t
is done just before #11 now, though I think it does no harm.

I also don't understand the way of the check: Why don't you just touch
and test it, like this:
	touch "$neq" && test -e "$neq"
?

--=20
k_satoda
