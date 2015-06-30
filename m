From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 17:19:06 -0400
Organization: Twitter
Message-ID: <1435699146.30953.7.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <1435609076-8592-7-git-send-email-dturner@twopensource.com>
	 <CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
	 <xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
	 <CAPig+cQ7tQV6uG0sVMsPJX=8V3g+zufRCYcdfDo4ixwwUp5hZA@mail.gmail.com>
	 <xmqq3819c6ze.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 23:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA2w0-0000UP-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 23:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbbF3VTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 17:19:12 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:32977 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbF3VTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 17:19:09 -0400
Received: by qkhu186 with SMTP id u186so16358261qkh.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 14:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=wIGsj/4KuWD46wGdqUnVrf/+f0OmZPrDUnNct2m8Pfk=;
        b=AawTTgjI0lEXtwmUPIxaF8D6fklzQhEg2+fjsaNL8z0knmOzUI6PLQObu4YOZy9uG/
         A3oeYfSKf3N87ho+GhhdVa9aAi3Oz+MmzWQYPeqmTr6GgI/ukJzgtvzU8HnfZgWa8JQ7
         5E+SgbIfUPJbPZEmw1o10HK3XW3CMELxuDM/x4y7SHoxOcwOxEP+IXhe9kibTZDi0mfO
         z4qgsrigbApk1kGEMh4dkl9T2n6v8uPcD0CBfOAW0yfnaTDpfh9wL8IAcFaHb5ze5Dfx
         vrKidd/SC0lIq7zQGdgwqN/1ExwLe1DAmEx1HQbAay9z2vGRr9oyq1CJdFgdmkDy5Iq1
         2Uxg==
X-Gm-Message-State: ALoCoQlOhSJ2fZK9zbK8PFSTe0WuD4WyFNRvNqY38AN57qptkISHnYT9WWzLwJMVN/hj0oaZv5lA
X-Received: by 10.55.31.226 with SMTP id n95mr48005847qkh.38.1435699148538;
        Tue, 30 Jun 2015 14:19:08 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id f8sm576970qkf.7.2015.06.30.14.19.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 14:19:07 -0700 (PDT)
In-Reply-To: <xmqq3819c6ze.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273104>

On Tue, 2015-06-30 at 12:48 -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >>> Alternatives would be strbuf_reset() or declaring and releasing the
> >>> strbuf within the for-loop scope.
> >>
> >> Because _reset() just rewinds the .len pointer without deallocating,
> >> you would need an extra _release() before it goes out of scope. If
> >> it is expected that the strbuf will be reused for a number of times,
> >> the length of the string each iteration uses is similar, and you
> >> will iterate the loop many times, "_reset() each time and _release()
> >> to clean-up" pattern would save many calls to realloc/free.
> >
> > Yep, that's why I suggested strbuf_reset() as an alternative (and
> > likely would have chosen it myself).
> 
> OK, then let's do that by squashing this in.
> 
>  builtin/reflog.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I squashed that into my repo on github:

https://github.com/dturner-tw/git.git
on the branch dturner/pluggable-backends-preamble
