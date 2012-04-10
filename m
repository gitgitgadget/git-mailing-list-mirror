From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase -p loses amended changes
Date: Tue, 10 Apr 2012 09:14:22 +0200
Message-ID: <4F83DDCE.1040000@viscovery.net>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com> <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com> <87fwcpun95.fsf@thomas.inf.ethz.ch> <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com> <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com> <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com> <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com> <4F7BEA9F.3060805@viscovery.net> <CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHVI5-0007QG-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 09:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab2DJHO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 03:14:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:28345 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab2DJHO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 03:14:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SHVHf-0004UR-DA; Tue, 10 Apr 2012 09:14:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BBF3E1660F;
	Tue, 10 Apr 2012 09:14:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195074>

Am 4/5/2012 18:16, schrieb Martin von Zweigbergk:
> On Tue, Apr 3, 2012 at 11:30 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> IMO, it is a sub-optimal implementation of rebase -p that it attempts to
>> redo the merge. A better strategy is to just replay the changes between
>> the first parent and the merge commit, and then generate a new merge commit:
>>
>>   git diff-tree -p M^ M | git apply --index &&
>>   git rev-parse M^2 > .git/MERGE_HEAD &&
>>   git commit -c M
>>
>> This would side-step all the issues discussed here, no?
> 
> Maybe. How would it handle the following, though?
> 
> With this history
> 
>           .-e-.
>          /     \
>       .-c---d---f
>      /
> a---b---g
> 
> , "git rebase -p --onto g b f" produces
> 
> 
>               .-e'.
>              /     \
> a---b---g---c'--d'--f'
> 
> If the merge was interactive (or was made interactive due to merge
> conflicts), e'-c' (the diff between c' and e') might be very different
> from e-c. Creating f' by replaying f-d on top of d' would lose any
> changes done in e'-c' as compared to e-c, no?

If I understand correctly, rebase -p is not intended to move branchy
history to a new fork point (that would be the task of the still
hypothetical generic sequencer). Its purpose is only to keep the merges of
other "unrelated" topics, e.g.:

...--o--o        <- bugfix topic (needed by my-topic)
         \
    x--y--M--z   <- my-topic
   /
--A--o--o--B     <- master

to be turned into

...--o--o--------.        <- bugfix topic (needed by my-topic)
                  \
             x'-y'-M'-z'  <- my-topic
            /
--A--o--o--B              <- master

-- Hannes
