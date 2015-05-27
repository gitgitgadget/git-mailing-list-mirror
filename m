From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of upload-pack
Date: Wed, 27 May 2015 10:40:37 -0700
Message-ID: <CAGZ79kYaoViDrz9TKXWebif4mfyUjzJ6b3id8ozTqtwsmjAC1A@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-5-git-send-email-sbeller@google.com>
	<20150527063558.GB885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 19:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxfJr-00029o-RW
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 19:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbE0Rkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 13:40:39 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34793 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbE0Rki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 13:40:38 -0400
Received: by qcbhb1 with SMTP id hb1so7060841qcb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YTkHQKNVyn2UeIVs/vR1c5gPWwfMdtnY3ivHQcKNDzo=;
        b=WxHr9+WtOp//U5SAFT6d9USy/wIkTeDb+UHiCgRVYAaymEtfrKpLs0vMAGYtopl4Le
         JITP5dUUMXhnzTfSMEUwvf0rGpzLMS8JgBhImnUEVDxknCnKZbwgNtqptKL9m/ETdmMG
         wv9+wQ4oCb6mhvxOGObF+wJjMsex2wc/KFLn2YXvPPGt07Zvhb8oc32BmAyotkRJjK++
         lAUtlM9PZyLLMaUmAXQiAwv0qUEmavTgITSnYghYBGOnOpt3iwYZae90Dmfc8L4axqla
         5zpVoztaP8nnZpQW3VaG/xAxcp6xV1n11dFfv5sz+c0qZ8yhPIi0GpsztzHfIG1KqyDZ
         wQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YTkHQKNVyn2UeIVs/vR1c5gPWwfMdtnY3ivHQcKNDzo=;
        b=iDDo/MP2/q9BHttxrBK8UiJSEFSI909cDPt0I+iZPrpjgdZTp0rbPrjzdKd42qJQMt
         l5qd0Nw9L+e7iUxJ65LtSluXtplwyYP2p3MsulzMhyCjhsGiAmC5eZBqGLf3rLbd+h1m
         eid2c+aBrRATTGyXjRdTHG0oKY9aMHMKgJErBZuQzSXF0pnhZSE9zcKYmpajJus64YdA
         PsrlPndmtXZXVmbVX9ayTOtAUKwDrAlPe7atMje66A8WR+b9lYcZYzd3sIRys5GS980g
         JMk9of9U0wSq9oX3rNdb+CuDw5UKZpuEYlF1Iu7Cvv9m6dALR9voSYEqRFVS8vlkMRDi
         87Rw==
X-Gm-Message-State: ALoCoQmWY3dEYd2DmmSzuh18HAbo+q4RXWRbgaexP/uTJbJYPDyKZYrl6r3DDLW59Q9RXyzgmoIv
X-Received: by 10.140.133.9 with SMTP id 9mr38215275qhf.5.1432748437738; Wed,
 27 May 2015 10:40:37 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 10:40:37 -0700 (PDT)
In-Reply-To: <20150527063558.GB885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270061>

On Tue, May 26, 2015 at 11:35 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 26, 2015 at 03:01:08PM -0700, Stefan Beller wrote:
>
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -716,10 +716,47 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
>>               strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
>>  }
>>
>> -static const char *advertise_capabilities = "multi_ack thin-pack side-band"
>> +static char *advertise_capabilities = "multi_ack thin-pack side-band"
>>               " side-band-64k ofs-delta shallow no-progress"
>>               " include-tag multi_ack_detailed";
>
> If we are upload-pack-2, should we advertise that in the capabilities? I
> think it may make things easier later if we try to provide some
> opportunistic out-of-band data. E.g., if see tell git-daemon:
>
>   git-upload-pack repo\0host=whatever\0\0version=2
>
> how do we know whether version=2 was understood and kicked us into v2
> mode, versus an old server that ignored it?

So in my vision we would call git-upload-pack-2 instead of having a "version=2".
and if git-upload-pack-2 doesn't exist, the whole conversation is
over, the client
it is left to make up some good error message or retry version 1.

