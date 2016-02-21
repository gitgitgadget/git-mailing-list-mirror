From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Sun, 21 Feb 2016 22:12:23 +0900
Message-ID: <56C9B7B7.7030406@f2.dion.ne.jp>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net> <20160215005210.GA31141@dcvr.yhbt.net>
 <56C297A9.2080705@f2.dion.ne.jp> <20160216063357.GA17455@dcvr.yhbt.net>
 <56C34BFF.3030301@f2.dion.ne.jp> <20160220233743.GA28606@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	alex.crezoff@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:56:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYFZ-0003QH-Hm
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbcBUR42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:56:28 -0500
Received: from mail-ae1-f9.auone-net.jp ([106.187.231.9]:46038 "EHLO
	dmta01.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751270AbcBUR41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:56:27 -0500
Received: from amlmta051.auone-net.jp (amlmta051-MM [10.188.23.102])
	by dmta01.auone-net.jp (au one net mail) with ESMTP id DB6C656032F
	for <git@vger.kernel.org>; Sun, 21 Feb 2016 22:12:30 +0900 (JST)
Received: from [0.0.0.0] ([197.231.221.211])
	by amlmta051.auone-net.jp id 56c9b7ba000689450000576100002efae0000761ff7e;
	Sun, 21 Feb 2016 22:12:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160220233743.GA28606@dcvr.yhbt.net>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286815>

On 2016/02/21 8:37 +0900, Eric Wong wrote:
> Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
...
>> Setting LC_ALL=C.UTF-8 in the test 11-12 made them pass on Cygwin.
>> Same change made the previous version also pass. Please find the patch
>> in the attached output of git format-patch.
> 
> Thanks.  However, I also wonder what happens on machines without
> "C.UTF-8" support (are there still any?).
> 
>> Could you please test with this on non-Cygwin environment?
> 
> Works for me, at least.  I've squashed your changes into the two
> patches already queued up.  I needed to split the
> "export LC_ALL=C.UTF-8" statement into
> "LC_ALL=C.UTF-8 && export LC_ALL" for portability.

Thank you.

>> If it made no harm, please tell me what should I do to proceed this patch.
>> Will you (Eric) please make further integration? Shall I make another
>> series (v2) of patches?
> 
> I've pushed out a new branch with your LC_ALL changes squashed
> in.  However I'm unsure if there's any new portability problems
> with LC_ALL=C.UTF-8...
> 
> Junio or anyone else: thoughts?

The test passed on my environment.

I've searched use of LC_ALL values other than "C".
It seems be the best to move the variable a_utf8_locale in t9129 to
lib-git-svn.sh and use it also in t9115.


t/Makefile:83
> 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8

Here, "en_US.UTF-8" is hard-coded. I think this is at least more
problematic than hard-coding "C.UTF-8". Beside hard-coding, does this
take effect while test-lib.sh does LC_ALL=C ?

t/t9129-git-svn-i18n-commitencoding.sh:17
> a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
> 	p
> 	q
> }')
>
> if test -n "$a_utf8_locale"
> then
> 	test_set_prereq UTF8
> else
> 	say "# UTF-8 locale not available, some tests are skipped"
> fi

Here, a UTF-8 locale is took from "locale -a", and the test is skipped
if not found. This gives "a_utf8_locale=C.utf8" on my Cygwin
environment. There was a record that says the difference of ".utf8" and
".UTF-8" caused a failure.
https://git.kernel.org/cgit/git/git.git/commit/?id=2de03ebe0635c93e182c3367140f999e79bdadcd

t/lib-gettext.sh:17
> 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
> 	is_IS_locale=$(locale -a 2>/dev/null |
> 		sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
> 		p
> 		q
> 	}')
...
> 	if test -n "$is_IS_locale" &&
> 		test $GIT_INTERNAL_GETTEXT_SH_SCHEME != "fallthrough"
> 	then
> 		# Some of the tests need the reference Icelandic locale
> 		test_set_prereq GETTEXT_LOCALE
...
> 	else
> 		say "# lib-gettext: No is_IS UTF-8 locale available"
> 	fi
(the same logic is used for is_IS.ISO8859-1.)

Here, a UTF-8 locale with hard coded "is_IS" is took from "locale -a",
and the test is skipped if not found. This gives
"is_IS_locale=is_IS.utf8.utf8" on my Cygwin environment.

-- 
k_satoda
