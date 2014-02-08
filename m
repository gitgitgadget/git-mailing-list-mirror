From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Sat, 8 Feb 2014 15:53:05 +0700
Message-ID: <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 08 09:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC3fS-0007XI-2p
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaBHIxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 03:53:37 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59804 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaBHIxf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 03:53:35 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so6822321qab.33
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jroj3Rc2VV5NrTiOVkG+dKJDY8xygZ0voqirYg5lX5w=;
        b=fUHN1PAuCk+8gPSFOOK2OK5YAC5009a2u+9jckHe/uecWaDbkl9BUHSH4frjCoH977
         lZ7ovxICVEzWuX4zzGR1mDTdaPEnlo7Nr+Gg9nRpG2uuHm5hdDEoPtwka7dp8ggDMkwn
         hcV0JQr5gUooOrPxyv/Q1lyT+QU97UiVNclne6cSveAhbNi7qz+k/6UeFGw6RM/JvBpj
         roc1EI/dN8E0a+25PidG2XJJBpWKVR9bR5MOJ+f0ctXcF4nFEgbIW14HSe7UM3RyQI7x
         ON4k+/jLJ6VbByJLOFf9pam6/fuuRahEEgN2b1JcZXlV3XqukdIMY3+TSVZBtKFEQm6t
         yPMw==
X-Received: by 10.224.36.129 with SMTP id t1mr27254220qad.8.1391849615136;
 Sat, 08 Feb 2014 00:53:35 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 8 Feb 2014 00:53:05 -0800 (PST)
In-Reply-To: <52F5E521.4090707@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241829>

Thanks for the comments. I can see I now have some work to do in the
coming weeks :)

On Sat, Feb 8, 2014 at 3:04 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> I would appreciate if we could have an outline of the protocol
> as a seperate "document" somewhere, to be able to have a look at the =
protocol
> first, before looking into the code.

My fear is document becomes outdated because people don't always
remember to update doc when they change code. Which is why I embed the
protocol as comments in handle_command() function. If the final
version [1] is still not easy to read, I'll split the protocol out
into a separate document.

[1] https://github.com/pclouds/git/blob/file-watcher/file-watcher.c#L67=
2

> (Am I using wireshark too much to dream about a dissector ?)

Try GIT_TRACE_PACKET=3D2

> 1)
>   write_in_full_timeout()
>   packet_read_line_timeout()
>   At other places we handle EINTR after calling poll().
>   Looking at the code, it could be easier to introduce
>   a new function xpoll() in wrapper.c, and use that instead
>   of poll().

Yeah there are already 4 poll call sites before file-watcher jumps in. =
Will do.

> 2)
>   Similar for the usage of accept().
>   I like the idea of xread() xwrite() and all the x functions
>   so it coud make sense to establish xpoll() and xaccept()
>   before inotify suppport.

OK

> 3)
>> -int unix_stream_listen(const char *path)
>> +int unix_stream_listen(const char *path, int replace)
>>  {
>>       int fd, saved_errno;
>>       struct sockaddr_un sa;
>> @@ -103,7 +103,8 @@ int unix_stream_listen(const char *path)
>>               return -1;
>>       fd =3D unix_stream_socket();
>>
>> -     unlink(path);
>> +     if (replace)
>> +             unlink(path);
>
> Minor remark:
> As we do not do the replace here:
> s/replace/un_link/ may be ?

Heh, I thought of using the name "unlink" but it's taken so I chose
"replace" and did not think of underscore.Will do.

> 4)
>> +++ b/file-watcher.c
> {}
>> +static const char *const file_watcher_usage[] =3D {
>> +     N_("git file-watcher [options] <socket directory>"),
>> +     NULL
>> +};
> Do we already have options here?
> I can think about having
> -d daemoniye
> -u uses Unix doain socket
> (And later -t to use a TCP/IP socket, when the repo
>  is on a mounted NFS (or SAMBA) drive, and  the daemon is on a
>  different machine.
>  I don't say this patch should include this logic in first round,
>  But I can see a gain for this kind of setup)

Later on we have two, --detach (i.e. daemonize, I reuse the same name
from git-daemon) and --check-support. Transport settings (like unix vs
tcp/ip...) should be config options though. You don't want to specify
it here, then again when you run "git status". Actually I should add
--default, that will retrieve <socket directory> from config key
filewatcher.path, so the user does not have to specify it..

