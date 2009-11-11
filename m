From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: P4 Sync problem
Date: Wed, 11 Nov 2009 13:00:39 +0100
Message-ID: <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com>
References: <loom.20091110T145046-137@post.gmane.org>
	 <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>
	 <loom.20091111T100646-406@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 13:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8BsV-00075o-Ti
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 13:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200AbZKKMAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 07:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757147AbZKKMAf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 07:00:35 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44225 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986AbZKKMAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 07:00:35 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so913076fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cr8GLEtmN/1T6M0QQv0bfhEzn3wCBvbX8Zh5qN3Y5eE=;
        b=hW9oyznSA+6owhlP+1gQkAp8rp2IEHTH4vbEa9kMMrTaIOB5XjUL8yph6gPrc8DeuP
         DY4lXrjgiz8DPU54shCmbdxW00rdn0vTsUx79hmHm7TGj+Yn+vA/jotvFpWg31RuRNOL
         mN+N7jzCDoUK7N8JMezpZwsD44HDOqNyLfAvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xClrJ0W9Fyo/M1mVZM6WHn90ieko8RLMp6L2oD2skEJvomS5Juc/0A+sFMCBVbP4QS
         Wt9nDJRwXnu4dJ489zwcuJGmy7chSSHRTk9rH5Kf90ahRqglJxZuwJqgaFgxfgqnv79B
         S18bsro0idzJDuuWiuqwVk2eRHpbzkrD8iWEs=
Received: by 10.239.145.29 with SMTP id q29mr148853hba.127.1257940839947; Wed, 
	11 Nov 2009 04:00:39 -0800 (PST)
In-Reply-To: <loom.20091111T100646-406@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132642>

On Wed, Nov 11, 2009 at 10:43 AM, Dmitry Smirnov <divis1969@gmail.com> =
wrote:
> Tor Arvid Lund <torarvid <at> gmail.com> writes:
>
>> Hi. So - I think the problem is that git-p4 doesn't understand what =
it
>> is you want to sync.
>
> I believe it will never understand that until self.depotPaths
> will be initialized.

Correct.

> It looks like it is intitilized from argument list only (or from alre=
ady saved
> settings). See P4Sync.run().

Also correct, me thinks.

> But self.getClientSpec() which is called some time before, does not i=
nit neither
> self.depotPaths nor args.

Correct again. The useclientspec flag was created (by me) as a simple
way to filter out files that I did not want to download (the reason
being my company tends to mix binaries with source files causing
unnecessary long sync times). So it was never used to tell git-p4
_what_ to sync, but rather what to _not_ sync.

So - in your case, you could have tried to just say "git p4 sync
//depot@all", and if your clientspec contained, say, only
"//depot/path/projectX", then projectX should be the only thing that
got downloaded. Keep in mind, though, that git-p4 would still ask the
p4 server for _all_ of its changelists, loop through them, and check
each file in each changelist against the clientSpecDirs array...

> I had fixed this with the following code (new lines marked with +):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.useClientSpec or gitConfig("git-p4=
=2Euseclientspec") =3D=3D "true":
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "Get c=
lient spec"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.getClientSpec()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.verbose:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "Clien=
t Spec Dirs: %s" % self.clientSpecDirs
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if len(args) =3D=3D 0:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for item in =
self.clientSpecDirs:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0k,v =3D item
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0args.append(k)

Well, I see what you're trying to do, but I would not want to see that
patch in the official script, because some (most?) people (myself, at
least) use git-p4 to clone single projects out of a perforce depot
that may contain many projects. I do this myself by doing:

git p4 clone //depot/path/to/projectX@all

I usually use one clientspec in perforce, and I do not want to change
that... With your patch, I would be in trouble since my clientspec
contains "//depot/..." (followed by a lot of lines starting with '-')

> Unfortunately, this fails on another stage:
>
>>git p4 sync --verbose
<snip>
> Opening pipe: p4 -c MYCLIENT-G files <my paths here appended with ...=
#head >
> p4 returned an error: //MYCLIENT/path/file.c/...#head> - file(s) not =
in client
> view.
>
> My client spec contains some line to the file:
> -//depot/path/... //MYCLIENT/null/...
> //depot/path/file.cs //MYCLIENT/path/file.cs
>
> This means that I wish to sync only file.cs into my client and get ri=
d of other
> files in this directory.
> BTW, note that file extension is truncated in the log

Yep - this is a bug (or lack of a feature, if you will...). The
clientspec functionality in git-p4 supports directories only. If you
look at the getClientSpec function, you see that it looks for "...".
It's probably an easy fix if you want to support having single files
in the client spec. I didn't (and don't) need it, so it didn't occur
to me at the time...

If you want to fix it, you might want to rename clientSpecDirs to
clientSpecEntries or something like that.

Btw... Am I understanding correctly what it is you wish to accomplish?
I'm guessing that you have a perforce server with a client spec set
up, and you want to sync everything on the entire server according to
that client spec?

-Tor Arvid-
