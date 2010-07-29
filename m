From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv4 1/3] Allow creation of arbitrary git-shell commands
Date: Wed, 28 Jul 2010 17:37:29 -0700
Message-ID: <AANLkTikKQb=WZQ=179+qNxn_1=5mJtuOnqb=Cdw78W4e@mail.gmail.com>
References: <1280302984-1752-1-git-send-email-gdb@mit.edu>
	<1280302984-1752-2-git-send-email-gdb@mit.edu>
	<AANLkTim=iJUCZW+9Ttssnp=NpOpeQEhXsumCPw=HykX=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: jrnieder@gmail.com, j.sixt@viscovery.net, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org, gdb@mit.edu
X-From: git-owner@vger.kernel.org Thu Jul 29 02:37:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeH89-0004t1-OA
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 02:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab0G2Ahe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 20:37:34 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:58943 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171Ab0G2Ahd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 20:37:33 -0400
X-AuditID: 1209190e-b7bbeae000000a09-69-4c50cd4e87cd
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 9F.57.02569.E4DC05C4; Wed, 28 Jul 2010 20:37:34 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6T0bVJl032576
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:37:32 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6T0bTsa017866
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 28 Jul 2010 20:37:31 -0400 (EDT)
Received: by iwn7 with SMTP id 7so5115970iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 17:37:29 -0700 (PDT)
Received: by 10.231.12.76 with SMTP id w12mr12787487ibw.87.1280363849749; Wed, 
	28 Jul 2010 17:37:29 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Wed, 28 Jul 2010 17:37:29 -0700 (PDT)
In-Reply-To: <AANLkTim=iJUCZW+9Ttssnp=NpOpeQEhXsumCPw=HykX=@mail.gmail.com>
X-Brightmail-Tracker: AAAAAxVg7SYVYaj1FWG7PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152135>

Err, actually it would probably be a good idea to
s/char *home =3D getenv("HOME");/const char *home =3D getenv("HOME");/

Greg



On Wed, Jul 28, 2010 at 5:31 PM, Greg Brockman <gdb@mit.edu> wrote:
> This provides a mechanism for the server to expose custom
> functionality to clients. =A0My particular use case is that I would l=
ike
> a way of discovering all repositories available for cloning. =A0A
> client that clones via
>
> =A0git clone user@example.com
>
> can invoke a command by
>
> =A0ssh user@example.com $command
>
> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---
> =A0shell.c | =A0 44 ++++++++++++++++++++++++++++++++++++++++++--
> =A01 files changed, 42 insertions(+), 2 deletions(-)
>
> As discussed on-list, it should be fine to trust the value of HOME.
> This patch differs from the previous only in the implementation of
> cd_to_homedir.
>
> diff --git a/shell.c b/shell.c
> index e4864e0..1e6077d 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -3,6 +3,8 @@
> =A0#include "exec_cmd.h"
> =A0#include "strbuf.h"
>
> +#define COMMAND_DIR "git-shell-commands"
> +
> =A0static int do_generic_cmd(const char *me, char *arg)
> =A0{
> =A0 =A0 =A0 =A0const char *my_argv[4];
> @@ -33,6 +35,29 @@ static int do_cvs_cmd(const char *me, char *arg)
> =A0 =A0 =A0 =A0return execv_git_cmd(cvsserver_argv);
> =A0}
>
> +static int is_valid_cmd_name(const char *cmd)
> +{
> + =A0 =A0 =A0 /* Test command contains no . or / characters */
> + =A0 =A0 =A0 return cmd[strcspn(cmd, "./")] =3D=3D '\0';
> +}
> +
> +static char *make_cmd(const char *prog)
> +{
> + =A0 =A0 =A0 char *prefix =3D xmalloc((strlen(prog) + strlen(COMMAND=
_DIR) + 2));
> + =A0 =A0 =A0 strcpy(prefix, COMMAND_DIR);
> + =A0 =A0 =A0 strcat(prefix, "/");
> + =A0 =A0 =A0 strcat(prefix, prog);
> + =A0 =A0 =A0 return prefix;
> +}
> +
> +static void cd_to_homedir(void)
> +{
> + =A0 =A0 =A0 char *home =3D getenv("HOME");
> + =A0 =A0 =A0 if (!home)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not determine user's home di=
rectory; HOME is unset");
> + =A0 =A0 =A0 if (chdir(home) =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not chdir to user's home dir=
ectory");
> +}
>
> =A0static struct commands {
> =A0 =A0 =A0 =A0const char *name;
> @@ -48,6 +73,7 @@ static struct commands {
> =A0int main(int argc, char **argv)
> =A0{
> =A0 =A0 =A0 =A0char *prog;
> + =A0 =A0 =A0 const char **user_argv;
> =A0 =A0 =A0 =A0struct commands *cmd;
> =A0 =A0 =A0 =A0int devnull_fd;
>
> @@ -76,7 +102,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0else if (argc !=3D 3 || strcmp(argv[1], "-c"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("What do you think I am? A shell?"=
);
>
> - =A0 =A0 =A0 prog =3D argv[2];
> + =A0 =A0 =A0 prog =3D xstrdup(argv[2]);
> =A0 =A0 =A0 =A0if (!strncmp(prog, "git", 3) && isspace(prog[3]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Accept "git foo" as if the caller s=
aid "git-foo". */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prog[3] =3D '-';
> @@ -99,5 +125,19 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(cmd->exec(cmd->name, arg));
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 die("unrecognized command '%s'", prog);
> +
> + =A0 =A0 =A0 cd_to_homedir();
> + =A0 =A0 =A0 if (split_cmdline(prog, &user_argv) !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_valid_cmd_name(user_argv[0])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prog =3D make_cmd(user_=
argv[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_argv[0] =3D prog;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 execv(user_argv[0], (ch=
ar *const *) user_argv);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(prog);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(user_argv);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unrecognized command '%s'", argv[2=
]);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(prog);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("invalid command format '%s'", argv=
[2]);
> + =A0 =A0 =A0 }
> =A0}
> --
> 1.7.0.4
>
