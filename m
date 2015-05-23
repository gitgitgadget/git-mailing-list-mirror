From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 10:39:39 -0700
Message-ID: <xmqqk2vzchwk.fsf@gitster.dls.corp.google.com>
References: <555FD1EA.2060706@rightscale.com>
	<CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
	<20150523022256.GA17789@lanh> <20150523053900.GA2364@glandium.org>
	<xmqq1ti7dyky.fsf@gitster.dls.corp.google.com>
	<xmqqwpzzcjq0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 23 19:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwDOn-00068Y-9v
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbbEWRjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:39:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33634 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbbEWRjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:39:42 -0400
Received: by igbpi8 with SMTP id pi8so13104440igb.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ib9H76N9jRnnSAyLzTp9gQvWKa/cNk1q+gaGWy34z6A=;
        b=uTM/beAt7fCvvXcgtTzu4+tMOz+LSd2uPNVtvWbRu4KAlm545/Bw5YXbppFjBYB18D
         UcbZ0a7Lk1B4jdtk1TkVIWubFHaH6drICZ6XKMdkHx3ZmVqiWpJAL2SJb9qRyK8XUHmx
         WBcvQi1mfZeEmefUsHRYUpvivd1c2o9Nmt+bljCKCzGFcQYvsLp5sOseOUOnsVzqtQuj
         Dn6QWRtnHMqgmgPqC8mOlgNpw3H69y+wbJrlnBYI8Uj2Lxr2hGew3N9aMPE2Y/ZuVF8G
         Irp7CL8HMEm8naHGoc8GsCcGhAlrF9kH+nh5JEszSgWZkijEQC9ylAzkuDwJM0/ZTcrj
         swUA==
X-Received: by 10.107.14.78 with SMTP id 75mr18282833ioo.15.1432402782261;
        Sat, 23 May 2015 10:39:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id i185sm4612186ioi.24.2015.05.23.10.39.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 10:39:40 -0700 (PDT)
In-Reply-To: <xmqqwpzzcjq0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 23 May 2015 10:00:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269811>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think both of you are wrong ;-)
>>
>> The thing is, what you are seeing does not have much to do with
>> GIT_DIR.  It is "what Git does when it finds a directory inside the
>> working tree of a project".  And ".git" is the only special thing in
>> that context.
>
> In short, I think Duy's "how about this" means well, but adds
> documentation at a wrong place.
>
> Having said all that, the message I am responding to showed the
> right way to look at, understand, and explain the current behaviour.
> It is a separate issue if the current behaviour is optimal from the
> usability point of view.  It is not entirely implausible to extend
> the special casing rules from "a directory named '.git' only" to "in
> addition, the directory pointed at by GIT_DIR, if exists, is treated
> the same way".

If somebody is interested in pursuing this further in the direction
of changing the behaviour (so that Thorsten's original would work as
expected), one thing to be careful about is the case (1) (case (2)
is more or less straight-forward and obvious).

If you do

    $ GIT_DIR=/path/to/worktree/sub/repo.git
    $ GIT_WORK_TREE=/path/to/worktree
    $ export GIT_DIR GIT_WORK_TREE
    $ cd $GIT_WORK_TREE
    $ git add sub

with the current rule, because sub/repo.git does not trigger the
special casing, we may end up adding everything inside our own
repository, which is clearly crazy.  But if you change the rule to
special case the directory pointed at by $GIT_DIR, then we would
start treating that directory as "ah, there is a Git repository".
But the updated code must not say "hence, sub/ is the top level of
the working tree of that repository, so we add it as a submodule".

It instead should just ignore that repo.git directory, just like a
plain vanilla "git add ."  ignores ".git" at the top-level, and add
other things in sub/ directory, i.e. treating sub/ as just a normal
subdirectory in our working tree.

I am not planning to do this in a near future myself, but I thought
I should caution in case anybody is interested.

Thanks.
