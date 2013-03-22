From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] t7800: modernize tests
Date: Fri, 22 Mar 2013 12:14:27 +0100
Message-ID: <514C3D13.5010301@viscovery.net>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com> <1361419428-22410-2-git-send-email-davvid@gmail.com> <1361419428-22410-3-git-send-email-davvid@gmail.com> <514985FB.8080806@viscovery.net> <CAJDDKr4O-OU57j0f7F2E2_4EvtCTE1gFP5uLv+fvD6VcpPiifg@mail.gmail.com> <514AB9A5.3050601@viscovery.net> <514C04AA.6030305@viscovery.net> <20130322100030.GH2283@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 22 12:15:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIzwA-0006Vd-AA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 12:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab3CVLOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 07:14:36 -0400
Received: from so.liwest.at ([212.33.55.24]:37371 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab3CVLOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 07:14:36 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIzvZ-0004AF-9G; Fri, 22 Mar 2013 12:14:30 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F1E281660F;
	Fri, 22 Mar 2013 12:14:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130322100030.GH2283@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218791>

Am 3/22/2013 11:00, schrieb John Keeping:
> On Fri, Mar 22, 2013 at 08:13:46AM +0100, Johannes Sixt wrote:
>> Am 3/21/2013 8:41, schrieb Johannes Sixt:
>>> Am 3/20/2013 23:59, schrieb David Aguilar:
>>>> I started digging in and the @worktree_files (aka @worktree above)
>>>> is populated from the output of "git diff --raw ...".
>>>>
>>>> Seeing the "output" filename in "diff --raw" implies that one of the
>>>> tests added "output" to the index somehow.  I do not see that
>>>> happening anywhere, though, so I do not know how it would end up in
>>>> the @worktree array if it is not reported by "diff --raw".
>>>>
>>>>
>>>> My current understanding of how it could possibly be open twice:
>>>>
>>>> 1. via the >output redirect
>>>> 2. via the copy() perl code which is fed by @worktree
>>>>
>>>> So I'm confused.  Why would we get different results on Windows?
>>>
>>> I tracked down the difference between Windows and Linux, and it is...
>>>
>>> 	for my $file (@worktree) {
>>> 		next if $symlinks && -l "$b/$file";
>>>
>>> ... this line in sub dir_diff. On Linux, we take the short-cut, but on
>>> Windows we proceed through the rest of the loop,
>>
>> And that is likely by design. From the docs:
>>
>> --symlinks
>> --no-symlinks
>>
>>     git difftool's default behavior is create symlinks to the working
>>     tree when run in --dir-diff mode.
>>
>>     Specifying `--no-symlinks` instructs 'git difftool' to create
>>     copies instead.  `--no-symlinks` is the default on Windows.
>>
>> And indeed, we have this initialization:
>>
>> 	my %opts = (
>> 		...
>> 		symlinks => $^O ne 'cygwin' &&
>> 				$^O ne 'MSWin32' && $^O ne 'msys',
>> 		...
>> 	);
>>
>> Can the --dir-diff tests case pass on Cygwin when neither --symlinks nor
>> --no-symlinks is passed?
>>
>> Perhaps the right solution is this:
> 
> We already have tests that explicitly pass '--symlinks'.  I wonder if it
> would be better to change "output" to ".git/output", which should avoid
> the problem by moving the output file out of the working tree.

The point of using --symlinks is not to test the effect of the option, but
to test the same thing on Unix and on Cygwin, because the latter uses
--no-symlinks by default. Therefore, I think that this sketch is the right
thing to do.

But the real problem seems to be that "output" should not be among the
files treated in the cited pieces of code (unless I'm wrong, of course; I
know next to nothing about git-difftool). It should not matter where the
file lives. Just add --no-symlinks to the difftool invocation of test
"difftool -d" and watch it fail on Linux, too.

-- Hannes
