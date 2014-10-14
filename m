From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] [kernel] completion: silence "fatal: Not a git
 repository" error
Date: Tue, 14 Oct 2014 15:18:17 -0400
Message-ID: <CAEBDL5V_Mzxwc4fnybg9=fmeotGV91XerzTccHMWLV79bE+mVA@mail.gmail.com>
References: <1413283785-505-1-git-send-email-john@szakmeister.net>
	<xmqqfveqzeqy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 21:18:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe7bz-0008U6-As
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 21:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbaJNTST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 15:18:19 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:59189 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbaJNTST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 15:18:19 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so443206lab.29
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B0fX/5gTkG2XBeJQFDeaii7H/CZ5mkVN8ng9MsFQezg=;
        b=Ut79GxTYx4PnUUIDrt3S2c7g+aiMBl/Enm+VXk6QbfyIKMqMDCpc2MZBjyJprZTowr
         xk/VeN6zP7Mha4V6KMRoO9FRIxSR/d6he8dBblOGH/s0dzF+tt7ZhqgxNV/7owT6AFxq
         IjE9BzNlTOY7PS8RMsuk/HLsVdK/5Hnn42RLJVLFBF2XO1k6GIn5iewgT22jxjRiVFjF
         jb2HW+JscDSWqhfZyLhSVAOWg/YpOyJCfMdOgXz97cWClADvDh2/YIzAcKWIYbKOSqAt
         BhIwyG0OjUd24Opdpl9KG+edIOa451epnuW9b/4oZJd+52YoibN6t8y/4oMjO1DLegxq
         eiFg==
X-Received: by 10.152.216.167 with SMTP id or7mr5148656lac.93.1413314297204;
 Tue, 14 Oct 2014 12:18:17 -0700 (PDT)
Received: by 10.25.138.132 with HTTP; Tue, 14 Oct 2014 12:18:17 -0700 (PDT)
In-Reply-To: <xmqqfveqzeqy.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: g8qPERoi6eLdgAge09ibfJwrc5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Szakmeister <john@szakmeister.net> writes:
>
>> It is possible that a user is trying to run a git command and fail to realize
>> that they are not in a git repository or working tree.  When trying to complete
>> an operation, __git_refs would fall to a degenerate case and attempt to use
>> "git for-each-ref", which would emit the error.
>>
>> Let's fix this by shunting the error message coming from "git for-each-ref".
>
> Hmph, do you mean this one?
>
>     $ cd /var/tmp ;# not a git repository
>     $ git checkout <TAB>
>
> ->
>
>     $ git checkout fatal: Not a git repository (or any of the parent directories): .git
>     HEAD
>
> I agree it is ugly, but would it be an improvement for the end user,
> who did not realize that she was not in a directory where "git checkout"
> makes sense, not to tell her that she is not in a git repository in
> some way?

I had thought about that too, but I think--for me--it comes down to two things:

1) We're not intentionally trying to inform the user anywhere else
that they are not in a git repo.  We simply fail to complete anything,
which I think is an established behavior.
2) It mingles with the stuff already on the command line, making it
confusing to know what you typed.  Then you end up ctrl-c'ing your way
out of it and starting over--which is the frustrating part.

For me, I thought it better to just be more well-behaved.  I've also
run across this issue when I legitimately wanted to do something--I
wish I could remember what it was--with a remote repo and didn't
happen to be in a git working tree.  It was frustrating to see this
error message then too, for the same reason as above.  I use tab
completion quite extensively, so spitting things like this out making
it difficult to move forward is a problem.

Would it be better to check that "$dir" is non-empty and then provide
the extra bits of information?  We could then avoid giving the user
anything in that case.

-John
