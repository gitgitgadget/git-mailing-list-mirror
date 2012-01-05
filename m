From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Do not fetch tags on new shallow clones
Date: Thu, 5 Jan 2012 07:16:14 -0800
Message-ID: <CAJo=hJse=6+9DdDgwJOEas1kdbx946SSKeTjEMZrYUA6V+h=1Q@mail.gmail.com>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
 <7vwr97nho7.fsf@alter.siamese.dyndns.org> <CAJo=hJvL2ebziPw=0q-e=G3WFEvEKtFR2xMFMiquSyrHJDradA@mail.gmail.com>
 <7vfwfuofnk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 16:16:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rip3b-0000iV-7s
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab2AEPQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 10:16:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46069 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab2AEPQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 10:16:36 -0500
Received: by dajs34 with SMTP id s34so342609daj.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 07:16:35 -0800 (PST)
Received: by 10.68.189.163 with SMTP id gj3mr6106033pbc.86.1325776595743; Thu,
 05 Jan 2012 07:16:35 -0800 (PST)
Received: by 10.68.26.37 with HTTP; Thu, 5 Jan 2012 07:16:14 -0800 (PST)
In-Reply-To: <7vfwfuofnk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187979>

2012/1/4 Junio C Hamano <gitster@pobox.com>:
> Shawn Pearce <spearce@spearce.org> writes:
>> ... Its useful because cloning a branch immediately after it
>> has been tagged for a release should have `git describe` provide bac=
k
>> the name of the release from the tag (assuming of course no new
>> commits were made since the tag).
=2E..
> ... this thing, once you have a "single ref only" stuff working. =A0A=
fter
> Linus announces that he released 3.2, you would do the poor emulation=
 of
> "git archive | tar xf -" with something like:
>
> =A0 =A0git clone --single=3Dv3.2 --shallow $there linux-3.2
>
> and your "git describe" should fall out as a natural consequence out =
of
> everything else, without the usual "tag following" semantics, no?

I said "branch" not "tag". Of course a single ref clone might be able
to be used on a tag.

If my project maintainer tags a release from "maint" and announces
that, I should also be able to shallow clone maint and pick up the tag
automatically if it is within the depth I have asked for from the
server.

Consider this case, a client clones shallow with a depth of 1. Then
does normal `git fetch` to keep up-to-date with the project. When the
project places a new tag on a branch, our shallow follower will
automatically get that tag during her next `git fetch`, because auto
following tags is enabled in fetch and the tag's referent was included
in the pack. Why is this case permitted to get a tag, and shallow
clone is not?

Actually, I think you might find that a shallow client with depth of 1
will automatically pick up a missing tag at the branch head on its
next `git fetch`. It will see the tag's ^{} line advertise an object
it has, and ask for the tag.

We really should support auto-following tags within the history space
the client already has. Its mostly done for us with the include-tag
capability, the client just needs to make sure it asks for it from the
server, and check to see if any tag reference points to an object it
has.

> you would do the poor emulation of
> "git archive | tar xf -" with something like:
>
> =A0 =A0git clone --single=3Dv3.2 --shallow $there linux-3.2

Is it really that poor of an emulation? Like tar, we get only one copy
of each file (assuming depth 1). Assuming --format=3Dtar.gz, both are
compressed. I wonder how much better or worse the Git cross-object
delta compression is than the libz rolling window. I could see how Git
might be able to compress something like C source code smaller than
tar | gzip by using delta compression on related files (e.g. Makefile
in every directory, or *.h and *.c files pairing by type). An added
advantage of the shallow clone is you can incrementally update that
stream, as its easy to fetch a v3.2.1 patch release, or apply a patch
and record it on top.
