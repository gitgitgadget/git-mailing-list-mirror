From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Mon, 25 Feb 2013 20:43:37 +0200
Message-ID: <CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
	<7vzjysxnb1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA31v-0001T8-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612Ab3BYSni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:43:38 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43782 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab3BYSni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:43:38 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so1777273qaj.12
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4fcakaXDIM//HCVbqafGhrY5Sg4nlxxUNtjhWEJOee4=;
        b=X/A7uPHjwv3LIjx11HXApo6Vmb/bMbbphVuqHNCXjL2buDCp5BJ3g022giYFKCe/o7
         VlYnV0+QPp0LkRhvkcW8BU421GyTvazWTjL2T9vxM9hVN2Pizeq84NiA4BCUd7RcKaFP
         lcvP+lgoGUcMGykgBkAFEuZpfWm2P8ykE8TNYWBl0WaYWaB65BKoRJVS2IH+SRC4xw1l
         efd0P+cBMxgsAita3SPFPJXpoXTa6y8MRWeKo3RRcWBeNnK/aRQbfqdl0q429ylLeclb
         HkMsLwyhbBS7aMmptb7aXAf9FV+filvguHq/UWjmJbvsMApuwVa7zhnlxoO2vrJUC+3M
         rjUg==
X-Received: by 10.224.32.11 with SMTP id a11mr12822697qad.87.1361817817188;
 Mon, 25 Feb 2013 10:43:37 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 10:43:37 -0800 (PST)
In-Reply-To: <7vzjysxnb1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217079>

>> Fix is_date() function failings in detection of correct date in case
>> if time was not properly initialized.
>
> Please explain why this patch is needed and what problem this patch
> is trying to fix (if any) a bit better in the proposed log message.
> For example, on what input do we call this function with partially
> filled *r, and is that an error in the code, or is it an indication
> that the input has only been consumed partially?

function is_date() must not fail if time fields are not set. Currently
is_date() invokes tm_to_time_t() which perform check of time fields.
With these fixes t0006-date.sh test is no longer fail on these tests:

check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'

By the way following test is always fails due to absence of EST5
timezone in timezones array in date.c module.

check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5

> tm_to_time_t() is designed to reject underspecified date input, and
> its callers call is_date() starting with partially filled tm on
> purpose to reject such input. Doesn't "fixing" partially filled tm
> before calling tm_to_time_t() inside is_date() break that logic?

According to logic is_date() have no any relations with time
(hours/mins/secs). In the tests described above date is defined first,
before time, so at the point when date is checked for correctness time
is not defined yet.

Thanks.
