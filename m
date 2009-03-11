From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Removed unnecessary use of global variables.
Date: Tue, 10 Mar 2009 18:19:46 -0700 (PDT)
Message-ID: <55ef48ab-403d-41b8-bf16-203bb0f73fc7@b16g2000yqb.googlegroups.com>
References: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 02:21:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhD8L-0007SW-H4
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 02:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbZCKBTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 21:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbZCKBTu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 21:19:50 -0400
Received: from yx-out-2122.google.com ([74.125.44.25]:16429 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbZCKBTt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 21:19:49 -0400
Received: by yx-out-2122.google.com with SMTP id 33so1553225yxl.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 18:19:46 -0700 (PDT)
Received: by 10.100.6.13 with SMTP id 13mr1219140anf.1.1236734386185; Tue, 10 
	Mar 2009 18:19:46 -0700 (PDT)
In-Reply-To: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
X-IP: 84.48.62.155
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) 
	AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112865>

Sorry about the whole double-post thing, this whole submitting patches
over email thing is new to me, and I'm making too many mistakes right
now. Hopefully, I'll improve in the future ;)

On Mar 11, 1:09=A0am, Erik Faye-Lund <kusmab...@gmail.com> wrote:
> git_config() now takes a third data-parameter that is passed back
> to the callback-function. At the time this code was written, that
> parameter did not exist, so a somewhat nasty (but by all means
> correct) use of global variables was introduced. In commit
> ef90d6d4208a5130185b04f06e5f90a5f9959fe3 Johannes Schindelin
> <Johannes.Schinde...@gmx.de> introduced a parameter for similar
> purposes.
>
> I've changed the code to utilize this parameter to pass the
> string. In addition, I've made the function calculate the string
> length on usage instead, to reduce the parameters needed to what
> the callback-interface supplies.
>
> Signed-off-by: Erik Faye-Lund <kusmab...@gmail.com>
> ---
> =A0connect.c | =A0 16 ++++++----------
> =A01 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 2f23ab3..98fbaea 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -371,14 +371,13 @@ static void git_tcp_connect(int fd[2], char *ho=
st, int flags)
> =A0 =A0 =A0 =A0 fd[1] =3D dup(sockfd);
> =A0}
>
> -
> =A0static char *git_proxy_command;
> -static const char *rhost_name;
> -static int rhost_len;
> -
> =A0static int git_proxy_command_options(const char *var, const char *=
value,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *cb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data)
> =A0{
> + =A0 =A0 =A0 const char *rhost_name =3D data;
> + =A0 =A0 =A0 const size_t rhost_len =3D strlen(rhost_name);
> +
> =A0 =A0 =A0 =A0 if (!strcmp(var, "core.gitproxy")) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *for_pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int matchlen =3D -1;
> @@ -421,16 +420,13 @@ static int git_proxy_command_options(const char=
 *var, const char *value,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 return git_default_config(var, value, cb);
> + =A0 =A0 =A0 return git_default_config(var, value, data);
> =A0}
>
> =A0static int git_use_proxy(const char *host)
> =A0{
> - =A0 =A0 =A0 rhost_name =3D host;
> - =A0 =A0 =A0 rhost_len =3D strlen(host);
> =A0 =A0 =A0 =A0 git_proxy_command =3D getenv("GIT_PROXY_COMMAND");
> - =A0 =A0 =A0 git_config(git_proxy_command_options, NULL);
> - =A0 =A0 =A0 rhost_name =3D NULL;
> + =A0 =A0 =A0 git_config(git_proxy_command_options, (void*)host);
> =A0 =A0 =A0 =A0 return (git_proxy_command && *git_proxy_command);
> =A0}
>
> --
> 1.6.2.GIT
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
