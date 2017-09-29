Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8422047F
	for <e@80x24.org>; Fri, 29 Sep 2017 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdI2Ila (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 04:41:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdI2Il1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 04:41:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED3DF13A9D;
        Fri, 29 Sep 2017 08:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com ED3DF13A9D
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.26] (ovpn-117-26.ams2.redhat.com [10.36.117.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9021C1F8;
        Fri, 29 Sep 2017 08:41:25 +0000 (UTC)
Subject: Re: [Bug/Solution] Git hangs in compat/poll/poll.c on HPE NonStop
To:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
References: <009c01d3389c$f6c0cb00$e4426100$@nexbridge.com>
 <xmqqo9puzbii.fsf@gitster.mtv.corp.google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d934af29-9cee-ea74-40c8-e63f7592f8aa@redhat.com>
Date:   Fri, 29 Sep 2017 10:41:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9puzbii.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 29 Sep 2017 08:41:27 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/09/2017 00:47, Junio C Hamano wrote:
> [jch: a patch that hopefully is applicable is attached at the end;
>  I'd appreciate input from Paolo, the contributor of the original
>  upstream]

I wasn't involved in upstream commit d42461c3, but Linux is also always
overwriting the revents output with zero.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
>> After a whole lot of investigating, we (it is a large "we") have discovered
>> the reason for the hang we occasionally get in git-upload-pack on HPE
>> NonStop servers - reported here well over a year ago. This resulted from a
>> subtle check that the operating system does on file descriptors. When it
>> sees random values in pfd[i].revents,...
> 
> What do you mean by "random values"?  Where do these random values
> come from?  The original code the patch touches is _not_ setting
> anything, so it is leaving it uninitialized and that is seen by the
> system?  If that is the case perhaps should we clear it before we
> call into this codepath?
> 
>> .... There is a non-destructive fix
>> that I would like to propose for this that I have already tested.
> 
> I am not sure in what sense this is "non-destructive"; we left the
> value as it was when we didn't notice anything happening in
> compute_revents().  Now we explicitly destroy the value there was
> (just like we do in the case where the corresponding file descriptor
> was negative).  Maybe overwriting with 0 is the right thing, but I
> wouldn't call it "non-destructive", though.  Puzzling...
> 
>> --- a/compat/poll/poll.c
>> +++ b/compat/poll/poll.c
>> @@ -438,6 +438,10 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>>             pfd[i].revents = happened;
>>             rc++;
>>           }
>> +        else
>> +          {
>> +            pfd[i].revents = 0;
>> +          }
>>        }
>>
>>    return rc;
> 
> FYI, the upstream gnulib rewrites this part of the code with
> d42461c3 ("poll: fixes for large fds", 2015-02-20) quite a bit, and
> it reads like this:
> 
> +    {
> +      pfd[i].revents = (pfd[i].fd < 0
> +                        ? 0
> +                        : compute_revents (pfd[i].fd, pfd[i].events,
> +                                           &rfds, &wfds, &efds));
> +      rc += pfd[i].revents != 0;
> +    }
> 
> The code before your fix (and before d42461c3) used to assign to
> pfd[i].revents only when compute_revents() gave us non-zero value,
> but with d42461c3 in the upstream, it pfd[i].revents is assigned
> the return value from compute_revents() even if the value returned
> is 0.  And rc is incremented only when that value is non-zero.
> 
> The result of applying your patch is equivalent, so after all, I
> tend to think that your patch is the right fix in the context of the
> code we have (i.e. the older code we borrowed from them).
> 
> I wonder if we want to refresh the borrowed copy of poll.c to a
> newer snapshot someday, but that is totally a separate topic.  At
> least, I now know that your fix in this patch will not be broken due
> to d42461c3 updating the code in a slightly different way ;-)
> 
> Randall, I forged your Sign-off in the patch below, but please say
> it is OK, after reading Documentation/SubmittingPatches.
> 
> Thanks.
> 
> -- >8 --
> From: Randall S. Becker <rsbecker@nexbridge.com>
> Subject: poll.c: always set revents, even if to zero.
> 
> Match what happens to pfd[i].revents when compute_revents() returns
> 0 to the upstream gnulib's commit d42461c3 ("poll: fixes for large
> fds", 2015-02-20).  The revents field is set to 0, without
> incrementing the value rc to be returned from the function.
> 
> This fixes occasional hangs in git-upload-pack on NPE NonStop.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/poll/poll.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index b10adc780f..ae03b74a6f 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -438,6 +438,10 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>  	    pfd[i].revents = happened;
>  	    rc++;
>  	  }
> +	else
> +	  {
> +	    pfd[i].revents = 0;
> +	  }
>        }
>  
>    return rc;
> 

