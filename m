From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for 
	user-friendliness
Date: Sat, 17 Jul 2010 00:12:33 -0400
Message-ID: <AANLkTikiOgV1iE7dwPUkLpWTb_zXSFdEuOYvyqJ1eDCo@mail.gmail.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
	<4C3DC2BD.6020907@digium.com>
	<20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
	<201007141740.37867.trast@student.ethz.ch>
	<20100714160730.GA27078@pcpool00.mathematik.uni-freiburg.de>
	<AANLkTikEjMeKPkyY4RdRq-ESkmmq4PvqCFPgp8yvLVBz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Sat Jul 17 06:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZyla-0000Ko-Mh
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 06:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab0GQEMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 00:12:38 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:44176 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab0GQEMh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 00:12:37 -0400
X-AuditID: 12074423-b7be0ae000000a83-03-4c412db47988
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 5A.4B.02691.4BD214C4; Sat, 17 Jul 2010 00:12:37 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6H4CZqT027788
	for <git@vger.kernel.org>; Sat, 17 Jul 2010 00:12:35 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6H4CYdd006541
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 17 Jul 2010 00:12:35 -0400 (EDT)
Received: by iwn7 with SMTP id 7so2806706iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 21:12:34 -0700 (PDT)
Received: by 10.231.14.201 with SMTP id h9mr1826846iba.129.1279339953964; Fri, 
	16 Jul 2010 21:12:33 -0700 (PDT)
Received: by 10.231.160.195 with HTTP; Fri, 16 Jul 2010 21:12:33 -0700 (PDT)
In-Reply-To: <AANLkTikEjMeKPkyY4RdRq-ESkmmq4PvqCFPgp8yvLVBz@mail.gmail.com>
X-Brightmail-Tracker: AAAAAhUrKw8VLBJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151178>

It looks like git@ got dropped from the CC at some point, but I had
written a few days ago:

>> Is there a reason that you duplicate functionality offered by run_co=
mmand()?
> No--I hadn't realized that existed. =A0I'll switch over to that in V2=
 of
> this patch series.

Today, I inspected run_command() in more detail.  Unfortunately, I'm
not sure of the best way to use it in this situation.  In particular,
run_command() uses execvp, meaning that PATH is invoked.  However, the
user should only be able to run commands in the git-shell-commands
directory.   I do have a few ideas for approaches here; maybe others
see more?  Anyway:
- Set PATH to just $HOME/git-shell-commands.  But then the helper
scripts have to restore PATH to a sane value themselves, and it's not
really clear to me what that value should be.
- Under the hood, exec a different script, which processes the user's
command on its own.  (So if the user types 'help' at the git shell
prompt, actually exec 'git-shell-wrapper help'.)  The
git-shell-wrapper could be a dumb wrapper that just execs
$HOME/git-shell-commands/help or similar.
- Extend run_command to optionally use execv.  Would any other code
actually want this functionality though?  If not, it's probably an
excessively large code change for little benefit.
- Continue using the one-off run() method that I wrote here.

Do people have opinions on the most elegant way to handle this?

Thanks!

Greg

> On Wed, Jul 14, 2010 at 12:07 PM, Bernhard R. Link <brlink@debian.org=
> wrote:
>> * Thomas Rast <trast@student.ethz.ch> [100714 17:41]:
>>> [Please don't trim the Cc list without good reason.]
>>
>> The mail I answered to had only git@vger.kernel.org in CC and some
>> syntax errors in To.
>>
>>> Bernhard R. Link wrote:
>>> > To be more specific: If NULL is (void *)0 then it does not need t=
o be
>>> > cast. Sadly the standard allows to define it as 0, and so it is o=
n
>>> > some systems. So to be portable it needs to be cast to be a point=
er,
>>> > otherwise the varargs argument is assumed to be an int.
>>>
>>> Worse, the pointer representations need not be the same between typ=
es,
>>> even though that is a fairly exotic idea:
>>>
>>> =A0 http://c-faq.com/null/machexamp.html
>>>
>>> So it seems execl() must always have an explicitly-cast (char*)NULL
>>> sentinel.
>>
>> There is a difference between ugly operating systems where everythin=
g
>> else works and you need to cast it and things too exotic to have any
>> chance to get the rest of the code to work without big changes.
>>
>> Machines where you do not get a NULL pointer by a memset(,0,), callo=
c
>> or the like will have bigger problems anyway. (have not looked at gi=
t,
>> but I'd be suprised if at every place there is an explicit assignmen=
t
>> for the pointers).
>> Note that in the other examples, char * and void * are the same anyw=
ay.
>>
>> =A0 =A0 =A0 =A0Bernhard R. Link
>>
>
