From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Mon, 10 Feb 2014 17:37:16 +0700
Message-ID: <CACsJy8A9JxDWhEWpdUUL_6tTJZvmf93Ga_nPt09yUzG44mc-Qg@mail.gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de>
 <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com> <52F7E2BC.5030905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 10 11:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCoFu-0004Wz-C2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 11:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbaBJKiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 05:38:20 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:51456 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbaBJKhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 05:37:47 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so9281742qae.27
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 02:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7dqGg5q22xC9hKJClHeazGZLGyL+UjRGLeeQJPH2Qr4=;
        b=RwNHBnFBoTzV8Iyvz0k0P94sO9FMNnTc2g1OWSc1RsTBEO2Dnb11nGLelIZfobYqK4
         TqQvWfaoECIgs1ojfapfPRb8j2byyyoU96al0lAyzO5EXcjsA5Q6Vxb9g9DSyZwIK5fO
         hUrSH3k7CFdImK7gRwgWq3F+8S+Pw7lHJ7k4/PPiFs88p+hjuMf36V9PqEjZHi0jMTQi
         7MpWSy8D5VvcMZ+bvGLaV0d4q17HXWUSq6QLm3/SzdCgGO77BtJzJ9FBeEQ7YZxQYv8J
         j8sK/Z//13LXTct1Bh8kn7347yqkC/UUxS7YMZSf5l/Lnn8Ir2k2+1c+VihMKDc343/D
         rYJQ==
X-Received: by 10.224.49.69 with SMTP id u5mr46466850qaf.88.1392028666676;
 Mon, 10 Feb 2014 02:37:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 10 Feb 2014 02:37:16 -0800 (PST)
In-Reply-To: <52F7E2BC.5030905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241906>

On Mon, Feb 10, 2014 at 3:19 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Please see filewatcher.c:
> +       if (daemon) {
> +               int err;
> +               strbuf_addf(&sb, "%s/log", socket_path);
> +               err =3D open(sb.buf, O_CREAT | O_TRUNC | O_WRONLY, 06=
00);
> +               adjust_shared_perm(sb.buf);
> (And now we talk about the logfile:
> "In daemon mode, stdout and stderr are saved in $WATCHER/log."
> It could be nice to make this feature configrable,
> either XXX/log or /dev/null.
> On the long run we may eat to much disc space on a machine.
> The other thing is that we may want to seperate stdout
> from stderr, but even this is a low prio comment.

I probably should follow git-daemon and put these to syslog.

> ----------------
> There is a small issue when I tested on a machine,
> where the "data directory" called "daten" is softlinked to another di=
sk:
> daten -> /disk3/home2/tb/daten
>
> and the "projects" directory is softlinked to "daten/projects"
> projects -> daten/projects/
>
> t7514 fails like this:
> --- expect      2014-02-08 14:37:07.000000000 +0000
> +++ actual      2014-02-08 14:37:07.000000000 +0000
> @@ -1,6 +1,6 @@
>  packet:          git> hello
>  packet:          git< hello
> -packet:          git> index 6cb9741eee29ca02c5b79e9c0bc647bcf47ce948=
 /home/tb/projects/git/tb/t/trash directory.t7514-file-watcher-lib
> +packet:          git> index 6cb9741eee29ca02c5b79e9c0bc647bcf47ce948=
 /disk3/home2/tb/daten/projects/git/tb/t/trash directory.t7514-file-wat=
cher-lib
>
> Could we use relative path names internally, relative to $GIT_DIR ?

No because this is when the client tell the server about $GIT_DIR. I
guess we can use realpath(1) here.

> -------------------
> Another thing:
> Compiling under Mingw gives this:
>     LINK git-credential-store.exe
> libgit.a(file-watcher-lib.o): In function `connect_watcher':
> c:\Dokumente und Einstellungen\tb\projects\git\tb/file-watcher-lib.c:=
21: undefined reference to `unix_stream_connect'
> collect2: ld returned 1 exit status
> make: *** [git-credential-store.exe] Error 1
>
> We may need a compiler option like HAS_UNIX_SOCKETS or so.

I'll make unix-socket.o build unconditionally and return error at runti=
me.

> --------------------------
> +++ b/file-watcher.c
>
> +#define INOTIFY_MASKS (IN_DELETE_SELF | IN_MOVE_SELF | \
> +                      IN_CREATE | IN_ATTRIB | IN_DELETE | IN_MODIFY =
|  \
> +                      IN_MOVED_FROM | IN_MOVED_TO)
> This feels confusing:
> a) we have inotify_masks with lower case below.
> b) how about INOTIFY_NEEDED_BITS ?
> ---------------

OK

> I'm OK with having the protocol having specified in the
> test cases.
> One thing that I have on the wish list is to make the
> commands/responses more unique, to be able to run grep
> on the code base.
>
> One idea could be to use a prefix
> "fwr" for "file watcher request" or
> "fwr" for "file watcher response".
> This does not work, hihi, so
>
> "fwq" for "file watcher reQuest" and
> "fwe" for "file watcher rEsponse".
> Or
> "ffw" as "from file watcher" and
> "tfw" as "to file watcher" for the people who have problems
> with left and right, < and > could work.

If you want I can update test-file-watcher to accept "send<" and
"recv>" instead of "<" and ">", respectively. The only command with
the same name for response and request is "hello". I can make it
"hello" and "helloack" (or "bonjour" as response?).
--=20
Duy
