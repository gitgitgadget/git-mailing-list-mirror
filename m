From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:27:04 -0700
Message-ID: <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOMq-0007OP-7H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbbH1S1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:27:07 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34979 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbbH1S1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:27:06 -0400
Received: by pacdd16 with SMTP id dd16so70268138pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=D9GBUGktCcr95ZcUlkZghsAUMlTV7OtbIbpukjEY0Wk=;
        b=JYNq02lAMSuc8Y7oqXNvevhAtg2e5HaJdvbMoMtO6P0ZVX/E12FWNEEJFSAkvHdZHX
         +e17whWoM4U1K0T8oORPlTtjLm24G0moM8NrQ/MIClMez9ZjAB8k+L6SlPEmtgkeXfAA
         EusxIJ3nQNvo6hDfcbO+WDpuDeKqnTEoXDdvjk6MfcYoZdvuJ9SD3fYOd+47/BIz/NUY
         5GHateWMojgK/PmD+YCr0CHyRm7ZfLDRT5tn1JWF4AXtPt37ekCAtplUe7LOQ6Tr50+U
         rD+sDBlsKBlGZvEoq2PmoTmBkNJX9oumi6qtKvRn7+ci0fhO8854v/d4gbNO9UR7/zB9
         TKqA==
X-Received: by 10.68.174.100 with SMTP id br4mr17316702pbc.73.1440786426197;
        Fri, 28 Aug 2015 11:27:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id bv4sm6441701pbb.86.2015.08.28.11.27.05
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:27:05 -0700 (PDT)
In-Reply-To: <20150828182008.GC8165@google.com> (Jonathan Nieder's message of
	"Fri, 28 Aug 2015 11:20:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276745>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> My preference is still (1) leave standard error output all connected
>> to the same fd without multiplexing, and (2) line buffer standard
>> output so that the output is at least readable as a text, in a
>> similar way a log of an irc channel where everybody is talking at
>> the same time.
>
> There is something nice about the immediacy of seeing output from all
> the subprocesses at the same time in that model.
>
> But for commands that show progress like "git clone", "git checkout",
> and "git fetch", it does not work well at all.  They provide output
> that updates itself by putting a carriage return at the end of each
> chunk of output, like this:
>
>  remote: Finding sources:  11% (18/155)           \r
>  remote: Finding sources:  12% (19/155)           \r
>
> With multiple commands producing such output, they will overwrite each
> other's lines, producing a mixture that is confusing and unuseful.

That example also illustrates why it is not a useful to buffer all
of these lines and showing them once.

> Ideally what I as a user want to see is something like what "prove"
> writes, showing progress on the multiple tasks that are taking place
> at once:
>
>  ===(     103;1  0/?  8/?  3/?  11/?  6/?  16/?  1/?  1/? )==============

Tell me how that "buffer all and show them once" helps us to get
near that ideal.

> That would require more sophisticated inter-process communication than
> seems necessary for the first version of parallel "git submodule
> update".

Exactly.  Why waste memory to buffer and stall the entire output
from other processes in the interim solution, then?
