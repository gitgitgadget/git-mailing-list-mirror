From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 10:47:10 -0400
Message-ID: <CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 16:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXVnK-0002Ys-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 16:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbbICOrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 10:47:14 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36802 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbICOrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 10:47:11 -0400
Received: by ykcf206 with SMTP id f206so45388897ykc.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=E5uEgpKJLcgOvRSua6XMaPdT8N8riSj7utvjsR3ziTY=;
        b=OSkyGRlN7RwBpAob4kxOvowwtm7zlVRoCUJIK+2uj3nQWCh44KfjVmxAmsI4yDCx69
         UH7lPWkO/ZF5O5bMrr93Ou9X8POOFN0BoZuf5O2HOBFhsOeLtYf1hGeBeOzx85DTa24i
         hVGD1yE3lDy1aAz27l63XHNlBTjrqiT0PgIJzyyxa2dKuB9t0PgAF0U1dJO6Gc0YOcxP
         CB8BOTP/wdDTvAMnlaPArtpP00+8FJEWKUEo+0poqsJxtSdeyuYd4iMLeoNOUtKydp3d
         8uQwEYakusKP5ezqIvLcWnoedXh92pgRPCc6qhSR5Bk+cnhMYzGJSShfvjFtaasZS+t1
         oDbQ==
X-Received: by 10.129.92.8 with SMTP id q8mr40590907ywb.163.1441291630858;
 Thu, 03 Sep 2015 07:47:10 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 3 Sep 2015 07:47:10 -0700 (PDT)
In-Reply-To: <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
X-Google-Sender-Auth: XTBDPKLF7uw_XPeUdQwUtp054EY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277207>

On Thu, Sep 3, 2015 at 10:39 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>> +{
>> +       if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>> +               size += 2;
>
> Aside from the +2 which Matthieu already questioned, this code has a
> much more serious problem. strstr() assumes that 'buf' is
> NUL-terminated, however, the fact that buf's size is also being passed
> to the function, implies that it may not be NUL-terminated.
> Consequently, strstr() could zip well past the end of 'buf', trying to
> consult memory not part of 'buf', which is a violation of the C
> standard. Even with the band-aid (sp <= buf + size) which tries to
> detect this situation, it's still a violation, and could crash if
> strstr() attempts to consult memory which hasn't even been allocated
> to the process or is otherwise protected in some fashion.
>
> It's possible that 'buf' may actually always be NUL-terminated, but
> this code does not convey that fact. If it is known to be
> NUL-terminated, then it is safe to use strstr(), however, that should
> be shown more clearly either by revising the code or adding an
> appropriate comment.

Also, if 'buf' is indeed unconditionally NUL-terminated, then the (sp
<= buf + size) check is wasted code since the result of strstr() will
always be either NULL or pointing somewhere within the NUL-terminated
string.
