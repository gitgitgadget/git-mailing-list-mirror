From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Sun, 12 Jul 2015 20:29:29 +0800
Message-ID: <CACRoPnQyPpK3g0G3N-Yf2Zatk5RCEUe_1mbW9LGq8-=zypYcNg@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
	<xmqqa8v7yts9.fsf@gitster.dls.corp.google.com>
	<20150708081902.GA8606@yoshi.chippynet.com>
	<xmqqio9tx42z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:29:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEGO1-00062Z-IH
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 14:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbbGLM3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 08:29:32 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35760 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbGLM3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 08:29:31 -0400
Received: by lblf12 with SMTP id f12so42243756lbl.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=12xree0Mwrz0an2roXgP1NmflV0qOvBqUpAONgsT9Ck=;
        b=iNi/i2aF5xs2PbEYiFXHwDyiE7oTSjVODQp5Rd3QCeYAjAMXEh0zmGV8zNkwjE7Ous
         /uthBkEcFGiHrlFwwDpQk/KJ5139B0/RecHpGUqzcjg9OoVwRvLjvGPz2xrHHJwUGEpj
         +FJ+LTesfwaVDB5KqptgaRvVm+AgcS+ah8RIHVCRbIGuCvn4sPQJiojyMlqz78ttlvVw
         Kt3JWfZYIJ9Do+aNEYHk5xxMzWLS6hvulcts+sf1J2wEewI0+EG+cus7qaM4kZkeGyZl
         JlDVpU8pV3IXZidnUW8ahQBZdsITxszrSMK7/MhIEP71Gn/KwV6dbm6xYlDxmC9c8uJq
         ELgw==
X-Received: by 10.152.4.163 with SMTP id l3mr28303365lal.35.1436704169705;
 Sun, 12 Jul 2015 05:29:29 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sun, 12 Jul 2015 05:29:29 -0700 (PDT)
In-Reply-To: <xmqqio9tx42z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273892>

Hi,

(Sorry for the late reply. Caught a nasty stomach bug that kept me in
bed for a while ><)

On Thu, Jul 9, 2015 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What I pushed out tonight should have SQUASH??? (or fixup!) that
> splits this into appropriate steps in your series.  Please check.

Yeah they look good.

> Note that you do not have to say "if the variable h2as something,
> then free it".  free(NULL) is perfectly fine and we can read
>
>         free(var);
>         var = compute_new_value();
>
> just fine.

OK. There are other places where I used "if (x) free(x)" though (such
as in am_state_release()), so I will fix them in a re-roll as well.

> However, I am reluctant to blindly replace assert(!state->field)
> with free(state->field).  Are there cases where we _must_ call a
> function that sets these fields at most once?

I wouldn't say we are "blindly" replacing them. The purpose of the
assert(!state->field) is to ensure that we are not overwriting any
commit metadata already stored in the state directory. And in almost
all cases, this holds true. However, as you have just shown, running
"git am" again while there is a session in progress will override the
commit metadata stored in the state directory, so I believe the
replacement with free() is reasonable.

> On the other hand, assert() like this is more or less useless.
>
>         assert(state->field);
>         ...
>         printf("%s", state->field); /* or other uses */
>
> "The caller must have filled the field" can be seen by unconditional
> use of "state->field" without such an assert().

OK. Will remove them as well.

Thanks,
Paul
