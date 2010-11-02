From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 2 Nov 2010 07:11:45 -0700
Message-ID: <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <20101102065208.GA4280@burratino> <201011020948.22677.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kenny Root <kroot@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 02 15:12:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDHax-0004Vl-6h
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 15:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab0KBOMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 10:12:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65029 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0KBOMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 10:12:06 -0400
Received: by gyg4 with SMTP id 4so4027114gyg.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 07:12:05 -0700 (PDT)
Received: by 10.42.166.8 with SMTP id m8mr461368icy.120.1288707125346; Tue, 02
 Nov 2010 07:12:05 -0700 (PDT)
Received: by 10.231.140.97 with HTTP; Tue, 2 Nov 2010 07:11:45 -0700 (PDT)
In-Reply-To: <201011020948.22677.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160520>

On Tue, Nov 2, 2010 at 1:48 AM, Johan Herland <johan@herland.net> wrote:
> On Tuesday 02 November 2010, Jonathan Nieder wrote:
>> (+cc: Johan, Thomas)
>>
>> Kenny Root wrote:
>> > Git notes were restricted to refs/notes/* in the command line
>> > utilities, but setting things like GIT_NOTES_REF to something outside
>> > of that structure would work.
>> >
>> > This removes the restrictions on the git notes command line interface.
>
> Why do you need to set GIT_NOTES_REF to something outside refs/notes/ at
> all?

I wanted Kenny to create a notes branch called refs/meta/bad-commits,
and put that inside of one of our Gerrit Code Review server
repositories.  We want to extend Gerrit Code Review to check to see if
any commit in the incoming pack appears in the bad-commits with a
note.  If it does, it will reject the push.  This allows a repository
owner to ban certain commits from re-entering a repository once they
have done a filter-branch or rebase to rewrite a particular item out
of history.

I didn't want to use refs/notes/bad-commits because its not really an
annotation you would be looking at with git log.  But we do want to
have a log of who banned particular SHA-1s from entering the
repository, and being able to push that branch from a workstation to
the server is a convenient way to edit that list of banned SHA-1s.
During prototyping Kenny discovered you can't use `git note --ref
refs/meta/bad-commits`.  Which means a server administrator wouldn't
be able to edit the list directly in the repository.  Hence this
patch.

>> Cc-ing some people more knowledgeable about notes than I am; maybe
>> they can give more information about what this notes.rewriteref
>> protection and other check are about.
>
> Well, I guess we originally decided to limit notes refs to within
> refs/notes/ in order to clearly separate notes from non-notes, and to
> prevent notes code from accidentally messing up non-notes refs.

I guess I can see some logic in this.  But the documentation says
--ref accepts a qualified ref name, and then proceeds to assume that a
string that starts with "refs/" (like "refs/meta/bad-commits") should
actually be "refs/notes/refs/meta/bad-commits".  That's a bug in the
UI and/or documentation.  If we are given a string starting with
"refs/" and its documented as taking a qualified name, that's
qualified and should either be rejected, or should be taken as-is.

I think the docs are correct, and the code is buggy.  If the user
asked us to edit refs/meta/bad-commits, we should.  If the user asked
us to edit refs/heads/my-branch... well, they asked us to edit it.
:-)

A better safety measure might be to sniff the ref's contents and see
what it is.  If the top level directory has a number of non-note like
entries, we should abort editing the branch.  Its not common for users
to name their directories "02" and "fe".

-- 
Shawn.
