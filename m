From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Sat, 08 Feb 2014 09:04:49 +0100
Message-ID: <52F5E521.4090707@web.de>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 08 09:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2uL-0002sG-Tr
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbaBHIE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 03:04:58 -0500
Received: from mout.web.de ([212.227.15.14]:57478 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaBHIEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 03:04:54 -0500
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MN47k-1W9s7Q3qUS-006jeY for <git@vger.kernel.org>;
 Sat, 08 Feb 2014 09:04:53 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:vpJI9vhAhRF0wLI38Ru04hJjnS1XYgfe9mlmiZt2EhaE03Z8dnZ
 WdKoK8HokkNw05oHFSkEkYHcRm6tsQObqCLiY3JVI/REl77o3hNoWwaJp558u50NUoEIff6
 cBH/sgkmDWKRtlr+0AeewZSu2podImupktK9OnY4VLctF8wGXpRP/Y8JXutbma90zYWJ/1B
 A4tSkK9uRmGiC0/5Rp1rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241824>

On 03.02.14 05:28, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

I managed to review the code 0..12/26, so some parts are missing.
The list below became longer than what I intended,
my comments may be hard to read,
and there is a mixture of minor and major remarks.

I would appreciate if we could have an outline of the protocol
as a seperate "document" somewhere, to be able to have a look at the pr=
otocol
first, before looking into the code.

(Am I using wireshark too much to dream about a dissector ?)

All in all I like the concept, thanks for the work.


1)
  write_in_full_timeout()
  packet_read_line_timeout()
  At other places we handle EINTR after calling poll().
  Looking at the code, it could be easier to introduce
  a new function xpoll() in wrapper.c, and use that instead
  of poll().

2)
  Similar for the usage of accept().
  I like the idea of xread() xwrite() and all the x functions
  so it coud make sense to establish xpoll() and xaccept()
  before inotify suppport.


3)
> -int unix_stream_listen(const char *path)
> +int unix_stream_listen(const char *path, int replace)
>  {
>  	int fd, saved_errno;
>  	struct sockaddr_un sa;
> @@ -103,7 +103,8 @@ int unix_stream_listen(const char *path)
>  		return -1;
>  	fd =3D unix_stream_socket();
> =20
> -	unlink(path);
> +	if (replace)
> +		unlink(path);

Minor remark:
As we do not do the replace here:
s/replace/un_link/ may be ?


4)
> +++ b/file-watcher.c
{}
> +static const char *const file_watcher_usage[] =3D {
> +	N_("git file-watcher [options] <socket directory>"),
> +	NULL
> +};
Do we already have options here?
I can think about having=20
-d daemoniye
-u uses Unix doain socket
(And later -t to use a TCP/IP socket, when the repo
 is on a mounted NFS (or SAMBA) drive, and  the daemon is on a=20
 different machine.
 I don't say this patch should include this logic in first round,
 But I can see a gain for this kind of setup)


5)
> +++ b/file-watcher.c
[]
> +static int shutdown_connection(int id)
> +{
> +	struct connection *conn =3D conns[id];
> +	conns[id] =3D NULL;
> +	pfd[id].fd =3D -1;
> +	if (!conn)
> +		return 0;
> +	close(conn->sock);
> +	free(conn);
> +	return 0;
> +}
The function is called shutdown_connection(), but it does a close()
Could it be named close_connection() ?

6)=20
> +++ b/file-watcher.c
[]
Do we have a sequence chart about the command flow between the watcher
daemon and the client ?

------------
7)

in 03/26:
>This version is also gentler than its friend packet_read_line()
gentler, what does this mean?

>because it's designed for side channel I/O that should not abort the
>program even if the channel is broken.
I'm not so familar with side-channel I/O. How does it fit in here?

Does this make sense:
In opposite to packet_read_line() which can call die()
to abort the program, read_in_full_timeout() will keep the program runn=
ing.
(or something like this)

