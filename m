From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between
 shorthand names and full refnames
Date: Mon, 13 May 2013 08:31:23 +0200
Message-ID: <CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:31:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmIH-0001iU-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3EMGb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:31:29 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:64111 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3EMGb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:31:29 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbmIB-0005TK-B9
	for git@vger.kernel.org; Mon, 13 May 2013 08:31:27 +0200
Received: from mail-oa0-f41.google.com ([209.85.219.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbkFL-000EsE-KO
	for git@vger.kernel.org; Mon, 13 May 2013 06:20:23 +0200
Received: by mail-oa0-f41.google.com with SMTP id n9so2834691oag.0
        for <git@vger.kernel.org>; Sun, 12 May 2013 23:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mNe7Ah1IB6PrP7Iph2Hk0tWIJj3xd9AjD1DY7gvbynM=;
        b=CLFq6blTf4+uyx3zeZWqIM1ZPnZNNn0SdbwWcS3ErX26/vxckgfs6vHRvZT4kEPx34
         DQ6XXJoa7LulTvpy5U4HSjbbgpA7VTTkSNwVuT3EWSH674lCZcqrJLYGhTL8H1LHhXSm
         fdRSZ8fqITaQ+7fGcbzLIQ7jj0WjG0uxNAECGdEv44hUZzVcpFjgdtojrkPPI8XrOwKU
         Yt0whPf0wlcpcqf8Z/AGrgRsWL9Y5Hiv0HgQJsXGtJOJkrkx4t0BSmC9GN2a1icodH5h
         SaIMZC0UGCDV9KEE5t7AuwI0t8F9KKnuWx8pBHiuzXvAyzAMB2YZiTWRRz/Hkcx4ou+Q
         CqTg==
X-Received: by 10.60.55.231 with SMTP id v7mr11994451oep.135.1368426683384;
 Sun, 12 May 2013 23:31:23 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Sun, 12 May 2013 23:31:23 -0700 (PDT)
In-Reply-To: <7vmwrzsck1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224093>

On Mon, May 13, 2013 at 6:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> The refname_expand() function no longer uses mkpath()/mksnpath() to
>> perform the pattern expansion. Instead, it uses strbuf_expand(), which
>> removes the need for using fixed-length buffers from the code.
>
> It is a brilliant idea to use strbuf_expand() for this. I like it.
>
> I notice that you later introduce %1 (that is 'one', not 'el'), but
> unless you are planning to introduce %2 and %3 that semantically
> fall into a similar category as %1, I would rather see a different
> letter used that is mnemonic to what the placeholder _means_.
>
> The choice of the letter is arbitrary and may not look like it
> matters that much, because it is not exposed to the end user.  But
> by switching from the sprintf() semantics that shows things given to
> it in the order they were given, without knowing what they mean, and
> introducing a strbuf_expand() machinery tailored for refnames (and
> refnames only), the new code assigns meanings to each part of the
> refname, and we can afford to be more descriptive.
>
> The choice of '%*' is justifiable, "it is the closest to the '*' we
> traditionally used to replace only one thing", but '%1' does not
> look the best placeholder to use, at least to me.

Obviously, I named it '%1' since it expands into the _first_ component
of the (slash-separated) shorthand. There is no further parsing or
verification that it actually corresponds to a remote (and as far as I
currently understand, we do not want to do such verification), so I
thought it better not to make such assumptions in the placeholder
name. That said, I could go with '%r' for "remote", although we have
plenty of other concepts in Git that use 'r' as the initial letter. I
could maybe use '%remote' instead?

Also, about the '%*': When used alone, it means "the entire
shorthand", but when preceded with a '%1' it subtly changes meaning
into 'the remainder of the shorthand after extracting the first
component'. I believe the two interpretations are compatible and
unambiguous, but if we want to be very explicit about what's
happening, we could use something like '%all' and '%the_rest' for the
two cases, respectively?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
