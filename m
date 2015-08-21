From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 13:47:30 -0700
Message-ID: <xmqqy4h44bdp.fsf@gitster.dls.corp.google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZrcPAAt+miHDGQp=052S-q=JaKvvLgKHaPG+G6cDjBtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZStDt-0002eL-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbbHUUrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:47:33 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33741 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbHUUrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 16:47:33 -0400
Received: by pdrh1 with SMTP id h1so30750340pdr.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XHvz75YNrRjP5ATPvAL8uTN2EZelxJP7MS27Ars7t8I=;
        b=KA+XZo09yVRIUOHKRZZJ9PR74XuvWwhNrODy5hS09ZZvlE46D3zeuWZwPKy5nvjwes
         JMx3KKyXJJRQ7qDYQwpXmPT9v0LA7rye4yGUvKhzWQ13Oy4m1f7qrKCT5NhOVu/D062C
         6YcDM+2PTpwFBEWQrQWKO79cE3FVKvgGwbRCI55MvVpFjlAwKKyAWk3jd2VKCrbrLHiH
         V4Gij1XbKfd8s9U8I4X44M1C7I6/HufZG27vStYvPCRnLv/3cGZPRl7GWMDT9x7lGhDO
         yc36rHdiWHUomwESHxrMXo4OcyMt/3StsQt1t0ssH2oBTiHdTV/HHbz+PwCXfo0b8F2p
         1vAw==
X-Received: by 10.70.132.228 with SMTP id ox4mr21004723pdb.0.1440190052410;
        Fri, 21 Aug 2015 13:47:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id z16sm8809387pbt.3.2015.08.21.13.47.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 13:47:31 -0700 (PDT)
In-Reply-To: <CAGZ79kZrcPAAt+miHDGQp=052S-q=JaKvvLgKHaPG+G6cDjBtg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 21 Aug 2015 12:45:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276331>

Stefan Beller <sbeller@google.com> writes:

>>> +struct task_queue *create_task_queue(unsigned max_threads)
>>> +{
>>> +     struct task_queue *aq = xmalloc(sizeof(*aq));
>>> +
>>> +#ifndef NO_PTHREADS
>>> +     int i;
>>> +     if (!max_threads)
>>> +             aq->max_threads = online_cpus();
>>> +     else
>>> +             aq->max_threads = max_threads;
>>> +
>>> +     sem_init(&aq->mutex, 0, 1);
>>> +     sem_init(&aq->workingcount, 0, 0);
>>> +     sem_init(&aq->freecount, 0, aq->max_threads);
>>> +     aq->threads = xmalloc(aq->max_threads * sizeof(pthread_t));
>>> +
>>> +     for (i = 0; i < aq->max_threads; i++)
>>> +             pthread_create(&aq->threads[i], 0, &dispatcher, aq);
>>> +
>>> +     aq->first = NULL;
>>> +     aq->last = NULL;
>>
>>
>> Shouldn't these be initialized before letting threads call into
>> dispatcher?  The workingcount semaphore that is initialized to 0 may
>> prevent them from peeking into these pointers and barfing, but still...
>
> They are initialized to NULL as the empty queue doesn't need a
> container element.
> Do we do queues in another way usually?

I do not think we are on the same wavelength.  What I meant was to
do this:

	aq = xmalloc(...);
        set up _everything_ in aq and make it a consistent state;
        /* aq->first and aq->last are part of _everything_ in aq */
        for (many times)
        	pthread_create(...);

	/* No aq->first = aq->last = NULL assignment here */

instead of

	aq = xmalloc(...);
        set up part of aq;
        for (many times)
        	pthread_create(...);
	belatedly initialize aq->first and aq->last and finally
        aq becomes a consistent state.

which is what we see above.  The latter works _only_ because the
threads created are blocked waiting on aq->workingcount which is
initialized to block before threads are created to run dispatch,
and one of the early things dispatch does is to try acquiring that
semaphore to block before accessing aq->first and aq->last.
