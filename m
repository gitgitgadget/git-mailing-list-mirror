From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Add repos but not as normal files, not submodule
Date: Wed, 14 Apr 2010 04:36:03 -0500
Message-ID: <20100414093603.GA29065@progeny.tock>
References: <BFCA0C1E-FBE0-4CE6-8018-704BC5E0ACA6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, illegalargument@googlegroups.com
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 11:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1z12-0004rP-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0DNJgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 05:36:06 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:65156 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0DNJgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 05:36:05 -0400
Received: by pzk42 with SMTP id 42so5443236pzk.4
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VpktglBmap+OqB2Nfy87ACV1nrdyNh68RzDWB1r6Heg=;
        b=vVV6A2wtA8Fn/22fb2VVIC0R7NoslTnoU7/DsDvJFsOgUCzKQY2t5oJIEVKHkT6EWz
         Gve3NzevatQZnKpp681KtZQGWbX1onAl3WjdefYctAPUTCJSQXfXHQgjE1fsmbb4/t87
         eSgjxbwGu1hzbyuFExKUPJeZHJL0XZbeU/aBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=B9QuoIRJCIyS5KHvdq2TFWlFiNotytK516bhZ1Uzjkok3ODZ8KEGVddiqCww2OvTFq
         q3FWye8Kh6KOFN9JihplHEz5QBNNZ90zc5ppZaErOeLh9J8BCMqdcJV3qZWaG/qBY7it
         0SaDWYAYyn02aF0JxiUM24nE+brp9vouAv8NE=
Received: by 10.141.100.21 with SMTP id c21mr3796058rvm.101.1271237764303;
        Wed, 14 Apr 2010 02:36:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm154399iwn.2.2010.04.14.02.36.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 02:36:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BFCA0C1E-FBE0-4CE6-8018-704BC5E0ACA6@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144859>

Hi,

Antony Stubbs wrote:

> I have a special situation (maven git scm provider) where I have sub
> directories with git repps in them which I use as data to run tests
> on.=20
>=20
> Is it possible to track these "internal" repos without using submodul=
es?=20

=46irst I should say that whatever I say below is about git of the
present, not git of the future.  In other words, if you have a patch
that would change this without breaking things, go for it.

Okay, so why does git not allow adding files or directories named
=2Egit?

The first hint is in dir.c:

| /*
|  * Read a directory tree. We currently ignore anything but
|  * directories, regular files and symlinks. That's because git
|  * doesn't handle them at all yet. Maybe that will change some
|  * day.
|  *
|  * Also, we ignore the name ".git" (even if it is not a directory).
|  * That likely will not change.
|  */
| static int read_directory_recursive(struct dir_struct *dir,

Odd, yes?

| $ git log -S'Also, we ignore the name ".git" (even if' --follow -- di=
r.c
| commit 453ec4bdf403c2e89892266a0a660c21680d3f9d
| Author: Linus Torvalds <torvalds@osdl.org>
| Date:   Tue May 16 19:02:14 2006 -0700
|=20
|     libify git-ls-files directory traversal
|=20
|     This moves the core directory traversal and filename exclusion lo=
gic into
|     the general git library, making it available for other users dire=
ctly.
[...]
| $ git name-rev --tags 453ec4bdf403c2e89892266a0a660c21680d3f9d
| 453ec4bdf403c2e89892266a0a660c21680d3f9d tags/v1.4.0-rc1~79^2~8
| $ git diff v1.4.0-rc1~80..v1.4.0-rc1~79
[...]
| --- a/update-index.c
| +++ b/update-index.c
| @@ -120,70 +120,6 @@ static int add_file_to_cache(const char *path)
|  	return 0;
|  }
| =20
| -/*
| - * We fundamentally don't like some paths: we don't want
| - * dot or dot-dot anywhere, and for obvious reasons don't
| - * want to recurse into ".git" either.
| - *

So much for origins.  Starting out, it was easier to ignore all files
named .git than just the .git directory.

Of course, a lot has changed since then.  For example, consider the
following:

 ; git init foo
 ; cd foo
 ; mkdir bar
 ; >bar/.git
 ; git add .
 fatal: Invalid gitfile format: bar/.git

Adding an abort() to die_routine() and grabbing a back trace from the
core dump reveals that this comes from

| $ git log -S'if (resolve_gitlink_ref(dirname, "HEAD", sha1) =3D=3D 0)=
' -- dir.c
| commit 095952585c2a955f45deac69df17a702d7584c80
| Author: Linus Torvalds <torvalds@linux-foundation.org>
| Date:   Wed Apr 11 14:49:44 2007 -0700
|
|     Teach directory traversal about subprojects
|
|     This is the promised cleaned-up version of teaching directory tra=
versal
|     (ie the "read_directory()" logic) about subprojects. That makes "=
git add"=20
|     understand to add/update subprojects.
[...]
| $ git name-rev --tags 095952585c2a955f45deac69df17a702d7584c80
| 095952585c2a955f45deac69df17a702d7584c80 tags/v1.5.2-rc0~19^2~9

In other words, if bar is itself a git repository with a valid HEAD,
then =E2=80=98git add bar=E2=80=99 will register it in the index as a s=
ubmodule.

I should also mention the problem of finding the right git directory:
if foo and foo/bar are git trees and you try the following from the
foo directory, what should happen?

 ; git add bar/something

How about the following?

 ; (cd bar && git add something)

The answers are less ambiguous with submodules.

> The only alternative I see is to compress all the test repos in an
> archive and track that - but that's not nice.

If the concern is making it pack nicely, you can use an uncompressed
tar file for each test (or shar, or whatever your favorite
uncompressed format is).  Still ugly, but it should work okay.

If you can rely on build systems to have git installed, I=E2=80=99d sug=
gest
writing a simple script to build the test repository from scratch.

You can also try using repositories not named .git if you are careful.
I don=E2=80=99t really encourage this.

> The reason I don't want to do submodules is that I don't want to
> have the submodules as serperate projects as such, because they're
> not. they're "test data" so to speak.

Yes, makes sense to me.

Hope that helps,
Jonathan
