From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v4 0/5] git_config callers rewritten with the new config
 cache API
Date: Thu, 31 Jul 2014 12:37:02 +0100
Message-ID: <53DA2A5E.4020101@ramsay1.demon.co.uk>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>	<vpq1tt3rmbt.fsf@anie.imag.fr> <53D8FB39.7040904@gmail.com> <vpqiomeokx7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCofb-0000nw-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbaGaLhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:37:08 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:42448 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750710AbaGaLhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:37:07 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 69344400AA8;
	Thu, 31 Jul 2014 12:37:05 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 2D573400862;
	Thu, 31 Jul 2014 12:37:05 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu, 31 Jul 2014 12:37:04 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <vpqiomeokx7.fsf@anie.imag.fr>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254556>

On 30/07/14 17:45, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>> Also, any thoughts on what to do with git_default_config()? We can,
>>
>> 1> make a new function git_load_default_config(), use it for the rewrites.
> 
> That seems the most sensible option. It could be called it git.c before
> the command-dependant part, so that any call to git loads this.
> 
> I didn't check if it was correct (e.g. do some command rely on the fact
> that the default config is not loaded?)
> 

Hmm, here be dragons ... :-P

I don't know that there has actually been any kind of policy
regarding the reading of config files/variables in git (or if
there is a different policy for plumbing vs porcelain), but it
has always seemed to be somewhat ad-hoc; each command decides
for itself what it wants to read.

However, with increased use of common code which _uses_ certain
config variables for correct operation, the 'choice' is much
harder to make (and may change after the fact!).

For example, about a year ago I submitted a couple of patches
which added a call to git_config(git_default_config, NULL) to
both 'git pack-refs' and 'git show-refs'. This was as a result
of the 'mh/ref-races' branch which introduced a 'stat_validity'
api for checking if the packed-refs file had changed on the
filesystem since last you looked. This re-used some of the same
code used to handle index updates that used config variables
like core.checkstat and core.trustctime. These config variables
can affect the correctness and/or the efficiency of the code on
some platforms (e.g. cygwin, mingw).

[Note: 'stat_validity' has since been re-used again (why not?)
in some shallow clone code, so similar comments may apply ...
I haven't looked.]

However, those patches were dropped, because it resulted in an
(unwanted) change in behaviour. In particular, 'git show-refs'
changed behaviour because it now 'listened' to core.abbrev!

I started to look at splitting the 'core config variables' into
two groups; essential variables that _all_ git commands should
read for correct/efficient/consistent behaviour and everything
else (mainly UI related variables).

However, something else came up ...

Just an FYI.

ATB,
Ramsay Jones
