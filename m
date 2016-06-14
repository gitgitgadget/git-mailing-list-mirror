From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 18:26:33 -0400
Message-ID: <20160614222633.GA32020@sigill.intra.peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 00:27:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwoC-0006Yj-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 00:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbcFNW0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 18:26:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:54924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751943AbcFNW0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 18:26:41 -0400
Received: (qmail 17039 invoked by uid 102); 14 Jun 2016 22:26:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 18:26:35 -0400
Received: (qmail 1000 invoked by uid 107); 14 Jun 2016 22:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 18:26:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 18:26:33 -0400
Content-Disposition: inline
In-Reply-To: <20160614215019.GB22334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297344>

On Tue, Jun 14, 2016 at 05:50:19PM -0400, Jeff King wrote:

> On Tue, Jun 14, 2016 at 11:13:54AM -0700, Junio C Hamano wrote:
> 
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> > 
> > >  	bottom = signature->len;
> > > -	len = strbuf_read(signature, gpg.out, 1024);
> > > +	strbuf_read(signature, gpg.out, 1024);
> > > +	strbuf_read(&err, gpg.err, 0);
> > 
> > Hmmmm, isn't this asking for a deadlock?  When GPG spews more than
> > what would fit in a pipe buffer to its standard error (hence gets
> > blocked), its standard output may not complete, and the we would get
> > stuck by attempting to read from gpg.out, failing to reach the other
> > strbuf_read() that would unblock GPG by reading from gpg.err?
> 
> Yeah, it definitely is a deadlock. I think we'd need a select loop to
> read into multiple strbufs at once (we can't use "struct async" because
> that might happen in another process).

Something like this on top of Michael's patch (only lightly tested).

I'm still undecided on whether it is a better approach than making sure
the stdout we got looks sane. In particular I'd worry that it would make
things harder for somebody trying to plug in something gpg-like (e.g.,
if you wanted to do something exotic like call a program which fetched
the signature from a remote device or something). But it's probably not
_that_ hard for such a script to emulate --status-fd.

---
diff --git a/gpg-interface.c b/gpg-interface.c
index 850dc81..576e462 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -153,6 +153,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	const char *args[5];
 	size_t i, j, bottom;
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf_reader readers[2];
 
 	gpg.argv = args;
 	gpg.in = -1;
@@ -183,8 +184,15 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	close(gpg.in);
 
 	bottom = signature->len;
-	strbuf_read(signature, gpg.out, 1024);
-	strbuf_read(&err, gpg.err, 0);
+
+	readers[0].buf = signature;
+	readers[0].fd = gpg.out;
+	readers[0].hint = 1024;
+	readers[1].buf = &err;
+	readers[1].fd = gpg.err;
+	readers[1].hint = 1024;
+	strbuf_read_parallel(readers, 2);
+
 	close(gpg.out);
 	close(gpg.err);
 
diff --git a/strbuf.c b/strbuf.c
index 1ba600b..f674b23 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -395,6 +395,58 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	return cnt;
 }
 
+void strbuf_read_parallel(struct strbuf_reader *readers, int nr)
+{
+	int i;
+	struct pollfd *pfd;
+
+	ALLOC_ARRAY(pfd, nr);
+	for (i = 0; i < nr; i++)
+		readers[i].error = 0;
+
+	while (1) {
+		int pollsize = 0;
+		int ret;
+
+		for (i = 0; i < nr; i++) {
+			if (readers[i].fd < 0)
+				continue;
+			pfd[pollsize].fd = readers[i].fd;
+			pfd[pollsize].events = POLLIN;
+			readers[i].pfd = &pfd[pollsize];
+			pollsize++;
+		}
+
+		if (!pollsize)
+			break;
+
+		ret = poll(pfd, pollsize, -1);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			/* should never happen? */
+			die_errno("poll failed");
+		}
+
+		for (i = 0; i < nr; i++) {
+			if (readers[i].fd < 0)
+				continue;
+			if (readers[i].pfd->revents &
+			    (POLLIN|POLLHUP|POLLERR|POLLNVAL)) {
+				ret = strbuf_read_once(readers[i].buf,
+						       readers[i].fd,
+						       readers[i].hint);
+				if (ret < 0)
+					readers[i].error = errno;
+				if (ret <= 0)
+					readers[i].fd = -1;
+			}
+		}
+	}
+
+	free(pfd);
+}
+
 ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 {
 	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
diff --git a/strbuf.h b/strbuf.h
index 7987405..b93822e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -374,6 +374,25 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
  */
 extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
 
+/**
+ * Read from several descriptors in parallel, each into its own strbuf.
+ * This can be used, for example, to capture stdout and stderr from a
+ * sub-process without worrying about deadlocks.
+ */
+struct strbuf_reader {
+	/* Initialized by caller */
+	struct strbuf *buf;
+	int fd;
+	size_t hint;
+
+	/* Returned by strbuf_read_parallel */
+	int error; /* 0 for success, otherwise errno */
+
+	/* Internal use */
+	struct pollfd *pfd;
+};
+void strbuf_read_parallel(struct strbuf_reader *readers, int nr);
+
 /**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
