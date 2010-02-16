From: Mark Lodato <lodatom@gmail.com>
Subject: Re: git-grep ignores untracked files
Date: Mon, 15 Feb 2010 19:20:30 -0500
Message-ID: <ca433831002151620q2b875c51md883f4b424231f15@mail.gmail.com>
References: <1266194137-25653-1-git-send-email-lodatom@gmail.com> 
	<7vvddz5l1z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 01:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhBBQ-00010j-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 01:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355Ab0BPAUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 19:20:52 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:42290 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab0BPAUv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 19:20:51 -0500
Received: by gxk24 with SMTP id 24so5334992gxk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 16:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iPNVTobHcCCuls+YcihwXypmxf5ZFJf0ImlTWhCcA08=;
        b=g7pGWQL08fHdWnGE+UiQpIFh0L9cf/sGRxTz0L/+IqNQBMGNFZg1CXGT/mr3qIUNqK
         ErGS0F+nV4o619p6dtk75j24FTLwT/9vUWstji0qd2Rhk0UczpSLdNpOafTaAvbhtjYS
         X79OHt7yC65uJyYyI5TiEiUXdNlU/LyapL1AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v67MU3c6ZnZbp6LZCOdAzoBN0sZ2BeHBGRSXC79ViK0LA3/SUmrdCQrCoKycVIYQEQ
         Ii1XCBZ3dcX4sR2X/Y4qqi3b3HyBSD7Qtx9AG2TCm8yua1b3yhFQ3b32utgyU1gj7SFQ
         X7ff54ug1Hm4eJ30QEyf+SA/J7yOHDuMqkFlU=
Received: by 10.91.153.3 with SMTP id f3mr35124ago.80.1266279650226; Mon, 15 
	Feb 2010 16:20:50 -0800 (PST)
In-Reply-To: <7vvddz5l1z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140052>

On Sun, Feb 14, 2010 at 8:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I doubt we want to have "Only tracked files blah blah". =C2=A0Like al=
l the
> normal git commands, "grep" is about tracked contents, and I don't th=
ink
> it would help to repeat the obvious like pathspec filter will act as =
a
> filter. =C2=A0"add <pathspec>" is an exception in that it _is_ about =
untracked
> paths and that is why you get warnings for unmatched ones.

I think adding this information to the description of <path> would be
sufficient.  I'll send a new patch in a minute.

> =C2=A0 =C2=A0Side note: there will be --no-index option to let you ru=
n "git grep"
> =C2=A0 =C2=A0over files in a random directory.

Ah, didn't see this.  So, it looks like most of my requests were
already done.  However, it may still be a good idea to DWIM when none
of --cached, --no-index, or trees are given but a pathspec is given
that matches an untracked file in the working directory.  For example:

$ git grep $pattern -- untracked_file

It is obvious that the user meant to specify --no-index.   However,
I'm not sure where to draw the line.  What if they give tracked and
untracked files, or if they given a glob pattern that matches both?

Still, the simple, "one path is given, it's not a pattern, and it
matches exactly to an untracked file" case should probably run with
--no-index.

>> +<path>...::
>> + =C2=A0 =C2=A0 Only search files matching these wildcard patterns; =
see glob(7) for
>> + =C2=A0 =C2=A0 the format. =C2=A0If not given, all tracked files in=
 the tree are searched.
>
> Please do *not* "see glob(7) for the format". =C2=A0Pathspec used for=
 "grep"
> (and "ls-files") are "leading path match or glob(7)". =C2=A0E.g. "git=
 grep
> frotz t/" looks for frotz in all files under "t/" recursively, and th=
at
> does not have much to do with glob(7). =C2=A0If we do not have a desc=
ription
> already, we may want to add these basics to git(1) or the user manual=
=2E

Ah.  This is a major inconsistency in the documentation.  I have a lot
to say about this, so I'll make this a separate thread.  For the
patch, I'll just reference git-add(1), which is the does have a
description, and then we can fix this properly in a future patch.
