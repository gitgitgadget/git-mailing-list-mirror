From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Fri, 27 Jan 2012 12:46:29 +0100
Message-ID: <CAH6sp9O0WG++mqq-YvOo3BUZioNWkKhCjGo4ySvSTaNFaY9afQ@mail.gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
	<1327444346-6243-6-git-send-email-fransklaver@gmail.com>
	<20120124232421.GH8222@burratino>
	<op.v8moybu10aolir@keputer>
	<4F205028.4060606@kdbg.org>
	<7vr4ym2rad.fsf@alter.siamese.dyndns.org>
	<CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
	<20120127084845.GC806@burratino>
	<CAH6sp9O7P8bmYA66fY754mn=ogp8OP1i3KQuE_hnrTY46nNAxw@mail.gmail.com>
	<20120127094145.GA2611@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 12:46:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqkGK-00017A-BF
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 12:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab2A0Lqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 06:46:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58167 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2A0Lqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 06:46:30 -0500
Received: by qadc10 with SMTP id c10so616156qad.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jkgqdjzqzVg7mRzxT6ionGpCP1pXpBrlZMazi03rfu4=;
        b=gWd283NNYYAibo7TKvx1ro+Cha6JqPSW9YsbZadnSJd2ImSnmLqf3p7lYCqwXRc+AV
         HBywTPCQkny3O8YU52z7MGgvLy4kwV5CWdbAschDxs0Ub88Y9Yn5xxkat7nHvvpYC3Z6
         32GAOi7VnmBUQod2rtqg+qtCL2WjTCnyaTzp4=
Received: by 10.224.195.2 with SMTP id ea2mr7585341qab.84.1327664790064; Fri,
 27 Jan 2012 03:46:30 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Fri, 27 Jan 2012 03:46:29 -0800 (PST)
In-Reply-To: <20120127094145.GA2611@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189215>

On Fri, Jan 27, 2012 at 10:41 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Frans Klaver wrote:
>
>> Just for my understanding: before a command is executed, a pager
>> (less/more or so) is started? We want to avoid starting the pager if
>> we won't be able to execute the command?
>
> See [1] for an example of a recent patch touching the relevant
> code path.

I'll have a look at that.


> For example: if I run "git --paginate foo", foo is an alias for bar,
> and the "[pager] bar" configuration is set to point to "otherpager",
> then without this safety git launches the default pager in preparatio=
n
> for running git-foo, receives ENOENT from execvp("git-foo"), and then
> the pager has already been launched and it is too late to launch
> otherpager instead.

Something to be looked into then.


> Well, as I said, I don't know. :) =C2=A0And I don't want to give fals=
e
> hopes --- it's perfectly possible and not even unlikely that this is =
a
> dead end and any patch in this direction will turn out not to be a
> good idea and not applied.

Hm don't worry about false hopes. I don't insist on having some of my
work actually in if there's no point in including it. Contributing to
the research is good enough for me if we can come to a conclusion that
we can present to people running into similar issues.


> That's part of why I was really grateful to Hannes for the reminder t=
o
> take a step back for a moment and consider whether it's worth it.
> Maybe there's another way or a more targetted way to take care of the
> motivational original confusing scenario that leads to execvp errors.

I wonder.

> (By the way, can you remind me which one that was?)

I'll even summarize my thinking and motivation about this.

I was executing the test suite on my PC. Some test for aliases failed
-- git said EACCES, while for aliases one would expect ENOENT. For
users expecting an alias to be executed, "cannot execute git-frotz:
Access Denied" will be rather confusing. "Huh? Access denied? The file
doesn't even exist?!". It took me quite some debugging in git to track
this down to an inaccessible PATH entry. As someone who didn't know
anything of the git internal code it took quite a bit of learning as
well just to find out where we'd end up in the first place. It
bothered me (and still does) that execve uses EACCES for at least four
different errors:

=2E..
    EACCES Search  permission is denied on a component of the path
prefix of filename or the
              name of a script interpreter.  (See also path_resolution(=
7).)
    EACCES The file or a script interpreter is not a regular file.
    EACCES Execute permission is denied for the file or a script or
ELF interpreter.
    EACCES The file system is mounted noexec.
=2E..

Anyway, reading through that man page later on I found that a lot of
errors are only mentioned once, but do contain 'or' in the problem
description, like the first one of the EACCES items. ENOENT does that
as well:

    ENOENT The file filename or a script or ELF interpreter does  not
exist,  or  a  shared
              library needed for file or interpreter cannot be found.

I then additionally figured that always silently passing ENOENT is a
bad thing to do, because it simply can mean more than just "The file
you asked for cannot be found". It means "something required cannot be
found". My resulting view on this is basically that the execvp error
handling git currently has, is lacking a nuance that is necessary for
effective debugging. As I said earlier, it's when things go wrong
people get annoyed. Even more so if you don't provide them with
pointers to what might be wrong.

It also bothers me that to effectively debug program execution errors,
you have to know that git uses execvp, and you have to know how it
behaves. I would label that "implementation details" and as a user I
really don't want to be bothered by that, especially not as a new
user. For that reason I would have liked to end up with something like
bash does. I would rather see "Hey dummy, can't access /some/path" or
"Hey dummy, you ask for an interpreter that I have no acces to" than
"Well we got EACCES, so check the following things: Do we have search
permission on.... Is it a regular file? mounted noexec?..." or "We got
EACCES, check man execve(2) for possible reasons", although I'd agree
that even that would be slightly better than "We got EACCES".

So take of your git-guru hat and put on your new-git-user one and let
it simmer for a while.
