From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Mon, 24 Nov 2014 14:12:47 +0600
Message-ID: <87lhn1au67.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com> <xmqqioi5ycme.fsf@gitster.dls.corp.google.com> <87sih9en65.fsf@gmail.com> <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com> <87mw7haxdp.fsf@gmail.com> <CAPc5daWnJCGPTMA0Hyg8QEAmsnF17ZQ9njGq8xVaUAfuwCRQDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 09:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsoqh-00061W-4u
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 09:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaKXISP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 03:18:15 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:36061 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbaKXISO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 03:18:14 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so7082784lab.4
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=iuCyO/9LGjAfs7hSwuoVoXcldSk5ytpnxQYIFBm1Jx8=;
        b=XJCcdIdUJGRhWOr3B7LoPZmCidGtdl7aPs6GFEKrvwIr5K2vex4Deov8fo3xK0P1O4
         6d5mgvfVMMXQ6sHN4ql6HXvrcOVamWKDc/+/0sAd4dNW6SDkc8iawFkZq5EZj0BIK6w9
         0Wc9ef+I0lEPdwwqDTVBwusMqWuUsH1uO6oWoBz16aIb75AIz5Nb4TZZv5ybDqhGVVbW
         BVnVtmpNpc/9XMhpx1VtSy1SvyRtgIUSP00rcCEd7Rr2nXD1lENRFHGiZNPvejf0sIFZ
         9K1yU3Ja8qG6LUoCXXT8by3BJakScXAf95zwXL9IF4DF/4lkgNLphi/dGsWClP6LMls3
         aC6A==
X-Received: by 10.112.17.101 with SMTP id n5mr18970188lbd.83.1416817092895;
        Mon, 24 Nov 2014 00:18:12 -0800 (PST)
Received: from alex-desktop ([95.59.100.64])
        by mx.google.com with ESMTPSA id q9sm3367750lah.12.2014.11.24.00.18.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 00:18:12 -0800 (PST)
In-reply-to: <CAPc5daWnJCGPTMA0Hyg8QEAmsnF17ZQ9njGq8xVaUAfuwCRQDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260117>


Junio C Hamano <gitster@pobox.com> @ 2014-11-24 13:37 ALMT:

> [jc: added those who were mentioned but were missing back to Cc]
>
> On Sun, Nov 23, 2014 at 11:02 PM, Alex Kuleshov <kuleshovmail@gmail.com> wrote:
>>
>> Junio C Hamano:
>>
>>>Fixing these callers are done as separate patches, that can be
>>>applied either before or after this patch.
>>
>> How to do it better? Update this patch, fix all callers which broken and
>> concat this patches to one or make separate patches?
>
> As I said, I do not think the approach your v2 takes is better than the original
> approach to pass the ownership of the returned value to the caller. I'd say that
> a cleaned up v1 that makes sure it adds a necessary strdup() in the codepath
> where it returns an absolute pathname given as-is, with necessary changes to
> callers that do not currently free the received result to free it when they are
> done, and to callers that currently do strdup() of the received result not to do
> strdup(), in a single patch, would be the right thing to do.
>
> I think I already wrote the bulk of proposed commit message for you for such
> a change earlier ;-) The one that talks about changing the contract between the
> system_path() and its callers.
>
> Thanks.

OK, but i'm little confused now, long thread :)

So what's our next strategy?

I'll make system_path will return volatile value, so callers must free
it by itself, but we have two types of callers:

Callers which doesn't need to store system_path return value (like git
--man-path and etc.. in git.c), and which need to store it (as in attr.c).

We must to free system_path return value in first case, and does not
need to create copy of returned string with xstrdup.

Am i correct or i'm wrong with this?

Thank you.

--
Best regards.
0xAX
