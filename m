From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] receive-pack.c: only accept push-cert if
 push_cert_nonce was advertised
Date: Fri, 9 Jan 2015 15:15:17 -0800
Message-ID: <CAGZ79kZhUZBU886UkqbAXZwSO+xE90FyEqcJYB+AQZ9Aa_c9xg@mail.gmail.com>
References: <1420836437-11068-1-git-send-email-sbeller@google.com>
	<xmqqsifjbmu2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:15:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9im3-0003fp-Ec
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 00:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbbAIXPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 18:15:19 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58086 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbbAIXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 18:15:18 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so17713870iec.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y/Bm8DhN389e48YIo6/pne5Yg6wzUY8tJEq1iKDWSgs=;
        b=hbNHnGu28bDPTW27swkaU5kZ7iX/yt5wyz1aHyDRfnWvIXC4lJX706MLczA9kH+fIp
         3j8GC0YI66yELBq+30DvmlClFmjC3p5MP9JE8RejM9vacFlNZyNiwZvW0VZLvmYERP0b
         gdI5ZlSeU1VP78x0XFAKKJQmHAJEYD1q0zytMrqKO9dbMmROLN0z7V/+OLAtc9vIpLIv
         hSIKrpm508+8YKClcB2daguxs9W4YD3kE0rZV6CILKJIQXmkp9pgJ88cuGgKZ0xTZ2nk
         9WAcVHERRzYmj2IzrV6HRtILLETcEh1Ao3U/yGn1n/n5ByWfYu8yQx8yd9oj8hUyh9Yu
         aQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=y/Bm8DhN389e48YIo6/pne5Yg6wzUY8tJEq1iKDWSgs=;
        b=b1ykHEiQwBO7rjZ7LXARZHRDGohJwjj0qTwIbyiNbQxoWSE3oJC96apG3+AZJ3FTrM
         A9YG8yGQHcetXajQVs6zvvs0rkp0WA7VTpIBDirp6Efl859abW+oeihjuBeynOC/wvNX
         JsGNuGn0GWu6fFAlfg6mfLLUd2zIGz4RWdhSgcYmnMVVKNlAKW7aqmJxpkOW1IJNEuf7
         iyGgcpTrs0BxJHbU3zyikrETxwYcsfFH95FuGs/uVmYZQlszts8UlnpUxWN94rGPfa2o
         qG0LY8XrqeOPTI7G7ffAIjgzlkchTAXPuT8Ft0xDX/l5XX4j1xYSLSoqF0P31wkaILyY
         EwxA==
X-Gm-Message-State: ALoCoQnjM8JDlFsLFS467XsDN0ltufOO+VYRR2iyW4pIl8dQ3Z+J2BgHtZ5OyZJRNkiZdwZ45xfk
X-Received: by 10.50.107.36 with SMTP id gz4mr5074416igb.25.1420845317519;
 Fri, 09 Jan 2015 15:15:17 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 9 Jan 2015 15:15:17 -0800 (PST)
In-Reply-To: <xmqqsifjbmu2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262251>

On Fri, Jan 9, 2015 at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The patched code will make it fail by hoping that queue_command()
> that only handles "40-hex 40-hex ref" will reject the line that
> begins with "push-cert".  Instead of relying on such a hidden
> dependency, wouldn't it be cleaner to actually parse the push-cert
> block and then at the end notice and explictly say "Your requests
> were syntactically correct, but I am not going to honor your request
> to use the push-cert extension, because I never told you that I'd
> offer you that capability", instead of rejecting the request with "I
> was expecting old/new/ref but you sent a line with 'push-cert' on
> it; what are you talking about?"

When reading the documentation at first I understood it the way:
"If I did not advertise the feature, I am expected to pretend it
doesn't even exist". That lead me to the implementation as
proposed.

Your proposal to acknowledge the correctness of the message leads
to more questions. How would we proceed? We would not  accept the
featured capability, but we could still do a normal push operation. This
would not be desired by a authentic user, so aborting the whole push
process would be ok.

I expect such behavior only from malicious clients which actively want
to abuse a feature which wasn't advertised, so I wouldn't mind being
slightly dishonest to the client and pretend we don't know that capability.
But relying on the hidden dependency is bad indeed. So maybe just
answer more rudely "I did not advertise one of the capability you
requested, go away! (closes connection)".


> But the other side of the same coin is that it makes it harder to
> diagnose the failure.

The push-cert case is special compared to other capabilities as it
is quite intrusive to the protocol compared to say "quiet", so more
diagnosis may be helpful.

> When the protocol exchange gets to this state, in practice, we know
> we are talking with somebody who has push privilege into the
> repository,

Yeah but what is one repository compared to the whole server?
(Just painting the devil on the wall now:) Say you could abuse one
capability to gain access to the server or create a huge memory
allocation such that the server becomes unresponsive for others.

I know my argument is weak for the "parse and reject route", so
I will see if I can adjust the patch to give diagnosis but still reject
the un-advertised capability.
