From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 08/10] dir: simplify untracked cache "ident" field
Date: Wed, 30 Dec 2015 18:20:25 +0100
Message-ID: <CAP8UFD1LdPODnfsesLO+HzGeTg0WvzcvSeq6Hy4-Eb+yLdBqnA@mail.gmail.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
	<5683C463.9010003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 18:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEKQK-0001wD-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 18:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbbL3RU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 12:20:29 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34066 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbbL3RU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2015 12:20:27 -0500
Received: by mail-lf0-f44.google.com with SMTP id y184so229107103lfc.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sp4fB8Ohnb7ito+DyU0gyrPd5sznfyKjmAIGjN/j7iI=;
        b=JjF3NR9oeqT1lAr/ir8RnPu8jxX8/NfAiPiBrucH/zXErqw4X1UMM5iPgFm9yfTEWn
         yFN0QQK71lbN1hszJaHle0T94CRph5Vn/gnaK4R7cePjfUenBaGkjNbbfe1Zgokqzuww
         Yf3BRrvR7Mio7o8A3mDPu0hGaASWmNNvI7mIrlFCwyLAtczKUx6L1e/ffNKycqBpq18t
         60J+5O/q764lLCnDkRktOTulazh6sNUmLMfH2+yF4pJeRXnpvKPqbVUCWs3s6Ddtchk5
         l6GVdrK11CmPbtTPJhw4PKfN4rlb63xlW4KVdlBnx1D99X3Ahm4IYccTcXQTmH0mCIEd
         uqwg==
X-Received: by 10.25.35.143 with SMTP id j137mr3924661lfj.36.1451496025749;
 Wed, 30 Dec 2015 09:20:25 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 30 Dec 2015 09:20:25 -0800 (PST)
In-Reply-To: <5683C463.9010003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283189>

On Wed, Dec 30, 2015 at 12:47 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2015-12-29 08.09, Christian Couder wrote:
>> It is not a good idea to compare kernel versions and disable
>> the untracked cache if it changes as people may upgrade and
>> still want the untracked cache to work. So let's just
>> compare work tree locations to decide if we should disable
>> it.
> OK with that.
>>
>> Also it's not useful to store many locations in the ident
>> field and compare to any of them. It can even be dangerous
>> if GIT_WORK_TREE is used with different values. So let's
>> just store one location, the location of the current work
>> tree.
> I don't think I fully agree in all details.

Suppose I use "git update-index --untracked-cache" first with
GIT_WORK_TREE=3D/foo and then with GIT_WORK_TREE=3D/bar. It will store
both /foo and /bar as valid locations for the worktree in the "ident"
field.

Then I work a bit with GIT_WORK_TREE=3D/foo and then a bit with
GIT_WORK_TREE=3D/bar. Now does the untracked cache info in the index
reflect the state of /foo or the state of /bar?

With a config variable, the problem is worse, because, as we
automatically add the untracked cache when git status is used, we are
even less likely to pay attention to GIT_WORK_TREE when the cache is
added.

> The list is there to distinguish between different clients when shari=
ng
> a Git workspace over a network to different clients:
>
> A file system is exported from Linux to Linux via NFS,
> including a Git workspace)
> The same Workspace is exported via SAMBA to Windows and, in an extrem=
e case,
> AFS to Mac OS.
>
> Other combinations could be
> Linux - SAMBA - Linux
> Linux - AFP - Linux
>
> Mac OS - NFS - Linux
> Mac OS - AFP - Mac OS
> Mac OS - SMB - Linux, Mac OS, Windows
> The list is incomplete (BSD and other Unix is missing),
> there are other combinations of network protocols,
> there are NAS boxes which mostly Linux under the hood, but
> may have vendor specific tweaks.
>
> Now we want to know, which of the combinations work.

In my opinion at this point it is a bit insane to want untracked cache
to work when it is accessed by different clients over the network. It
is much safer to just disable it (with a config option) in this case.
But I am ok to try to improve things for your use case to work if it
doesn't complicate things too much.

> The different clients need to test separately.
> E.g. for a given server:
>
> NFS - Linux
> SMB - Linux
> SMB Windows.
>
> At this point I would agree that the old code from dir.c:
>
> static const char *get_ident_string(void)
> {
>         static struct strbuf sb =3D STRBUF_INIT;
>         struct utsname uts;
>
>         if (sb.len)
>                 return sb.buf;
>         if (uname(&uts) < 0)
>                 die_errno(_("failed to get kernel name and informatio=
n"));
>         strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work=
_tree(),
>                     uts.sysname, uts.release, uts.version);
>         return sb.buf;
> }
> ------------------
> is unneccessary picky, and the sysname should be enough:
>
> strbuf_addf(&sb, "Location %s, system %s", get_git_work_tree(),
> uts.sysname);
>
> The old code did not find out, which network protocol that we used,
> (you need to call "mount", and grep for the directory, and try to get
> the FS information, which may be ext4, btrfs, smbfs, nfs....)
> This is unnecessary complicated, so we endet up in using the path.

I am ok with the change to compare only the location and the system
name. I wonder a bit though if this change is completely backward
compatible.

> If I was a system administrator, (I sometimes am), I would set up a
> bunch of Linux boxes in a similar way, so that the repo is under
> /nfs/server1/projects/myproject
> (and the same path is used for all Linux boxes)
>
> The Windows machines may use something like
> N:/projects/myproject
> or
> //server1/projects/myproject
>
> and Mac OS may use
> /Volumes/projects/myproject
> (If mounted from the finder)
> or
> /nfs/projects/myproject
> (When autofs is used)
>
> I may have missed the discussion somewhat, could you explain why havi=
ng
> different uname/location combinations are not usable at your site ?

I tried to explain above why using a config option to set the
untracked cache implies that you have to be careful at what happens
when people use GIT_WORK_TREE.

But it should be usable if indeed we put only the system name as you
suggest. So I think I will do that.

> How much burden is actually put on your system, and is there a way to=
 keep a
> list of different clients ?

About a list of different client, instead of just one, I don't think
it is sane given the GIT_WORK_TREE problem.

If you really have many clients that should use the untracked cache
with different paths, then what you might want is a set of config
options like this:

[untrackedCache "windows7"]
        enable =3D true
        system =3D Windows
        systemVersion =3D 7
        path =3D C:/my/work/tree
[untrackedCache "windows8"]
        enable =3D true
        system =3D Windows
        systemVersion =3D 8
        path =3D C:/my/windows8/work/tree
[untrackedCache "linux"]
        enable =3D true
        system =3D Linux
        path =3D ~/work/tree

This is much more flexible and visible than a custom string list
inside the untracked cache. But it is overkill for Booking.com's use
case (where the machines use Linux and behave well regarding mtime).
So if you are willing to implement that, then that would be great!

> What I understand is that a kernel update of a Linux machine shouldn'=
t matter,
> but if a machine runs Windows or Linux should matter.

Everything could matter. Some people might want to enable it or
disable it depending on the value of an environment variable or
something.

Instead of trying to think about all that could matter, we should
have, and still should, think about generic and flexible config based
solutions.

Thanks,
Christian.
