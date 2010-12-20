From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Dangerous "git am --abort" behavior
Date: Mon, 20 Dec 2010 10:31:05 -0800
Message-ID: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 20 19:31:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUkWD-0002Ln-M1
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 19:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab0LTSb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 13:31:29 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38050 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932742Ab0LTSb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 13:31:28 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id oBKIVRBX023074
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 20 Dec 2010 10:31:27 -0800
Received: by iyi12 with SMTP id 12so2437783iyi.19
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 10:31:25 -0800 (PST)
Received: by 10.231.36.195 with SMTP id u3mr4421356ibd.41.1292869885482; Mon,
 20 Dec 2010 10:31:25 -0800 (PST)
Received: by 10.231.31.72 with HTTP; Mon, 20 Dec 2010 10:31:05 -0800 (PST)
X-Spam-Status: No, hits=-2.981 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164002>

I just noticed this, and I wonder if it has bitten me before without
me noticing: "git am --abort" can be really dangerous.

What happened today was that I had been doing a pull or two, and then
applied an emailed patch with "git am" as usual. But as sometimes
happens, I actually had a previous "git am" that had failed - in fact,
it was the same patch that I applied today that had had an earlier
version that no longer applied.

So I just did "git am --abort" to get rid of the old stale 'am' state,
but that actually also ended up aborting my "git pull". Oops.

Happily, I noticed, and did a "git reset --hard @{1}" to get things
back, but at no point did "git am" warn about the implicit "reset" it
did, that threw away non-am state.

I suspect I've avoided this in the past because my normal approach to
getting rid of stale am state tends to be just the manual "rm -rf
.git/rebase-apply", but it's also possible that I've simply not
noticed before.

Maybe "git am" should actually save the last commit ID that it did,
and only do the "reset" if the current HEAD matches the rebase-apply
state and warns if it doesn't? Or maybe we could just introduce a new
"git am --clean" that just flushes any old pending state (ie does that
"clean_abort" thing, which is basically just the "rm -rf" I've done by
hand). Or both?

Comments?

                     Linus
