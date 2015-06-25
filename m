From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Thu, 25 Jun 2015 19:54:47 +0800
Message-ID: <CACRoPnSD5kHof6yeRLqP6E7LcBjiHR1it3cadcRUCA3T-g=kUw@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
	<xmqq1th7brsj.fsf@gitster.dls.corp.google.com>
	<20150624075446.GA1964@yoshi.chippynet.com>
	<xmqqa8vpayhg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 13:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85k6-0006aY-RS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbbFYLyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:54:51 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36227 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbFYLyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:54:49 -0400
Received: by lacny3 with SMTP id ny3so43302983lac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GpnJo70Kw5dFost0ezX6cs1nH+GnrKwIN+8yq8Jc2I8=;
        b=0CRFc4tSDa/RAOmbXdK0M11S5MpSZg3r0KRhlOWqxRbmlDOwoMkajnmhfOEaVfepvm
         g31vdUj6NNJWSAoMGyv6qFUo2omofn3GhmvUf51EpK1gFtOrx/Of+/pUZ36EJhxBHHfm
         ZL8jqP0EEpguh5ppx1jS4tK1/FyfKrBXUaKY/8yTvbSzbXCuzvMO2dTKD7iO+4w1XqPt
         jXudn7V4H5nm/y3lntYmEj1nYe+3MlklKp6CXeVwsjuvn234Y4WKBPddOtVugwHBwIKl
         A+bn+0W+2PWQ+bl6RgX87C/2+1zvKURG4xTkJFw+VnBtNfKX8bM/EBLk9hI0g0lfAD+l
         YWRw==
X-Received: by 10.112.12.102 with SMTP id x6mr37955758lbb.80.1435233287809;
 Thu, 25 Jun 2015 04:54:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 25 Jun 2015 04:54:47 -0700 (PDT)
In-Reply-To: <xmqqa8vpayhg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272668>

On Wed, Jun 24, 2015 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> 3. I'm over-thinking this and you just want the "struct strbufs" in the
>>    struct am_state to be switched to "char*"s?
>
> Yes, everybody interacts with am_state, and these fields are
> supposed to be constant during the processing of each patch input
> message; they should be simple strings, not strbufs, to make sure if
> anybody _does_ muck with them in-place, that would be very visible.
> The helpers to initialize them are free to use strbuf API to prepare
> these simple string fields, of course.

OK. I've implemented it on my end.

>> (On a somewhat related thought, currently we do write_file() all over
>> the place, which is really ugly. I'm leaning heavily on introducing an
>> am_save() function, for "I don't care how it is done but just update the
>> contents of the am state directory so that it matches the contents of
>> the struct am_state".
>
> Sure; the scripted Porcelain may have done "echo here, echo there"
> instead of "concatenate into a $var and then 'echo $var' at end" as
> that is more natural way to program in that environment.  You are
> doing this in C and "prepare the thing in-core and write it all at
> the point to snapshot" may well be the more natural way to program.
>
> As long as a process that stops in the middle does not leave on-disk
> state inconsistent, batching would be fine.  For example, you may
> apply and commit two (or more) patches without updating the on-disk
> state as you do not see need to give control back to the user
> (i.e. they applied cleanly) and then write out the on-disk state
> with .next incremented by two (or more) before giving the control
> back could be a valid optimization (take this example with a grain
> of salt, though; I haven't thought too deeply about what should
> happen if you Ctrl-C the process in the middle).

Right, I briefly wondered if we could hold off writing the am_state to
disk as much as possible, and only write to disk when we are about to
terminate. This would involve installing an atexit() and SIGTERM
signal handler, but I haven't thought too deeply about that.

Anyway, moving all the "writing am_state to disk" logic to a central
function am_save() would be a good immediate step, I think, so I've
implemented it on my end.

Thanks,
Paul
