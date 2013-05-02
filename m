From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Fri, 3 May 2013 01:05:17 +0530
Message-ID: <CALkWK0=1qxWWRT9ic_4uVg_ZF_5T0_ogpWwTHotqxWqsi9GOnA@mail.gmail.com>
References: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0k4YisL0Nc6906FRsx7556UVqy_DD9Wo=1j4OWMkwqK-A@mail.gmail.com> <CAMP44s3UTwgcxQ0Y89UtjBAw46ps_2EOGqZ=OG499G_uYL0DCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:36:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzIR-0000mp-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690Ab3EBTf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:35:59 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:59906 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab3EBTf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:35:58 -0400
Received: by mail-ia0-f176.google.com with SMTP id l27so761328iae.21
        for <git@vger.kernel.org>; Thu, 02 May 2013 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=S4DEn+wHKRA+Io0CXD/oqV8Gk40t5p75mko5ZVK+/7c=;
        b=ieb20JEtPB26cr6nSWMBdiMdj8p8cDAToloRJMBzkd0QVhtG+r9GgsXKaTtCku/Mgf
         +PQ9/NglCceZQ4ojV9NCxdtINPSjnlxZLn+bcF17mP0AQpMaIjk+gsi+59seXuCtVtIO
         UTs1/I3CiNxnflAeoGERvqbSktlqUCaAw/0S4Jr9Ddci+CGuvfMkZNJM0T1wSmZlZH5r
         hgWBuEEpbJ8phPHh05+xwZe1gsrKUi0o+lsuqOqkj1v1BknSzyisEVfBoSPNamWad9DM
         6C9h4KWDGe80mgknbhaa9e6MhuOSAXD8wpm0n5WgSS1HXzcViMdYB70QKnvWvZ4hq0R9
         89bg==
X-Received: by 10.50.3.38 with SMTP id 6mr4454779igz.44.1367523357929; Thu, 02
 May 2013 12:35:57 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 12:35:17 -0700 (PDT)
In-Reply-To: <CAMP44s3UTwgcxQ0Y89UtjBAw46ps_2EOGqZ=OG499G_uYL0DCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223251>

Felipe Contreras wrote:
>> Looking at this closely once again.
>> You've already hit the beginning.  What are you continuing?  Take the
>> example of a compound expression with @{-
>
> Yeah, we could break, but I would prefer the break to happen naturally
> when in the for loop check.

This is followed by a condition on upstream_mark: just change that
from if/else if/ and there's a break; at the end anyway.

The continue is misleading and should be removed.

>> On another note, I think you've fixed a bug: @{-1}{0} was parsing to
>> the same value as @{-1}@{0} before your patch.
>
> Yeap.

Write a note about it in the commit message atleast?  I found it to be
a very non-trivial conclusion.

>>> +               if (interpret_nth_prior_checkout(str, &buf) > 0) {
>>> +                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
>>> +                       strbuf_release(&buf);
>>> +                       if (detached)
>>> +                               return 0;
>>
>> Neat.  I'd set reflog_len to zero and made sure that the last part of
>> the function wouldn't be executed.  How did you get away without
>> setting refs_found to 1 though?
>
> The rest of the code is not executed, there's no need if @{-N}
> evaluates to a SHA-1. There's no ref to dwim, and there's no reflog
> anyway. We just fetch the SHA-1 and return.

Obviously the return 0 breaks out of the function.  I meant what
happens if it's not detached.  I'll answer it myself: you have a
string that's either not 40-characters, or doesn't resolve to a valid
object.  You haven't found anything yet.  Now, you'll be going down
the reflog_len codepath and calling dwim_log() to set the refs_found.
