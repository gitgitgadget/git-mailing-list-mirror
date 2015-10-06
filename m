From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: fix completion after 'git -C path'
Date: Tue, 06 Oct 2015 12:12:24 +0200
Message-ID: <20151006121224.Horde.eFfzROzl5PskJn4vxQYePQ6@webmail.informatik.kit.edu>
References: <1444046535-18316-1-git-send-email-szeder@ira.uka.de>
 <56138BB7.4000404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 12:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjPEY-0007Q8-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 12:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbbJFKMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 06:12:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43349 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751909AbbJFKM3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 06:12:29 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZjPEP-0007mz-9n; Tue, 06 Oct 2015 12:12:25 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZjPEO-0005oQ-D3; Tue, 06 Oct 2015 12:12:24 +0200
Received: from x4db27399.dyn.telefonica.de (x4db27399.dyn.telefonica.de
 [77.178.115.153]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 06 Oct 2015 12:12:24 +0200
In-Reply-To: <56138BB7.4000404@drmicha.warpmail.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1444126345.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279128>


Quoting Michael J Gruber <git@drmicha.warpmail.net>:

> SZEDER G=C3=A1bor venit, vidit, dixit 05.10.2015 14:02:
>> The main completion function finds the name of the git command by
>> iterating through all the words on the command line in search for th=
e
>> first non-option-looking word.  As it is not aware of 'git -C's
>> mandatory path argument, if the '-C path' option is present, 'path' =
will
>> be the first such word and it will be mistaken for a git command.  T=
his
>> breaks the completion script in various ways:
>>
>>  - If 'path' happens to match one of the commands supported by the
>>    completion script, then its options will be offered.
>>
>>  - If 'path' doesn't match a supported command and doesn't contain a=
ny
>>    characters not allowed in Bash identifier names, then the complet=
ion
>>    script does basically nothing and lets Bash to fall back to filen=
ame
>>    completion.
>>
>>  - Otherwise, if 'path' contains such unallowed characters, then it
>>    leads to a more or less ugly error in the middle of the command l=
ine.
>>    The standard '/' directory separator is such a character, and it
>>    happens to trigger one of the uglier errors:
>>
>>      $ git -C some/path <TAB>sh.exe": declare: `_git_some/path': =20
>> not a valid identifier
>>      error: invalid key: alias.some/path
>>
>> Fix this by skipping 'git -C's mandatory path argument while iterati=
ng
>> over the words on the command line.  Extend the relevant test with t=
his
>> case and, while at it, with cases that needed similar treatment in t=
he
>> past ('--git-dir', '-c', '--work-tree' and '--namespace').
>> Additionally, shut up standard error of the 'declare' commands looki=
ng
>> for the associated completion function and of the 'git config' query=
 for
>> the aliased command, so if git learns a new option with a mandatory
>> argument in the future, then at least the command line will not be
>> utterly disrupted by those error messages.
>>
>> Note, that this change merely fixes the breakage related to 'git -C
>> path', but the completion script will not take it into account as it
>> does '--git-dir path'.
>
> I don't understand the "as it does" part. Do you mean that the
> completion script does '--git-dir path', or that git does it?

When the user specifies '--git-dir path' on the command line the
completion script respects that (most of the time, I noticed a few
missing spots), i.e.

   git --git-dir /somewhere/else/.git log <TAB>

gives you all the refs from the specified repository, which is good.
However, that's not the case with '-C /somewhere/else', as it will lead=
 to
the error mentioned in the commit message on current git, or will be
ignored with this patch.

> In any case, "git -C path ..." is more like "cd path && git ...". Tha=
t
> is, completion should take it into account at least when determining
> GIT_DIR (though -C does not specifiy the git-dir directly), and possi=
bly
> also for completion of untracked files. Otherwise, it's going by the
> wrong repo (unless path is a subdir of cwd).

I agree, it should, but it doesn't.  That will be the next step in some
future patches.


G=C3=A1bor