>
>Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
>---
> cache.h    |  1 +
> pkt-line.c | 35 +++++++++++++++++++++++++++++++++++
> pkt-line.h |  1 +
> wrapper.c  | 21 +++++++++++++++++++++
> 4 files changed, 58 insertions(+)
>
>diff --git a/cache.h b/cache.h
>index 718e32b..939db46 100644
>--- a/cache.h
>+++ b/cache.h
>@@ -1230,6 +1230,7 @@ extern int write_or_whine_pipe(int fd, const voi=
d *buf, size_t count, const char
> extern void fsync_or_die(int fd, const char *);
>=20
> extern ssize_t read_in_full(int fd, void *buf, size_t count);
>+extern ssize_t read_in_full_timeout(int fd, void *buf, size_t count, =
int timeout);
> extern ssize_t write_in_full(int fd, const void *buf, size_t count);
> extern ssize_t write_in_full_timeout(int fd, const void *buf, size_t =
count, int timeout);
> static inline ssize_t write_str_in_full(int fd, const char *str)
>diff --git a/pkt-line.c b/pkt-line.c
>index cf681e9..5a07e97 100644
>--- a/pkt-line.c
>+++ b/pkt-line.c
>@@ -229,3 +229,38 @@ char *packet_read_line_buf(char **src, size_t *sr=
c_len, int *dst_len)
> {
> 	return packet_read_line_generic(-1, src, src_len, dst_len);
> }
>+

In what is the timeout measured ?
seconds, milli years?
As we use poll() I think it is milli seconds.
(I like the idea of naming timeout timeout_ms)

[]
>+	len -=3D 4;
>+	if (len >=3D buf_len) {
>+		error("protocol error: bad line length %d", len);
>+		return NULL;
>+	}
>+	if ((ret =3D read_in_full_timeout(fd, buf, len, timeout)) < 0)
>+		return NULL;
Do we want a packet_trace here?

When a timeout occurs, do we want to close the connection,
marking it as dead?
Or need to look at errno?


>+	buf[len] =3D '\0';
>+	if (len_p)
>+		*len_p =3D len;
>+	packet_trace(buf, len, 0);
>+	return buf;
>+}

