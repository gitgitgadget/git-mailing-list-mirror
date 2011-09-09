From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 9 Sep 2011 03:05:15 +0200
Message-ID: <201109090305.15896.trast@student.ethz.ch>
References: <4DF6A8B6.9030301@op5.se> <1315511619144-6773496.post@n2.nabble.com> <1315529522448-6774328.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 03:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pX2-0002dJ-Rx
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab1IIBFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:05:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28383 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab1IIBFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:05:17 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 03:05:14 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 03:05:15 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1315529522448-6774328.post@n2.nabble.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181014>

Martin Fick wrote:
> An update, I bisected it down to this commit:
> 
>   88a21979c5717e3f37b9691e90b6dbf2b94c751a
> 
>    fetch/pull: recurse into submodules when necessary
> 
> Since this can be disabled with the --no-recurse-submodules switch, I tried
> that and indeed, even with the latest 1.7.7rc it becomes fast (~8mins)
> again. The strange part about this is that the repository does not have any
> submodules. Anyway, I hope that this can be useful to others since it is a
> workaround which speed things up enormously. Let me know if you have any
> other tests that you want me to perform,

Jens should know about this, so let's Cc him.

I took a quick look and I'm guessing that there's at least one
quadratic behaviour: in check_for_new_submodule_commits(), I see

+       const char *argv[] = {NULL, NULL, "--not", "--all", NULL};
+       int argc = ARRAY_SIZE(argv) - 1;
+
+       init_revisions(&rev, NULL);

which means that the --all needs to walk all commits reachable from
all refs and flag them as uninteresting.  But that function is called
for every ref update, so IIUC the time spent is on the order of
#ref updates*#commits.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
