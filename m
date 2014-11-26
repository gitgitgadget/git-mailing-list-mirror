From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] change contract between system_path and it's callers
Date: Wed, 26 Nov 2014 09:53:27 -0800
Message-ID: <xmqqy4qxrgq0.fsf@gitster.dls.corp.google.com>
References: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com>
	<1416939854-29930-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqfvd7rnkb.fsf@gitster.dls.corp.google.com>
	<CANCZXo63q2YmTcYr9Vf99fAAnENNj7vE1nC18QJDYve=-OcXyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 18:53:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtgml-0007VD-3N
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 18:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbaKZRxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 12:53:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752876AbaKZRxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 12:53:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F678206B9;
	Wed, 26 Nov 2014 12:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E7xTXHwdkmr+1M63GgqSrXyNm+c=; b=vs9ahj
	xsfGKFiNtgns3DNo07ZCPH9H7wVaxGcfUCiLFU5wU2UOhH7hMeP9WSdhvOAbmw33
	v8on03QUtXYZRWEDvNH92Klg5wdUHjFf1xV4L7Xfb4spRAUQxFkrwKWsk3GZnfj+
	redwlgxbGzIlpQUUU55ZvDfqTqchsZKcG78Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gnOnA//B4OY8w0Hmh0aXhpV++9CRHzjF
	8c1L4ajPormR+V1Dfbq6KhWEneoU4zpnTjV7tbIFbHYCBbsJUqe7R83JGKB6+XDW
	zJV6PZvodrYvvLOHtCnfMCC6balZartMQsi07kXUoV0XsoUa8gTVkGYzz9A+s/br
	u1SeI1NqBwA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34CB2206B8;
	Wed, 26 Nov 2014 12:53:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2551206B7;
	Wed, 26 Nov 2014 12:53:29 -0500 (EST)
In-Reply-To: <CANCZXo63q2YmTcYr9Vf99fAAnENNj7vE1nC18QJDYve=-OcXyQ@mail.gmail.com>
	(Alexander Kuleshov's message of "Wed, 26 Nov 2014 09:53:34 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 214598C4-7595-11E4-A630-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260285>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

>> > +     setenv("INFOPATH", git_info_path, 1);
>> > +     free(git_info_path);
>> >       execlp("info", "info", "gitman", page, (char *)NULL);
>> >       die(_("no info viewer handled the request"));
>>
>> We are just about to exec; does this warrant the code churn?
>
> hmm... Can't understand what's the problem here?

Adding a new variable to keep the allocated piece of memory so that
you can free after using it, and freeing it.  These are not "problem"
per-se.

But immediately after doing so, execlp() wipes your process and
starts a different program afresh.  When that happens, all the heap
memory you allocated and were using is automatically reclaimed by
the system anyway.

So it may not be "wrong" to free, but doing anything extra is an
unnecessary work.

If you did an "assign to a variable to keep allocated memory, use
it, free it and then exec" sequence in a new code, I do not think it
is worth fixing the code not to do so to reduce that unnecessary
work---it is not worth another round of review exchange.  But in the
same way, make an existing code that is not doing an unnecessary
work to do so is not worth it.

>> > @@ -34,8 +34,7 @@ const char *system_path(const char *path)
>> >  #endif
>> >
>> >       strbuf_addf(&d, "%s/%s", prefix, path);
>> > -     path = strbuf_detach(&d, NULL);
>> > -     return path;
>> > +     return d.buf;
>>
>> These happens to be the same with the current strbuf implementation,
>> but it is a good manner to use strbuf_detach(&d, NULL) here.  We
>> don't know what other de-initialization tomorrow's implementation of
>> the strbuf API may have to do in strbuf_detach().
>
> How to do it in correct way?

Wouldn't "return strbuf_detach(&d, NULL);" work without any
assignment to "path"?

>> > ...
>> > -                     puts(system_path(GIT_INFO_PATH));
>> > +                     char *git_info_path = system_path(GIT_INFO_PATH);
>> > +                     puts(git_info_path);
>> > +                     free(git_info_path);
>> >                       exit(0);
>> >               } else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
>> >                       use_pager = 1;
>>
>> None of these warrant the code churn, I would say.
>
> Sorry, english is not my first language, what did you mean when saying:
> "code churn"? Code duplication or something else?

Step back a bit and _think_ why you want to avoid leaks.  When a
program is leaky, your process will bloat by accumulating unused
cruft in your heap.  Step back again and think the reason why you
want to avoid that bloat.

It is because the parts of your program that want to allocate and
use more memory will suffer _after_ leak happens, because leakers
consume and keep memory that would be otherwise useful if they did
not leak and freed instead.  The later callers want to get more
memory, but cannot get it because the program leaked memory before
the control flow got to them.

Now, who do these calls to free() you added help?  Whose desire to
allocate more memory can be harmed by the allocated but not freed
piece of memory held by the return values from system_path()?

Nobody--exactly because the next thing you do is to exit.

It is not wrong per-se to free immediately before exiting; it is
just like freeing immediately before execing.  It is an unnecessary
thing to do, and a change to do so has no or very little value, even
if it is not a wrong thing to do.
