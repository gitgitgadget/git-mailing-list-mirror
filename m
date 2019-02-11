Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77DA1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBKVpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:45:01 -0500
Received: from elephants.elehost.com ([216.66.27.132]:60737 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfBKVpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:45:01 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1BLisL1002816
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 16:44:54 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>     <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com> <xmqqsgwugi21.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgwugi21.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Proposed Fix] daemon.c: not initializing revents
Date:   Mon, 11 Feb 2019 16:44:48 -0500
Message-ID: <003501d4c253$05f16fd0$11d44f70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHuZCOJOJA2t83onwaMLThpXvGUrQHifX28AeBEHIKliccyIA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2019 15:57, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > Hi All,
> >
> > I found this while trying to track down a hang in t5562 - this isn't
> > the fix, but here it is something that could be considered a
> > code-inspection. If there have been random unexplained hangs when git
> > runs as a daemon, this might be the cause.
> >
> > According to many systems (other than Linux), the revents field is
> > supposed to be 0 on return to poll(). This was the cause of some
> > heart-ache a while back in compat/poll/poll.c.
> 
> I am having a hard time grokking "supposed to be 0 on return to", but do
you
> mean "the caller must clear .revents field before calling poll()"?
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/poll.html
> has this
> 
>     In each pollfd structure, poll() shall clear the revents member,
>     except that where the application requested a report on a condition
>     by setting one of the bits of events listed above, poll() shall set
>     the corresponding bit in revents if the requested condition is
>     true. In addition, poll() shall set the POLLHUP, POLLERR, and
>     POLLNVAL flag in revents if the condition is true, even if the
>     application did not set the corresponding bit in events.
> 
> and I am also having a hard time interpreting the "except that".  If we
asked
> to report (e.g. we set POLLIN in the .events field), poll() does not have
to
> clear .revents but just set whatever bits it needs to set to report the
> condition in the field?
> 
> If that is the case, it makes it a bug not to clear .revents before
calling poll;
> the sample code snippet on the same page in EXAMPLES section does not,
> though, so I am puzzled.
> 
> In any case, no matter what POSIX says, if clearing .revents before
calling
> poll() helps on platforms in the real world, the patch is worth taking as
a fix, I
> would think.

That's what my intent was - my explanations are suffering from a little
work-induced sleep deprivation. Would you like this as a formal patch?

> 
> > I am not certain whether that copy of poll() is used in daemon, but I
> > wanted to point out that the value is being returned to poll, outside
> > of compat/poll/poll.c and may present a potential for poll returning
> > an error on that FD due to random values that might be in revents.
> >
> > Please see 61b2a1acaae for a related change/justification.
> >
> > diff --git a/daemon.c b/daemon.c
> > index 9d2e0d20ef..1e275fc8b3 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1194,6 +1194,7 @@ static int service_loop(struct socketlist
*socklist)
> >                                 }
> >                                 handle(incoming, &ss.sa, sslen);
> >                         }
> > +                       pfd[i].revents = 0;
> >                 }
> >         }
> >  }

Regards,
Randall

