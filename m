From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Mon, 2 Jun 2014 11:12:20 -0700
Message-ID: <CAL=YDWm-7f3sgx-y6QnwwJK9k6fPr1WosBvrQLxh6O79kMbE-w@mail.gmail.com>
References: <1401479462-2329-1-git-send-email-sahlberg@google.com>
	<xmqqfvjr6i7u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWig-0003dw-9S
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaFBSMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:12:22 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:47006 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaFBSMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:12:21 -0400
Received: by mail-vc0-f173.google.com with SMTP id ik5so2629597vcb.32
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lNmcRdjgP9DGPt881tikfTuRKrj26LPPw6od324WVOY=;
        b=CH1mwIY7h6P8xxt4vqi2fkTl/O2VleQrffK0Ft3KdDitjCat1Cv0OTQCQ8HnokQuhE
         GVXAK/fWkuCar40PXycLwZb/j6MfPMMlJTjX9PhrOmXdUx4bFS0klbBHZI9C1pZwR25n
         iGJIF1AgrIfHAq1AdGWsN4/PE1riheMgcy4ydfAZSXqYHUvNGV/SEK/d2Mkd53tQ95lm
         NKGuvgf7ara9/VSHg0WtB2nnBCoIOZJaInTOTzSncW/rO9qFaPdsZPkZ8XsJ06TYZUCn
         ZJLiIXsdfQY/odrH129qYGbfs/V8cCLSEA6mlQMP03d/XmAqIvp8QE+Ooy6Y5BJnTos+
         Ahag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lNmcRdjgP9DGPt881tikfTuRKrj26LPPw6od324WVOY=;
        b=X0Sx5Ekacnaztt/P3HyxwUI02wiU6MGnBmDX3VVvASIw0Zf7l7ta9Cy2oGkmxQKHHK
         ugGoqIfHrkk1juDWWcNNiKckY9oez0XeYBwjdNk0UIMZi9tu4is15Ri2nMSHzl05nKxp
         LDsFTlnAUzzF/YG3jyHjVzk/O3udnCWLZfEo19jT3gUn1Lo1xUgQy1WN20WMZ0onCMCc
         Vj+dgiF7uaspyKV4LPt0jL/kJBpLN97RAtwiajfQ7PVDGmyccTNedo5Rzu60Nv3ury31
         5Qbzb+faRaUSXUizWRVpSE6nRgZffapUKR1Siv1ZuPF/Cxl/bQ/j48hRNI7jUAkLP/UD
         6S3w==
X-Gm-Message-State: ALoCoQkxaA0GvBypr4neCgPEhD1JSpmkgliu7V/BkDTg3k/vbuC7FJjwMN2iR+JvdHKR1ZmTizL3
X-Received: by 10.52.185.72 with SMTP id fa8mr26881947vdc.12.1401732741076;
 Mon, 02 Jun 2014 11:12:21 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Mon, 2 Jun 2014 11:12:20 -0700 (PDT)
In-Reply-To: <xmqqfvjr6i7u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250577>

On Fri, May 30, 2014 at 2:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> read_ref_at has its own parsing of the reflog file for no really good reason
>> so lets change this to use the existing reflog iterators. This removes one
>> instance where we manually unmarshall the reflog file format.
>>
>> Log messages for errors are changed slightly. We no longer print the file
>> name for the reflog, instead we refer to it as 'Log for ref <refname>'.
>> This might be a minor useability regression, but I don't really think so, since
>> experienced users would know where the log is anyway and inexperienced users
>> would not know what to do about/how to repair 'Log ... has gap ...' anyway.
>>
>> Adapt the t1400 test to handle the cahnge in log messages.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c                | 217 ++++++++++++++++++++++++++++----------------------
>>  t/t1400-update-ref.sh |   4 +-
>>  2 files changed, 122 insertions(+), 99 deletions(-)
>
> After reading the log message "we are removing one redundant
> implementation", I would have expected that such a change would
> remove a lot more lines than it would add.  Seeing the diffstat, I
> have to wonder if the fact that we need more lines to reuse the API
> is an indication that the reflog iterator API is overly cumbersome
> to use, perhaps requiring too much boilerplate or something.

Yeah. We simplify the code and make it reuse existing unmarshallers
and make it easier to read,  and the line count goes up :-(

Most of the extra code is the due to the structure to hold all the
data we need in the callbacks and is a bit less compact.
That said, I think the new code is a little easier to read.

The biggest value is that we reduce the number of reflog unmarshallers
by one which will save work when we start storing reflogs in a
different type of backend.

>
> The update in the error message may be a side-effect, but I think it
> is a change in the good direction.
>

The update in error message is also to prepare for the possibility
that we might get a different type of ref and reflog store in the
future.
So that we only generate log messages that refer to filenames in those
places where we are actually accessing files directly.

Thanks. I will resend the patch later with Eric's suggestions.


ronnie sahlberg
