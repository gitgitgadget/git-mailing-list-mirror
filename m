From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 1 Aug 2011 16:45:03 +0200
Message-ID: <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net>
 <20110728170222.GB15931@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 16:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qntkb-00086o-Pq
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 16:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab1HAOpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 10:45:45 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55730 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab1HAOpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 10:45:44 -0400
Received: by yxi11 with SMTP id 11so3168875yxi.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=rWLL5f0itcpY94xX6O8hJPa22KxpbMVClMFxIWwD8cs=;
        b=jcsPWr7LPs4xlapj6DusLlg+fZcvJWAQeCAi/PHRPEKHR2596Mw75hJXH8B9EmFVfZ
         MY8kwCuyVSuM3mT1eYpartOUcrrBmcM7KIvQhEgaWGRtRNo1RtBjuZRHh0uXSmhVrNA+
         Wzxao8advKUtcpbMPueE6vQJcDA7mhEVtFw38=
Received: by 10.68.29.5 with SMTP id f5mr8163197pbh.482.1312209943030; Mon, 01
 Aug 2011 07:45:43 -0700 (PDT)
Received: by 10.68.56.65 with HTTP; Mon, 1 Aug 2011 07:45:03 -0700 (PDT)
In-Reply-To: <20110728170222.GB15931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178346>

On Thu, Jul 28, 2011 at 7:02 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 28, 2011 at 10:47:58AM -0600, Jeff King wrote:
>
>> Ah, nevermind. I see now; the command-line option interface to "git
>> archive" is not as rich as what you can pass via write_archive.
>>
>> I think you can get around it by adding an option to "git archive" t=
o
>> indicate that we are filling a remote request, which is the only
>> extra information that my series adds.
>
> And that patch would look something like the one below.

This is the most straight forward way of doing this, thanks. I'll post
a new version with this squashed in soon.

What's the proper way of attributing you for the work?

> You can also now
> drop the "remote" parameter to write_archive entirely, but I didn't d=
o
> so here.

I'm not entirely sure how you propose we do this... do you mean by
hoisting the relevant logic from write_archive up to cmd_archive or
something?

> Applied on top of the merge of your series into next, this
> passes t5000.

Unfortunately, it doesn't pass on Windows, but this doesn't seem to be
directly related to the remote-stuff: Here's the tests that fail:


$ make t5000-tar-tree
*** t5000-tar-tree.sh ***
ok 1 - populate workdir
<snip>
ok 53 - infer tgz from .tar.gz filename
not ok - 54 extract tgz file
#
#               $GUNZIP -c <j.tgz >j.tar &&
#               test_cmp b.tar j.tar
#
not ok - 55 remote tar.gz is allowed by default
#
#               git archive --remote=3D. --format=3Dtar.gz HEAD >remote=
=2Etar.gz &&
#               test_cmp j.tgz remote.tar.gz
#
ok 56 - remote tar.gz can be disabled
# failed 2 among 56 test(s)
1..56
make: *** [t5000-tar-tree.sh] Error 1

It seems "git archive --format=3Dtgz HEAD" is broken on Windows:
$ git archive --format=3Dtgz HEAD > j.tgz
$ gunzip -c j.tgz > j.tar && echo ok

gzip: j.tgz: invalid compressed data--format violated

But if I perform the compression manually, the archive is fine:
$ git archive --format=3Dtar HEAD | gzip -cn > j.tgz
$ gunzip -c j.tgz > j.tar && echo ok
ok

So, the big question is, are all tar-filters broken on Windows? It
seems not; the tests for the foo-filter works fine... any clues? Could
it somehow be newline-related, perhaps?

>
> -Peff
>
> ---
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 883c009..6668340 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -85,6 +85,7 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
> =A0 =A0 =A0 =A0const char *exec =3D "git-upload-archive";
> =A0 =A0 =A0 =A0const char *output =3D NULL;
> =A0 =A0 =A0 =A0const char *remote =3D NULL;
> + =A0 =A0 =A0 int is_remote =3D 0;
> =A0 =A0 =A0 =A0struct option local_opts[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_STRING('o', "output", &output, "fi=
le",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"write the archive to =
this file"),
> @@ -92,6 +93,9 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"retrieve the archive =
from remote repository <repo>"),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_STRING(0, "exec", &exec, "cmd",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"path to the remote gi=
t-upload-archive command"),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { OPTION_BOOLEAN, 0, "remote-request", =
&is_remote, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "indicate we are servin=
g a remote request",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PARSE_OPT_NOARG | PARSE=
_OPT_HIDDEN },
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_END()
> =A0 =A0 =A0 =A0};
>
> @@ -106,5 +110,5 @@ int cmd_archive(int argc, const char **argv, cons=
t char *prefix)
>
> =A0 =A0 =A0 =A0setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
>
> - =A0 =A0 =A0 return write_archive(argc, argv, prefix, 1, output, 0);
> + =A0 =A0 =A0 return write_archive(argc, argv, prefix, 1, output, is_=
remote);
> =A0}
> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 0c192b5..c57e8bd 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -27,8 +27,9 @@ static void prepare_argv(const char **sent_argv, co=
nst char **argv)
> =A0 =A0 =A0 =A0int len;
>
> =A0 =A0 =A0 =A0/* put received options in sent_argv[] */
> - =A0 =A0 =A0 sent_argc =3D 1;
> + =A0 =A0 =A0 sent_argc =3D 2;
> =A0 =A0 =A0 =A0sent_argv[0] =3D "archive";
> + =A0 =A0 =A0 sent_argv[1] =3D "--remote-request";
> =A0 =A0 =A0 =A0for (p =3D buf;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* This will die if not enough free sp=
ace in buf */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D packet_read_line(0, p, (buf + =
sizeof buf) - p);
>
