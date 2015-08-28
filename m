From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] thread-utils: add a threaded task queue
Date: Fri, 28 Aug 2015 08:34:49 -0700
Message-ID: <xmqq1ten4eau.fsf@gitster.mtv.corp.google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
	<1440636766-12738-3-git-send-email-sbeller@google.com>
	<a35977776a7ea97b0ddd4d1921e3e95f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, jrnieder@gmail.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:34:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVLg8-00008w-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 17:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbH1Pex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 11:34:53 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34767 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbbH1Pew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 11:34:52 -0400
Received: by pabzx8 with SMTP id zx8so66287105pab.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=muaijyiurRtdWmH5CtLdEXRZeTu2pd87oSA8DzbHcS0=;
        b=kO+bDYKWU/ZzAirWQIXacogTbohh1DgN6QFC4zctXXTQAMTup2YzQhRnh4BFaTQ15v
         DlU+HDY5fJ1nKqpzCrh7o3eZY81i9+YzQVSHFV2IInCUkbEdTG0efN0gv4iVaOESl/TL
         tIfvUanadayFmJv1zVYolVXT0qM0zhZKyBugas+6yLHdpEFGrWGxSZaCTLndh0+fpe0G
         zfyFF24qRSe9Q/GtmeqHdtTY9PpDob58yFmWAVVZIeBJPGZj8LB+GgRVZmDsXM9v/3OU
         EXVteF7Zo1h0ri9A6UxpdEXuAMeqLMKIEcBVuy/DWzfm0DzG1sX7uBbM37ffo81bOk5X
         8cKA==
X-Received: by 10.66.118.39 with SMTP id kj7mr16158778pab.115.1440776091863;
        Fri, 28 Aug 2015 08:34:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id oq3sm6108780pdb.75.2015.08.28.08.34.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 08:34:50 -0700 (PDT)
In-Reply-To: <a35977776a7ea97b0ddd4d1921e3e95f@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 27 Aug 2015 14:59:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276723>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> +void add_task(struct task_queue *tq,
>> +	      int (*fct)(struct task_queue *tq, void *task),
>
> Might make sense to typedef this... Maybe task_t?

Let's not introduce user defined type that ends with _t that is seen
globally.

>> +	      void *task)
>> +{
>> +	if (tq->early_return)
>> +		return;
>
> Ah, so "early_return" actually means "interrupted" or "canceled"?
>
> I guess I will have to set aside some time to wrap my head around the
> way tasks are handled here, in particular how the two `early_return`
> variables (`dispatcher()`'s local variable and the field in the
> task_queue`) interact.

We had a very similar conversation in $gmane/276324 as the
early-return and get_task interaction was not quite intuitive.

I thought Stefan said something about this part of the logic being
unreadable and needs rework.  Perhaps that will come in the next
reroll, or something?

I tend to agree with you that interrupted or cancelled would be a
good name for this thing; at least it would help understanding what
is going on than "early-return".

Thanks.
