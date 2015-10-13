From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge: fix cache_entry use-after-free
Date: Tue, 13 Oct 2015 14:05:37 -0700
Message-ID: <xmqqio6aa38e.fsf@gitster.mtv.corp.google.com>
References: <1444687413-928-1-git-send-email-dturner@twitter.com>
	<xmqqio6bbu2w.fsf@gitster.mtv.corp.google.com>
	<1444764167.7234.14.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:05:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6lV-0004Z6-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbJMVFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:05:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33249 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbJMVFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 17:05:40 -0400
Received: by pabrc13 with SMTP id rc13so31858044pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=smNuFvA68iswhXG6ayaTQvojYRZ65EzfGJfdAfhZmJY=;
        b=OsEWeFBHde8HcwTnBZaFwP+DjUFwaljJQnnibXn7BXZwkoPtNDIBILZjLbWpQzRDiK
         yn8eSxRE0RbgLzndLGNIhltgIXS+hK6run4MgTDYGK1qTUoSJgNRK2olteaHw9wIsZQv
         KL6OYsO+zucN1ZaX/Bn08+frGyeKrgZuQSPYTm0ixiSwHa87Ks3C616JZth1O2/sQVSn
         h2ZoxVMdzbHT0v8XTMeZG8XsIkF4NX7HxJc4GhGELF180zfcGsnI4YniVGlUqcH4yVym
         JyhQ6ZY3EzqA+/CHK/G7dzrybDa56euybHAiHkXPrj64BUU6DUOS33jPZ24abM+c3XuT
         UCyQ==
X-Received: by 10.67.16.15 with SMTP id fs15mr43228547pad.82.1444770339522;
        Tue, 13 Oct 2015 14:05:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id yh3sm5528529pbb.82.2015.10.13.14.05.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 14:05:38 -0700 (PDT)
In-Reply-To: <1444764167.7234.14.camel@twopensource.com> (David Turner's
	message of "Tue, 13 Oct 2015 15:22:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279519>

David Turner <dturner@twopensource.com> writes:

>> This one smelled iffy.  I think it is safe because the caller does
>> not look at src[] other than src[0] after this function returns, and
>> this setting to NULL happens only when o->merge is set to 1, so I do
>> not think this is buggy, but at the same time I do not think setting
>> to NULL is necessary.
>> 
>> Other than that, looks nice.  Thanks.
>
> I like to set a pointer to NULL after I free the thing pointed to by it,
> because it helps make use-after-free bugs easier to detect.  

Yes, but it also helps unintended bugs to creep in if done blindly,
and that is why I vetted what happens in the codepath of the caller
of this function after src[] entries are NULLed (the caller could be
expecting to do things only to NULLed fields, for example, in which
case clearing them like this patch would have changed the behaviour
of the caller after this function returns).

Thanks.
