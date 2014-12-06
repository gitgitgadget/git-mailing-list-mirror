From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Fri, 5 Dec 2014 16:48:10 -0800
Message-ID: <CAJo=hJvt1fkgkMdQX=dkcdBcmv_PT4pnz5BC9d0DSLCi=Q7ZbQ@mail.gmail.com>
References: <1413884908.4175.49.camel@seahawk> <20141021144838.GA11589@seahawk>
 <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com> <1413963706.11656.5.camel@seahawk>
 <xmqqfveghvw3.fsf@gitster.dls.corp.google.com> <20141026153931.GA28288@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:48:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx3Y8-0001rB-Gh
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 01:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbaLFAsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 19:48:33 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:61425 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaLFAsc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 19:48:32 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so193421igb.11
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jgRwVR65Gl4IJLhZcg9Z2l45NkOS1CbX75AyCVWmpF8=;
        b=D8yZuxJInknSeX7qi8+n7eRwjSMjdqymEF3XOINv4jamRhr+r+th13z4v6x9Qd2md6
         FHxCaH69mJyt6Qaxe7EymUaJ6KEneM/OR6kny6P3eRgYaM8zBwED64HLdqlBYCcPOS+f
         ttFB8dgCXX1B2Y8q2SBnDarFXFRchilHm7L+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jgRwVR65Gl4IJLhZcg9Z2l45NkOS1CbX75AyCVWmpF8=;
        b=U6mnBZWrRoc87SLd/huoP7BAJsh2Tl7VvhoZR9ODVNTPFMTz+hzAO32E1FQ+M9jiPk
         +QaDEFLG8XkeCPMDK7wQyJLNMYRumRqcq/KDDGuoEp5T+wiIC0b8rOtH9Pxk0SFcae0g
         Dg++oeW2yXlrF6DvyTyGk/Aizpi+Fie+ykKLKGwUij/aGyG6HAsB+aOeUVwuSTSIObKn
         qcvOPB1U9UvdfQv4uId9LQ1TzOPqe+edJmA+ZGpZPyWB+k4D2aYLM9YI92RJdKpB5EfD
         wqMlmg8f/tZeJElktVmJ3jEJ7nq3yR4JVc5+GfdvVvcGYEnSYf3bArjW1kZDGMO9v+cm
         i2NQ==
X-Gm-Message-State: ALoCoQmzK5ItQgY/xtDqdK84L/fGtnUNbeUIN11cowo/Oe/ao02IMJ50GJEj6NpzTgpdpDn7ZU6O
X-Received: by 10.107.25.129 with SMTP id 123mr1301877ioz.90.1417826911120;
 Fri, 05 Dec 2014 16:48:31 -0800 (PST)
Received: by 10.64.226.161 with HTTP; Fri, 5 Dec 2014 16:48:10 -0800 (PST)
In-Reply-To: <20141026153931.GA28288@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260920>

On Sun, Oct 26, 2014 at 8:39 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Wed, Oct 22, 2014 at 10:11:40AM -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>
>> > On di, 2014-10-21 at 10:56 -0700, Junio C Hamano wrote:
>> >> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> >>
>> >> > By not clearing the request buffer in stateless-rpc mode, fetch-pack
>> >> > would keep sending already known-common commits, leading to ever bigger
>> >> > http requests, eventually getting too large for git-http-backend to
>> >> > handle properly without filling up the pipe buffer in inflate_request.
>> >> > ---
>> >> > I'm still not quite sure whether this is the right thing to do, but make
>> >> > test still passes :) The new testcase demonstrates the problem, when
>> >> > running t5551 with EXPENSIVE, this test will hang without the patch to
>> >> > fetch-pack.c and succeed otherwise.
>> >>
>> >> IIUC, because "stateless" is just that, i.e. the server-end does not
>> >> keep track of what is already known, not telling what is known to be
>> >> common in each request would fundamentally break the protocol.  Am I
>> >> mistaken?
>> >
>> > That sounds plausible, but why then does the fetch complete with this
>> > line removed, and why does 'make test' still pass?
>>
>> The fetch-pack program tries to help the upload-pack program(s)
>> running on the other end find what nodes in the graph both
>> repositories have in common by sending what the repository on its
>> end has.  Some commits may not be known by the other side (e.g. your
>> new commits that haven't been pushed there that are made on a branch
>> forked from the common history), and some others may be known
>> (i.e. you drilled down the history from the tips of your refs and
>> reached a commit that you fetched from the common history
>> previously).  The latter are ACKed by the upload-pack process and
>> are remembered to be re-sent to the _next_ incarnation of the
>> upload-pack process when stateless RPC is in use.
>>
>> With your patch, you stop telling the upload-pack process what these
>> two programs already found to be common in their exchange.  After
>> the first exchange, fetch-pack and upload-pack may have noticed that
>> both ends have version 2.0, but because you do not convey that fact
>> to the other side, the new incarnation of upload-pack may end up
>> deciding that the version 1.9 is the newest common commit between
>> the two, and sending commits between 1.9 and 2.0.
>>
>> If you imagine an extreme case, it would be easy to see why "the
>> fetch completes" and "make test passes" are not sufficient to say
>> anything about this change.  Even if you break the protocol in in a
>> way different from your patch, by not sending any "have", such a
>> butchered "fetch-pack" will become "fetch everything from scratch",
>> aka "clone".  The end result will still have correct history and
>> "fetch completes" would be true.
>>
>> But I'd prefer deferring a more detailed analysis/explanation to
>> Shawn, as stateless RPC is his creation.

Junio's statement above about the world is correct.

> Thanks for the explanation, that makes it quite clear that this approach
> is wrong. The patch below (apologies for the formatting, I'm not quite
> sure how to use format-patch in this situation) does it differently: by
> buffering upload-pack's output until it has read all the input, the new
> test still succeeds and again 'make test' passes.

This probably introduces latency into the traditional bidirectional
multi_ack protocol.

> @@ -384,15 +385,19 @@ static int get_common_commits(void)
>                         if (multi_ack == 2 && got_common
>                             && !got_other && ok_to_give_up()) {
>                                 sent_ready = 1;
> -                               packet_write(1, "ACK %s ready\n", last_hex);
> +                               packet_buf_write(&resp_buf, "ACK %s ready\n", last_hex);
>                         }
>                         if (have_obj.nr == 0 || multi_ack)
> -                               packet_write(1, "NAK\n");
> +                               packet_buf_write(&resp_buf, "NAK\n");

By buffering and delaying these when !stateless_rpc we defer telling
the peer in a multi_ack exchange. That delays the peer from cutting
off its communication by about 1RTT.
