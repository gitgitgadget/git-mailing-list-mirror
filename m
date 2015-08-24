From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/8] branch.c: use 'ref-filter' APIs
Date: Mon, 24 Aug 2015 10:31:41 -0700
Message-ID: <xmqqtwro4mpu.fsf@gitster.dls.corp.google.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
	<1440226309-25415-8-git-send-email-Karthik.188@gmail.com>
	<CAP8UFD3rXJqB1DEz5LfdM8xxanzoJp6J=weED+FygeZmufG4Sw@mail.gmail.com>
	<CAOLa=ZSwU94-JgAdw-xoL5mDNVL8nsbuBCD-MhN3H+m1gFD9gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvb2-0004xk-BN
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbHXRbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:31:44 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34425 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbHXRbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:31:43 -0400
Received: by pabzx8 with SMTP id zx8so11177180pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UITmyMyOtAxlolq+noRh8puT6ajx4v2HSspc1Reay0Y=;
        b=u4puv+KZ4sZDEJpqd+XC/nKbirL3caGoWjHpP0KdcVsmhB9YA//qQxtlOvXtrvRrqw
         cnNfunFz/9TavbiaZzyWQWoZIPj/gZAzP2OkACSrRy06RSntHHcRNpS2wQsUeDKmLOcS
         ZTOIdFYVaUmClJP7k5F3a673V9U//uuAPXXdwD+h5jao7mJAm57ft1dp4fdhcbTZpTwx
         GFgmXOfgCDMYncFJPA3o2EMFhod38WtMFT1dgF2xn/8R7qSiQ9vIIq7IYy9zMhkrDlKh
         CximycCtmIWRkr4onFXHonaOSOAaqs9kt/CDbPm1NMVR9gQ517jHXuiBHuNng0km7M7o
         7yrw==
X-Received: by 10.68.57.203 with SMTP id k11mr47733206pbq.8.1440437502929;
        Mon, 24 Aug 2015 10:31:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id p3sm18140222pdf.3.2015.08.24.10.31.41
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:31:42 -0700 (PDT)
In-Reply-To: <CAOLa=ZSwU94-JgAdw-xoL5mDNVL8nsbuBCD-MhN3H+m1gFD9gQ@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 22 Aug 2015 23:20:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276468>

Karthik Nayak <karthik.188@gmail.com> writes:

>>>  test_expect_success 'git branch shows badly named ref' '
>>>         cp .git/refs/heads/master .git/refs/heads/broken...ref &&
>>>         test_when_finished "rm -f .git/refs/heads/broken...ref" &&
>>> -       git branch >output &&
>>> +       git branch 2>output &&
>>>         grep -e "broken\.\.\.ref" output
>>>  '
>>
>> Maybe the test could be renamed to 'git branch warns about badly named
>> ref' and maybe you could also check that "broken\.\.\.ref" is not
>> printed on stdout.
>
> The name change sounds reasonable, do we really need to check for it in the
> stdout?

I think Christian meant "we should check in both", i.e.

	git branch >output 2>error &&
        grep "broken\.\.\.ref" error &&
        ! grep "broken\.\.\.ref" output

or something like that.  That way, you are effectively specifying in
the test that badly named refs must not be included in the output,
so somebody who changes that in the future needs to justify why
including them in the output is a good idea when updating the test.