>diff --git a/pkt-line.h b/pkt-line.h
>index 4b93a0c..d47dca5 100644
>--- a/pkt-line.h
>+++ b/pkt-line.h
>@@ -69,6 +69,7 @@ int packet_read(int fd, char **src_buffer, size_t *s=
rc_len, char
>  * packet is written to it.
>  */
> char *packet_read_line(int fd, int *size);
>+char *packet_read_line_timeout(int fd, int timeout, int *size);
>=20
> /*
>  * Same as packet_read_line, but read from a buf rather than a descri=
ptor;
>diff --git a/wrapper.c b/wrapper.c
>index 9a0e289..9cf10b2 100644
>--- a/wrapper.c
>+++ b/wrapper.c
>@@ -193,6 +193,27 @@ ssize_t read_in_full(int fd, void *buf, size_t co=
unt)
> 	return total;
> }
>=20
>+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int tim=
eout)
>+{
>+	char *p =3D buf;
>+	ssize_t total =3D 0;
>+	struct pollfd pfd;
>+
>+	pfd.fd =3D fd;
>+	pfd.events =3D POLLIN;
>+	while (count > 0 && poll(&pfd, 1, timeout) > 0 &&
>+	       (pfd.revents & POLLIN)) {
>+		ssize_t loaded =3D xread(fd, p, count);
>+		if (loaded <=3D 0)
>+			return -1;
>+		count -=3D loaded;
>+		p +=3D loaded;
>+		total +=3D loaded;
>+	}
>+
>+	return count ? -1 : total;
Isn't it that=20
ret < 0  means "error of some kind"
ret =3D=3D 0 means EOF,
ret > 0  means some data
Why do we turn 0 into -1?

--------------
8)
+++ b/unix-socket.c
@@ -93,7 +93,7 @@ fail:
 	return -1;
 }
=20
-int unix_stream_listen(const char *path)
+int unix_stream_listen(const char *path, int replace)
 {
 	int fd, saved_errno;
 	struct sockaddr_un sa;
@@ -103,7 +103,8 @@ int unix_stream_listen(const char *path)
 		return -1;
 	fd =3D unix_stream_socket();
=20
-	unlink(path);
+	if (replace)
+		unlink(path);
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
Why do we call the parameter replace, when it does an
unlink() ?
s/replace/un_link/ ?=20


9)
>Access to the unix socket $WATCHER/socket is covered by $WATCHER's
>permission. While the file watcher does not carry much information,
>repo file listing is sometimes not something you want other users to
>see. Make sure $WATCHER has 0700 permission to stop unwanted access.

>Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
>---
> file-watcher.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

I feel a little bit unsure about the 700.
Most often Git does not care about permissions,
and relies on umask being set appropriatly.
(Please correct me if I'm wrong)

My spontanous feeling is that adjust_shared_perm() could be used.

10)
An other thing:
>strbuf_addf(&sb, "%s/socket", socket_path);
Does it make sense to name the socket "%s/watcher" ?


11)
>In daemon mode, stdout and stderr are saved in $WATCHER/log.

[]
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-file-watcher.txt |  2 ++
 cache.h                            |  1 +
 daemon.c                           | 30 ++++--------------------------
 file-watcher.c                     | 17 +++++++++++++++++
 setup.c                            | 25 +++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
index 625a389..ec81f18 100644
--- a/Documentation/git-file-watcher.txt
+++ b/Documentation/git-file-watcher.txt
@@ -18,6 +18,8 @@ lstat(2) to detect that itself.
=20
 OPTIONS
 -------
+--detach::
+	Run in background.

Shouldn't that be named --daemon ?


12)
>read_cache() connects to the file watcher, specified by
>filewatcher.path config, and performs basic hand shaking. CE_WATCHED
>is cleared if git and file watcher have different views on the index
>state.
>
>All send/receive calls must be complete within a limited time to avoid
>a buggy file-watcher hang "git status" forever. And the whole point of
>doing this is speed. If file watcher can't respond fast enough, for
>whatever reason, then it should not be used.
>
>Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
>---
> Documentation/config.txt           |  10 +++
> Documentation/git-file-watcher.txt |   4 +-
> Makefile                           |   1 +
> cache.h                            |   1 +
> file-watcher-lib.c (new)           |  91 ++++++++++++++++++++++
> file-watcher-lib.h (new)           |   6 ++
> file-watcher.c                     | 152 ++++++++++++++++++++++++++++=
++++++++-
> read-cache.c                       |   6 ++
> 8 files changed, 269 insertions(+), 2 deletions(-)
> create mode 100644 file-watcher-lib.c
> create mode 100644 file-watcher-lib.h
>
>diff --git a/Documentation/config.txt b/Documentation/config.txt
>index 5f4d793..6ad653a 100644
>--- a/Documentation/config.txt
>+++ b/Documentation/config.txt
>@@ -1042,6 +1042,16 @@ difftool.<tool>.cmd::
> difftool.prompt::
> 	Prompt before each invocation of the diff tool.
>=20
>+filewatcher.path::
>+	The directory that contains the socket of `git	file-watcher`.
>+	If it's not an absolute path, it's relative to $GIT_DIR. An
>+	empty path means no connection to file watcher.
I would really like to be able to have different tranport mechanismen
using the same config.
Today this is only a matter of documentation and naming things:

How about this idea:
filewatcher.url::
The directory that contains the socket of `git	file-watcher`.
It can be an absolute path, meaning a unix domain socket in the
file system.
It can be a path relative to $GIT_DIR.

It must start with either=20
"/" (absolut path) or=20
"./" (relative path to $GIT_DIR) or=20
"~/" (relaive path in your $HOME directoy.
An empty url means no connection to file watcher.
(Later we can add url schemes like "tcp://" or "pipe://")


>+
>+filewatcher.timeout::
>+	This is the maximum time in milliseconds that Git waits for
>+	the file watcher to respond before giving up. Default value is
>+	50. Setting to -1 makes Git wait forever.
50 feels low, especially on "older/slower machines"
200 is probably acceptable even for the very impatient user,
I could think of 500 to make the user aware of it.

[]
>+	/*
>+	 * ">" denotes an incoming packet, "<" outgoing. The lack of
>+	 * "<" means no reply expected.
>+	 *
>+	 * < "error" SP ERROR-STRING
>+	 *
>+	 * This can be sent whenever the client violates the protocol.
>+	 */
>+
>+	msg =3D packet_read_line(fd, &len);
>+	if (!msg) {
>+		packet_write(fd, "error invalid pkt-line");
>+		return shutdown_connection(conn_id);
>+	}
>+
>+	/*
>+	 * > "hello" [SP CAP [SP CAP..]]
>+	 * < "hello" [SP CAP [SP CAP..]]
>+	 *
>+	 * Advertise capabilities of both sides. File watcher may
>+	 * disconnect if the client does not advertise the required
>+	 * capabilities. Capabilities in uppercase MUST be
>+	 * supported. If any side does not understand any of the
>+	 * advertised uppercase capabilities, it must disconnect.
>+	 */
>+	if ((arg =3D skip_prefix(msg, "hello"))) {
>+		if (*arg) {	/* no capabilities supported yet */
>+			packet_write(fd, "error capabilities not supported");
>+			return shutdown_connection(conn_id);
>+		}
>+		packet_write(fd, "hello");
>+		conns[conn_id]->polite =3D 1;
>+	}
>+
>+	/*
>+	 * > "index" SP INDEX-SIGNATURE SP WORK-TREE-PATH
>+	 * < "ok" | "inconsistent"
>+	 *
>+	 * INDEX-SIGNATURE consists of 40 hexadecimal letters
>+	 * WORK-TREE-PATH must be absolute and normalized path
>+	 *
>+	 * Watch file changes in index. The client sends the index and
>+	 * work tree info. File watcher validates that it holds the
>+	 * same info. If so it sends "ok" back indicating both sides
>+	 * are on the same page and CE_WATCHED bits can be ketpt.
>+	 *
>+	 * Otherwise it sends "inconsistent" and both sides must reset
>+	 * back to initial state. File watcher keeps its index
>+	 * signature all-zero until the client has updated the index
>+	 * ondisk and request to update index signature.
>+	 *
>+	 * "hello" must be exchanged first. After this command the
>+	 * connection is associated with a worktree/index. Many
>+	 * commands may require this to proceed.
>+	 */
>+	else if (starts_with(msg, "index ")) {
>+		struct repository *repo;
>+		struct stat st;
>+		if (!conns[conn_id]->polite) {
>+			packet_write(fd, "error why did you not greet me? go away");
>+			return shutdown_connection(conn_id);
>+		}
>+		if (len < 47 || msg[46] !=3D ' ' || !is_absolute_path(msg + 47)) {
>+			packet_write(fd, "error invalid index line %s", msg);
>+			return shutdown_connection(conn_id);
>+		}
>+
>+		if (lstat(msg + 47, &st) || !S_ISDIR(st.st_mode)) {
>+			packet_write(fd, "error work tree does not exist: %s",
>+				     strerror(errno));
>+			return shutdown_connection(conn_id);
>+		}
>+		repo =3D get_repo(msg + 47);
>+		conns[conn_id]->repo =3D repo;
>+		if (memcmp(msg + 6, repo->index_signature, 40) ||
>+		    !memcmp(msg + 6, invalid_signature, 40) ||
>+		    repo->inode !=3D st.st_ino) {
>+			packet_write(fd, "inconsistent");
>+			reset_repo(repo, st.st_ino);
>+			return 0;
>+		}
>+		packet_write(fd, "ok");
>+	}
>+	else {
>+		packet_write(fd, "error unrecognized command %s", msg);
>+		return shutdown_connection(conn_id);
I feel a little bit unsure about this.
We establish a protocol which is not extendable.
Do we need to call shutdown_connection() ?
(And as I noticed earlier, close_connection() could be a better name)
