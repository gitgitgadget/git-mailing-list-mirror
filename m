From: Mason <slash.tmp@free.fr>
Subject: Re: Salvaging borked project history
Date: Thu, 26 Feb 2015 21:25:49 +0100
Message-ID: <54EF814D.1020105@free.fr>
References: <54EB5DD7.7050202@free.fr>	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>	<54EF098B.4080803@free.fr> <xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:26:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR50i-0006Wj-2G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbbBZU0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:26:11 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:36695 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbBZU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:26:10 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 9BB012DAF1
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 21:26:04 +0100 (CET)
Received: from [192.168.1.37] (unknown [77.207.132.113])
	(Authenticated sender: shill)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 423144C8042;
	Thu, 26 Feb 2015 21:25:42 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0 SeaMonkey/2.32.1
In-Reply-To: <xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264456>

Junio C Hamano wrote:

> Mason wrote:
> 
>> I fetched linux-stable.git inside our repo.
>> I created ~300 patches using git format-patch -1 in a loop.
>> I can now run 'git am --3way $IGNORE *.patch'
>>
>> IGNORE is used to --exclude the directories I'm not interested in.
>>
>> Note: it seems --exclude=arch/mips and --exclude=arch/mips/ are
>> not sufficient, I need to write --exclude=arch/mips/* for git-apply
>> to ignore changes to files inside arch/mips.
>>
>> Is that expected behavior?
> 
> I have no idea; at least to me, "--exclude" option to "git apply"
> was invented to name individual paths, not patterns, and I wouldn't
> be surprised if glob working were merely by accident not by design.

According to the docs, IIUC globbing is by design:
http://git-scm.com/docs/git-apply

--exclude=<path-pattern>
  Don't apply changes to files matching the given path pattern.
  This can be useful when importing patchsets, where you want to
  exclude certain files or directories.

This lead me to believe that --exclude=arch/mips should work.

>> Another nit: if a patch contains only changes to files inside arch/mips
>> then git-apply will create an "empty commit" (one with no diff). Is there
>> an option to say "skip empty patches"?
> 
> "git am --skip" perhaps?

Nah, as the doc states, --skip "is only meaningful when restarting
an aborted patch."

> "git am" may pass the "--exclude/--include" options to "git apply"
> but I wouldn't be surprised if that support was added without
> thinking.  Perhaps the reason why you discovered that it needed a
> lot more thinking to properly integrate these options to "git am"
> only now is because hardly anybody uses it ;-).

I do have a rather obscure use-case (and if I do it right, I will
never have to do it again).

> Not just passing
> these options, the code in "git am" to react to the result of patch
> application to avoid the issue you observed when these options are
> passed need to be adjusted by changes that started passing them, but
> I do not think they did, cf. 77e9e496 (am: pass exclude down to
> apply, 2011-08-03).

Sorry, I could not parse that paragraph :-)

>> One more thing: "regular" diff -q returns 0 when the files are identical,
>> and 1 when they differ. It seems git diff -s does not have that behavior.
>> Is that by design?
> 
> "diff -s" may be accepted but it is an idiotic thing for a user to
> say.  The "-s" option is to squelch output from "log" and friends,
> and it is exposed to "diff" only because these two families of
> commands share the command line parser.

Here is the use-case:

if diff -q A B; then do_X; else do_Y; fi

It makes sense to prevent diff from writing to stdout.

I was planning to write 'git diff -q commit^ commit'
to test for empty commits. Looks like I'll be needing
'git diff commit^ commit | wc -l' instead?

Regards.
