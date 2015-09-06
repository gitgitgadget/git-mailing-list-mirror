From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Sun, 06 Sep 2015 10:24:12 -0700
Message-ID: <xmqqd1xvbgw3.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
	<CACRoPnTUzeF=RUVv_0+2Ej422Vh-NH+KpYaKH0VKNmGbuVQ_8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 19:24:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYdfv-0001GZ-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 19:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbIFRYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 13:24:16 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36665 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbbIFRYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 13:24:15 -0400
Received: by padbj2 with SMTP id bj2so335930pad.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UrGiyeYzhIBnKtsFocq+sAW1syKsZcCSdoVWQaJn+W0=;
        b=AujXwQ4yqSkOOE3a3/F067f/3c0n8LnH1s/AojyEJC1llvm5ZU8SntIxH3GmV9H126
         Jc+cezN5d+H+FouXV3yWhLSxL7x5RGUBqh1D4E9Qr078Cy6O/qqne5RKW0/7noxFMCwP
         D7WnnG+QGaBvfvGxBLn5TVsTOMN/ewJCMJamLn/0vLfcufF6+Meb4KO/f0drTI2hc2Km
         gL4sIDQtVRqnv/AdYybbUz0QJOMk2J2IjqzfMg1413+gGP3YlpmWSjUBhbTIeazUWDGD
         kw6zUKOGe2UDpo7zL+r19HwZEWwLAYi6xtqdawPZ3UN8CvCI7p9YyDx9rjSR17ruKjcf
         y6Uw==
X-Received: by 10.68.224.162 with SMTP id rd2mr35603810pbc.33.1441560254696;
        Sun, 06 Sep 2015 10:24:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id o7sm9155625pdr.25.2015.09.06.10.24.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sun, 06 Sep 2015 10:24:14 -0700 (PDT)
In-Reply-To: <CACRoPnTUzeF=RUVv_0+2Ej422Vh-NH+KpYaKH0VKNmGbuVQ_8g@mail.gmail.com>
	(Paul Tan's message of "Sun, 6 Sep 2015 17:04:13 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277431>

Paul Tan <pyokagan@gmail.com> writes:

> s/reimplementated/reimplemented/ ?
> s/resulting an/resulting in an/ ?
> s/extra blank/extra blank line/ ?

Thanks.

>> +static void am_signoff(struct strbuf *sb)
>> +{
>
> Hmm, okay, but now we have two similarly named functions am_signoff()
> and am_append_signoff() which both do nearly similar things, the only
> difference being am_signoff() operates on a strbuf while
> am_append_signoff() operates on the "msg" char* field in the am_state,
> which seems a bit iffy to me.

I do recall advising you not to overuse strbuf in am_state, and
specifically not to use strbuf for a field like author_name, and the
criteria to tell why a field should not be a strbuf in am_state is
if the code used its strbuf-ness only because it is initially read
with strbuf_read_file(), but afterwards it is necessary to use the
field as a strbuf because the field is not modified later and is not
passed to a helper function that takes a strbuf.

I think the final code ended up following that piece of advice a bit
too aggressively.  The <msg, msg_len> pair in am_state did need to
be modified with sign-off, and it was done by passing it as a strbuf
to append_signoff() in the code we are fixing here; keeping msg
field that you wrote as a strbuf in the original would have made
am_append_signoff() unnecessary.

But this patch you are commenting on is purely for regression fix,
and I didn't want to change other things like data representation at
the same time.

>> +       /* Does it end with our own sign-off? */
>> +       strbuf_addf(&mine, "\n%s%s\n",
>> +                   sign_off_header,
>> +                   fmt_name(getenv("GIT_COMMITTER_NAME"),
>> +                            getenv("GIT_COMMITTER_EMAIL")));
>
> Maybe use git_committer_info() here?

Perhaps, but I wanted to make sure I am doing the same thing as the
codepath of sequencer.c::append_signoff(), which the original ended
up calling.  git_committer_info() does way more than that, no?

>> +       if (mine.len < sb->len &&
>> +           !strcmp(mine.buf, sb->buf + sb->len - mine.len))
>
> Perhaps use ends_with()?

This caller already _knows_ how long the sb->buf string is; it is
pointless to have ends_with() run strlen() on it.
