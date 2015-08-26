From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pack negotiation algorithm between 2 share-nothing repos
Date: Wed, 26 Aug 2015 09:49:56 -0700
Message-ID: <xmqqbnduuh8r.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AKKYux6w=6X392mJhGFfqfEvJsrX0PjcivHPt2PYVKAw@mail.gmail.com>
	<xmqqk2t0mrhi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:50:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUdto-0006Qk-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 18:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbHZQt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 12:49:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32882 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbHZQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 12:49:58 -0400
Received: by pacti10 with SMTP id ti10so93596580pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+/GgVfDRHrVJ62riB1uH8HhI8X8Q24U2SXYrEFfOvZ0=;
        b=GLi/vwug+w3RqBqd5nyMELZBGgTGx7s0dpW3EovXqOJwv3JhySODCtys29vbIWoqfP
         0nzZbAuiiUMETgAoRMHomTVKmbnvM+sKMT6ZA7IJ0NTNGHEy58hqb8hZmrQtj1ug+knZ
         4eNdcY671/cpOx4SNaY3c5V1wwfY3YfEe9/tnIT2LDRSeO9vJYb7dfJdl2UJIada8SMu
         L0fSWIRx+I6mDFz6FOqjSSKjNIWBqR5adYHbjNM3TebobW2TPXKnVHV7frXstRgwGvDu
         /ki7MxdgnEbEGng6pWYtM5typ1fWCGaKxRNzMfGKW/ckJwkbVoi3qaw+BWYyNVLI/vWD
         JcIw==
X-Received: by 10.66.160.133 with SMTP id xk5mr30831654pab.131.1440607797484;
        Wed, 26 Aug 2015 09:49:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id iw2sm25260767pbb.67.2015.08.26.09.49.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 09:49:56 -0700 (PDT)
In-Reply-To: <xmqqk2t0mrhi.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Aug 2015 08:55:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276618>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I know this is a corner case, but because it has a valid use case,
>> maybe we should do something about it. Immediate reaction is to add an
>> option to send no "have"s. But maybe you guys have better ideas.
>
> This and similar corner cases were discussed in very early days of
> Git.
>
> One interesting idea floated back then but was not pursued was to
> dig and send have's sparsely and then back up.  Instead of digging
> and sending _all_ commits in a contiguous history, after sending the
> tip, you skip the commits from the history before sending the next
> one, and progressively make the skipping larger (e.g. Fibonacci, or
> exponential).  You need to remember what you sent and for each of
> what you sent its topologically-oldest descendant you sent earlier
> that you heard the other side does not have.
>
> Then, when you get an Ack, you know a stretch of history between a
> commit that is known to be common (i.e. the one you heard an Ack
> just now) and its descendant that is known only to you (i.e. the
> topologically-oldest one you remember that you did send and they
> didn't say is common).  At that point, you and the other end can
> bisect that range.

If anybody is interested, here is a good place to start:

http://thread.gmane.org/gmane.comp.version-control.git/96149/focus=102485

[Cc'ed Stefan as I think he was collecting possible enhancement to
put in the protocol v2].
