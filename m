Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA8120A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdI1WrU (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:47:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750805AbdI1WrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:47:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24383ABC2C;
        Thu, 28 Sep 2017 18:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wPYR1XFXrFKZc6tNro3ILHSlgyg=; b=YZjaxZ
        gruBmgapQzQKEEw1IDeBtE5sHWi/UizZvZ7zMgMHXorlITtECOnOY3gAHb3w+Jbi
        DkI+6IgLVJeTzm7xwFXcuLn/tTNL2uhuxUW2segLrAk1WZrcCEKlS8aIJJ1dy8+b
        tDBLQBfhzKIaZ8Fm4f91p3/QtpSfHFwKvaOak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ak9/6uCsnSnzcVewpfUKkkGdnsSEXgCr
        V3povLKRKc4l8J9T2/bZmuTUtnqCGW7AxriFrXGEbuSVCQcq0V8y11ejtDVrarPE
        OsLJ7gcFi9LDrcF4ZioRO2WoVhT9rBJo/TsmOq4R8bMzZQwFXu79oDDsDnKJWj1k
        Z89+foZKJ2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BA0EABC2A;
        Thu, 28 Sep 2017 18:47:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8727BABC27;
        Thu, 28 Sep 2017 18:47:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Bug/Solution] Git hangs in compat/poll/poll.c on HPE NonStop
References: <009c01d3389c$f6c0cb00$e4426100$@nexbridge.com>
Date:   Fri, 29 Sep 2017 07:47:17 +0900
In-Reply-To: <009c01d3389c$f6c0cb00$e4426100$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 28 Sep 2017 17:01:27 -0400")
Message-ID: <xmqqo9puzbii.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB484A18-A49E-11E7-83B7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jch: a patch that hopefully is applicable is attached at the end;
 I'd appreciate input from Paolo, the contributor of the original
 upstream]

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> After a whole lot of investigating, we (it is a large "we") have discovered
> the reason for the hang we occasionally get in git-upload-pack on HPE
> NonStop servers - reported here well over a year ago. This resulted from a
> subtle check that the operating system does on file descriptors. When it
> sees random values in pfd[i].revents,...

What do you mean by "random values"?  Where do these random values
come from?  The original code the patch touches is _not_ setting
anything, so it is leaving it uninitialized and that is seen by the
system?  If that is the case perhaps should we clear it before we
call into this codepath?

> .... There is a non-destructive fix
> that I would like to propose for this that I have already tested.

I am not sure in what sense this is "non-destructive"; we left the
value as it was when we didn't notice anything happening in
compute_revents().  Now we explicitly destroy the value there was
(just like we do in the case where the corresponding file descriptor
was negative).  Maybe overwriting with 0 is the right thing, but I
wouldn't call it "non-destructive", though.  Puzzling...

> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -438,6 +438,10 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>             pfd[i].revents = happened;
>             rc++;
>           }
> +        else
> +          {
> +            pfd[i].revents = 0;
> +          }
>        }
>
>    return rc;

FYI, the upstream gnulib rewrites this part of the code with
d42461c3 ("poll: fixes for large fds", 2015-02-20) quite a bit, and
it reads like this:

+    {
+      pfd[i].revents = (pfd[i].fd < 0
+                        ? 0
+                        : compute_revents (pfd[i].fd, pfd[i].events,
+                                           &rfds, &wfds, &efds));
+      rc += pfd[i].revents != 0;
+    }

The code before your fix (and before d42461c3) used to assign to
pfd[i].revents only when compute_revents() gave us non-zero value,
but with d42461c3 in the upstream, it pfd[i].revents is assigned
the return value from compute_revents() even if the value returned
is 0.  And rc is incremented only when that value is non-zero.

The result of applying your patch is equivalent, so after all, I
tend to think that your patch is the right fix in the context of the
code we have (i.e. the older code we borrowed from them).

I wonder if we want to refresh the borrowed copy of poll.c to a
newer snapshot someday, but that is totally a separate topic.  At
least, I now know that your fix in this patch will not be broken due
to d42461c3 updating the code in a slightly different way ;-)

Randall, I forged your Sign-off in the patch below, but please say
it is OK, after reading Documentation/SubmittingPatches.

Thanks.

-- >8 --
From: Randall S. Becker <rsbecker@nexbridge.com>
Subject: poll.c: always set revents, even if to zero.

Match what happens to pfd[i].revents when compute_revents() returns
0 to the upstream gnulib's commit d42461c3 ("poll: fixes for large
fds", 2015-02-20).  The revents field is set to 0, without
incrementing the value rc to be returned from the function.

This fixes occasional hangs in git-upload-pack on NPE NonStop.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/poll/poll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index b10adc780f..ae03b74a6f 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -438,6 +438,10 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 	    pfd[i].revents = happened;
 	    rc++;
 	  }
+	else
+	  {
+	    pfd[i].revents = 0;
+	  }
       }
 
   return rc;
