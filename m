From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
 logging by
Date: Tue, 12 Aug 2008 20:07:24 -0400
Message-ID: <48A225BC.7070709@griep.us>
References: <20080812235247.8353.95609.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT3ul-0007LZ-Og
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 02:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYHMAHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 20:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYHMAHc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 20:07:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:27767 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYHMAHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 20:07:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1040808yxm.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=yQ23gcRrNFUezHtp/A6zheGoh5sPvpSL3eC0xkvh/YQ=;
        b=D1772EvtXec8HnPjYoiapO8cJ+IRpZKxbky38XLf3NAwTsGYY/90XWNWKhhf5ZLvbU
         W5RG7bexLX/IRx5l82iwfaR4/4+ynCCh5SyN/y58CTUaGhaBca1IZ7ZuD6Uw4jQJsCmY
         9nwZ93bmcPlPUsRk/gHTTf03a3HNfxaqPzco4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=hZqh68QJ/vjnZyXhpwj2TmKcZL56lMrqHwIrkfkwbq723VTaM77kRWBAzKlg4lxVaw
         PtfkuUAgZqWYuHzzGcVeIVwDavbnlWxk2RwgJBHVdapJzEb5qxgLK5y3HkrQELA+IjCg
         6ca/+PNiseDWpkxMgCObAlL58Rc74NAIenErQ=
Received: by 10.151.46.17 with SMTP id y17mr15326470ybj.86.1218586050281;
        Tue, 12 Aug 2008 17:07:30 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id h37sm2770076wxd.15.2008.08.12.17.07.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 17:07:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080812235247.8353.95609.stgit@aristoteles.cuci.nl>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92157>

I'd still suggest this get split up.  Even though the patches may
be dependent upon one another, each logical unit should be it's
own patch and commit in the Git repository.  Submit them as a
patch series with a summary and it'll make each part clear as
to what was modified to achieve what, and easier to review.

Also, the title to your patch is malformed.  Perhaps your MUA doing
some unintended wrapping?

Marcus

