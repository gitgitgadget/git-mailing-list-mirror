From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 10:48:16 +0200
Message-ID: <CALKQrgfCR10nfP9tVuHyhCPOfe3XVvBzzQayhM7b9Ra5ZDGnMw@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-4-git-send-email-gitster@pobox.com>
	<CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
	<CALkWK0mAyDb3AjH0s3j2gRRDckx=a2nr9MR+O6gEtwX2MSJrtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur2Rm-0005va-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab3FXIsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:48:23 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:61665 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab3FXIsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:48:22 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur2Rg-000MoQ-N5
	for git@vger.kernel.org; Mon, 24 Jun 2013 10:48:20 +0200
Received: from mail-oa0-f45.google.com ([209.85.219.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur1L3-000C01-OE
	for git@vger.kernel.org; Mon, 24 Jun 2013 09:37:26 +0200
Received: by mail-oa0-f45.google.com with SMTP id j1so11809635oag.32
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 01:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m5tLGw5MKHbWvgFjzIWhchoo5OeE80P9FopO/e+MzmA=;
        b=GP/mhiNCWODDBQIKGnvLUag1z4z4SjftXAJAznnY4DL0IiSu+w0Ouck9LVTa3Zqhz5
         B1LCaSqBNXgxjbMOKn/szhACFLE1N0DjwjuoHg/cF6DaaJL1EdY3b1X462BD1lR4dXyF
         U7yAcyC+kLhEs91r8SUUfg4Csasx/ec5o7GmEW4WTabLFl7w2vCJ4Y1zPPczvdTGlf1v
         dRwZBswhh4LlnudS6PA8kO/rw67IZgiuL9B7B1B5Nf25KLztqGUQnpQbX0D3cTb3UGFy
         D5YpyZSV0q/sG3oxbstI1uv2Y0ezYNy8QzKcCTZteRULPH65O+7/vk187apWySNzo1JM
         5xVg==
X-Received: by 10.60.143.41 with SMTP id sb9mr10295245oeb.102.1372063696638;
 Mon, 24 Jun 2013 01:48:16 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Mon, 24 Jun 2013 01:48:16 -0700 (PDT)
In-Reply-To: <CALkWK0mAyDb3AjH0s3j2gRRDckx=a2nr9MR+O6gEtwX2MSJrtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228797>

On Mon, Jun 24, 2013 at 9:46 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Johan Herland wrote:
>>> +static void setup_push_current(struct remote *remote, struct branch *branch)
>>> +{
>>> +       if (!branch)
>>> +               die(_(message_detached_head_die), remote->name);
>>> +       add_refspec(branch->name);
>>
>> Here (and above) we add a refspec to tell Git exactly what to push
>> from the local end, and into what on the remote end.
>
> Nope, we add the refspec "foo", without the :destination part.  The
> remote end is unspecified (and defaults to "foo", but that is in the
> transport layer).

Ok, so "foo" is not always semantically equivalent to "foo:foo", and
when adding "foo:bar" it is always considered more specific than (and
superior to) "foo". I think that makes sense.

>> Is it possible to
>> end up with multiple simultaneous refspecs matching the same local
>> ref, but mapping to different remote refs? If so, which will win, and
>> does that make sense?
>
> It is impossible.  We either:
>
> - Get an explicit refspec from the user and never run
> setup_default_push_refspecs() to begin with.
>
> - Run setup_push_refspecs() and add *one* refspec depending on the
> push.default value.

Thanks, that's what I wanted to hear. But then, does it make sense to
say that we will only ever have exactly _one_ push refspec in the
current context, and we should therefore replace the "static const
char **refspec;" string array with a single "static const char
*refspec;" string? That would make it obvious that there is no room
for ambiguity with overlapping refspecs.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
