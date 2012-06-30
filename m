From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git_getpass regression?
Date: Sat, 30 Jun 2012 13:27:09 +0200
Message-ID: <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net> <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 30 13:28:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkvqG-00079d-7c
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jun 2012 13:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab2F3L1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jun 2012 07:27:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34905 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab2F3L1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2012 07:27:50 -0400
Received: by pbbrp8 with SMTP id rp8so5614426pbb.19
        for <git@vger.kernel.org>; Sat, 30 Jun 2012 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=XGg5aY3UHo66Ysfq4A5YasMsMqlf4w2gg362m7zZJoI=;
        b=P8IdHk6pp6NrJxxEdYvpNHcSpV6wF9Gt2LV03sSbm6Jlj8x8cBxQMlDRwntx+Q4D6G
         KMAHvujjoMYWH7Iw4c6XhnrAkA3bSrlgYKU8DDGlOV95/Iob0zSvnKZcrCaY1oT9c2wh
         f1Rn9h/b74b2/kQl3vioLVOKMQX+upAcHe/vayS6wGP5eBXj8Hp+hxsFS2e1f5Xkj5BB
         0HUkqHk69DNp0qUzty2gRly2S/b2mDVJdQiLSVfLp+dJaAmV7RhB+Sk+4+p/jUs2Ass9
         RjdJ1GxbS4VKjk3giOHLfMNCo1LQmjvtuBRd0wwGQ0m1ebgurPOd1x5A8nNMY7nrM8z7
         lTMw==
Received: by 10.68.197.70 with SMTP id is6mr14032549pbc.64.1341055670005; Sat,
 30 Jun 2012 04:27:50 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Sat, 30 Jun 2012 04:27:09 -0700 (PDT)
In-Reply-To: <20120629203001.GA12937@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200833>

On Fri, Jun 29, 2012 at 10:30 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 29, 2012 at 10:14:35PM +0200, Erik Faye-Lund wrote:
>
>> > Backspace shouldn't be making it to git at all; it should be handl=
ed at
>> > the terminal input layer, because we are not putting the terminal =
into
>> > raw mode.
>>
>> I don't get it. How can the terminal ever interpret the backspace, w=
hen
>> we've already put the character it's supposed to erase in a strbuf? =
Sure,
>> the echo can be correctly dealt with (probably with the exception of=
 the
>> border case of erasing characters from the prompt text), but once we=
've put
>> the characters into a buffer, the terminal cannot erase it.
>
> Because a terminal in non-raw mode is typically line-oriented, and yo=
ur
> program doesn't get to see any input at all until the user hits enter=
=2E
>
> Try this on your linux box:
>
> =A0strace -e read cat
>
> You should be able to type characters and backspace erase them, all
> without seeing any activity from strace. When you hit enter, you shou=
ld
> see the full text you typed read as a single syscall.
>

Thanks for the explanation.

> If the backspacing doesn't work, then there is a configuration mismat=
ch
> between what linux's tty driver expects and what your terminal emulat=
or
> is sending (the former is probably expecting ^? as the erase characte=
r,
> and the latter is sending ^H).
>

The only thing I actually tested, was that getpass behaved correctly.
I just assumed fgetc returned the input right away. I had no idea that
fgetc didn't fetch characters until a whole line was entered. I guess
you learn something every day ;)

I have now written a small test-application that confirms that the
prompt works just fine; I was making conclusions without testing
properly, my bad. So I'm sorry for the noise. But please read on ;)

>> > If that is the case, I wonder if your 'stty erase' settings
>> > do not match what your terminal emulator is sending.
>>
>> I have no idea what that even means. And having to fiddle around wit=
h
>> terminal settings just makes git feel cheap.
>
> But it's not git that is broken. It's your configuration. Fixing git =
is
> a band-aid, and other programs will still be broken. Of course, I may=
 be
> mis-diagnosing your problem. Did you try this:
>
>> > If you run "stty erase ^H" and then run git, does it work?
>
> ?
>

I'm sorry, I didn't have access to a box at that time, that's why I
didn't answer that part.

But now, I see that "stty erase ^H" makes the terminal behave all
strange when it comes to the backspace character; it starts printing
"^?" instead.

>> > =A0I think (3) is the only sane thing,
>> > though.

Yes, you are right. But perhaps with one exception: we probably want
to piggy-back on those terminal-handling goodies on Windows. If only
to get git to behave more consistently with other applications.

So perhaps we should do something like this?

---8<---
diff --git a/compat/terminal.c b/compat/terminal.c
index 53c5166..2f44fb5 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -76,18 +76,58 @@ char *git_terminal_prompt(const char *prompt, int e=
cho)
 char *git_terminal_prompt(const char *prompt, int echo)
 {
 	static struct strbuf buf =3D STRBUF_INIT;
+	int r;
+	FILE *input_fh, *output_fh;
+	DWORD cmode =3D 0;
+	HANDLE hconin;
+
+	input_fh =3D fopen("CONIN$", "r");
+	if (!input_fh)
+		return NULL;
+
+	output_fh =3D fopen("CONOUT$", "w");
+	if (!output_fh) {
+		fclose(input_fh);
+		return NULL;
+	}

-	fputs(prompt, stderr);
-	strbuf_reset(&buf);
-	for (;;) {
-		int c =3D _getch();
-		if (c =3D=3D '\n' || c =3D=3D '\r')
-			break;
-		if (echo)
-			putc(c, stderr);
-		strbuf_addch(&buf, c);
+	if (!echo) {
+		hconin =3D CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
+		    FILE_SHARE_READ, NULL, OPEN_EXISTING,
+		    FILE_ATTRIBUTE_NORMAL, NULL);
+		if (hconin =3D=3D INVALID_HANDLE_VALUE) {
+			fclose(input_fh);
+			fclose(output_fh);
+			return NULL;
+		}
+		GetConsoleMode(hconin, &cmode);
+		if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
+			fclose(input_fh);
+			fclose(output_fh);
+			return NULL;
+		}
 	}
-	putc('\n', stderr);
+
+	fputs(prompt, output_fh);
+	fflush(output_fh);
+
+	r =3D strbuf_getline(&buf, input_fh, '\n');
+	if (!echo) {
+		putc('\n', output_fh);
+		fflush(output_fh);
+
+		SetConsoleMode(hconin, cmode);
+		CloseHandle(hconin);
+	}
+
+	if (buf.buf[buf.len - 1] =3D=3D '\r')
+		strbuf_setlen(&buf, buf.len - 1);
+
+	fclose(input_fh);
+	fclose(output_fh);
+
+	if (r =3D=3D EOF)
+		return NULL;
 	return buf.buf;
 }

---8<---

Notice how this looks very similar to the HAVE_TTY code-path, with the
exception of needing two file handles instead of one, and the actual
enabling/resetting of the prompt-setting. So the code-paths can
probably be refactored to share code...

>> As I already said, I don't think this is the case. Inserting 0x7f in=
 a
>> strbuf does not delete the preceding char...
>
> Of course not. Control characters should be handled by the terminal
> driver, and shouldn't make it to git at all. Backspacing works perfec=
tly
> well on correctly configured systems, and it should not be git's
> responsibility to care about it at all for line-oriented input (and i=
f
> we _did_ want to handle it ourselves, we should use a real terminal
> library like readline or curses).

Yes, I absolutely agree. Sorry for getting confused and wasting your
time with unfounded accusations.

But perhaps something good came from it; the Windows-prompt doesn't
support erasing until the patch above is applied. I don't know if you
care or not, but I certainly do ;)
