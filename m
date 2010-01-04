From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 07:54:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com> <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain> <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 16:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpGZ-00073H-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 16:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094Ab0ADPyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 10:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235Ab0ADPyo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 10:54:44 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45387 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752107Ab0ADPyn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 10:54:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04FsP8N004037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Jan 2010 07:54:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o04FsOca003025;
	Mon, 4 Jan 2010 07:54:25 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100104064408.GA7785@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.67 required=5 tests=AWL,BAYES_00,FH_DATE_PAST_20XX,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136119>



On Mon, 4 Jan 2010, Jeff King wrote:
> 
> I have to wonder, though...did anybody ever actually profile our
> internal grep to find out _why_ it was so much slower than GNU grep?
> Could we simply ship a better grep engine and obsolete external grep?

The internal grep is about 2.5 times slower than the external one for me. 
That's a big deal:

 - external grep:

	[torvalds@nehalem linux]$ time git grep qwerty
	...
	real	0m0.412s
	user	0m0.196s
	sys	0m0.132s

 - NO_EXTERNAL_GREP:

	[torvalds@nehalem linux]$ time ~/git/git grep qwerty
	...
	real	0m1.006s
	user	0m0.900s
	sys	0m0.096s

so that's not even close.

And "perf record" followed by "perf report" on the internal one shows 
that it's not even regexec() - we use strstr() for the trivial case:

    43.63%      git  /home/torvalds/git/git         [.] grep_buffer_1
    25.19%      git  /lib64/libc-2.11.so            [.] __strstr_sse42
     9.16%      git  /home/torvalds/git/git         [.] match_one_pattern
     4.79%      git  /lib64/libc-2.11.so            [.] __m128i_strloadu

bit it seems to be all that line-per-line crud. If we got rid of that one, 
and could do the match as a _single_ regexec() instead (at least for the 
trivial cases of just one grep expression), perhaps we'd be better off.

			Linus
