From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as "sideband"
Date: Tue, 1 Sep 2015 15:23:06 -0700
Message-ID: <CAGZ79kZKJF2epU=2gb7jFWni2tBu03dYGgttvZeW40ra=r2iiA@mail.gmail.com>
References: <20150901202215.GA17370@sigill.intra.peff.net>
	<20150901202412.GA8020@sigill.intra.peff.net>
	<xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtxS-0006T2-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbbIAWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:23:09 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:32997 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbIAWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:23:07 -0400
Received: by ykei199 with SMTP id i199so5369457yke.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=inboSKpECc5lQY9aZS+E7Gu3wYpkjQ7MjZAbR3u3X9s=;
        b=df6GQ6YZIAZkh8AtDtoSAQDQiJiiZu8lFxWdNntZz1In8myGD7WthRUM2nVb4fQlAs
         luCWdbInSZMQMQ/gPBZcMTkP5IQXK3zxDcQ9jf12I3xegZ3/nBC4qHoTALrlbUdXh/qy
         kvSNVgDIdmLbvpKfM+KiD5rotybnbNj/edOxLqwVW1NBMLahvI6WAEpc17Nnhe2ds9ws
         uTwC2p2Yeb/wAd0xVl63d4+oX2TB+3/1WzEmzKGAoTcAXWNZjKeMDwfBkL+/70s4WuB7
         DufpOjFOmU4Ux4hT30qoXoBemxqPO5/cM4vPVJzmRbXK4b5cM2tqgzRCdBRG1U65bXyh
         3vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=inboSKpECc5lQY9aZS+E7Gu3wYpkjQ7MjZAbR3u3X9s=;
        b=LW26fbNNcLsI5G3+aySBiki/1RVeTSdOYgTpFzzhKFqGzk8GjZvVWWJ0ILdtY5Szcu
         Znx5BxcU8lKxLhOOvOAcl/+UOCBFdtRbkahYC2BTXF5uJ664FRR4uf4AOMvhuYLzlpas
         h/lHZKEWMyzxZBLxBgGHjfN4vOvDwTaAIcy6EuYJL3QpXezj76rU0U5vv4D6M4WpUQPp
         ESW9hXuszr9sBnQZsEYPXJTzyfBoN0j4JUgFsI029gMZC3hwHw7z9yt5OocQZ72l8pdP
         WgGIRes3yd3yabL4losQPin9cQfoAA9FT/1JbMKqswFga6vLfPm+ipj75NEpF7CEmXBo
         m/Fg==
X-Gm-Message-State: ALoCoQmBig1Cr5EqUyuT1PopgY8+Cgm3P72pk2l124BKW9ZTkqFqOB0hX2lNeHPdrW2CPtND4Hnn
X-Received: by 10.170.122.88 with SMTP id o85mr802070ykb.119.1441146186877;
 Tue, 01 Sep 2015 15:23:06 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 15:23:06 -0700 (PDT)
In-Reply-To: <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277057>

On Tue, Sep 1, 2015 at 3:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> What we really need is thread-local storage for
>> packet_trace_identity. But the async code does not provide
>> an interface for that, and it would be messy to add it here
>> (we'd have to care about pthreads, initializing our
>> pthread_key_t ahead of time, etc).
>
> True.
>
>> So instead, let us just assume that any async process is
>> handling sideband data. That's always true now, and is
>> likely to remain so in the future.
>
> Hmm, does Stefan's thread-pool thing interact with this decision in
> any way?

I do not plan to actually fetch from inside the thread pool, but each thread
is just a proxy for starting a new process doing the fetch and getting
the output
in order.

That seems to be the least amount of work to me. Very long term we may want to
do the fetch directly in a thread pool worker, but then we can also
add the thread
local storage interface.

>>
>> The output looks like:
>>
>>    packet:  sideband< \1000eunpack ok0019ok refs/heads/master0000
>>    packet:      push< unpack ok
>>    packet:      push< ok refs/heads/master
>>    packet:      push< 0000
>>    packet:  sideband< 0000
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  pkt-line.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/pkt-line.c b/pkt-line.c
>> index 08a1427..62fdb37 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -1,5 +1,6 @@
>>  #include "cache.h"
>>  #include "pkt-line.h"
>> +#include "run-command.h"
>>
>>  char packet_buffer[LARGE_PACKET_MAX];
>>  static const char *packet_trace_prefix = "git";
>> @@ -11,6 +12,11 @@ void packet_trace_identity(const char *prog)
>>       packet_trace_prefix = xstrdup(prog);
>>  }
>>
>> +static const char *get_trace_prefix(void)
>> +{
>> +     return in_async() ? "sideband" : packet_trace_prefix;
>> +}
>> +
>>  static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
>>  {
>>       if (!sideband) {
>> @@ -57,7 +63,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>>       strbuf_init(&out, len+32);
>>
>>       strbuf_addf(&out, "packet: %12s%c ",
>> -                 packet_trace_prefix, write ? '>' : '<');
>> +                 get_trace_prefix(), write ? '>' : '<');
>>
>>       /* XXX we should really handle printable utf8 */
>>       for (i = 0; i < len; i++) {
