From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 3/8] mingw: make failures to unlink or move raise a question
Date: Tue, 14 Dec 2010 23:35:26 +0100
Message-ID: <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Albert Dvornik <dvornik+git@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:35:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdTN-00025d-Th
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108Ab0LNWft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 17:35:49 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:53794 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759055Ab0LNWfs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 17:35:48 -0500
Received: by fxm18 with SMTP id 18so1343490fxm.2
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=W3JB3//D5N0ELhs/xUW+g1Rds2bXHEmbvDQclEq2fLo=;
        b=lkzaxlxeGVKufvr+NFFo8Q4CgW4HdGLcH50ukQZJ8nmuoKv9Bi5y1oC16VOY+dXNg5
         W7yX044gvEQxFuCEm0zWoZVy0VRWSv4wsvtXQlXYDbSxSzQiG0EsXQbp6bcAjavbVoEZ
         oDmBcMKDFMjNhmNXPScTTlE8pxefq2A66f8yY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=V9l3V/QaywHl38kwR0X5URvGcPgsAqqWDvhyvOVJnWLK7i7QYASXLfbJ9lEoZHv2hB
         tZZ6meHk89YgtnsTlyy55rOw0rKR5uDobV12CDp4rugou2ENhAeOPTUzDb4nb0rdKEYG
         X/bCFjlznnMHGHbCJcbHF/1wcl+GKEHtfyAVY=
Received: by 10.223.83.8 with SMTP id d8mr6649191fal.94.1292366146916; Tue, 14
 Dec 2010 14:35:46 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Tue, 14 Dec 2010 14:35:26 -0800 (PST)
In-Reply-To: <20101214222122.GD4084@sandbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163701>

On Tue, Dec 14, 2010 at 11:21 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
> On Windows in case a program is accessing a file unlink or
> move operations may fail. To give the user a chance to correct
> this we simply wait until the user asks us to retry or fail.
>
> This is useful because of the following use case which seem
> to happen rarely but when it does it is a mess:
>
> After making some changes the user realizes that he was on the
> incorrect branch. When trying to change the branch some file
> is still in use by some other process and git stops in the
> middle of changing branches. Now the user has lots of files
> with changes mixed with his own. This is especially confusing
> on repositories that contain lots of files.
>
> Although the recent implementation of automatic retry makes
> this scenario much more unlikely lets provide a fallback as
> a last resort.
>
> Thanks to Albert Dvornik for disabling the question if users can't se=
e it.
>
> If the stdout of the command is connected to a terminal but the stder=
r
> has been redirected, the odds are good that the user can't see any
> question we print out to stderr. =A0This will result in a "mysterious
> hang" while the app is waiting for user input.
>
> It seems better to be conservative, and avoid asking for input
> whenever the stderr is not a terminal, just like we do for stdin.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Albert Dvornik <dvornik+git@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> I have added the sign-off from the squashed commit of Albert and
> Johannes. I hope its ok this way.
>
> =A0compat/mingw.c | =A0 82 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 82 insertions(+), 0 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 52183a7..ac9fb4a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2,6 +2,7 @@
> =A0#include "win32.h"
> =A0#include <conio.h>
> =A0#include "../strbuf.h"
> +#include "../run-command.h"
>
> =A0static const int delay[] =3D { 0, 1, 10, 20, 40 };
>
> @@ -129,6 +130,78 @@ static inline int is_file_in_use_error(DWORD err=
code)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int read_yes_no_answer()

Perhaps "static int read_yes_no_answer(void)" for portability?

> +{
> + =A0 =A0 =A0 char answer[1024];
> +
> + =A0 =A0 =A0 if (fgets(answer, sizeof(answer), stdin)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t answer_len =3D strlen(answer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int got_full_line =3D 0, c;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* remove the newline */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (answer_len >=3D 2 && answer[answer_=
len-2] =3D=3D '\r') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 answer[answer_len-2] =3D=
 '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 got_full_line =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (answer_len >=3D 1 && answer[an=
swer_len-1] =3D=3D '\n') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 answer[answer_len-1] =3D=
 '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 got_full_line =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* flush the buffer in case we did not =
get the full line */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!got_full_line)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while((c =3D getchar())=
 !=3D EOF && c !=3D '\n');
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we could not read, return the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* default answer which is no */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (answer[0] =3D=3D 'y' && strlen(answer) =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 if (!strncasecmp(answer, "yes", sizeof(answer)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 if (answer[0] =3D=3D 'n' && strlen(answer) =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!strncasecmp(answer, "no", sizeof(answer)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

Since you're doing case insensitive checks for "yes" and "no", perhaps
it'd make sense to allow upper case 'Y' and 'N' also? Something like:

- =A0 =A0 =A0 if (answer[0] =3D=3D 'n' && strlen(answer) =3D=3D 1)
+ =A0 =A0 =A0 if (tolower(answer[0]) =3D=3D 'n' && strlen(answer) =3D=3D=
 1)

hm?


> +static int ask_user_yes_no(const char *format, ...)
> +{
> + =A0 =A0 =A0 char question[4096];
> + =A0 =A0 =A0 const char *retry_hook[] =3D { NULL, NULL, NULL };
> + =A0 =A0 =A0 va_list args;
> +
> + =A0 =A0 =A0 if ((retry_hook[0] =3D getenv("GIT_ASK_YESNO"))) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 va_start(args, format);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vsnprintf(question, sizeof(question), f=
ormat, args);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 va_end(args);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry_hook[1] =3D question;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !run_command_v_opt(retry_hook, 0=
);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr))=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

I'm wondering, doesn't this make the semantics a bit wrong? The
function is called "ask_user_yes_no", but it might end up not asking
after all. Perhaps it should be called something that reflects this?
"maybe_ask_yes_no", "ask_yes_no_if_tty", "should_retry"? I don't have
a non-ugly suggestion, but I suspect something like that might leave
other people less puzzled when reading the code.
