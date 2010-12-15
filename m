From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/8] mingw: make failures to unlink or move raise a
 question
Date: Wed, 15 Dec 2010 01:11:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012150109340.1461@bonsai2>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox> <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1337496104-1292371864=:1461"
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 01:11:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSexf-00088P-3N
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab0LOALJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 19:11:09 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:36525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752542Ab0LOALH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 19:11:07 -0500
Received: (qmail invoked by alias); 15 Dec 2010 00:11:04 -0000
Received: from pD9EB205C.dip0.t-ipconnect.de (EHLO noname) [217.235.32.92]
  by mail.gmx.net (mp032) with SMTP; 15 Dec 2010 01:11:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199oLtkVyZ9uDGMAPRrp83bacUkBPvrCFreVMt/CD
	wWYYQf99NORGjc
X-X-Sender: gene099@bonsai2
In-Reply-To: <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163723>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1337496104-1292371864=:1461
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 14 Dec 2010, Erik Faye-Lund wrote:

> On Tue, Dec 14, 2010 at 11:21 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Windows in case a program is accessing a file unlink or
> > move operations may fail. To give the user a chance to correct
> > this we simply wait until the user asks us to retry or fail.
> >
> > This is useful because of the following use case which seem
> > to happen rarely but when it does it is a mess:
> >
> > After making some changes the user realizes that he was on the
> > incorrect branch. When trying to change the branch some file
> > is still in use by some other process and git stops in the
> > middle of changing branches. Now the user has lots of files
> > with changes mixed with his own. This is especially confusing
> > on repositories that contain lots of files.
> >
> > Although the recent implementation of automatic retry makes
> > this scenario much more unlikely lets provide a fallback as
> > a last resort.
> >
> > Thanks to Albert Dvornik for disabling the question if users can't see it.
> >
> > If the stdout of the command is connected to a terminal but the stderr
> > has been redirected, the odds are good that the user can't see any
> > question we print out to stderr.  This will result in a "mysterious
> > hang" while the app is waiting for user input.
> >
> > It seems better to be conservative, and avoid asking for input
> > whenever the stderr is not a terminal, just like we do for stdin.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > Signed-off-by: Albert Dvornik <dvornik+git@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > I have added the sign-off from the squashed commit of Albert and
> > Johannes. I hope its ok this way.

I'm fine with it.

> >  compat/mingw.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 82 insertions(+), 0 deletions(-)
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 52183a7..ac9fb4a 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -2,6 +2,7 @@
> >  #include "win32.h"
> >  #include <conio.h>
> >  #include "../strbuf.h"
> > +#include "../run-command.h"
> >
> >  static const int delay[] = { 0, 1, 10, 20, 40 };
> >
> > @@ -129,6 +130,78 @@ static inline int is_file_in_use_error(DWORD errcode)
> >        return 0;
> >  }
> >
> > +static int read_yes_no_answer()
> 
> Perhaps "static int read_yes_no_answer(void)" for portability?

LOL. This file is called compat/mingw.c... :-)

But I have no objection to stay with the convention of the rest of Git. 
Nobody needs to convince me that consistency is good.

> > +{
> > +       char answer[1024];
> > +
> > +       if (fgets(answer, sizeof(answer), stdin)) {
> > +               size_t answer_len = strlen(answer);
> > +               int got_full_line = 0, c;
> > +
> > +               /* remove the newline */
> > +               if (answer_len >= 2 && answer[answer_len-2] == '\r') {
> > +                       answer[answer_len-2] = '\0';
> > +                       got_full_line = 1;
> > +               }
> > +               else if (answer_len >= 1 && answer[answer_len-1] == '\n') {
> > +                       answer[answer_len-1] = '\0';
> > +                       got_full_line = 1;
> > +               }
> > +               /* flush the buffer in case we did not get the full line */
> > +               if (!got_full_line)
> > +                       while((c = getchar()) != EOF && c != '\n');
> > +       } else
> > +               /* we could not read, return the
> > +                * default answer which is no */
> > +               return 0;
> > +
> > +       if (answer[0] == 'y' && strlen(answer) == 1)
> > +               return 1;
> > +       if (!strncasecmp(answer, "yes", sizeof(answer)))
> > +               return 1;
> > +       if (answer[0] == 'n' && strlen(answer) == 1)
> > +               return 0;
> > +       if (!strncasecmp(answer, "no", sizeof(answer)))
> > +               return 0;
> 
> Since you're doing case insensitive checks for "yes" and "no", perhaps
> it'd make sense to allow upper case 'Y' and 'N' also? Something like:
> 
> -       if (answer[0] == 'n' && strlen(answer) == 1)
> +       if (tolower(answer[0]) == 'n' && strlen(answer) == 1)
> 
> hm?

Makes sense to me.

> > +static int ask_user_yes_no(const char *format, ...)
> > +{
> > +       char question[4096];
> > +       const char *retry_hook[] = { NULL, NULL, NULL };
> > +       va_list args;
> > +
> > +       if ((retry_hook[0] = getenv("GIT_ASK_YESNO"))) {
> > +
> > +               va_start(args, format);
> > +               vsnprintf(question, sizeof(question), format, args);
> > +               va_end(args);
> > +
> > +               retry_hook[1] = question;
> > +               return !run_command_v_opt(retry_hook, 0);
> > +       }
> > +
> > +       if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
> > +               return 0;
> 
> I'm wondering, doesn't this make the semantics a bit wrong? The
> function is called "ask_user_yes_no", but it might end up not asking
> after all. Perhaps it should be called something that reflects this?
> "maybe_ask_yes_no", "ask_yes_no_if_tty", "should_retry"? I don't have
> a non-ugly suggestion, but I suspect something like that might leave
> other people less puzzled when reading the code.

I like ask_yes_no_if_tty.

Ciao,
Dscho

--8323329-1337496104-1292371864=:1461--
