From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv4 1/2] daemon: add helper function named_sock_setup
Date: Mon, 30 Aug 2010 14:12:52 +0200
Message-ID: <AANLkTindaa-wDkOMW=BgtNJ+Wmi3xaBo1o_CF7NFH=Qm@mail.gmail.com>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org> <1283167851-18331-2-git-send-email-alexander@sulfrian.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Aug 30 14:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq3JC-0006w6-6w
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 14:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0H3MRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 08:17:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59794 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514Ab0H3MRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 08:17:43 -0400
Received: by ywh1 with SMTP id 1so1610579ywh.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=OZgYMZ5NHSjNh8Koze+nMuNTvkUwKWXLI49Pi5xvWmU=;
        b=Gm1+t54cDrf2CXscjNpwmTjQgwOwPis+iTx9qlVVyRXlO95AEuodkLZ6NwhCV3pruk
         QcMFD+mPLHvl9EyW9Q096ek122kRoAmJz0E7nmIF8Z8QLRW1KEBsLs11zFLLxsMxXAhp
         1phgzbOEd9ZGRFkobNtqDx8mWl918zj9K0w2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=uyKuchgPnuiazCugRzmXA5NAEkdmKUQyYRITypkfQNTT6MkyqHdSqrOUT91Uz5+Bf9
         sV+G7ohAp356komkJDKHLQ8/S0AW3gHk2lpiEVng/PergHJQI6lV/Ku6Qg5VgSujs7Av
         uLCQ7dWR0kSx5UqvIE1vJmTW+4GrDlMHSQY4I=
Received: by 10.150.96.18 with SMTP id t18mr77979ybb.406.1283170506138; Mon,
 30 Aug 2010 05:15:06 -0700 (PDT)
Received: by 10.150.211.14 with HTTP; Mon, 30 Aug 2010 05:12:52 -0700 (PDT)
In-Reply-To: <1283167851-18331-2-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154792>

