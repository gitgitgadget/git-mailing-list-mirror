From: Kevin Ballard <kevin@sb.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Tue, 16 Nov 2010 02:49:02 -0800
Message-ID: <5FCB4CFB-65F1-4694-AFB4-36A9612BE4F3@sb.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com> <4CE04B82.1040804@pileofstuff.org> <19363118-D147-4946-8973-B5DDA4B00985@sb.org> <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org> <AANLkTimpyug867ccsKA+fLjzDJ8NukQXcPnVJw3Uk4LD@mail.gmail.com> <C43669C9-CD42-4D51-BFB9-567AAA422C06@sb.org> <4CE2603D.8080209@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastien Douche <sdouche@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 11:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIJ67-0003AA-N7
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 11:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934239Ab0KPKtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 05:49:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52124 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992Ab0KPKtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 05:49:05 -0500
Received: by pwi9 with SMTP id 9so72425pwi.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 02:49:05 -0800 (PST)
Received: by 10.143.168.14 with SMTP id v14mr3148969wfo.74.1289904545330;
        Tue, 16 Nov 2010 02:49:05 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id z28sm1217691wfd.21.2010.11.16.02.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 02:49:04 -0800 (PST)
In-Reply-To: <4CE2603D.8080209@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161557>

On Nov 16, 2010, at 2:43 AM, Michael J Gruber wrote:

> Kevin Ballard venit, vidit, dixit 16.11.2010 10:07:
>> On Nov 16, 2010, at 12:11 AM, Sebastien Douche wrote:
>> 
>>> On Tue, Nov 16, 2010 at 00:14, Kevin Ballard <kevin@sb.org> wrote:
>>>> I take it back. We can use PROMPT_COMMAND for this, to set up variables
>>>> containing what you want.
>>>> 
>>>> Something like the following should work:
>>> 
>>> Hi Kevin,
>>> good job! I looked the git prompt and I'm a bit disappointed with the
>>> combination, ps1 can show many items:
>>> 
>>> #
>>> %
>>> +
>>> *
>>> $
>>> REBASE-i|
>>> REBASE-m|
>>> MERGING|
>>> BISECTING|
>>> < > <> (or u+count u-count u+countu-count)
>>> 
>>> Each item is "optional", so you can have REBASE-i| with * and +, or
>>> only *. It seems to complicated to wrap all items (I think of the
>>> verbose mode for upstream branches). Maybe coding a lua (or Python)
>>> prompt with a config file.
>> 
>> In the end you need to stuff everything that needs a distinct color into its
>> own shell variable. You could just extend the shell function that's doing that
>> right now, or you could write a script in another language that emits a
>> shell-quoted set of variables suitable for evaling by the shell.
> 
> Also, you should get away from parsing individual characters in
> __git_ps1. Characters like + and - are valid in branch names. Coloring
> them within the name is not quite intended.

That's actually handled with the PROMPT_COMMAND version. It uses

  git rev-parse --symbolic-full-name --abbrev-ref=loose HEAD

to get a copy of the branch name, and then removes that from the __git_ps1 output.
Everything that's left is part of the status.

> I guess the only way is to produce colors within __git_ps1 (based on an
> option). Also, colors would allow to use the same status letters as "git
> status -s".

That's how my original version worked (though it had the flaw you mentioned above).
The PROMPT_COMMAND version was motivated by the fact that the color escapes need to
be embedded directly in PS1 so \[ and \] can be used to instruct bash to treat them
as non-printable characters. If the color codes are emitted by __git_ps1 directly, then
bash will incorrectly treat them as printable characters and wrap at the wrong spot.

What would be nice is a mode for __git_ps1 that emits a string suitable for eval by
bash that gives every status indicator its own variable. This could be enabled by
using something like $(__git_ps1 --shell-quote " (%s)"). In this case, __git_ps1 would
break the format string into two parts, by splitting around the %s, and put those in
the left/right guard variables.

-Kevin Ballard