From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/4] rev-parse: suppress duplicate log limit exceeded message.
Date: Tue, 24 Aug 2010 00:59:58 +1000
Message-ID: <AANLkTi=3=sumzcSFoCN6FUPQPzfQvfSim8KPRoXoT3tL@mail.gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
	<1282355022-17795-3-git-send-email-jon.seymour@gmail.com>
	<7vy6by2vlf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 17:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnYVi-0002aC-AI
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 17:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab0HWPAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 11:00:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59071 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab0HWO77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 10:59:59 -0400
Received: by qyk9 with SMTP id 9so2757543qyk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1q71bihQJfkecQd33LQXwUrYn5/I8ZWF+rCrWfsK0g=;
        b=de/zpuU+6pNAh2nzSz+uBQOVJfifeH916EiUu/xEmBdnE95YRmCs9Mt+mIHpFJ9SWg
         6q08Z8tY7bCkjjraIOoC2V3iRc53xG+D29h/qRCPa5p3r0+gGs6Os84POm5JVxc+ZxGK
         MPuaqmR1F4vAb4jjL0lbrcjRQd7ioIQQLni5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LL6VzjhJsxVmdJqRQD0kuZvOSk13W+JmQGWg3+W47tJZ1hCXjsJvIUJyDwMw2i+64g
         3rv+kmZGEngYYwak9HFqHrM37aG49TD6dSk01t+oxY4vwmoc4/KNWdUY0mxCUmIqV/0c
         XxEyXQL+0qpzn93RI3n6apDfYKcySaNWuwcj0=
Received: by 10.229.184.21 with SMTP id ci21mr3750896qcb.116.1282575599099;
 Mon, 23 Aug 2010 07:59:59 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Mon, 23 Aug 2010 07:59:58 -0700 (PDT)
In-Reply-To: <7vy6by2vlf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154227>

On Mon, Aug 23, 2010 at 7:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> With this change, git rev-parse master@{99999} reports:
>>
>> =C2=A0 master@{99999}
>> =C2=A0 error: Log for 'master' only has 166 entries.
>> =C2=A0 fatal: ambiguous argument 'master@{99999}': unknown revision =
or path not in the working tree.
>> =C2=A0 Use '--' to separate paths from revisions
>
> If we are going to say "fatal:" and die at the end, I think we probab=
ly do
> not want to say a separate "error" message. =C2=A0Instead of adding a=
 boolean
> parameter "fail silently or warn?", it may be better to make it a poi=
nter
> to a strbuf and have it filled with error details (or a machine reada=
ble
> struct and make it responsibility of the caller to generate a message=
).
>

I agree that it is not ideal that we have an error message and a fatal
message in this case.

Ideally,  I think we should simply be reporting the log limit exceeded
condition as a fatal condition on its own, and not reporting the
ambiguous ref catch all at all in this case. We have already decided
that the argument is a reference at this point and as such it is not
really ambiguous, it just happens to be out of bounds.

> Then die_verify_filename can become, e.g.:
>
> static void NORETURN die_verify_filename(const char *prefix, const ch=
ar *arg)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned mode;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf e;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* learn in what way is it bad? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_sha1_with_mode_1(arg, sha1, &mode, &e,=
 prefix);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ... or fall back the most general messa=
ge. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0die("ambiguous argument '%s': unknown revi=
sion or path not in the working tree.\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"%s"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Use '--' to separate paths =
from revisions", arg, e.buf);
> }
>
> and we can later reuse the same mechanism to cover other kind of erro=
rs,
> not just "the log does not have that many entries" error. =C2=A0With =
your
> "gently" approach it may not be easy to do that without adding more
> parameters to all the functions in the codepath, no?
>

I agree that the gently approach used here doesn't generalise to other
cases. It seemed like the smallest change I could make that was
reasonably consistent with existing code. I am happy to look at a more
general solution.

> I also wonder if this can simply become part of "struct object_contex=
t",
> which is to pass extra information in addition to the SHA-1 (which th=
e
> original API returned) back to the caller.
>

I'll have a look at this. object_context seems like a reasonably
coherent structure at the moment - do we risk diluting that coherence
by attaching error reporting state to it?

Should we consider passing an error callback function (+ struct)
around so that the calling context can decide whether to directly
report errors at the point of detection or defer them until later?
Calling contexts that don't care about reporting immediately can do
so, calling contexts that do care can choose how to record errors into
the struct, as required.

jon.
