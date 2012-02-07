From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 12:15:52 -0800
Message-ID: <CAJDDKr5uTj0Jav=3Kwf4Atd81qn1x9CLTveZOPmWwsnNCT9Lhw@mail.gmail.com>
References: <20120206062713.GA9699@sigill.intra.peff.net>
	<CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
	<20120207051719.GA11598@sigill.intra.peff.net>
	<CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
	<20120207173025.GA22225@sigill.intra.peff.net>
	<m31uq63143.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 21:16:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RurSI-0006Co-2l
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 21:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706Ab2BGUPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 15:15:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56733 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab2BGUPx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 15:15:53 -0500
Received: by yhoo21 with SMTP id o21so3262064yho.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eAys7YgKIdvOGPjkzN3SkFQvhXTjNBTrro4M7MZNHeM=;
        b=UaMVX4dk8lSjxvLMJ7KwyPfhmqYQo748ynPiCGgBle3hXwgtvnyroPsL7wKgZE9jQh
         0LXtBAoExinmd979/shw8qt9YHcB4WzBO7q7+tSwMGD+TkSd9RGTt6s7rcwkqqHkS8+t
         AwGK6h/Bev4etQduPUix35K02nLSVWCgNNKAs=
Received: by 10.236.173.202 with SMTP id v50mr34381026yhl.102.1328645752635;
 Tue, 07 Feb 2012 12:15:52 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Tue, 7 Feb 2012 12:15:52 -0800 (PST)
In-Reply-To: <m31uq63143.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190209>

On Tue, Feb 7, 2012 at 11:16 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Jeff King <peff@peff.net> writes:
>
> [...]
>> Git-config could potentially help with that (and even simplify the
>> current code) by allowing something like:
>>
>> =C2=A0 $ git config --list-with-sources
>> =C2=A0 /home/peff/.gitconfig user.name=3DJeff King
>> =C2=A0 /home/peff/.gitconfig user.email=3Dpeff@peff.net
>> =C2=A0 .git/config core.repositoryformatversion=3D0
>> =C2=A0 .git/config core.bare=3Dfalse
>> =C2=A0 [etc]
>>
>> (you would use the "-z" form, of course, and the filenames would be
>> NUL-separated, but I made up a human-readable output format above fo=
r
>> illustration purposes).
>
> That would be _very_ nice to have (even without includes support).

I like this as well.

Thanks for digging deep into this one, Jeff.  You've convinced me that
not following includes is the better default behavior.

You are correct in mentioning that what was really missing was
something akin to "git config --repo --list".  Since that command
would be a shortcut for "-f .git/config" then it would be consistent
in behavior.  The suggestion to have the app understand .[include]
path =3D and show separate panes for included files is an elegant
solution and definitely helpful for power users.  I do have to write
more code but that's fine since it enables new functionality.

Jeff, you mentioned possibly adding a "backwards-compatible way" of
accessing this stuff and hiding it behind an environment variable.  I
don't want to make us carry around backwards compat code paths just
for one particular use case so perhaps the best thing would be for me
to start preparing for this change now.  I already have various places
where functionality is guarded behind a git version check.  If what
we're talking about is git-cola adding "--include" when git >=3D 1.8(?)
then that works for me.

It should be noted that git-gui also uses `git config --global --list`
so I don't know if this has implications there.  E.g. maybe things
like user.name won't be overridden if done via an included config
there.

RE: the caching -- we call git config a few times in various places.
Getting the user.* fields.  Getting the diff.summary settings, etc.  I
started tweaking app startup for speed and noticed all the git-config
calls and was able to replace a handful of calls with a single call,
which was nice.  The difference is more pronounced on win32 (I am a
linux user but I do try to play nice with the msysgit folks).

Thanks Jeff,
--=20
David
