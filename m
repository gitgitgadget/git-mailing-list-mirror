From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 07:59:18 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net> <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com> <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain> <7vvdf9402f.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 16:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUMgM-0004nC-Me
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 16:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab0AKP7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 10:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386Ab0AKP7f
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 10:59:35 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42613 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371Ab0AKP7f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 10:59:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BFxJjp024332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 07:59:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0BFxI8q013469;
	Mon, 11 Jan 2010 07:59:18 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136634>



On Mon, 11 Jan 2010, Linus Torvalds wrote:
>
> Without testing it, I can already ACK it. It looks like the 
> ObviouslyRightThing(tm) to do. But I'll run some numbers too.

Ok, some good news, some meh news, and some bad news.

The good news: the trivial numbers look good. It's noticeably faster than 
external grep for me when it does the 'fixmatch()' case, quite probably 
because fixmatch() on at least Linux/x86-64 (which is the only case I 
really care about) uses SSE to do the string ops.

So on my Nehalem:

	[torvalds@nehalem linux]$ time git grep qwerty > /dev/null 

	real	0m0.418s
	user	0m0.204s
	sys	0m0.136s

	[torvalds@nehalem linux]$ time git grep --no-ext-grep qwerty > /dev/null 

	real	0m0.309s
	user	0m0.168s
	sys	0m0.136s

and since that simple fixmatch case is the common one for me, I'm happy.

The meh news: this shows how grep is faster than regexec() due to being a 
smarter algorithm. For the non-fixed case (I used "qwerty.*as"), the 
numbers are

 - built-in:
	real	0m0.548s
	user	0m0.384s
	sys	0m0.152s

 - external:
	real	0m0.415s
	user	0m0.176s
	sys	0m0.160s

so it really is just 'strstr()' that is faster. But This is a 'meh', 
because I don't really care, and the new code is still way faster than the 
old one. And I'd be personally willing to just drop the external grep if 
this is the worst problem.

[ I worry a bit that some libc implementations of 'strstr' may suck, but I 
  wouldn't lose sleep over it. ]

The bad news is that you broke multi-line greps:

	git grep --no-ext-grep -2 qwerty.*as

results in:

	drivers/char/keyboard.c-unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =
	drivers/char/keyboard.c-        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
	drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */

when the _correct_ result is 

	drivers/char/keyboard.c-unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =
	drivers/char/keyboard.c-        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
	drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
	drivers/char/keyboard.c-        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
	drivers/char/keyboard.c-        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */

ie it didn't do the "two lines after" thing.

That said, the external grep also gets this wrong (a different way), 
because it gets all the extra noise due to unnecessary separation lines, 
so for the external grep I actually get

	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	drivers/char/keyboard.c-unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =
	drivers/char/keyboard.c-        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
	drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
	drivers/char/keyboard.c-        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
	drivers/char/keyboard.c-        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--

but that's a long-standing problem, and is more "ugly" than "wrong grep 
results".

			Linus
