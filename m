From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFH 0/3] stable priority-queue
Date: Mon, 14 Jul 2014 17:12:07 +0700
Message-ID: <CACsJy8DCbY7hOknGVM7zd6uJBq70+MG9N+Mj-+VXvrSan5njcA@mail.gmail.com>
References: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 14 12:13:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6dFp-0001zE-FL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 12:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbaGNKMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 06:12:46 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53187 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaGNKMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 06:12:38 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so3032562qaq.39
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YfXm0vjZoz1eSOLNdWxgUh5T8fkDGBqXYmNcy0NQmCo=;
        b=O9els6cgueHKhPwj4Q8BYPtAnG/r9nhOhTR5iw7WVOY/Mql0CtKqgKDkAy6Nqqe4Fh
         3qUhYPdiy7w/LzZ9fytUIVzmuAiZaRSXQ7D63cOmLoEpf7TwDYFQZqWRc+wYq5bgGk6A
         kXeki/+MYqRYbQcqZM4QCG1ims5fz9SwW3zPMV265enR6z0QokMdKwinTrLe3Qt3LV1N
         NUdz1GfRDvdCFcGOxPKdKH5UksAak6TCwgBZS8H/p2ns+do7J9fzw3U3vRAHRIz+2Agm
         zxtSN2zijB8ELaJfJnSsu55OQEM3yMQejMHM+O0z8UL2N+kUgDXVabTDAFjWrRhwQaxC
         ZyOw==
X-Received: by 10.140.91.164 with SMTP id z33mr21678995qgd.65.1405332757802;
 Mon, 14 Jul 2014 03:12:37 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 14 Jul 2014 03:12:07 -0700 (PDT)
In-Reply-To: <20140714054021.GA4422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253484>

On Mon, Jul 14, 2014 at 12:40 PM, Jeff King <peff@peff.net> wrote:
> As Junio and I discussed earlier in [1], this series makes the
> prio_queue struct stable with respect to object insertion (which in turn
> means we can use it to replace commit_list in more places).
>
> I think everything here is correct, but the second commit fails the
> final test in t5539. I think the test is just flaky (hence the RFH and
> cc to Duy).
>
> That test creates some unrelated commits in two separate repositories,
> and then fetches from one to the other. Since the commit creation
> happens in a subshell, the first commit in each ends up with the same
> test_tick value. When fetch-pack looks at the two root commits
> "unrelated1" and "new-too", the exact sequence of ACKs is different
> depending on which one it pulls out of the queue first.
>
> With the current code, it happens to be "unrelated1" (though this is not
> at all guaranteed by the prio_queue data structure, it is deterministic
> for this particular sequence of input). We see the ready-ACK, and the
> test succeeds.
>
> With the stable queue, we reliably get "new-too" out (since it is our
> local tip, it is added to the queue before we even talk to the remote).
> We never see a ready-ACK, and the test fails due to the grep on the
> TRACE_PACKET output at the end (the fetch itself succeeds as expected).
>
> I'm really not quite clear on what's supposed to be going on in the
> test. I can make it pass with:
>
> diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
> index 94553e1..b461188 100755
> --- a/t/t5539-fetch-http-shallow.sh
> +++ b/t/t5539-fetch-http-shallow.sh
> @@ -54,6 +54,7 @@ EOF
>  test_expect_success 'no shallow lines after receiving ACK ready' '
>         (
>                 cd shallow &&
> +               test_tick &&
>                 for i in $(test_seq 15)
>                 do
>                         git checkout --orphan unrelated$i &&
>
> which just bumps the timestamp for the unrelated* commits (so that they
> are always more recent than "new-too" and get picked first). I'm not
> sure if that is too hacky, or if there's a more robust way to set up the
> test.

The test needs the right amount of "have"s with pkt-flush inserted at
the right place. If test_tick makes it happy, I think we could go with
it for now. I'll try to study this code more and see if I can come up
with a better test. It'll be low priority in my backlog though.
-- 
Duy