Stephen R. van den Berg wrote:
> making the signal handler almost a no-op.
> Fix the killing code to actually be smart instead of the
> pseudo-random mess.
> Get rid of the silly fixed array of children and make
> max-connections dynamic and configurable in the process.
> Make git-daemon a proper syslogging citizen with PID-info.
> Simplify the overzealous double buffering in the logroutine,
> remove the artificial maximum logline length in the process.
> Changed two calls to error() into logerror().
>=20
> Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
> ---
>=20
> Took out the vsyslog().
> Cleanup a bit left and right.
> Can this go in in one piece?  Or do I need to split it up?
> Like I said, large parts of the split-up are obsolete due do getting
> deleted.
>=20
>  Documentation/git-daemon.txt |    8 +
>  daemon.c                     |  285 ++++++++++++++++----------------=
----------
>  2 files changed, 114 insertions(+), 179 deletions(-)
>=20
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.=
txt
> index 4ba4b75..48bcc25 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -9,8 +9,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git daemon' [--verbose] [--syslog] [--export-all]
> -	     [--timeout=3Dn] [--init-timeout=3Dn] [--strict-paths]
> -	     [--base-path=3Dpath] [--user-path | --user-path=3Dpath]
> +	     [--timeout=3Dn] [--init-timeout=3Dn] [--max-connections=3Dn]
> +	     [--strict-paths] [--base-path=3Dpath] [--base-path-relaxed]
> +	     [--user-path | --user-path=3Dpath]
>  	     [--interpolated-path=3Dpathtemplate]
>  	     [--reuseaddr] [--detach] [--pid-file=3Dfile]
>  	     [--enable=3Dservice] [--disable=3Dservice]
> @@ -99,6 +100,9 @@ OPTIONS
>  	it takes for the server to process the sub-request and time spent
>  	waiting for next client's request.
> =20
> +--max-connections::
> +	Maximum number of concurrent clients, defaults to 32.
> +
>  --syslog::
>  	Log to syslog instead of stderr. Note that this option does not imp=
ly
>  	--verbose, thus by default only error conditions will be logged.
> diff --git a/daemon.c b/daemon.c
> index 1c00305..82eb224 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -16,12 +16,11 @@
>  static int log_syslog;
>  static int verbose;
>  static int reuseaddr;
> -static int child_handler_pipe[2];
> =20
>  static const char daemon_usage[] =3D
>  "git daemon [--verbose] [--syslog] [--export-all]\n"
> -"           [--timeout=3Dn] [--init-timeout=3Dn] [--strict-paths]\n"
> -"           [--base-path=3Dpath] [--base-path-relaxed]\n"
> +"           [--timeout=3Dn] [--init-timeout=3Dn] [--max-connections=3D=
n]\n"
> +"           [--strict-paths] [--base-path=3Dpath] [--base-path-relax=
ed]\n"
>  "           [--user-path | --user-path=3Dpath]\n"
>  "           [--interpolated-path=3Dpath]\n"
>  "           [--reuseaddr] [--detach] [--pid-file=3Dfile]\n"
> @@ -78,38 +77,19 @@ static struct interp interp_table[] =3D {
> =20
>  static void logreport(int priority, const char *err, va_list params)
>  {
> -	/* We should do a single write so that it is atomic and output
> -	 * of several processes do not get intermingled. */
> -	char buf[1024];
> -	int buflen;
> -	int maxlen, msglen;
> -
> -	/* sizeof(buf) should be big enough for "[pid] \n" */
> -	buflen =3D snprintf(buf, sizeof(buf), "[%ld] ", (long) getpid());
> -
> -	maxlen =3D sizeof(buf) - buflen - 1; /* -1 for our own LF */
> -	msglen =3D vsnprintf(buf + buflen, maxlen, err, params);
> -
>  	if (log_syslog) {
> +		char buf[1024];
> +		vsnprintf(buf, sizeof(buf), err, params);
>  		syslog(priority, "%s", buf);
> -		return;
>  	}
> -
> -	/* maxlen counted our own LF but also counts space given to
> -	 * vsnprintf for the terminating NUL.  We want to make sure that
> -	 * we have space for our own LF and NUL after the "meat" of the
> -	 * message, so truncate it at maxlen - 1.
> -	 */
> -	if (msglen > maxlen - 1)
> -		msglen =3D maxlen - 1;
> -	else if (msglen < 0)
> -		msglen =3D 0; /* Protect against weird return values. */
> -	buflen +=3D msglen;
> -
> -	buf[buflen++] =3D '\n';
> -	buf[buflen] =3D '\0';
> -
> -	write_in_full(2, buf, buflen);
> +	else {
> +		/* Since stderr is set to linebuffered mode, the
> +		 * logging of different processes will not overlap
> +		 */
> +		fprintf(stderr, "[%d] ", (int)getpid());
> +		vfprintf(stderr, err, params);
> +		fputc('\n', stderr);
> +	}
>  }
> =20
>  static void logerror(const char *err, ...)
> @@ -604,40 +584,38 @@ static int execute(struct sockaddr *addr)
>  	return -1;
>  }
> =20
> +static int max_connections =3D 32;
> =20
> -/*
> - * We count spawned/reaped separately, just to avoid any
> - * races when updating them from signals. The SIGCHLD handler
> - * will only update children_reaped, and the fork logic will
> - * only update children_spawned.
> - *
> - * MAX_CHILDREN should be a power-of-two to make the modulus
> - * operation cheap. It should also be at least twice
> - * the maximum number of connections we will ever allow.
> - */
> -#define MAX_CHILDREN 128
> -
> -static int max_connections =3D 25;
> -
> -/* These are updated by the signal handler */
> -static volatile unsigned int children_reaped;
> -static pid_t dead_child[MAX_CHILDREN];
> -
> -/* These are updated by the main loop */
> -static unsigned int children_spawned;
> -static unsigned int children_deleted;
> +static unsigned int live_children;
> =20
>  static struct child {
> +	struct child*next;
>  	pid_t pid;
> -	int addrlen;
>  	struct sockaddr_storage address;
> -} live_child[MAX_CHILDREN];
> +} *firstborn;
> =20
> -static void add_child(int idx, pid_t pid, struct sockaddr *addr, int=
 addrlen)