But I think advertising both which versions the server could deal
with, as well as
the currently expected version is a good thing.

capability: can_speak=1,2
capability: speaking_now=2

>
> It also just makes the protocol more self-describing; from the
> conversation you can see which version is in use.
>
>> +static void send_capabilities(void)
>> +{
>> +     char buf[100];
>> +
>> +     while (next_capability(buf))
>> +             packet_write(1, "capability:%s\n", buf);
>
> Having a static-sized buffer and then passing it to a function which has
> no idea of the buffer size seems like a recipe for a buffer overflow. :)

Yes. All patches I proposed are very brittle. My first goal was to have the
last test passing (an actual fetch with version 2). Now I will start looking at
making things robust, as by now you all seem to not disagree totally.

>
> You are fine here because you are parsing the hard-coded capabilities
> string, and we know 100 is enough there. But it's nice to avoid such
> magic.
>
> Like Eric, I find the whole next_capability thing a little ugly. His
> suggestion to pass in the parsing state is an improvement, but I wonder
> why we need to parse at all. Can we keep the capabilities as:
>
>   const char *capabilities[] = {
>         "multi_ack",
>         "thin-pack",
>         ... etc ...
>   };
>
> and then loop over the array? The v1 writer will need to be modified,
> but it should be fairly straightforward (loop and add them to the buffer
> rather than dumping the whole string).

Thanks for the design guidance! I'll change that.

>
> Also, do we need the capability noise-word?

I thought it opens up a new possible door in the future.
As we ignore anything not starting with "capability" for now, you
could introduce
your foo and bar ping pong easily and still be version 2 compatible.

S: capability: thin
S: capability: another-capability
S: ping-pong foo
S: done
C: (not having understood ping-pong) just answering with capability: thin
C: done, let's proceed to refs advertisement

The alternative client would do:

C: ping-pong: foo-data1a
S: ping-pong: foo-data1b
C: ping-pong: foo-data2a
C: capability: thin
...

> They all have it, except
> for:
>
>> +     packet_write(1, "agent:%s\n", git_user_agent_sanitized());
>
> But isn't that basically a capability, too (I agree it is stretching the
> definition of "capability", but I think that ship has sailed; the
> client's response is not "I support this, too" but "I want to enable
> this").
>
> IOW, is there a reason that the initial conversation is not just:
>
>   pkt-line("multi_ack");
>   pkt-line("thin-pack");
>   ...
>   pkt-line("agent=v2.5.0");
>   pkt-line(0000);
>
> We already have framing for each capability due to the use of pkt-line.
> The "capability:" is just one more thing the client has to parse past.
> The keys are already unique up to any "=", so I don't think there is any
> ambiguity (e.g., we don't care about "capability:agent"; we have already
> assigned a meaning to the term "agent", and will never introduce a
> standalone capability with the same name).

It looks clearer to me (we're not wasting band-width), maybe this ping pong
thing can be part of the capabilities announcement too, so we're good this way.

>
> Likewise, if we introduce new protocol items here, the client should
> either ignore them (if it does not understand them) or know what to do
> with them.
>
>> +static void receive_capabilities(void)
>> +{
>> +     int done = 0;
>> +     while (1) {
>> +             char *line = packet_read_line(0, NULL);
>> +             if (!line)
>> +                     break;
>> +             if (starts_with(line, "capability:"))
>> +                     parse_features(line + strlen("capability:"));
>> +     }
>
> Use:
>
>   const char *cap;
>   if (skip_prefix(line, "capability:", &cap))
>         parse_features(cap);
>
> Or better yet, if you take my suggestion above:
>
>   parse_features(line);

will do.

>
> :)
>
>> +static int endswith(const char *teststring, const char *ending)
>> +{
>> +     int slen = strlen(teststring);
>> +     int elen = strlen(ending);
>> +     return !strcmp(teststring + slen - elen, ending);
>> +}
>
> Eric mentioned the underflow problems here, but I wonder even more:
> what's wrong with the global ends_with() that we already provide?

I was missing knowledge we have that, and apparently I was thinking it's
faster to come up with my own version than to look for it. :)

>
> -Peff
