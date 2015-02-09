From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: 'git rebase' silently drops changes?
Date: Mon, 09 Feb 2015 20:03:15 +0100
Message-ID: <54D90473.2090208@kdbg.org>
References: <87386ispb3.fsf@osv.gnss.ru> <54D68455.5070305@gmail.com>	<54D7696B.3060407@kdbg.org> <87oap38cv1.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtcE-0006XZ-N9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 20:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbbBITDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 14:03:22 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:6629 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933756AbbBITDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 14:03:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kgxTL4Wryz5tlH;
	Mon,  9 Feb 2015 20:03:18 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EDD0C19F925;
	Mon,  9 Feb 2015 20:03:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <87oap38cv1.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263584>

Am 09.02.2015 um 13:53 schrieb Sergey Organov:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 07.02.2015 um 22:32 schrieb Sebastian Schuberth:
>>> On 06.02.2015 22:28, Sergey Organov wrote:
>>>
>>>> # Now rebase my work.
>>>> git rebase -f HEAD~1
>>>>
>>>> # What? Where is my "Precious" change in "a"???
>>>> cat a
>>>> </SCRIPT>
>>>>
>>>> I.e., the modification marked [!] was silently lost during rebase!
>>>
>>> Just a wild guess: Maybe because you omitted "-p" / "--preserve-merges"
>>> from "git rebase"?
>>
>> No, that would not help. --preserve-merges repeats the merge, but does
>> not apply the amendment.
> 
> Really? Why? Here the valid concern you gave below doesn't even apply!

--preserve-merges was bolted on to git-rebase. The first implementation
just re-computed the merge, and rebase would be interrupted if the merge
was not clean. This was good enough for many.

Later --preserve-merges was abused to replay not only integration
branches, but branchy history in general. At that time, the feature was
deemed wide spread enough that changing its behavior was a no-go.

There you have it.

If you want a version of --preserve-merges that does what *you* need,
consider this commit:

  git://repo.or.cz/git/mingw/j6t.git rebase-p-first-parent

Use it like this:

  git rebase -i -p --first-parent ...

Beware, its implementation is incomplete: if the rebase is interrupted,
then 'git rebase --continue' behaves as if --first-parent were not given.

>> it is impossible for git rebase to decide to which rebased
>> commit the amendement applies. It doesn't even try to guess. It's the
>> responsibility of the user to apply the amendment to the correct
>> commit.
> 
> Yeah, this sounds reasonable, /except/ git even gives no warning when it
> drops amendments. Shouldn't 'git rebase' rather consider merge amendment
> a kind of conflict?

There is work in progress where a merge is computed entirely in-memory
(without relying on files in the worktree). It could be used to detect
whether there are any changes beyond the automatic merge results, and
they could be warned about.

-- Hannes