> 5)
>> +++ b/file-watcher.c
> []
>> +static int shutdown_connection(int id)
>> +{
>> +     struct connection *conn =3D conns[id];
>> +     conns[id] =3D NULL;
>> +     pfd[id].fd =3D -1;
>> +     if (!conn)
>> +             return 0;
>> +     close(conn->sock);
>> +     free(conn);
>> +     return 0;
>> +}
> The function is called shutdown_connection(), but it does a close()
> Could it be named close_connection() ?

Yes, there was a close_connection() which did something similar, and
then it was killed off. Will rename.

> 6)
>> +++ b/file-watcher.c
> []
> Do we have a sequence chart about the command flow between the watche=
r
> daemon and the client ?

I suggest you have a look at the file-watcher test. For example, from
[2] we have this sequence

<hello
>hello
<index $SIG $TRASH_DIRECTORY
>inconsistent
# Do not call inotify_add_watch()
<test-mode
>test mode on
# First batch should be all ok
<<watch
<<dir1/foo
<<dir2/foo
<<dir3/foo
<<dir4/foo
=2E..

"<" denotes a packet from the client to file-watcher, ">" the opposite
direction. But you can always obtain a real flow with
GIT_TRACE_PACKET=3D2 (path lists not available though, so really just a
flow).

[2] https://github.com/pclouds/git/blob/file-watcher/t/t7513-file-watch=
er.sh#L273

> in 03/26:
>>This version is also gentler than its friend packet_read_line()
> gentler, what does this mean?

No dying for whatever error. packet_read_line is designed for git
protocol. It's the main job so if there's an error, dying is the right
thing to do. file-watcher on the other hand is a side job and should
not stop whatever command from doing. Will update commit message.

>>because it's designed for side channel I/O that should not abort the
>>program even if the channel is broken.
> I'm not so familar with side-channel I/O. How does it fit in here?

To sum up, whatever error in communication with file-watcher should
not stop you from doing whatever you're doing. file-watcher is
contacted whenever $GIT_DIR/index is read, so "whatever you're doing"
is basically all git commands that involve worktree or index.

> Does this make sense:
> In opposite to packet_read_line() which can call die()
> to abort the program, read_in_full_timeout() will keep the program ru=
nning.
> (or something like this)

Exactly!

