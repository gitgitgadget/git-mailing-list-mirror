From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with EACCES
Date: Wed, 14 Dec 2011 15:31:25 +0100
Message-ID: <CAH6sp9Mf=EjkVN9mDN59ZCxCU0sCFLa8E=7YxM1J8LCCMr=xYQ@mail.gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
	<1323788917-4141-1-git-send-email-fransklaver@gmail.com>
	<1323788917-4141-2-git-send-email-fransklaver@gmail.com>
	<7vliqguwhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 15:31:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raprq-00051H-0C
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab1LNOb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:31:26 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60959 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1LNObZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:31:25 -0500
Received: by qcqz2 with SMTP id z2so524187qcq.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oe3uJac3BA+ED75EAZ2/+3dzLS/Sk6sZoVc4apmPt1E=;
        b=LLaJfHCygdFcIEBkvF9hVc+CGa4su9alU8fHFLv6ZMnZnc1oLjr5Mu78t6eySJLBhI
         vwAnXOIvm+rc3La+dWcqlFsyufKf86BNrPJzPtmyVeVushQW6qDz83BkaTGfIsfhpEYS
         YTPPTUx+Aq+uBS/OIqh4n9+mWYVQZLZaMqpao=
Received: by 10.224.116.144 with SMTP id m16mr9894226qaq.19.1323873085150;
 Wed, 14 Dec 2011 06:31:25 -0800 (PST)
Received: by 10.224.76.82 with HTTP; Wed, 14 Dec 2011 06:31:25 -0800 (PST)
In-Reply-To: <7vliqguwhq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187121>

On Tue, Dec 13, 2011 at 8:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:

>
> =C2=A0- That "have_..._ions()" is too long and ugly.

I half expected that one and I agree. I vaguely remember typing it,
deleting it and typing it again when I started on that one.


>
> =C2=A0- The only thing you care about this callsite is if you have en=
ough
> =C2=A0 permission to execute the "cmd".
>
> In fact, you should not unconditionally require read permissions here=
=2E
>
> =C2=A0 =C2=A0$ chmod a-r $(type --path git) && /bin/ls -l $(type --pa=
th git)
> =C2=A0 =C2=A0--wx--x--x 109 junio junio 5126580 Dec 13 09:47 /home/ju=
nio/git-active/bin/git
> =C2=A0 =C2=A0$ /home/junio/git-active/bin/git --version
> =C2=A0 =C2=A0git version 1.7.8.249.gb1b73
>
> You may need read permission when the file is a script (i.e. not bina=
ry
> executable).
[...]
> When checking if you can run "foo/bar/baz", directories "foo/" and "f=
oo/bar/"
> do not have to be readable. =C2=A0They only have to have executable b=
it to allow
> descending into them, and typically this is called "searchable" (see =
man chmod).
>
> =C2=A0 =C2=A0$ mkdir -p /var/tmp/a/b && cp $(type --path git) /var/tm=
p/a/b/git
> =C2=A0 =C2=A0$ chmod 111 /var/tmp/a /var/tmp/a/b
> =C2=A0 =C2=A0$ /var/tmp/a/b/git --version
> =C2=A0 =C2=A0git version 1.7.8.249.gb1b73
>
> I'd suggest having two helper functions, instead of the single one wi=
th
> overlong "have...ions" name.
>
> =C2=A0- can_search_directory() checks with access(X_OK);
>
> =C2=A0- can_execute_file() checks with access(X_OK|R_OK), even though=
 R_OK is
> =C2=A0 not always needed.

On the whole I like the suggestion. We should probably take it a bit
further. Since the x and r bits basically have nothing to do with each
other, and we need +rx only on scripts, I could just rely on fopen()
for the +r check. I will still add the can_execute_file() and
can_search_dir() helpers to support readability, as access(path, X_OK)
means different things in the different contexts. I would then
probably go for is_searchable() and is_executable() as function names.
is_executable then means "is file and has executable flag set",
is_searchable means "is directory and has executable flag set".
Basically files won't be searchable and directories won't be
executable. If execvp fails on a command that is executable, but not
readable, it is definitely a script and we can generate an error in
that case. 1/2 would then probably use access(path, R_OK), while 2/2
would start using fopen.

Since fopen() uses the effective uid/gid, it then makes sense to use
eaccess(3) instead of access(2) if available. It would be stupid to
have bugs arise just because of a mismatch between the [ug]ids used by
the two access checks. I'm aware of the fact that eaccess isn't a
standard function, so a #define HAVE... fallback to at least access()
would probably be required.


>
> Use the former here where you check the directory that contains the
> command, and use the latter up above where you check the command that=
 is
> supposed to be executable, and also down below after you checked sb.b=
uf is
> a path to a file that may be the command that is supposed to be
> executable.
>
> Then patch 2/2 can extend can_execute() to enhance its support for sc=
ripts
> by reading the hash-bang line and validating it, etc.

I'd rather keep the hash-bang check outside of that function and use
can_execute/is_executable for checking the interpreter as well, if
only for keeping the possibility of easily promoting them into an API.

I'd rather move check_interpreter into where it's called now, but pull
out the logic to find the interpreter. This will keep the error text
generation in diagnose_execvp_eacces. I think the code will make more
sense this way. There's tons of more errors that can be caused by a
faulty interpreter, and it'll be easier to cover more cases this way
in the future.

Thanks for the insightful reviews so far.

Let me know what you think,
=46rans
