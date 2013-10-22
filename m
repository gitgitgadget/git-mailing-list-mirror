From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 15:15:35 +0200
Message-ID: <CAEef6Wx7K0KJK-dMJ2HTgdoGvVhve7=rHK8gv1gQc7GO5_K0WA@mail.gmail.com>
References: <1382443823-31317-1-git-send-email-jl@opera.com>
	<CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 15:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYboV-0004in-4c
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 15:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3JVNPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 09:15:39 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:58760 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab3JVNPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 09:15:36 -0400
Received: by mail-lb0-f175.google.com with SMTP id z5so1829933lbh.6
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 06:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eNFUHcvJluNcislPMhuNURcqMSw9+xXpTzfPdgY3gBA=;
        b=A3IOIVJjJIZgjoyORg4wL79sQ818uwxjrnjOnWn/YWvLF1i9oxcKG5cGC2c+8U5F9s
         Jm9Y7Qa424dLXpJwiXIjUHGFdTdwnLPfSZHStC9MVKSaFF4teCl9IG86pH9fScJ/EWEJ
         0zwIP4XAoueP/Ev8IUBivrZCH+wbsBTVXAqGzyXxLQTV3J0pVqM1dx+LE3EGtNW2tnfW
         FjsTI5xhS5Ypp95TTKfhBYBLoGJs3eJu9hGFOFVxj7yWFciKarB8BroE1FRYQ0Kq3+1R
         9tFUX3ywmWxBhtXpUfNUYplb1H+NQ49RJRcgHkfTiuVgF9T4UfLSDqZJlPNymdK4EfDs
         BB/w==
X-Gm-Message-State: ALoCoQnTP5bVKTktiJwnp9tyYN/7kpLDfurqqQIMnYnwMtG6DUW6PCnSSe/yFTBbSahiZwuNvdXH
X-Received: by 10.152.37.130 with SMTP id y2mr15825814laj.24.1382447735110;
 Tue, 22 Oct 2013 06:15:35 -0700 (PDT)
Received: by 10.112.56.171 with HTTP; Tue, 22 Oct 2013 06:15:35 -0700 (PDT)
In-Reply-To: <CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236469>

On Tue, Oct 22, 2013 at 2:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:

> Not your itch. But if you have time you may want to fix fetch-pack
> too. It has the same problem. fetch-pack.c:get_pack() with
> use_sideband =3D=3D 0 passes fd[0] to start_command(), then later its
> caller transport.c:fetch_refs_via_pack() closes the handle again.

I'll update the patch to clear that fd as well.


>> Signed-off-by: Jens Lindstr=C3=B6m <jl@opera.com>
>> ---
>>  send-pack.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/send-pack.c b/send-pack.c
>> index 7d172ef..7def2af 100644
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -302,6 +302,9 @@ int send_pack(struct send_pack_args *args,
>>                                 finish_async(&demux);
>>                         return -1;
>
> In this code block, there is "close(out);", we may need to set fd[1] =
=3D -1 too.

This block closes the fd unconditionally, I think. Either via
pack_objects() (if !args->stateless_rpc) or directly (otherwise.) So I
guess it should always clear the fd before returning to be safe.


>>                 }
>> +               if (!args->stateless_rpc)
>> +                       /* Closed by pack_objects() via start_comman=
d() */
>> +                       fd[1] =3D -1;
>>         }
>>         if (args->stateless_rpc && cmds_sent)
>>                 packet_flush(out);
>
> I was puzzled by this packet_flush(out) for a while because I thought
> "out" was already closed. Turns out when stateless_rpc is true, a new
> pipe is created in pack_objects() and "out" is not closed. So
> everything is still good (and messy).
>
> Life would have been simpler if fd[1] was _always_ closed by
> send_pack(), like in c20181e (start_command(), if .in/.out > 0, close=
s
> file descriptors, not the callers - 2008-02-21).

It did strike me as a bit unclear who exactly "owned" these file
descriptors. But I'm of course wholly unfamiliar with this code.

/ Jens