>>diff --git a/cache.h b/cache.h
>>index 718e32b..939db46 100644
>>--- a/cache.h
>>+++ b/cache.h
>>@@ -1230,6 +1230,7 @@ extern int write_or_whine_pipe(int fd, const vo=
id *buf, size_t count, const char
>> extern void fsync_or_die(int fd, const char *);
>>
>> extern ssize_t read_in_full(int fd, void *buf, size_t count);
>>+extern ssize_t read_in_full_timeout(int fd, void *buf, size_t count,=
 int timeout);
>> extern ssize_t write_in_full(int fd, const void *buf, size_t count);
>> extern ssize_t write_in_full_timeout(int fd, const void *buf, size_t=
 count, int timeout);
>> static inline ssize_t write_str_in_full(int fd, const char *str)
>>diff --git a/pkt-line.c b/pkt-line.c
>>index cf681e9..5a07e97 100644
>>--- a/pkt-line.c
>>+++ b/pkt-line.c
>>@@ -229,3 +229,38 @@ char *packet_read_line_buf(char **src, size_t *s=
rc_len, int *dst_len)
>> {
>>       return packet_read_line_generic(-1, src, src_len, dst_len);
>> }
>>+
>
> In what is the timeout measured ?
> seconds, milli years?
> As we use poll() I think it is milli seconds.
> (I like the idea of naming timeout timeout_ms)

Yes in ms. Will rename.

>>+      len -=3D 4;
>>+      if (len >=3D buf_len) {
>>+              error("protocol error: bad line length %d", len);
>>+              return NULL;
>>+      }
>>+      if ((ret =3D read_in_full_timeout(fd, buf, len, timeout)) < 0)
>>+              return NULL;
> Do we want a packet_trace here?

Compared to packet_read_line(), probably not.

> When a timeout occurs, do we want to close the connection,
> marking it as dead?
> Or need to look at errno?

We do want to close the connection, but the caller should do that and
clear the file handle variable at the same time. Or we risk race
condition.

>>diff --git a/wrapper.c b/wrapper.c
>>index 9a0e289..9cf10b2 100644
>>--- a/wrapper.c
>>+++ b/wrapper.c
>>@@ -193,6 +193,27 @@ ssize_t read_in_full(int fd, void *buf, size_t c=
ount)
>>       return total;
>> }
>>
>>+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int ti=
meout)
>>+{
>>+      char *p =3D buf;
>>+      ssize_t total =3D 0;
>>+      struct pollfd pfd;
>>+
>>+      pfd.fd =3D fd;
>>+      pfd.events =3D POLLIN;
>>+      while (count > 0 && poll(&pfd, 1, timeout) > 0 &&
>>+             (pfd.revents & POLLIN)) {
>>+              ssize_t loaded =3D xread(fd, p, count);
>>+              if (loaded <=3D 0)
>>+                      return -1;
>>+              count -=3D loaded;
>>+              p +=3D loaded;
>>+              total +=3D loaded;
>>+      }
>>+
>>+      return count ? -1 : total;
> Isn't it that
> ret < 0  means "error of some kind"
> ret =3D=3D 0 means EOF,
> ret > 0  means some data
> Why do we turn 0 into -1?

Because this is read_in_full. The caller expects either all is read, or=
 errors.

> 9)
>>Access to the unix socket $WATCHER/socket is covered by $WATCHER's
>>permission. While the file watcher does not carry much information,
>>repo file listing is sometimes not something you want other users to
>>see. Make sure $WATCHER has 0700 permission to stop unwanted access.
>
>>Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
>>---
>> file-watcher.c | 32 ++++++++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>
> I feel a little bit unsure about the 700.
> Most often Git does not care about permissions,
> and relies on umask being set appropriatly.
> (Please correct me if I'm wrong)

Git does care. See credential-cache--daemon.c. In fact this function
is a copy of check_socket_directory() from that file.

> My spontanous feeling is that adjust_shared_perm() could be used.
>
> 10)
> An other thing:
>>strbuf_addf(&sb, "%s/socket", socket_path);
> Does it make sense to name the socket "%s/watcher" ?

No strong opinions. Whatever name works for me. Will change unless
somebody else raises their voice.

> 11)
>>In daemon mode, stdout and stderr are saved in $WATCHER/log.

Mostly for debugging purposes.

> diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-f=
ile-watcher.txt
> index 625a389..ec81f18 100644
> --- a/Documentation/git-file-watcher.txt
> +++ b/Documentation/git-file-watcher.txt
> @@ -18,6 +18,8 @@ lstat(2) to detect that itself.
>
>  OPTIONS
>  -------
> +--detach::
> +       Run in background.
>
> Shouldn't that be named --daemon ?

I just followed the naming convention in git-daemon. I think detach is
more friendly then daemon anyway.

