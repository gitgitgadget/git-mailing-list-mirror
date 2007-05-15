From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Ensure return value from xread() is always stored into an
 ssize_t
Date: Tue, 15 May 2007 18:21:57 +0200
Message-ID: <200705151821.58068.johan@herland.net>
References: <34a7ae040705150447k2e770b5ag3629632f61b813a0@mail.gmail.com>
 <200705151449.22744.johan@herland.net>
 <56b7f5510705150912x7ab3ac0clcd494d5f4367c314@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Paolo Teti <paolo.teti@gmail.com>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 18:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnzmr-0001da-P2
	for gcvg-git@gmane.org; Tue, 15 May 2007 18:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbXEOQWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 12:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbXEOQWG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 12:22:06 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50973 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbXEOQWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 12:22:05 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI30010JC4RM800@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 18:22:03 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI300K04C4MIJ20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 18:21:58 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI300G26C4M7OE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 15 May 2007 18:21:58 +0200 (CEST)
In-reply-to: <56b7f5510705150912x7ab3ac0clcd494d5f4367c314@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47356>

On Tuesday 15 May 2007, Dana How wrote:
> Twice you change an int to a size_t (one s).
> [builtin-fetch-tool.c and pkt-line.c .]
> Did you want to do that?

Yes. AFAICS it was appropriate in the given context.
I.e. in both cases the int was used as an positive offset/size, and
although its value was altered by the ssize_t returned from xread(),
the ssize_t was always verified to be >= 0 before being added to the int.


Have fun!

...Johan

