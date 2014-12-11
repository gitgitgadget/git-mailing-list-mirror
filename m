From: Florian Hassanen <florian.hassanen@gmail.com>
Subject: Re: [PATCH] git-check-ignore.txt: Clarify exit codes
Date: Fri, 12 Dec 2014 00:40:53 +0100
Message-ID: <CAMAJHBZpLY_Rwdpuw6hruJwST_tgY1S02ZPt=ueKPXOXHREHxQ@mail.gmail.com>
References: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com>
 <xmqqiohhdc5j.fsf@gitster.dls.corp.google.com> <CAMAJHBYVMy-tc_aCjyeN7=VMG=k7gjWh9evL6bcJLzYfQcf6yg@mail.gmail.com>
 <xmqqa92tdb80.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:41:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzDMG-0000Na-P6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759191AbaLKXlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:41:17 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:63419 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759155AbaLKXlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 18:41:16 -0500
Received: by mail-lb0-f172.google.com with SMTP id u10so5052515lbd.31
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LR27JkfR2GwSjdA0IoIus5gduV+YPin6dS3YMJ6lnBw=;
        b=hQS6ytbYAljlwxxEdrfUUwyttgdpDSGF9d+tcP4QmhiG2f/nKeV42/IoEiNjmA+JS1
         1vtruX9Tov6XRVQmnJABJrZMs98M8BYkErUhZTVQufx+euXa09T9qI4r+5+ql3uNrLpU
         EANoy0Ud4TK/RDHTv3jdVzqv79KxyUYBZGTWiqK8FwIuKeTENcsTi/gumhqVl7eckYf/
         I/5OlcqaJM7vB3lGJvsA7xpF/o/fGE8ddYqH8Aru4YPMFWSQ3O+OS1zGSJK50gNLn5B5
         DnhlPDL948sU8kC22HvEiT4jlv1vSb7EvUxzLjp8/p4mPZnTT4Ov2HhSWfzL3XnT3lwm
         9ihw==
X-Received: by 10.112.130.65 with SMTP id oc1mr12591852lbb.7.1418341274808;
 Thu, 11 Dec 2014 15:41:14 -0800 (PST)
Received: by 10.152.26.101 with HTTP; Thu, 11 Dec 2014 15:40:53 -0800 (PST)
In-Reply-To: <xmqqa92tdb80.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261307>

> It smells like you spotted a bug in the behaviour, not a bug in the
> documentation, at least to me.

At first I thought so as well :-)
I even prepared a patch, just to find out, that existing tests specifically
test for this "unintuitive" behavior.

Then I read the docs in more detail and found this:

  If the pattern contained a ! prefix or / suffix, it will be
preserved in the output.

So it seems there is indeed the intent to output patterns, even if
they are negated/negative.

Another problem I see with providing "correct" behavior is this:

If I do a test for a non existant file, it cannot be decided whether I
mean a file or a directory.

e.g.

having a gitignore with a single line

  dir/

which only ignores die _directory_ dir, but not the _file_ dir

the exit code for

  $ git check-ignore dir

could either be 0 or 1, depending on whether a _file_ named "dir" or a
_directory_
named "dir" was meant.

I assume that the command is meant to get the applying entry of the gitignore
and then its up to the consumer to provide additional logic to determine whether
the path is actually ignored or not.

I am not sure what the correct behavior should be. And whether some
code already depends
on this command.

My personal preference, would be a behavior like

$ # regardless whether dir exists or not
$ git check-ignore dir # a file is meant
$ git check-ignore dir/ # a directory is mean

and the exit code should only depend on whether the file is actually
ignored or not
- and not if there is an arbitrary matching pattern in gitignore

PS: btw, the previously discussed gitignore file should have read
(note the order)
cat > .gitignore << EOF
*.o
!vendor.o
EOF

because always the last matching entry applies
(so exceptions must come last) - but the exit codes are still the same

On Fri, Dec 12, 2014 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Florian Hassanen <florian.hassanen@gmail.com> writes:
>
>> Maybe your global ignore file gets in the way?
>
> No, as I do not have one.
>
>> is one of a.o and vendor.o already in your index?
>
> Bingo.  I did "git add ." to see if the .gitignore file is doing the
> right thing before running that demonstration.
>
> It smells like you spotted a bug in the behaviour, not a bug in the
> documentation, at least to me.
>