> 12)
>>+filewatcher.path::
>>+      The directory that contains the socket of `git  file-watcher`.
>>+      If it's not an absolute path, it's relative to $GIT_DIR. An
>>+      empty path means no connection to file watcher.
> I would really like to be able to have different tranport mechanismen
> using the same config.
> Today this is only a matter of documentation and naming things:
>
> How about this idea:
> filewatcher.url::
> The directory that contains the socket of `git  file-watcher`.
> It can be an absolute path, meaning a unix domain socket in the
> file system.
> It can be a path relative to $GIT_DIR.
>
> It must start with either
> "/" (absolut path) or
> "./" (relative path to $GIT_DIR) or
> "~/" (relaive path in your $HOME directoy.
> An empty url means no connection to file watcher.
> (Later we can add url schemes like "tcp://" or "pipe://")

Makes sense.

>>+filewatcher.timeout::
>>+      This is the maximum time in milliseconds that Git waits for
>>+      the file watcher to respond before giving up. Default value is
>>+      50. Setting to -1 makes Git wait forever.
> 50 feels low, especially on "older/slower machines"
> 200 is probably acceptable even for the very impatient user,
> I could think of 500 to make the user aware of it.

Note that this timeout should never kick in unless there is an error
in communication. So in practice it should not matter much. OK I lied
a bit because file-watcher hard codes to "ping" the client every 30ms
to avoid this timeout. So it does matter, but very little.

>>+      /*
>>+       * ">" denotes an incoming packet, "<" outgoing. The lack of
>>+       * "<" means no reply expected.
>>+       *
>>+       * < "error" SP ERROR-STRING
>>+       *
>>+       * This can be sent whenever the client violates the protocol.
>>+       */
>>+
>>+      msg =3D packet_read_line(fd, &len);
>>+      if (!msg) {
>>+              packet_write(fd, "error invalid pkt-line");
>>+              return shutdown_connection(conn_id);
>>+      }
>>+
>>+      /*
>>+       * > "hello" [SP CAP [SP CAP..]]
>>+       * < "hello" [SP CAP [SP CAP..]]
>>+       *
>>+       * Advertise capabilities of both sides. File watcher may
>>+       * disconnect if the client does not advertise the required
>>+       * capabilities. Capabilities in uppercase MUST be
>>+       * supported. If any side does not understand any of the
>>+       * advertised uppercase capabilities, it must disconnect.
>>+       */
>>+      if ((arg =3D skip_prefix(msg, "hello"))) {
>>+              if (*arg) {     /* no capabilities supported yet */
>>+                      packet_write(fd, "error capabilities not suppo=
rted");
>>+                      return shutdown_connection(conn_id);
>>+              }
>>+              packet_write(fd, "hello");
>>+              conns[conn_id]->polite =3D 1;
>>+      }
>>+
>>+      /*
>>+       * > "index" SP INDEX-SIGNATURE SP WORK-TREE-PATH
>>+       * < "ok" | "inconsistent"
>>+       *
>>+       * INDEX-SIGNATURE consists of 40 hexadecimal letters
>>+       * WORK-TREE-PATH must be absolute and normalized path
>>+       *
>>+       * Watch file changes in index. The client sends the index and
>>+       * work tree info. File watcher validates that it holds the
>>+       * same info. If so it sends "ok" back indicating both sides
>>+       * are on the same page and CE_WATCHED bits can be ketpt.
>>+       *
>>+       * Otherwise it sends "inconsistent" and both sides must reset
>>+       * back to initial state. File watcher keeps its index
>>+       * signature all-zero until the client has updated the index
>>+       * ondisk and request to update index signature.
>>+       *
>>+       * "hello" must be exchanged first. After this command the
>>+       * connection is associated with a worktree/index. Many
>>+       * commands may require this to proceed.
>>+       */
>>+      else if (starts_with(msg, "index ")) {
>>+              struct repository *repo;
>>+              struct stat st;
>>+              if (!conns[conn_id]->polite) {
>>+                      packet_write(fd, "error why did you not greet =
me? go away");
>>+                      return shutdown_connection(conn_id);
>>+              }
>>+              if (len < 47 || msg[46] !=3D ' ' || !is_absolute_path(=
msg + 47)) {
>>+                      packet_write(fd, "error invalid index line %s"=
, msg);
>>+                      return shutdown_connection(conn_id);
>>+              }
>>+
>>+              if (lstat(msg + 47, &st) || !S_ISDIR(st.st_mode)) {
>>+                      packet_write(fd, "error work tree does not exi=
st: %s",
>>+                                   strerror(errno));
>>+                      return shutdown_connection(conn_id);
>>+              }
>>+              repo =3D get_repo(msg + 47);
>>+              conns[conn_id]->repo =3D repo;
>>+              if (memcmp(msg + 6, repo->index_signature, 40) ||
>>+                  !memcmp(msg + 6, invalid_signature, 40) ||
>>+                  repo->inode !=3D st.st_ino) {
>>+                      packet_write(fd, "inconsistent");
>>+                      reset_repo(repo, st.st_ino);
>>+                      return 0;
>>+              }
>>+              packet_write(fd, "ok");
>>+      }
>>+      else {
>>+              packet_write(fd, "error unrecognized command %s", msg)=
;
>>+              return shutdown_connection(conn_id);
> I feel a little bit unsure about this.
> We establish a protocol which is not extendable.

It should be extensible via "hello" message, as described in the
comments above it.

> Do we need to call shutdown_connection() ?

If you receive an unrecognized command, there's not much you can do
but shut the connection down.
--=20
Duy
