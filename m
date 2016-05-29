From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Sun, 29 May 2016 19:21:49 +0200
Message-ID: <7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, gitster@pobox.com, aaron@schrab.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Sun May 29 19:22:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b74Pf-0005hz-5C
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 19:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbcE2RVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 13:21:54 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:59863 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbcE2RVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 13:21:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A586420A4;
	Sun, 29 May 2016 19:21:50 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZVokra14M4q; Sun, 29 May 2016 19:21:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8B08C2098;
	Sun, 29 May 2016 19:21:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 846FE2077;
	Sun, 29 May 2016 19:21:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UenBVns2pGno; Sun, 29 May 2016 19:21:50 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 1F1852064;
	Sun, 29 May 2016 19:21:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpq8tyujkb0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295838>

On 05/28/2016 05:04 PM, Matthieu Moy wrote:
> Eric Wong <e@80x24.org> writes:
>
>> Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
>>
>>>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
>>>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
>>>
>>> Though `git send-email` now outputs something like:
>>>
>>>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>'
>>>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: One<one@example.com>'
>> I actually like neither, and would prefer something shorter:
>>
>>     (mbox) Adding cc: A <author@example.com> from Cc: header
>>     (mbox) Adding cc: One <one@example.com> from Cc: header
>>     (mbox) Adding cc: SoB <SoB@example.com> from Signed-off-by: trailer
>>
>> That way, there's no redundant addresses in each line and less
>> likely to wrap.
>
> I agree with this. Actually, I'd even say that the current output of
> "git send-email" looks sloppy, and internal refactoring may be a good
> opportunity to get it cleaner.

I agree.

Should we take what Eric suggested (see below) as standard output?

> Since the headers are already shown after those lines, it's
> redundant to have the entire line.  And we could add
> trailers after the headers (with a blank line to delimit):
>
>     # existing header output:
>     From: F <F@example.com>
>     Cc: A <author@example.com>, One <one@example.com>
>     Subject: foo
>
>     # new trailer output
>     Signed-off-by: SoB <SoB@example.com>
>     Acked-by: ack <ack@example.com>

And keep "(mbox) Adding ..." lines as error output, or maybe displayable 
by a new option `--verbose`?
