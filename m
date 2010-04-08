From: Jonathan Nieder <jrnieder@gmail.com>
Subject: nd/setup
Date: Thu, 8 Apr 2010 16:42:33 -0500
Message-ID: <20100408214233.GA32441@progeny.tock>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
 <20100408073825.GA15153@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 23:42:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzzUb-000729-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 23:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759128Ab0DHVmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 17:42:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37291 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758650Ab0DHVmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 17:42:23 -0400
Received: by pva18 with SMTP id 18so1686357pva.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BmZnWDhJn6RaXa2bYZoza2/xyh0UZjO7/U0OrkdMc1k=;
        b=YVUJNcebUxLEND0vXPkCcHH+ZCzLrBgdEeHnm4asnUWXa33HZvNwtVVatLyutlaD3i
         YH6ON79+VILUuxRtRI4ey6uZq19PqGmquFQT6MJ5umtKHgClG+FbsRtq4wm5X8VTSzEW
         fUcMmge1m/Je8q3Xb6UUyeRMAqcAeEwjl3udY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YI/jSFC/Q+AQxAmGiYqynnPFxz5lRrfjvTfPH4U1xY9lVc6UaOHG0ENR0qcqDqDAVS
         ZtJPnOkpYrOFfVWceaWpxoWz+D8GF+YGyglQhbGlLbJkdKwe5w42a/0IwVVaypYih70q
         ZSBF8bBYQK/JKKfCvfJb6z07fslvq691/ym2w=
Received: by 10.140.56.18 with SMTP id e18mr1155307rva.167.1270762943055;
        Thu, 08 Apr 2010 14:42:23 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id o38sm335884rvp.3.2010.04.08.14.42.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 14:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100408073825.GA15153@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144384>

Jeff King wrote:
> On Wed, Apr 07, 2010 at 05:48:02PM -0700, Junio C Hamano wrote:

>> * nd/setup (2010-04-05) 43 commits
[...]
> Probably one or both
> of us should look at it before applying it to next, but assuming it
> passes a basic sanity check, I think the best thing will be to get it=
 in
> 'next' early so we can shake out any bugs during the next cycle.

I don=E2=80=99t think it=E2=80=99s anywhere near master material yet.

=46irst, the basic problem.  The core of the series is in patch 40,
which adds a new runtime self-checker for git.  Kind of like lockdep.
Instead of proving locking correctness, this proves that whenever git
tries to access the repository, it has already been clearly and
unambiguously declared which repository to access (and in particular,
whether to try to access a repository at all).  Very neat, and it
reveals many bugs, which is nice.

When lockdep finds a locking problem, it quietly prints a message to
the kernel log and the kernel is able to keep going without worrying
about it.  Unfortunately, the repository access checker from nd/setup
is not so graceful: it makes git die even though it should be able to
carry on just fine.  Example: with nd/setup, ls-remote currently fails
when run outside any repository.  Probably the checker should be
configured by an environment variable that indicates where to print
its messages and whether to bail out when a problem is detected (for
tests).

A few of the earlier patches seem iffy, though they all start with a
correct idea.  For example, one of them changes the semantics of
rev-parse --show-prefix without documenting it.  So I have been looking
for time to document what each patch fixes.  Without some explanation
of what the patches are supposed to fix and what they are not supposed
to break, merging even them early would be a bit dangerous.

Sorry to be the bearer of bad tidings,
Jonathan
