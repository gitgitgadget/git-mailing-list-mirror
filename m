From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 09:46:58 -0700
Message-ID: <CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
	<1442012994-20374-3-git-send-email-sbeller@google.com>
	<xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 18:47:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbWuQ-0004w2-3U
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 18:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbbINQrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 12:47:03 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34636 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbbINQq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 12:46:59 -0400
Received: by ykdg206 with SMTP id g206so158471292ykd.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jRrBeo4RxIIsHpaeKm92GLuINf02DRU6lZAQQOmftQM=;
        b=Eaq806RvNIEUxQfV4c4i6btwyHlc/IW473t0AW6InxEc1jT0Y6F90FVTQElgBxU9Sa
         lfo1RlUM+M7oEQpv3Bvdj1vLAb7sof0xmpEcJ/803eC7OAHZ2lAxX+BzYkCpZdKHphW0
         RqJVGir8BdQcPHy7S4z0KlgpYgkq6/RYzXn2jFFS1zGAqMoLb7uaFzFzJheubTODFGQf
         z/BMpq8QFeAXZRtpPH5wuHwOegAAl+AA2aj5DbOulbS9Wk0bsbUXUfYY/VX5waq4hIp0
         udFpBJPB86jsjwowYBrEVuiwhXJvzebFkWJKb8Qg9Z4vnEyMW1YpI6eXYF5ND6LGWszo
         F+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jRrBeo4RxIIsHpaeKm92GLuINf02DRU6lZAQQOmftQM=;
        b=GgzVXp4KX6FzvsuuYZQWVgUVjod4Pt7AXXeq8Q/RNQb0UE+vISkESYevgwjR5NB1F/
         T8CVBx7pjkQX4pFkvw7NPLDxiH31CmGI+Td/2CUfx4ttXppG7CvYz5OJ3lOseEVVT0lH
         FKCPiqlhZ1qqJ7LLeePFzn6psPaOAQIj2+W2pxNuvoZDufHI986m5jevEHyaI//RP9Au
         l3/OlRRMrMon6Ggo/BUAHhfgMY4boFT/03/9AKAbKWU8fLhwPEigJioCsh8J+wwg4ICC
         fe9NzHLYGMW9QrfiMQqIjMenN8Mz8ItW+zUriLHK4F1gqaMh/MnvjxISc24IQUuDVFGX
         ClTA==
X-Gm-Message-State: ALoCoQmnsWkiNv7rKB3CDwrnEQAi2XN9SeyZEPAuhMWIKbw6ksolcUELU+1prPNUfGOec1/YC0y8
X-Received: by 10.129.16.212 with SMTP id 203mr15723558ywq.142.1442249219025;
 Mon, 14 Sep 2015 09:46:59 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 14 Sep 2015 09:46:58 -0700 (PDT)
In-Reply-To: <xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277834>

On Sat, Sep 12, 2015 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +                     if (start_command(&children[i]))
>> +                             die(_("Could not start child process"));
>> +                     flags = fcntl(children[i].err, F_GETFL);
>> +                     fcntl(children[i].err, F_SETFL, flags | O_NONBLOCK);
>
> This function in run-command.c looks as if it is a generic helper to
> be called by anybody, but it seems to only care about the standard
> error and not the standard output stream, which means potential
> users that do not dup them together cannot use it.  Is that a big
> downside, or is it sufficient to document the API to say that
> children must do so?  I offhand do not think the latter is
> unreasonable, but that may be only because I haven't thought things
> through.

Yes it ought to become a generic helper eventually.

I tried implementing a buffering solution for both stdout and stderr,
but that doesn't really workout well if you consider interleaved output
on the pipes as we cannot accurately replay that later on. To do that
we would need to store the timing information of the channels, at least
the relative order of it like:

  (stdout, First comes text to stdout),
  (stderr, interrupted by text in stderr)
  (stdout, but stdout doesn't bother, blasting more text)
  (stderr, continues to interrupt)

obtaining the information is inherently racy, as all we can do is
polling/reading from both stdout/err as fast as possible but without
proper synchronization mechanisms we cannot be sure.

I will add documentation explaining why the async output case
will only deal with one channel. I chose stderr as that's already
available and needed in this use case.


>
>> +                     nr_processes++;
>> +                     slots[i] = 1;
>> +             }
>> +
>> +             /* prepare data for select call */
>> +             FD_ZERO(&fdset);
>> +             maxfd = 0;
>> +             for (i = 0; i < n; i++) {
>> +                     if (!slots[i])
>> +                             continue;
>> +                     FD_SET(children[i].err, &fdset);
>> +                     if (children[i].err > maxfd)
>> +                             maxfd = children[i].err;
>> +             }
>> +             timeout.tv_sec = 0;
>> +             timeout.tv_usec = 500000;
>> +
>> +             i = select(maxfd + 1, &fdset, NULL, NULL, &timeout);
>
> I thought we try to use poll() and on systems with only select we
> allow compat/ to emulate in our code.

I did not know that. I'll rewrite the patch to use poll instead.

>
>> +             if (i < 0) {
>> +                     if (errno == EINTR)
>> +                             /* A signal was caught; try again */
>> +                             continue;
>> +                     else if (errno == ENOMEM)
>> +                             die_errno("BUG: keeping track of fds is hard");
>> +                     else if (errno == EINVAL)
>> +                             die_errno("BUG: invalid arguments to select");
>> +                     else if (errno == EBADF)
>> +                             die_errno("BUG: keeping track of fds is hard");
>> +                     else
>> +                             die_errno("Unknown error with select");
>
> I doubt that the later part of elseif cascade adds any value.  You
> will see errno printed anyway.

ok.
