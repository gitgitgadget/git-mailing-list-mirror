From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Wed, 26 Oct 2011 11:18:51 +1100
Message-ID: <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com> <7vd3dk516p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 02:19:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIrDL-0006SR-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 02:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab1JZATX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 20:19:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47097 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1JZATW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 20:19:22 -0400
Received: by bkbzt19 with SMTP id zt19so1095320bkb.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 17:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=13QkJOjmtGzOwJKz8foiSouWJBYJ7q/J/lIXr/xR1mY=;
        b=VqhV9l+f5Flw7zgOBY21ohzHRf4RaePRXqi/KJh1ihh7qhfLk77cJNo5Snoanbw6uQ
         ylm8dmdlcql0lSSeddHenmRbM/nL2ydqxVrlSah+bvosrgTt3Kz9DwM7vFcRBZkdrdez
         DvuYnGzDnEELCLNC/ly6fNLNoymYaBUvIN1Pc=
Received: by 10.204.154.149 with SMTP id o21mr21965782bkw.84.1319588361247;
 Tue, 25 Oct 2011 17:19:21 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Tue, 25 Oct 2011 17:18:51 -0700 (PDT)
In-Reply-To: <7vd3dk516p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184244>

2011/10/26 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> In this case, "foo" is considered a submodule and bar, if added,
>> belongs to foo/.git. "git add" should only allow "git add foo" in th=
is
>> case, but it passes somehow.
>
> I do not think the above description is correct.
>
> The test:
>
> =C2=A0- populates the current directory;
> =C2=A0- makes a clone in ./clone2;
> =C2=A0- creates a file clone2/b;
> =C2=A0- runs "git add clone2/b" with GIT_DIR set to clone2/.git, with=
out
> =C2=A0 setting GIT_WORK_TREE nor having core.worktree in clone2/.git/=
config.
>
> The last step should add a path "clone2/b" to $GIT_DIR/index (which i=
s
> clone2/.git/index in this case). =C2=A0The clone2 is not a submodule =
to the top
> level repository in this case, but even if it were, that would not ch=
ange
> the definition of what the command should do when GIT_DIR is set with=
out
> GIT_WORK_TREE nor core.worktree in $GIT_DIR/config.

Now look from "git add" perspective, it does not really care where
$GIT_DIR is. It assumes that $(pwd) is working directory's top. So it

 - reads content of current directory, it sees "clone2" as a directory
 - it descends in and see ".git" so "clone2" must be a git link
 - because clone2 is a separate repository (again $GIT_DIR is not
consulted), "b" should be managed by "clone2"
 - so it stops.

This is the only place I see a submodule (from the first glance) is
actually top level repository. Yes I guess we can support this, but
it's just too weird to be widely used in pratice..

> Running (cd clone2 && git add b) is a _more natural_ thing to do, and=
 it
> will result in a path "b" added to the clone2 repository, so that the
> result is more useful if you are going to chdir to the repository and=
 keep
> working on it. =C2=A0But that does not mean the existing test is inco=
rrect. It
> does not just pass somehow but the test passes by design.
>
> I did not check if later tests look at the contents of commit "new2" =
to
> make sure it contains "clone2/b", but if they do this change should b=
reak
> such tests.
>
> So I am puzzled by this change; what is this trying to achieve?
--=20
Duy
