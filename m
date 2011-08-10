From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in .git/sequencer
Date: Wed, 10 Aug 2011 21:04:02 +0530
Message-ID: <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com> <20110810152126.GE31315@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 17:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrAnc-0000X6-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 17:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab1HJPeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Aug 2011 11:34:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55214 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1HJPeX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2011 11:34:23 -0400
Received: by wyg24 with SMTP id 24so800824wyg.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OEYgyAVG52MQRiNPaPtwHnJ0go9dKdiKIBqlWvZB7uI=;
        b=B5+WIqYmnL4mLNamwGllax6s6+EwG6JRBtzQYAiNwUsfHt9QTwRdmK1b9CfbUwL1hQ
         u2QyJhXIDiUNk5xCnllKVWI/sUCq0E1o4jXHgzR+wVufiE0VH/Qpv0kjaVUoqv42R1VD
         EHZ9XZ9ESM0SRs8g5W3P9nQkx+B/+g28fz8uY=
Received: by 10.216.0.66 with SMTP id 44mr6759862wea.63.1312990462123; Wed, 10
 Aug 2011 08:34:22 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Wed, 10 Aug 2011 08:34:02 -0700 (PDT)
In-Reply-To: <20110810152126.GE31315@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179070>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> +struct replay_insn_list **replay_insn_list_append(enum replay_actio=
n action,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct commit *operand,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct replay_insn_list **next);
>> +void sequencer_read_todo(struct replay_insn_list **todo_list);
>> +void sequencer_read_opts(struct replay_opts **opts_ptr);
>> +int sequencer_create_dir(void);
>> +void sequencer_save_head(const char *head);
>> +void sequencer_save_todo(struct replay_insn_list *todo_list);
>> +void sequencer_save_opts(struct replay_opts *opts);
>
> This looks wrong. =C2=A0What is the expected calling sequence? =C2=A0=
Would it
> be possible to expose fewer functions by moving more to sequencer.c?

Thanks for the early review.  Yes, I agree with you: No caller can
make sense of this API; I want something like sequencer_start,
sequencer_handle_conflict, and sequencer_end, but I'm not sure where
to start.  I would have liked to just move these functions without
exposing them, but that would break cherry-pick/ revert.  So, we're
really faced with two choices:
1. Make this patch enormous by moving as well as refactoring
everything into a beautiful public API.  I suspect this won't be easy
to review at all.
2. Keep this patch as it is, and introduce a future patch to clean up
the API.  This is the approach I was going for.

I can't move these functions bit-by-bit either: a hypothetical
sequencer_start will require *everything*.  Could you suggest
something?

-- Ram