On Mon, Aug 30, 2010 at 1:30 PM, Alexander Sulfrian
<alexander@sulfrian.net> wrote:
> Add named_sock_setup as helper function for socksetup to make it
> easier to create more than one listen sockets. named_sock_setup could
> be called more than one time and add the new sockets to the supplied
> socklist_p.
>
> Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
> ---
> =A0daemon.c | =A0 53 +++++++++++++++++++++++++++++++++---------------=
-----
> =A01 files changed, 33 insertions(+), 20 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index e22a2b7..c666ced 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -734,11 +734,17 @@ static int set_reuse_addr(int sockfd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&on, sizeof(on));
> =A0}
>
> +struct socketlist {
> + =A0 =A0 =A0 int *list;
> + =A0 =A0 =A0 size_t nr;
> + =A0 =A0 =A0 size_t alloc;
> +};
> +
> =A0#ifndef NO_IPV6
>
> -static int socksetup(char *listen_addr, int listen_port, int **sockl=
ist_p)
> +static int setup_named_sock(char *listen_addr, int listen_port, stru=
ct socketlist *socklist)
> =A0{
> - =A0 =A0 =A0 int socknum =3D 0, *socklist =3D NULL;
> + =A0 =A0 =A0 int socknum =3D 0;
> =A0 =A0 =A0 =A0int maxfd =3D -1;
> =A0 =A0 =A0 =A0char pbuf[NI_MAXSERV];
> =A0 =A0 =A0 =A0struct addrinfo hints, *ai0, *ai;
> @@ -753,8 +759,10 @@ static int socksetup(char *listen_addr, int list=
en_port, int **socklist_p)
> =A0 =A0 =A0 =A0hints.ai_flags =3D AI_PASSIVE;
>
> =A0 =A0 =A0 =A0gai =3D getaddrinfo(listen_addr, pbuf, &hints, &ai0);
> - =A0 =A0 =A0 if (gai)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("getaddrinfo() failed: %s", gai_str=
error(gai));
> + =A0 =A0 =A0 if (gai) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 logerror("getaddrinfo() for %s failed: =
%s", listen_addr, gai_strerror(gai));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0for (ai =3D ai0; ai; ai =3D ai->ai_next) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int sockfd;
> @@ -795,8 +803,9 @@ static int socksetup(char *listen_addr, int liste=
n_port, int **socklist_p)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (flags >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fcntl(sockfd, F_SETFD,=
 flags | FD_CLOEXEC);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 socklist =3D xrealloc(socklist, sizeof(=
int) * (socknum + 1));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 socklist[socknum++] =3D sockfd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALLOC_GROW(socklist->list, socklist->nr=
 + 1, socklist->alloc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 socklist->list[socklist->nr++] =3D sock=
fd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 socknum++;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (maxfd < sockfd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0maxfd =3D sockfd;
> @@ -804,13 +813,12 @@ static int socksetup(char *listen_addr, int lis=
ten_port, int **socklist_p)
>
> =A0 =A0 =A0 =A0freeaddrinfo(ai0);
>
> - =A0 =A0 =A0 *socklist_p =3D socklist;
> =A0 =A0 =A0 =A0return socknum;
> =A0}
>
> =A0#else /* NO_IPV6 */
>
> -static int socksetup(char *listen_addr, int listen_port, int **sockl=
ist_p)
> +static int setup_named_sock(char *listen_addr, int listen_port, stru=
ct socketlist *socklist)
> =A0{
> =A0 =A0 =A0 =A0struct sockaddr_in sin;
> =A0 =A0 =A0 =A0int sockfd;
> @@ -851,22 +859,27 @@ static int socksetup(char *listen_addr, int lis=
ten_port, int **socklist_p)
> =A0 =A0 =A0 =A0if (flags >=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fcntl(sockfd, F_SETFD, flags | FD_CLOE=
XEC);
>
> - =A0 =A0 =A0 *socklist_p =3D xmalloc(sizeof(int));
> - =A0 =A0 =A0 **socklist_p =3D sockfd;
> + =A0 =A0 =A0 ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->=
alloc);
> + =A0 =A0 =A0 socklist->list[socklist->nr++] =3D sockfd;
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> =A0#endif
>
> -static int service_loop(int socknum, int *socklist)
> +static void socksetup(char *listen_addr, int listen_port, struct soc=
ketlist *socklist)
> +{
> + =A0 =A0 =A0 setup_named_sock(listen_addr, listen_port, socklist);
> +}
> +
> +static int service_loop(struct socketlist *socklist)
> =A0{
> =A0 =A0 =A0 =A0struct pollfd *pfd;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 pfd =3D xcalloc(socknum, sizeof(struct pollfd));
> + =A0 =A0 =A0 pfd =3D xcalloc(socklist->nr, sizeof(struct pollfd));
>
> - =A0 =A0 =A0 for (i =3D 0; i < socknum; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfd[i].fd =3D socklist[i];
> + =A0 =A0 =A0 for (i =3D 0; i < socklist->nr; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfd[i].fd =3D socklist->list[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pfd[i].events =3D POLLIN;
> =A0 =A0 =A0 =A0}
>
> @@ -877,7 +890,7 @@ static int service_loop(int socknum, int *socklis=
t)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_dead_children();
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (poll(pfd, socknum, -1) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (poll(pfd, socklist->nr, -1) < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (errno !=3D EINTR) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logerr=
or("Poll failed, resuming: %s",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0strerror(errno));
> @@ -886,7 +899,7 @@ static int service_loop(int socknum, int *socklis=
t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < socknum; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < socklist->nr; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pfd[i].revents & P=
OLLIN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 sockaddr_storage ss;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsign=
ed int sslen =3D sizeof(ss);
> @@ -948,10 +961,10 @@ static void store_pid(const char *path)
>
> =A0static int serve(char *listen_addr, int listen_port, struct passwd=
 *pass, gid_t gid)
> =A0{
> - =A0 =A0 =A0 int socknum, *socklist;
> + =A0 =A0 =A0 struct socketlist socklist =3D { NULL, 0, 0 };
>

Since serve() isn't a library function, wouldn't it reduce needless
code churn to just make socklist a set of global variables (or just a
global struct)? That way you don't have to pass it around, changing
all those function prototypes.

I'm a bit intimidated by this change since I have a rather big
patch-set on top of daemon.c, and I really don't want to resolve a lot
of conflicts. But I guess that's my problem :P
