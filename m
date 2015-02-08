From: Junio C Hamano <gitster@pobox.com>
Subject: Re: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 7 Feb 2015 18:13:47 -0800
Message-ID: <CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de>
 <loom.20150207T182443-33@post.gmane.org> <54D67662.7040504@web.de>
 <CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com> <loom.20150207T232422-706@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 03:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKHOD-0000OW-Gl
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 03:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbBHCOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 21:14:10 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51552 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbBHCOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 21:14:09 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so19803202obc.9
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 18:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5IlSn5qGQ/+fJgjsaSxgCDlXL1DVa5Y9IDHX65cIeQI=;
        b=kD+/v93dBN9cKj6mRdemEe+UR4bF/TF0qXMgwJ0+e+wr28leYOuO0kGRdMjjJBeTfs
         Qrnvhb9H3fsr8cIdBevRwqVsbpufxcTWRkHV/ZIsl8TOnWBz6oWebOxDSgoDaU8/rRVC
         MXs4SBdSZbwLYBjyyqsa92UsM7IxS0nnXcu0uE22y0fLkGeP8SA/Ww1Xqp1H5c1JotOc
         AwmlbqmwqZwJg+NjpRYQM0BpKZzqzDADUJcq3t3dq4/IDL8/+7iB1qsp5nqz+2YOQti0
         oD0TLQx1B4RPNxxEm2C8O4eNim3D8+JSEeKLz42o1DmUDQx9vVaIl7INZGJDRlmKuYLj
         zfrA==
X-Received: by 10.202.87.142 with SMTP id l136mr7100999oib.84.1423361648174;
 Sat, 07 Feb 2015 18:14:08 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sat, 7 Feb 2015 18:13:47 -0800 (PST)
In-Reply-To: <loom.20150207T232422-706@post.gmane.org>
X-Google-Sender-Auth: Jo-ujuEsHVzCwmP7tN_wrguuqkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263460>

On Sat, Feb 7, 2015 at 2:31 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>>
>> Yup, I agree that is a sensible way to go.
>>
>>  (1) if Makefile overrides the size, use it; otherwise
>>  (2) if SSIZE_MAX is defined, and it is smaller than our internal
>> default, use it; otherwise
>>  (3) use our internal default.
>>
>> And leave our internal default to 8MB.
>>
>> That way, nobody needs to do anything differently from his current build
> set-up,
>> and I suspect that it would make step (1) optional.
>
> something like this:
>
> /* allow overwriting from e.g. Makefile */
> #if !defined(MAX_IO_SIZE)
> # define MAX_IO_SIZE (8*1024*1024)
> #endif
> /* for plattforms that have SSIZE and have it smaller */
> #if defined(SSIZE_MAX && (SSIZE_MAX < MAX_IO_SIZE)
> # undef MAX_IO_SIZE /* avoid warning */
> # define MAX_IO_SIZE SSIZE_MAX
> #endif

No, not like that. If you do (1), that is only so that the Makefile can override
a broken definition a platform may give to SSIZE_MAX.  So

 (1) if Makefile gives one, use it without second-guessing with SSIZE_MAX.
 (2) if SSIZE_MAX is defined, and if it is smaller than our internal
default, use it.
 (3) all other cases, us our internal default.
