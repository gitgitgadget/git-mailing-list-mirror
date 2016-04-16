From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 17:59:34 -0700
Message-ID: <CAGZ79kY2u_X2xmm=+wvA13bnD57+o1br7vhAL0-Rf6K_1PeXTA@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
	<1460761306-18794-3-git-send-email-sbeller@google.com>
	<xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:59:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arEaK-0001G9-SP
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcDPA7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:59:36 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36479 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcDPA7f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:59:35 -0400
Received: by mail-io0-f178.google.com with SMTP id u185so150348442iod.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xigtstshsdCoIkMNX3R1+95C9KddiLIZ1zvKs2VMhfs=;
        b=Rlb2jPlh+/SdoIAE7bmYtqUUpX4u2dH6/4DNKk7cpIQkdQIt1xLNc8duyS22Sn9KM5
         v/prB2E9Mo9dW1bBexiqTKT8HWwYoNvKyL9vel+nht/diQIWrRVuyrLOWrpBL7Lcstau
         9ieWd64vPk7T/q4pm3PEwmuCZ+uXwIeiWVEfZs95rkG+ug3ChWvLtMXBIjmlcMOPafSD
         yaCdCTTnjcxFmDgyKkxd1fhlPUflPC4y5xBLm4fJ3RaK6q25890WbaCE4RoHVQ+pl6D6
         rxUXd0R+YBwJyf7DWO9eHZ/aI1P9rHORr5q2Q+K2eq+0ZYKUDcTMjszoZ7o8xkMSQ5VQ
         H36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xigtstshsdCoIkMNX3R1+95C9KddiLIZ1zvKs2VMhfs=;
        b=SayYCnkS+RpYYkJMGPlwiizJ5J6E1kzMfL9gKiqfz4jvNnDdOQraX1RYDBTi6YqdFU
         Fn3J9dUOTqgcH51AasXM8yZWrnPEO6m0azjgoI3+W0CB3Cpjz7iLis9my+4WD04ShEep
         H8BWZE+J6kAPc92m0RJH79+lQnSu2NJ9zO38Hr0LVJG0KufKsvJ5i+6Vnmp4AntVDMS7
         R73hLNnc7jJoC/Wv8+mSPS5FVEiZTvOCkQiTDA8rPU6uvY9FOlpFrlqJ4OFr03ahZvx6
         lp/JKg4a36HTdsf0O5PRsS5LF68GhENVqoX1ca4z2B0D38RRb7lyxlOydovGaxcttI9R
         fz1Q==
X-Gm-Message-State: AOPr4FUj53XksuwvT+Z/gtZ8QuZ1N+fr1ckLWx/RNztcGtJ/xb8PF6tVHkyJTMVgU1h3qybdOAkCEGFBMAB8p0Zh
X-Received: by 10.107.18.227 with SMTP id 96mr24867862ios.174.1460768374553;
 Fri, 15 Apr 2016 17:59:34 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 17:59:34 -0700 (PDT)
In-Reply-To: <xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291713>

On Fri, Apr 15, 2016 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static int line_length(const char *recs)
>> +{
>> +     char *s = strchr(recs, '\n');
>> +     return s ? s - recs : strlen(recs);
>> +}
>
> It seems that you guys are discarding this "number of bytes on a
> line, no matter what these bytes are" idea, so this may be moot, but
> is there a guarantee that reading through recs until you happen to
> see a NUL is safe?

We discarded this idea as it produces to many errors.
(We'd be back at the 50:50 case, "is it really worth it?")

We will go back to the "empty line" heuristic, which will be solved
via xdl_blankline(rec[i]->ptr, rec[i]->size, flags); which could be inlined.
That will solve the CRLF issue as a CR is covered as a whitespace
(with CRLF you'd have to specify diff to ignore white spaces).

For the safety I assumed
* there is always a \n even on the last line by convention.
* in case it is not, the string is null terminated, hence
  strchr and strlen for the rescue.

>
> Shouldn't the code that accesses a "line" be using the same "from
> here to there", i.e. recs[]->ptr, recs[]->size, interface to avoid
> having to scan the underlying string in an unbounded way?

xdl_blankline will use ->size, so we'll be holding it right.

Thanks,
Stefan

>
>