> On 5/15/07, Johan Herland <johan@herland.net> wrote:
> > This patch fixes all calls to xread() where the return value is not
> > stored into an ssize_t. The patch should not have any effect whatsoever,
> > other than putting better/more appropriate type names on variables.
> >
> > Signed-off-by: Johan Herland <johan@herland.net>
> > ---
> >
> > Feel free to ignore this patch as it may be argued that it needlessly
> > touches a lot of code, without having much (if any) positive effect
> > at all.
> >
> >  builtin-apply.c          |    4 ++--
> >  builtin-bundle.c         |    2 +-
> >  builtin-fetch--tool.c    |    4 ++--
> >  builtin-unpack-objects.c |    2 +-
> >  combine-diff.c           |    2 +-
> >  copy.c                   |    3 +--
> >  diff.c                   |    2 +-
> >  imap-send.c              |    2 +-
> >  index-pack.c             |    2 +-
> >  pkt-line.c               |    4 ++--
> >  sha1_file.c              |    2 +-
> >  ssh-upload.c             |    2 +-
> >  12 files changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 8b8705a..0399743 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -185,7 +185,7 @@ static void *read_patch_file(int fd, unsigned long *sizep)
> >         void *buffer = xmalloc(alloc);
> >
> >         for (;;) {
> > -               int nr = alloc - size;
> > +               ssize_t nr = alloc - size;
> >                 if (nr < 1024) {
> >                         alloc += CHUNKSIZE;
> >                         buffer = xrealloc(buffer, alloc);
> > @@ -1468,7 +1468,7 @@ static int read_old_data(struct stat *st, const char *path, char **buf_p, unsign
> >                         return error("unable to open %s", path);
> >                 got = 0;
> >                 for (;;) {
> > -                       int ret = xread(fd, buf + got, size - got);
> > +                       ssize_t ret = xread(fd, buf + got, size - got);
> >                         if (ret <= 0)
> >                                 break;
> >                         got += ret;
> > diff --git a/builtin-bundle.c b/builtin-bundle.c
> > index d1635a0..306ad29 100644
> > --- a/builtin-bundle.c
> > +++ b/builtin-bundle.c
> > @@ -48,7 +48,7 @@ static int read_string(int fd, char *buffer, int size)
> >  {
> >         int i;
> >         for (i = 0; i < size - 1; i++) {
> > -               int count = xread(fd, buffer + i, 1);
> > +               ssize_t count = xread(fd, buffer + i, 1);
> >                 if (count < 0)
> >                         return error("Read error: %s", strerror(errno));
> >                 if (count == 0) {
> > diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
> > index 2065466..12adb38 100644
> > --- a/builtin-fetch--tool.c
> > +++ b/builtin-fetch--tool.c
> > @@ -6,11 +6,11 @@
> >
> >  static char *get_stdin(void)
> >  {
> > -       int offset = 0;
> > +       size_t offset = 0;
> >         char *data = xmalloc(CHUNK_SIZE);
> >
> >         while (1) {
> > -               int cnt = xread(0, data + offset, CHUNK_SIZE);
> > +               ssize_t cnt = xread(0, data + offset, CHUNK_SIZE);
> >                 if (cnt < 0)
> >                         die("error reading standard input: %s",
> >                             strerror(errno));
> > diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> > index 2bbda67..a6ff62f 100644
> > --- a/builtin-unpack-objects.c
> > +++ b/builtin-unpack-objects.c
> > @@ -34,7 +34,7 @@ static void *fill(int min)
> >                 offset = 0;
> >         }
> >         do {
> > -               int ret = xread(0, buffer + len, sizeof(buffer) - len);
> > +               ssize_t ret = xread(0, buffer + len, sizeof(buffer) - len);
> >                 if (ret <= 0) {
> >                         if (!ret)
> >                                 die("early EOF");
> > diff --git a/combine-diff.c b/combine-diff.c
> > index cff9c5d..ea3ca5f 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -714,7 +714,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
> >                         result_size = len;
> >                         result = xmalloc(len + 1);
> >                         while (sz < len) {
> > -                               int done = xread(fd, result+sz, len-sz);
> > +                               ssize_t done = xread(fd, result+sz, len-sz);
> >                                 if (done == 0)
> >                                         break;
> >                                 if (done < 0)
> > diff --git a/copy.c b/copy.c
> > index 08a3d38..d340bb2 100644
> > --- a/copy.c
> > +++ b/copy.c
> > @@ -3,10 +3,9 @@
> >  int copy_fd(int ifd, int ofd)
> >  {
> >         while (1) {
> > -               int len;
> >                 char buffer[8192];
> >                 char *buf = buffer;
> > -               len = xread(ifd, buffer, sizeof(buffer));
> > +               ssize_t len = xread(ifd, buffer, sizeof(buffer));
> >                 if (!len)
> >                         break;
> >                 if (len < 0) {
> > diff --git a/diff.c b/diff.c
> > index 8354e71..33297aa 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1411,7 +1411,7 @@ static int populate_from_stdin(struct diff_filespec *s)
> >  #define INCREMENT 1024
> >         char *buf;
> >         unsigned long size;
> > -       int got;
> > +       ssize_t got;
> >
> >         size = 0;
> >         buf = NULL;
> > diff --git a/imap-send.c b/imap-send.c
> > index 84df2fa..4283a4a 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -224,7 +224,7 @@ socket_perror( const char *func, Socket_t *sock, int ret )
> >  static int
> >  socket_read( Socket_t *sock, char *buf, int len )
> >  {
> > -       int n = xread( sock->fd, buf, len );
> > +       ssize_t n = xread( sock->fd, buf, len );
> >         if (n <= 0) {
> >                 socket_perror( "read", sock, n );
> >                 close( sock->fd );
> > diff --git a/index-pack.c b/index-pack.c
> > index b9da19f..58c4a9c 100644
> > --- a/index-pack.c
> > +++ b/index-pack.c
> > @@ -82,7 +82,7 @@ static void *fill(int min)
> >                 die("cannot fill %d bytes", min);
> >         flush();
> >         do {
> > -               int ret = xread(input_fd, input_buffer + input_len,
> > +               ssize_t ret = xread(input_fd, input_buffer + input_len,
> >                                 sizeof(input_buffer) - input_len);
> >                 if (ret <= 0) {
> >                         if (!ret)
> > diff --git a/pkt-line.c b/pkt-line.c
> > index b4cb7e2..b605268 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -65,10 +65,10 @@ void packet_write(int fd, const char *fmt, ...)
> >
> >  static void safe_read(int fd, void *buffer, unsigned size)
> >  {
> > -       int n = 0;
> > +       size_t n = 0;
> >
> >         while (n < size) {
> > -               int ret = xread(fd, (char *) buffer + n, size - n);
> > +               ssize_t ret = xread(fd, (char *) buffer + n, size - n);
> >                 if (ret < 0)
> >                         die("read error (%s)", strerror(errno));
> >                 if (!ret)
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 32244d7..be991ed 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -2276,7 +2276,7 @@ int read_pipe(int fd, char** return_buf, unsigned long* return_size)
> >  {
> >         char* buf = *return_buf;
> >         unsigned long size = *return_size;
> > -       int iret;
> > +       ssize_t iret;
> >         unsigned long off = 0;
> >
> >         do {
> > diff --git a/ssh-upload.c b/ssh-upload.c
> > index 2f04572..498d41e 100644
> > --- a/ssh-upload.c
> > +++ b/ssh-upload.c
> > @@ -86,7 +86,7 @@ static int serve_ref(int fd_in, int fd_out)
> >
> >  static void service(int fd_in, int fd_out) {
> >         char type;
> > -       int retval;
> > +       ssize_t retval;
> >         do {
> >                 retval = xread(fd_in, &type, 1);
> >                 if (retval < 1) {
> > --
> > 1.5.1.4
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



-- 
Johan Herland, <johan@herland.net>
www.herland.net
