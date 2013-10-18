From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 11:58:46 -0400
Message-ID: <CAPig+cTLMKZ4MnG6YmKmqyFAZ0OgNLf83nOher_MqhPfDTDpLQ@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CAPig+cRg0ovyutXmTggr5P++dWuVP3izf5JfcJEeEVZhHuVJiA@mail.gmail.com>
	<CALKQrgdMagUQMTGWX7RwBfBkA6+Q65aPfpk1W3m1BKMUNmjKFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 17:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXCRz-0001lB-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 17:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab3JRP6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 11:58:50 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42378 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3JRP6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 11:58:48 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so633482lbd.36
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2kGrwObeE1+Fkgz5hlqNvLhv4RYNH4v1GKATtAuhHXc=;
        b=eDZ7U6W25UoYdyjHzpbDb/Ojr+vlQnUKdD3jQt5PwzQyRWWaTBeCsq2g6baddBSvDK
         aTE24nSvsJezHBOeFZXpJcBx7z5pi0kwzIq7BuT3MCkQRwWfzciLI0lTMsLMYQ+SE5c9
         ChzsAIsrg9xb+1RsK91qvfvxz1zUcNO2mR3cfUYD0t2mRsRiytvUsPEWlT1tk2pGKCVr
         eMBstlyoDZHpOMS474lrYWSmB+d2kcpIpzNfTHH6IfSIZbe24a9z4fOd1kix4q8wpN9B
         lnFIKaftqcBp48MIi6wgY7Cnd14GJUfeD8LnzNL1O4u3KtpS8Zz+KrSjsWXNm6at5Vqu
         tgsw==
X-Received: by 10.112.9.195 with SMTP id c3mr2029580lbb.33.1382111926931; Fri,
 18 Oct 2013 08:58:46 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Fri, 18 Oct 2013 08:58:46 -0700 (PDT)
In-Reply-To: <CALKQrgdMagUQMTGWX7RwBfBkA6+Q65aPfpk1W3m1BKMUNmjKFg@mail.gmail.com>
X-Google-Sender-Auth: OVTq4TP1zQ8jbbYY0ihGdiBCgKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236357>

On Fri, Oct 18, 2013 at 10:52 AM, Johan Herland <johan@herland.net> wrote:
> On Fri, Oct 18, 2013 at 3:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Oct 18, 2013 at 9:17 AM, Johan Herland <johan@herland.net> wrote:
>>> There are cases (e.g. when running concurrent fetches in a repo) where
>>> multiple Git processes concurrently attempt to create loose objects
>>> within the same objects/XX/ dir. The creation of the loose object files
>>> is (AFAICS) safe from races, but the creation of the objects/XX/ dir in
>>> which the loose objects reside is unsafe, for example:
>
> [...]
>
>>> The fix is to simply handle mkdir() setting errno = EEXIST as success.
>>
>> Would it make sense for the commit message to explain what happens if
>> EEXIST is returned but the pathname is not a directory? (For instance,
>> in the same race window, another process had created a plain file or
>> pipe there.)
>
> I'm pretty sure in that case, the following adjust_shared_perm() or
> git_mkstemp_mode() would fail, and we'd end up returning error from
> create_tmpfile() in any case.

>From a quick glance at the code, that was my impression as well.

> I can add the above to the commit message if you insist. :)

It was the only unanswered question which popped into my mind upon
reading the commit message, and required code consultation to answer.

A benefit of mentioning it in the commit message is that future
readers see that these other cases were taken into consideration (but
I don't insist upon a re-roll).
