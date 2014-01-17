From: Jeff King <peff@peff.net>
Subject: Re: git quietly fails on https:// URL, https errors are never
 reported to user
Date: Fri, 17 Jan 2014 15:13:25 -0500
Message-ID: <20140117201325.GB775@sigill.intra.peff.net>
References: <52D7D017.107@rawbw.com>
 <20140116180310.GA27180@sigill.intra.peff.net>
 <52D8FAA6.1010601@rawbw.com>
 <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FnI-0007zU-DF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbaAQUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:13:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:34364 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752600AbaAQUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:13:27 -0500
Received: (qmail 29330 invoked by uid 102); 17 Jan 2014 20:13:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Jan 2014 14:13:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jan 2014 15:13:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240625>

On Fri, Jan 17, 2014 at 11:43:35AM -0800, Junio C Hamano wrote:

> Yuri <yuri@rawbw.com> writes:
> 
> > I think that in a rare case of error this extra-printout wouldn't
> > hurt.
> 
> If the "error is rare, extra verbiage does not hurt" were a valid
> attitude, "error is rare, non-zero exit is enough" would be equally
> valid ;-)

I think the problem is that error is _not_ rare. For years, we did not
print the extra verbiage, and nobody complained. Then, within days of us
making a release that included the extra line, somebody complained[1].

The real issue is that the remote-helper hanging up _should_ be an
exceptional condition, but it's not. The remote-helper protocol sucks,
and has no way to signal failure of an operation besides just hanging
up. So you end up with junk like:

  $ git clone https://google.com/foo.git
  Cloning into 'foo'...
  fatal: repository 'https://google.com/foo.git/' not found
  fatal: Reading from helper 'git-remote-https' failed

That second line is not adding anything, and IMHO is making things
uglier and more confusing. We _expected_ the helper to hang up; that's
how it signals an error to us. It is not an unexpected condition at all.
The exit(128) we do is simply propagating the error report of the
helper.

That's the common error case: the message is redundant and annoying. The
_uncommon_ case is the one Yuri hit: some library misconfiguration that
causes the helper not to run at all.  Adding back any message is hurting
the common case to help the uncommon one.

> I think I am OK with adding one more line after "Reading from
> ... failed" that explains a more detailed error message might be
> there above that line, but I am not sure what the good phrasing
> would be.

I'd really rather not. Hopefully the explanation above makes it clear
why not.

The "most right" solution is to fix the helper protocol to allow error
reporting. That may be somewhat complicated to retain backward
compatibility (we have to introduce a capability, probe for it, handle
old helpers, etc).

We _may_ be able to do better by annotating certain commands with
whether we expect them to hangup. The big one, I think, would be the
initial "capabilities" command. Something like the patch below would
detect any startup problems in the helper. From Yuri's description, that
would catch his case or any similar ones.

Anything after startup should be the responsibility of the helper to
report. If it doesn't, that's a bug in the helper. The one exception may
be signals. We could waitpid() on the helper and report any signal
death (e.g., it obviously cannot report its own SIGKILL death, and I'd
guess that most do not report their own SIGPIPE death).

diff --git a/transport-helper.c b/transport-helper.c
index 2010674..af03f1a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -50,7 +50,8 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
+static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name,
+		       int die_on_failure)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -58,7 +59,9 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		if (die_on_failure)
+			exit(128);
+		return -1;
 	}
 
 	if (debug)
@@ -68,7 +71,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 
 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer, helper->name);
+	return recvline_fh(helper->out, buffer, helper->name, 1);
 }
 
 static void xchgline(struct helper_data *helper, struct strbuf *buffer)
@@ -163,7 +166,9 @@ static struct child_process *get_helper(struct transport *transport)
 	while (1) {
 		const char *capname;
 		int mandatory = 0;
-		recvline(data, &buf);
+
+		if (recvline_fh(data->out, &buf, data->name, 0) < 0)
+			die("remote helper '%s' aborted session", data->name);
 
 		if (!*buf.buf)
 			break;
@@ -557,7 +562,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	recvline_fh(input, &cmdbuf, name);
+	recvline_fh(input, &cmdbuf, name, 1);
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