> +static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
>  {
> -	live_child[idx].pid =3D pid;
> -	live_child[idx].addrlen =3D addrlen;
> -	memcpy(&live_child[idx].address, addr, addrlen);
> +	struct child*newborn;
> +	newborn =3D xmalloc(sizeof *newborn);
> +	if (newborn) {
> +		struct child **cradle, *blanket;
> +
> +		live_children++;
> +		newborn->pid =3D pid;
> +		memcpy(memset(&newborn->address, 0, sizeof newborn->address),
> +		 addr, addrlen);
> +		for (cradle =3D &firstborn;
> +		     (blanket =3D *cradle);
> +		     cradle =3D &blanket->next)
> +			if (!memcmp(&blanket->address, &newborn->address,
> +				   sizeof newborn->address))
> +				break;
> +		newborn->next =3D blanket;
> +		*cradle =3D newborn;
> +	}
> +	else
> +		logerror("Out of memory spawning new child");
>  }
> =20
>  /*
> @@ -646,107 +624,74 @@ static void add_child(int idx, pid_t pid, stru=
ct sockaddr *addr, int addrlen)
>   * We move everything up by one, since the new "deleted" will
>   * be one higher.
>   */
> -static void remove_child(pid_t pid, unsigned deleted, unsigned spawn=
ed)
> +static void remove_child(pid_t pid)
>  {
> -	struct child n;
> -
> -	deleted %=3D MAX_CHILDREN;
> -	spawned %=3D MAX_CHILDREN;
> -	if (live_child[deleted].pid =3D=3D pid) {
> -		live_child[deleted].pid =3D -1;
> -		return;
> -	}
> -	n =3D live_child[deleted];
> -	for (;;) {
> -		struct child m;
> -		deleted =3D (deleted + 1) % MAX_CHILDREN;
> -		if (deleted =3D=3D spawned)
> -			die("could not find dead child %d\n", pid);
> -		m =3D live_child[deleted];
> -		live_child[deleted] =3D n;
> -		if (m.pid =3D=3D pid)
> -			return;
> -		n =3D m;
> -	}
> +	struct child **cradle, *blanket;
> +
> +	for (cradle =3D &firstborn;
> +	     (blanket =3D *cradle);
> +	     cradle =3D &blanket->next)
> +		if (blanket->pid =3D=3D pid) {
> +			*cradle =3D blanket->next;
> +			live_children--;
> +			free(blanket);
> +			break;
> +		}
>  }
> =20
>  /*
>   * This gets called if the number of connections grows
>   * past "max_connections".
>   *
> - * We _should_ start off by searching for connections
> - * from the same IP, and if there is some address wth
> - * multiple connections, we should kill that first.
> - *
> - * As it is, we just "randomly" kill 25% of the connections,
> - * and our pseudo-random generator sucks too. I have no
> - * shame.
> - *
> - * Really, this is just a place-holder for a _real_ algorithm.
> + * We kill the newest connection from a duplicate IP first.
> + * If there are no duplicates, then the newest connection is killed,
> + * in order to allow long running clones to actually complete.
>   */
> -static void kill_some_children(int signo, unsigned start, unsigned s=
top)
> +static void kill_some_child(int signo)
>  {
> -	start %=3D MAX_CHILDREN;
> -	stop %=3D MAX_CHILDREN;
> -	while (start !=3D stop) {
> -		if (!(start & 3))
> -			kill(live_child[start].pid, signo);
> -		start =3D (start + 1) % MAX_CHILDREN;
> +	const struct child *blanket;
> +
> +	if ((blanket =3D firstborn)) {
> +		const struct child *next;
> +
> +		for (; (next =3D blanket->next); blanket =3D next)
> +			if (!memcmp(&blanket->address, &next->address,
> +				   sizeof next->address))
> +				break;
> +
> +		kill(blanket->pid, signo);
>  	}
>  }
> =20
>  static void check_dead_children(void)
>  {
> -	unsigned spawned, reaped, deleted;
> -
> -	spawned =3D children_spawned;
> -	reaped =3D children_reaped;
> -	deleted =3D children_deleted;
> -
> -	while (deleted < reaped) {
> -		pid_t pid =3D dead_child[deleted % MAX_CHILDREN];
> -		const char *dead =3D pid < 0 ? " (with error)" : "";
> -
> -		if (pid < 0)
> -			pid =3D -pid;
> +	int status;
> +	pid_t pid;
> =20
> -		/* XXX: Custom logging, since we don't wanna getpid() */
> -		if (verbose) {
> -			if (log_syslog)
> -				syslog(LOG_INFO, "[%d] Disconnected%s",
> -						pid, dead);
> -			else
> -				fprintf(stderr, "[%d] Disconnected%s\n",
> -						pid, dead);
> -		}
> -		remove_child(pid, deleted, spawned);
> -		deleted++;
> +	while ((pid =3D waitpid(-1, &status, WNOHANG))>0) {
> +		const char *dead =3D "";
> +		remove_child(pid);
> +		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
> +			dead =3D " (with error)";
> +		loginfo("[%d] Disconnected%s", (int)pid, dead);
>  	}
> -	children_deleted =3D deleted;
>  }
> =20
>  static void check_max_connections(void)
>  {
>  	for (;;) {
> -		int active;
> -		unsigned spawned, deleted;
> -
>  		check_dead_children();
> -
> -		spawned =3D children_spawned;
> -		deleted =3D children_deleted;
> -
> -		active =3D spawned - deleted;
> -		if (active <=3D max_connections)
> +		if (live_children <=3D max_connections)
>  			break;
> =20
>  		/* Kill some unstarted connections with SIGTERM */
> -		kill_some_children(SIGTERM, deleted, spawned);
> -		if (active <=3D max_connections << 1)
> +		kill_some_child(SIGTERM);
> +		check_dead_children();
> +		if (live_children <=3D max_connections << 1)
>  			break;
> =20
>  		/* If the SIGTERM thing isn't helping use SIGKILL */
> -		kill_some_children(SIGKILL, deleted, spawned);
> +		kill_some_child(SIGKILL);
>  		sleep(1);
>  	}
>  }
> @@ -756,16 +701,13 @@ static void handle(int incoming, struct sockadd=
r *addr, int addrlen)
>  	pid_t pid =3D fork();
> =20
>  	if (pid) {
> -		unsigned idx;
> -
>  		close(incoming);
> -		if (pid < 0)
> +		if (pid < 0) {
> +			logerror("Couldn't fork %s", strerror(errno));
>  			return;
> +		}
> =20
> -		idx =3D children_spawned % MAX_CHILDREN;
> -		children_spawned++;
> -		add_child(idx, pid, addr, addrlen);
> -
> +		add_child(pid, addr, addrlen);
>  		check_max_connections();
>  		return;
>  	}
> @@ -779,21 +721,10 @@ static void handle(int incoming, struct sockadd=
r *addr, int addrlen)
> =20
>  static void child_handler(int signo)
>  {
> -	for (;;) {
> -		int status;
> -		pid_t pid =3D waitpid(-1, &status, WNOHANG);
> -
> -		if (pid > 0) {
> -			unsigned reaped =3D children_reaped;
> -			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
> -				pid =3D -pid;
> -			dead_child[reaped % MAX_CHILDREN] =3D pid;
> -			children_reaped =3D reaped + 1;
> -			write(child_handler_pipe[1], &status, 1);
> -			continue;
> -		}
> -		break;
> -	}
> +	/* Otherwise empty handler because systemcalls will get interrupted
> +	 * upon signal receipt
> +	 * SysV needs the handler to be reinstated
> +	 */
>  	signal(SIGCHLD, child_handler);
>  }
> =20
> @@ -836,7 +767,7 @@ static int socksetup(char *listen_addr, int liste=
n_port, int **socklist_p)
>  		if (sockfd < 0)
>  			continue;
>  		if (sockfd >=3D FD_SETSIZE) {
> -			error("too large socket descriptor.");
> +			logerror("too large socket descriptor.");
>  			close(sockfd);
>  			continue;
>  		}
> @@ -936,35 +867,30 @@ static int service_loop(int socknum, int *sockl=
ist)
>  	struct pollfd *pfd;
>  	int i;
> =20
> -	if (pipe(child_handler_pipe) < 0)
> -		die ("Could not set up pipe for child handler");
> -
> -	pfd =3D xcalloc(socknum + 1, sizeof(struct pollfd));
> +	pfd =3D xcalloc(socknum, sizeof(struct pollfd));
> =20
>  	for (i =3D 0; i < socknum; i++) {
>  		pfd[i].fd =3D socklist[i];
>  		pfd[i].events =3D POLLIN;
>  	}
> -	pfd[socknum].fd =3D child_handler_pipe[0];
> -	pfd[socknum].events =3D POLLIN;
> -
> -	child_handler(0);
> =20
>  	for (;;) {
>  		int i;
> +		int olderrno;
> +
> +		i =3D poll(pfd, socknum, -1);
> +		olderrno =3D errno;
> =20
> -		if (poll(pfd, socknum + 1, -1) < 0) {
> -			if (errno !=3D EINTR) {
> -				error("poll failed, resuming: %s",
> -				      strerror(errno));
> +		check_dead_children();
> +
> +		if (i < 0) {
> +			if (olderrno !=3D EINTR) {
> +				logerror("poll failed, resuming: %s",
> +				      strerror(olderrno));
>  				sleep(1);
>  			}
>  			continue;
>  		}
> -		if (pfd[socknum].revents & POLLIN) {
> -			read(child_handler_pipe[0], &i, 1);
> -			check_dead_children();
> -		}
> =20
>  		for (i =3D 0; i < socknum; i++) {
>  			if (pfd[i].revents & POLLIN) {
> @@ -1055,10 +981,7 @@ int main(int argc, char **argv)
>  	gid_t gid =3D 0;
>  	int i;
> =20
> -	/* Without this we cannot rely on waitpid() to tell
> -	 * what happened to our children.
> -	 */
> -	signal(SIGCHLD, SIG_DFL);
> +	child_handler(0);
> =20
>  	for (i =3D 1; i < argc; i++) {
>  		char *arg =3D argv[i];
> @@ -1105,6 +1028,10 @@ int main(int argc, char **argv)
>  			init_timeout =3D atoi(arg+15);
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--max-connections=3D")) {
> +			max_connections =3D atoi(arg+18);
> +			continue;
> +		}
>  		if (!strcmp(arg, "--strict-paths")) {
>  			strict_paths =3D 1;
>  			continue;
> @@ -1178,9 +1105,11 @@ int main(int argc, char **argv)
>  	}
> =20
>  	if (log_syslog) {
> -		openlog("git-daemon", 0, LOG_DAEMON);
> +		openlog("git-daemon", LOG_PID, LOG_DAEMON);
>  		set_die_routine(daemon_die);
>  	}
> +	else			    /* so that logging into a file is atomic */
> +		setlinebuf(stderr);
> =20
>  	if (inetd_mode && (group_name || user_name))
>  		die("--user and --group are incompatible with --inetd");
> @@ -1233,8 +1162,10 @@ int main(int argc, char **argv)
>  		return execute(peer);
>  	}
> =20
> -	if (detach)
> +	if (detach) {
>  		daemonize();
> +		loginfo("Ready to rumble");
> +	}
>  	else
>  		sanitize_stdfds();
> =20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
