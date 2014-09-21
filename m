From: Johan Herland <johan@herland.net>
Subject: Re: Bug/request: the empty string should be a valid git note
Date: Sun, 21 Sep 2014 03:44:39 +0200
Message-ID: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
References: <F9750CC0-3FAC-4B50-AB6A-BFD6A7D0BE97@trifork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "James H. Fisher" <jhf@trifork.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 03:44:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVWCr-0000Fs-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 03:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbaIUBou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 21:44:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:53919 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaIUBot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2014 21:44:49 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XVWCk-0008t5-Th
	for git@vger.kernel.org; Sun, 21 Sep 2014 03:44:47 +0200
Received: by mail-pd0-f171.google.com with SMTP id y13so2239700pdi.2
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 18:44:39 -0700 (PDT)
X-Received: by 10.70.102.41 with SMTP id fl9mr15347193pdb.136.1411263879443;
 Sat, 20 Sep 2014 18:44:39 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Sat, 20 Sep 2014 18:44:39 -0700 (PDT)
In-Reply-To: <F9750CC0-3FAC-4B50-AB6A-BFD6A7D0BE97@trifork.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257333>

On Sat, Sep 20, 2014 at 9:47 PM, James H. Fisher <jhf@trifork.com> wrot=
e:
> In the documentation for git notes [1] I read:
>
>     In principle, a note is a regular Git blob, and any kind of
>     (non-)format is accepted.
>
> Then, since the empty string is a valid regular Git blob, the empty
> string is also a valid git note.

Agreed.

> Therefore this behavior was unexpected for me:
>
>     > git notes --ref=3Dfoo add -m ''
>     Removing note for object 97b8860c071898d9e162678ea1035a8ced2f8b1f

Although I can understand your surprise, if you keep reading the
sentences following the above quote from the manual page, it says:

   You can binary-safely create notes from arbitrary files using
    git hash-object:

        $ cc *.c
        $ blob=3D$(git hash-object -w a.out)
        $ git notes --ref=3Dbuilt add -C "$blob" HEAD

This might indicate that even if "git notes add -m ''" does not create
an empty note, then at least the following command should:

    git notes add -C e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

(that is the SHA1 sum of the empty blob)

However (and this is where I start to grow surprised as well), that
_also_ totally fails to create an empty note!

This is IMHO clearly a bug: If we advertise a binary-safe method for
creating git-notes, then that method should definitely also support
creating empty notes.

Whether or not "git notes add -m ''" should also create an empty note,
is not necessarily that clear to me. There are historical reasons for
the current behavior (see below), but there is also a certain element
of convenience for the user here; consider the following:

When you run "git commit", git opens your editor to let you write the
commit message. However, if you change your mind, and want to abort
the commit, you can simply write nothing (or exit without saving),
and git will respond with:

    Aborting commit due to empty commit message.

The same applies to "git commit -m ''".

This is the pattern on which "git notes add" is modeled: Empty input
is interpreted as an intent to abort, which, in the notes case is to
simply not create the note at all.

> I was surprised to see that this behavior was deliberately introduced=
:
>
>     > git log -1 a0b4dfa
>     commit a0b4dfa9b35a2ebac578ea5547b041bb78557238
>     Author: Johan Herland <johan@herland.net>
>     Date:   Sat Feb 13 22:28:24 2010 +0100
>
>         Teach builtin-notes to remove empty notes
>
>         When the result of editing a note is an empty string, the
>         associated note entry should be deleted from the notes tree.
>
>         This allows deleting notes by invoking either "git notes -m '=
'"
>         or "git notes -F /dev/null".
>
>         Signed-off-by: Johan Herland <johan@herland.net>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> I don=E2=80=99t understand what the motivation for this change was. Y=
es, it
> "allows deleting notes" by providing the empty string, but there is
> a specific subcommand for removal of a note, `git notes remove`,
> which makes this intention much clearer.

Actually, if you take a closer look at the context for that commit,
you will see that things were in fact the other way around: auto-
removing empty notes was added _before_ "git notes remove", and if
you look at 92b3385f which introduces "git notes remove", you'll see
that it was initially implemented wholly in terms of editing the note
to become empty, which then caused its removal.

That said, these are unimportant historical details, and should not
serve as justification for continued incorrect behavior.

> I have specific motivation for wanting to store the empty string as
> a git note, as distinct from the non-existence of a note for the
> object. (Specifically I have a tool to annotate a commit with a list
> of files that satisfy a certain condition. The empty string represent=
s
> the empty list, a valid value which asserts that no files satisfied
> the condition. I can imagine many other use cases for which the empty
> string is a useful git note.)

I do not disagre with your use case at all, and it is regrettable that
there is no simple workaround for creating empty notes. Assuming that
your lists of files use e.g. a newline to separate filenames, then I
guess you could use a note consisting of a single newline to signify
an empty list ("echo | git hash-object -w --stdin"). At least as a
temporary workaround until we get this fixed in Git.

> Does anyone know why we have the existing behavior? Is it for
> "technical reasons=E2=80=9D or was it actually considered desirable?

I guess it's "historical reasons". But we should definitely fix it.

At least, we should fix

    git notes add -C e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

Whether we should also change

    git notes add -m ''

to create an empty note, or leave it as-is, (i.e. similar in spirit to
"git commit -m ''"), I'll leave up to further discussion.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
