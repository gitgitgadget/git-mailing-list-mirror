From: Ville Walveranta <walveranta@gmail.com>
Subject: Re: Git 1.8.4.2: 'git-rev-parse --is-inside-git-dir' wrong output!
Date: Sat, 2 Nov 2013 17:58:48 -0500
Message-ID: <CACbqpSs3DcHuypbBwLJ6Dbd5nKz6c=oozTxyJepEmi1Zis7WRQ@mail.gmail.com>
References: <CACbqpSvU4qxc0WtquP6Eq8bZGjLxTrVhtT2Nqw90wb23ESkfcw@mail.gmail.com>
	<20131102105816.GC24023@serenity.lan>
	<11593D3DCFCD4D24BB881B9E5FAB79C0@PhilipOakley>
	<20131102140656.GE24023@serenity.lan>
	<CE13C82CA4C24CA8B56380DA00A700A5@PhilipOakley>
	<CACbqpSspsUvw3QXnSmOXA2boenh3y4DjHO-813OTna7cpSXkZQ@mail.gmail.com>
	<20131102202041.GF24023@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 02 23:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vck9s-0007VR-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 23:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3KBW6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 18:58:49 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:43610 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3KBW6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 18:58:49 -0400
Received: by mail-vc0-f178.google.com with SMTP id ie18so3878078vcb.9
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=SU4OK//nFPmJxihCeS5yMNZpK2qY2AT6tikFOke5UT0=;
        b=z/3PLLEAt0305nuA7hyJsN/NdzQUfH1fbhtk62M07hjgX3NkmlyeVYk2SosIEYpXpu
         lsyK9DKdKKYImdSyzaLwKFj84Z2XUXJx2msli68ndfrM6ig3DVlRIeklwdpaT8xxMduX
         lpBGEyrZYwZgQCCuLu2vMzZNcWrtR5Fazgm0rxyYkLWB68hK25/UGV1N1GAU56c3YWO1
         zG3iktdvmbXxAuiltK1e5KQVbF7GAPfTRoAhBb94qLApaApVzn5aIUalmn9cVRRmzo2i
         EcP5QvAKaWELkkOSMMBJmyxPqMprECyc78F0Ut3NkuW3wds2ujzQARfcyzEj3MTa4hag
         oKDA==
X-Received: by 10.220.86.69 with SMTP id r5mr6054312vcl.9.1383433128064; Sat,
 02 Nov 2013 15:58:48 -0700 (PDT)
Received: by 10.58.2.133 with HTTP; Sat, 2 Nov 2013 15:58:48 -0700 (PDT)
In-Reply-To: <20131102202041.GF24023@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237253>

Yes, stderr redirection in a subshell seems to work ok.  Since I'm
creating a small git utility script I ended up doing:

--
#!/bin/bash

(git rev-parse --git-dir >/dev/null 2>&1)

if [ $? -ne 0 ] ; then
  echo "Not in a git repo"
else
  echo "Git repo; proceeding.."
  # more logic..
fi
-- 

That works! Thanks for your help!

Ville

On Sat, Nov 2, 2013 at 3:20 PM, John Keeping <john@keeping.me.uk> wrote:
> On Sat, Nov 02, 2013 at 02:42:04PM -0500, Ville Walveranta wrote:
>> Without the functionality such as that 1.7.9.5 still offered, it is
>> now not possible to use "git-rev-parse --is-inside-work-tree" to
>> detect whether the current location is controlled by a git repository
>> without emitting the "fatal: Not a git
>> repository (or any of the parent directories): .git" error message,
>> when it is not. There is no functional "--quiet" switch, and the usual
>> error/std redirection to /dev/null doesn't seem to work to squelch the
>> output.
>
> How doesn't redirection work?  The message is printed to stderr; the
> snippet I posted below does indeed squelch the output.
>
>> If "--is-inside-git-dir" and "--is-inside-work-tree" are indeed not
>> supposed to emit "false" when outside of a git repository, perhaps
>> there is another way I can use (in a bash script) to cleanly detect
>> whether a specific path is part of a git repo or not?
>
> Something like this, maybe?
>
>     (cd "$dir" && git rev-parse --git-dir >/dev/null 2>&1)
>
>> On Sat, Nov 2, 2013 at 12:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> > From: "John Keeping" <john@keeping.me.uk>
>> > Sent: Saturday, November 02, 2013 2:06 PM
>> >
>> >> On Sat, Nov 02, 2013 at 01:47:02PM -0000, Philip Oakley wrote:
>> >>>
>> >>> From: "John Keeping" <john@keeping.me.uk>
>> >>> Sent: Saturday, November 02, 2013 10:58 AM
>> >>> > On Fri, Nov 01, 2013 at 06:19:51PM -0500, Ville Walveranta wrote:
>> >>> >> "git-rev-parse --is-inside-git-dir" outputs "fatal: Not a git
>> >>> >> repository (or any of the parent directories): .git", instead of
>> >>> >> "false" when outside of a git directory.  "--is-inside-work-tree"
>> >>> >> behaves the same way. Both commands work correctly (i.e. output
>> >>> >> "true") when inside a git directory, or inside a work tree,
>> >>> >> respectively.
>> >>> >
>> >>> > I think that's intentional - and it looks like the behaviour has
>> >>> > not
>> >>> > changed since these options were added.  With the current behaviour
>> >>> > you
>> >>> > get three possible outcomes from "git
>> >>> > rev-parse --is-inside-work-tree":
>> >>> >
>> >>> >    if worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
>> >>> >    then
>> >>> >        if test "$worktree" = true
>> >>> >        then
>> >>> >            echo 'inside work tree'
>> >>> >        else
>> >>> >            echo 'in repository, but not in work tree'
>> >>> >        fi
>> >>> >    else
>> >>> >        echo 'not in repository'
>> >>> >    fi
>> >>> > --
