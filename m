From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] git tag --contains: avoid stack overflow
Date: Sat, 20 Sep 2014 20:18:59 +0200
Message-ID: <871tr688a4.fsf@igel.home>
References: <20140417213238.GA14792@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
	<20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
	<xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
	<20140423191628.GA20596@sigill.intra.peff.net>
	<xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
	<20140423205533.GA20582@sigill.intra.peff.net>
	<xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
	<20140424122029.GA8168@camelia.ucw.cz>
	<20140424122439.GB8168@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:19:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVPFZ-0006KA-LQ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 20:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbaITSTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 14:19:09 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35507 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbaITSTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 14:19:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3j0gCp0j2xz3hm1g;
	Sat, 20 Sep 2014 20:19:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3j0gCn6fH4zvh1l;
	Sat, 20 Sep 2014 20:19:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id g3qFkNneUm8K; Sat, 20 Sep 2014 20:19:00 +0200 (CEST)
X-Auth-Info: FyLyuPMZGnrMSqpWB9B2TTsVFQBsZNiMsx8NrnoN71aO8Bq2zJ2zduMTtOuDeXgs
Received: from igel.home (ppp-188-174-150-234.dynamic.mnet-online.de [188.174.150.234])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 20 Sep 2014 20:19:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id CA6F82C1980; Sat, 20 Sep 2014 20:18:59 +0200 (CEST)
X-Yow: I'd like some JUNK FOOD...  and then I want to be ALONE --
In-Reply-To: <20140424122439.GB8168@camelia.ucw.cz> (Stepan Kasal's message of
	"Thu, 24 Apr 2014 14:24:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257328>

Stepan Kasal <kasal@ucw.cz> writes:

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 143a8ea..a911df0 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1423,4 +1423,30 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +run_with_limited_stack () {
> +	(ulimit -s 64 && "$@")
> +}

That is way too small.

https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/git/standard/ppc64le

[  492s] not ok 136 - --contains works in a deep repo
[  492s] ok 11 - log using absolute path names
[  492s] #      
[  492s] #              >expect &&
[  492s] #              i=1 &&
[  492s] #              while test $i -lt 4000
[  492s] #              do
[  492s] #                      echo "commit refs/heads/master
[  492s] #      committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
[  492s] #      data <<EOF
[  492s] #      commit #$i
[  492s] #      EOF"
[  492s] #                      test $i = 1 && echo "from refs/heads/master^0"
[  492s] #                      i=$(($i + 1))
[  492s] #              done | git fast-import &&
[  492s] #              git checkout master &&
[  492s] #              git tag far-far-away HEAD^ &&
[  492s] #              run_with_limited_stack git tag --contains HEAD >actual &&
[  492s] #              test_cmp expect actual
[  492s] #      
[  492s] # failed 1 among 136 test(s)
[  492s] 1..136
[  492s] Makefile:44: recipe for target 't7004-tag.sh' failed
[  492s] make[2]: *** [t7004-tag.sh] Error 1

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
