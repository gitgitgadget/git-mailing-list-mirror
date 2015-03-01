From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 1 Mar 2015 18:32:08 +0700
Message-ID: <CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com> <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 12:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS276-0001JF-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 12:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbbCALcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 06:32:42 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33440 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbCALcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 06:32:39 -0500
Received: by igbhl2 with SMTP id hl2so10021401igb.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 03:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Aih0PHEXUVBBCdFrFjYKpQP7XV3JRjk1MliKI4pP1E=;
        b=iNIaGd4kIBsHzHE243caPauRMQGAznV4if/Chkca34DRCSmyl+1y9B6OqCjkrT0Jd+
         UFBKHo/ui2Z9RIVOdvigT/2fWQQfVf+ZNacvXQE+EVqOYq2J1SgM8ABTXUzc9wpsa8HA
         xLeUCm3VIAnDYlnCEShTPYDkCFThLABDiCrebPvX/I1TvR9QMlc6VehkHSsGhUKDp0Fx
         u9HH8DcrkysJ/6HJdA9tV8tsCpvH6t6T26i781utt+GJ9TLcnjl1Cc0PPnAkQf2WFz2g
         N4YOC6rJBuCdSB8F3ZiYEN3uY3ATtIH3mLnU1c00x/g00Z4BIB0IgYVzaDakn8NQOglb
         CDEQ==
X-Received: by 10.50.147.99 with SMTP id tj3mr15608971igb.41.1425209558882;
 Sun, 01 Mar 2015 03:32:38 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Sun, 1 Mar 2015 03:32:08 -0800 (PST)
In-Reply-To: <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264556>

On Sun, Mar 1, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  - Because the protocol exchange starts by the server side
>>    advertising all its refs, even when the fetcher is interested in
>>    a single ref, the initial overhead is nontrivial, especially when
>>    you are doing a small incremental update.  The worst case is an
>>    auto-builder that polls every five minutes, even when there is no
>>    new commits to be fetched [*3*].

Maybe you can elaborate about how to handle states X, Y... in your
footnote 3. I just don't see how it's actually implemented. Or is it
optional feature that will be provided (via hooks, maybe) by admin? Do
we need to worry about load balancers? Is it meant to address the
excessive state transfer due to stateless nature of smart-http?

>> I'd like to see a new protocol that lets us overcome the above
>> limitations (did I miss others? I am sure people can help here)
>> sometime this year.
>
> Unfortunately, nobody seems to want to help us by responding to "did
> I miss others?" RFH, here are a few more from me.

Heh.. I did think about it, but I didn't see anything worth mentioning..

>  - The semantics of the side-bands are unclear.
>
>    - Is band #2 meant only for progress output (I think the current
>      protocol handlers assume that and unconditionally squelch it
>      under --quiet)?  Do we rather want a dedicated "progress" and
>      "error message" sidebands instead?
>
>    - Is band #2 meant for human consumption, or do we expect the
>      other end to interpret and act on it?  If the former, would it
>      make sense to send locale information from the client side and
>      ask the server side to produce its output with _("message")?

No producing _(...) is a bad idea. First the client has to verify
placeholders and stuff, we can't just feed data from server straight
to printf(). Producing _() could complicate server code a lot. And I
don't like the idea of using client .po files to translate server
strings. There could be custom strings added by admin, which are not
available in client .po. String translation should happen at server
side.

If we want error messages to be handled by machine as well, just add a
result code at the beginning, like ftp, http, ... do. Hmm.. this could
be the reason to separate progress and error messages.
-- 
Duy
