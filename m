From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Multiple threads of compression
Date: Sun, 25 Nov 2012 18:37:02 -0800
Message-ID: <CA+sFfMerMWnJwiBz0=MxO0gn8B2M8g12mt5VzZaRj591oMPVow@mail.gmail.com>
References: <loom.20121125T171702-64@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thorsten Glaser <tg@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 03:37:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcoZY-0005yG-Q3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 03:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2KZChF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 21:37:05 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34219 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab2KZChE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 21:37:04 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5177973vbb.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 18:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uRmdfIbcPIMgj53kGnEdgnvSJFYU8A1gb89fwDEmmq0=;
        b=n96KlnTJYogvrqH7ddMBAcOZzKRRnnY5NMi+qXh1ySuVywcio+TGiPjbzsmZja3ZHb
         tJ8uvBk4+vpm4PWhqPV+//5xwx99MkiBi6KP9a6hs8TqbBkg/J7tBIcyQ6RGGj+WgaR+
         32Gu2L8dIEnq8DUui2xdYBDmiUInubo1+A00Wcdwfo+jWOSkRo9VkDRe6CGFMEneSV6e
         6kkKJTfnyl/VnJ6w64/KM4aWpPM9/5/+W83PbHQTcBoDAueqkwHRfyGDTOOc/NdrBJLY
         oyuZOiv14XIETEjyYh3abGgFRqL7RINqepWVD97ZZosAvkPRcNqbac1vsuipMT9NUvdF
         08KA==
Received: by 10.58.200.39 with SMTP id jp7mr17674111vec.26.1353897422870; Sun,
 25 Nov 2012 18:37:02 -0800 (PST)
Received: by 10.58.143.5 with HTTP; Sun, 25 Nov 2012 18:37:02 -0800 (PST)
In-Reply-To: <loom.20121125T171702-64@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210402>

On Sun, Nov 25, 2012 at 8:27 AM, Thorsten Glaser <tg@debian.org> wrote:

> tl;dr: I would like to have a *global* option for git to restrict
> the number of threads of execution it uses. Several subcommands,
> like pack-objects, are already equipped with an optioin for this,
> but unfortunately, these are seldom invoked by hand=C2=B9, so this ca=
n=E2=80=99t
> work in my situations.

See the git-config man page.

The number of threads that pack uses can be configured in the global
or system gitconfig file by setting pack.threads.

e.g.

   $ git config --system pack.threads 1

Also, modern git accepts a '-c' option which allows you to set
configuration options on the command line, e.g. 'git -c pack.threads=3D=
1
gc'.

The other setting you should probably look at is pack.windowMemory
which should help you control the amount of memory git uses while
packing.  Also look at core.packedGitWindowSize and
core.packedGitLimit if your repository is really large.

>
> =E2=91=A0 automatic garbage collection, =E2=80=9Cgit gc --aggressive =
--prune=3Dnow=E2=80=9D,
>   and cloning are the use cases I have at hand right now.
>
> =C3=80 propos, while here: is gc --aggressive safe to run on a live,
> online-shared repository, or does it break other users accessing
> the repository concurrently? (If it=E2=80=99s safe I=E2=80=99d very m=
uch like to do
> that in a, say weekly, cronjob on FusionForge, our hosting system.)

Running 'git gc' with --aggressive should be as safe as running it
without --aggressive.

But, you should think about whether you really need to run it more
than once, or at all.  When you use --aggressive, git will perform the
entire delta search again for _every_ object in the repository.  The
general usecase for --aggressive is when you suspect that the original
delta search produced sub-optimal deltas or if you modify the size of
the delta search window or depth and want to regenerate your packed
objects to improve compression or access speed.  Even then, you will
not likely get much benefit from running with --aggressive a second
time.

hth,
-Brandon
