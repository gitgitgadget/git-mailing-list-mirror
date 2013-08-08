From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 8 Aug 2013 13:14:52 +0530
Message-ID: <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 09:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Kui-0005tU-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 09:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3HHHph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 03:45:37 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:49258 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab3HHHpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 03:45:36 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so878272bkh.25
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Cqz/733O7s4BSoiHDOTbTJSCpm+gq3eSmRzuDqUr02s=;
        b=Poq4nChsOyDlay93XDpkWcI//+7tFLAmPViMLY32ateFHXI855ziTd602dGVN4b8Cy
         wecz8qRMDfJRMsCdXNysuv0rD8McBw9roqLDO2FzX/f+P55N9V8Qh2ulBbl2eTKqnf/D
         K6IqSBcQ0VeEsb+1ABeQ+2hfm3yGxErrusMg6u9zAK8Ule1/Us09yRsJcB+oA1+W4aa+
         N22XWm7i1Z1yy3sNFDMz2ufD6pyG9jyg5XvYhSVgjUyaIzCNXlrJLHwxs2rQap7efhWr
         U28NMlgiJDcZzrpKZYSZDSpq+LoR4mQHp/Drf0plwcJJajHuIHxqaXtS8/LYKrapylkR
         cHsw==
X-Received: by 10.204.240.203 with SMTP id lb11mr1091665bkb.82.1375947934024;
 Thu, 08 Aug 2013 00:45:34 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Thu, 8 Aug 2013 00:44:52 -0700 (PDT)
In-Reply-To: <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231870>

Junio C Hamano wrote:
> it is
> not a problem for the pack that consolidates young objects into a
> single pack to contain some unreachable crufts.

So far, we have never considered putting unreachable objects in packs.
Let me ask the obvious question first: what happens when I push? Do I
pack up all the loose objects quickly (without bothering about
reachability) and send unreachable cruft to the server? Who is
ultimately going to clean up this cruft, and when?

> Note that *1* is an assumption. I do not know offhand if such a
> "consolidate young objects quickly into one to keep the number of
> packs small" strategy is an overall win.

The way I see it, you're just delaying the reachability analysis
beyond the usual pack-time. The whole point of separating out loose
objects from packfiles was to not make the user wait everytime she
does common repository operations locally: delay the reachability
analysis and compression (aka. packing) until a network operation
kicks in.

To see if introducing another stage is an overall win, think about
what the bottlenecks are: in network operations, it's always the data
being sent over. If I understand correctly, during a network
transaction, there's very minimal computation where the server-client
just quickly tell each other where their refs are: therefore, it's
trivial to figure out what's missing and pack that up to send it over.
The strategy of including unreachable cruft in these packs might make
sense from the point of view of a local gc, but will ultimately slow
down network operations, no?
