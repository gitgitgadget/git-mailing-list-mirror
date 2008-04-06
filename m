From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sun, 6 Apr 2008 07:49:33 +0200
Message-ID: <200804060749.34109.chriscool@tuxfamily.org>
References: <20080405121834.GB14565@leksak.fem-net> <200804051819.46904.chriscool@tuxfamily.org> <20080405173956.GD14565@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 07:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiNgV-0000Gi-DH
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 07:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYDFFoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 01:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYDFFoL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 01:44:11 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33183 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbYDFFoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 01:44:10 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 22E5C1AB2C3;
	Sun,  6 Apr 2008 07:44:08 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E62F61AB2AF;
	Sun,  6 Apr 2008 07:44:07 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080405173956.GD14565@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78886>

Hi,

Le samedi 5 avril 2008, Stephan Beyer a =E9crit :
> Hi,
>
> > Did you see:
> >
> > "(And no, casting the "char **" into a "const char **" is not a goo=
d
> > solution either.)"
> >
> > in the above page ?
>
> Yes.

So you should say in the commit message that you decided to cast to "co=
nst=20
char **" despite what is on the Janitor page, and most importantly expl=
ain=20
why in the commit message.

> > > +	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
> > > +		return git_config_string((const char**)&alias_val, k, v);
> >
> > Are you sure this ugly cast to "const char**" is needed ?
> > Isn't there a better way to do it ?
>
> Well, because alias_val is not a constant[1], changing
> 	static char *alias_val;
> to
> 	static const char *alias_val;
> is not an option.
>
> The only other way I see[2] atm is a brain-damaged:
> --
> static int alias_lookup_cb(const char *k, const char *v)
> {
> 	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
> 		const char *tmp;
> 		int ret =3D git_config_string(&tmp, k, v);
> 		alias_val =3D xstrdup(tmp);
> 		/* actually, tmp should be free()'d. */
> 		return ret;
> 	}
> 	return 0;
> }
> --
> But instead of doing that, the original should be kept, because it is
> better in code beauty, performance and memory usage. ;-)

Yes, so perhaps it's not a good idea to convert the original file to=20
git_config_string.

> So I thought the casting is ugly, but it does no harm. I hope ;)
> (Yes, a cast from const char ** to char ** is, indeed, dangerous.)
>
> But if I miss an obvious point, please tell me :)
>
> Regards,
>  Stephan
>
> Footnotes:
>  [1] It is no constant because it is returned by alias_lookup(),
>      and thus could be changed by further instructions.

Yes, but there are only 2 callers and only one in git.c changes the buf=
fer.

A patch like this (not tested) one makes use of a strbuf to copy the bu=
ffer=20
returned by alias_lookup in git.c, so that it is now possible (if we re=
ally=20
want it) to change alias_lookup to return a "const char *" instead of=20
a "char *":

----8<----

diff --git a/git.c b/git.c
index c4e4644..ba5593f 100644
--- a/git.c
+++ b/git.c
@@ -147,34 +147,29 @@ static int handle_alias(int *argcp, const char=20
***argv)
 	int count, option_count;
 	const char** new_argv;
 	const char *alias_command;
-	char *alias_string;
+	struct strbuf alias_buf =3D STRBUF_INIT;
+	char *cmdline;
 	int unused_nongit;
=20
 	subdir =3D setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
-	alias_string =3D alias_lookup(alias_command);
-	if (alias_string) {
-		if (alias_string[0] =3D=3D '!') {
-			if (*argcp > 1) {
-				struct strbuf buf;
-
-				strbuf_init(&buf, PATH_MAX);
-				strbuf_addstr(&buf, alias_string);
-				sq_quote_argv(&buf, (*argv) + 1, PATH_MAX);
-				free(alias_string);
-				alias_string =3D buf.buf;
-			}
+	strbuf_addstr(&alias_buf, alias_lookup(alias_command));
+	if (alias_buf.len) {
+		if (alias_buf.buf[0] =3D=3D '!') {
+			if (*argcp > 1)
+				sq_quote_argv(&alias_buf, (*argv) + 1, PATH_MAX);
 			trace_printf("trace: alias to shell cmd: %s =3D> %s\n",
-				     alias_command, alias_string + 1);
-			ret =3D system(alias_string + 1);
+				     alias_command, alias_buf.buf + 1);
+			ret =3D system(alias_buf.buf + 1);
 			if (ret >=3D 0 && WIFEXITED(ret) &&
 			    WEXITSTATUS(ret) !=3D 127)
 				exit(WEXITSTATUS(ret));
 			die("Failed to run '%s' when expanding alias '%s'\n",
-			    alias_string + 1, alias_command);
+			    alias_buf.buf + 1, alias_command);
 		}
-		count =3D split_cmdline(alias_string, &new_argv);
+		cmdline =3D strbuf_detach(&alias_buf, NULL);
+		count =3D split_cmdline(cmdline, &new_argv);
 		option_count =3D handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"

----8<----

But I don't think it's worth the trouble.

Thanks,
Christian.
