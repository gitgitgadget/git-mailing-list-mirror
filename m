From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 18:05:10 -0500
Message-ID: <CAPig+cTbQXJPu5WHqCXDJL-s0XzB+PdOX9akoXHH1DmsLU5phQ@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
	<CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cBC-00042Q-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbbLNXFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:05:12 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36633 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbbLNXFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:05:11 -0500
Received: by vkay187 with SMTP id y187so164229497vka.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XiIZYR85hfEz4noYt0Z8/ckAjfZpW8WMaoNONLWPx2U=;
        b=RL4XR72nM5zAyzWtZRXANYmi2/Ks0D+mZIi7Nwc4jpnN38rBT4E+kIhkTZ0/kE4CXE
         5LoDtqi1ZBl/Fe2wVeScOMhn1YktUV0fvnnelV8sSykgN6H7vP/j1O/JYm7KKzsyZkvB
         Ef1iLAm+JxP/WqyaylvSV9MuycA9jTRKhtl0StEcFdYhwRHzNxR+h34BolRf0/IdvzNv
         FSQjoZ7b8Ju2izpAWK9/mT4/8Do9rcgJQvJQVvYEusjrrHao6SC/tToL6CgiTIod20UO
         wEwDgUHK2R+PHkd7Xn+K4B8SNnty30ngrAnx8ke3Qv0FtFMJ3juIlwf3ZEIXGmQfvaZ2
         uIlw==
X-Received: by 10.31.58.74 with SMTP id h71mr26812811vka.151.1450134310594;
 Mon, 14 Dec 2015 15:05:10 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 15:05:10 -0800 (PST)
In-Reply-To: <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282445>

On Mon, Dec 14, 2015 at 6:03 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 2:37 PM, Stefan Beller <sbeller@google.com> wrote:
>> Provide a wrapper to read(), similar to xread(), that restarts on
>> EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
>> handle polling itself, possibly polling multiple sockets or performing
>> some other action.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/wrapper.c b/wrapper.c
>> @@ -252,6 +252,28 @@ ssize_t xread(int fd, void *buf, size_t len)
>> + * xread_nonblock() is the same a read(), but it automatically restarts read()
>> + * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
>> + * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
>
> The last sentence is confusing. From the commit message, we learn that
> this function doesn't care about EAGAIN or EWOULDBLOCK, yet the above
> comment seems to imply that it does. What it really ought to be saying
> is that "as a convenience, errno is transformed from EWOULDBLOCK to
> EAGAIN so that the caller only has to check for EAGAIN".

I forgot to mention that the mutation of EWOULDBLOCK into EAGAIN is
something that should be described in the header rather than here at
the source. In fact, the entire comment block above this function is
more suitable in the header file.
