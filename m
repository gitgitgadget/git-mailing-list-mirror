From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement ACL module architecture and sample MySQL ACL
 module
Date: Tue, 14 Aug 2012 11:37:51 -0700
Message-ID: <7vpq6t9v5s.fsf@alter.siamese.dyndns.org>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 <7v1uj98nbj.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com>
 <7vsjbp768y.fsf@alter.siamese.dyndns.org>
 <CAJo=hJu7W6JnNLYvahaQ43ZNqDtrurTOLCnLfZacVJKeL6VMFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Novotny <minovotn@redhat.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1M09-00062S-8k
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 20:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012Ab2HNSh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 14:37:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743Ab2HNShz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 14:37:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C147A23;
	Tue, 14 Aug 2012 14:37:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OexVxKfQnJb6cL/4UClDIebKMfk=; b=pHhBUr
	tL88KiQWptu7Z0NLBKjnu2PPE6UTYo5JcV1Ts8G19MUuTa+7RYU4FuDJV4JMj6Gx
	NcpzttBZWLZajJsEGoUbaOaWBgGiBMGT0aBzad0mEqxxOkuKLBL/vlJ4nG+uGPUK
	UNbKNGY1lIcmLsgVwaWYKMycQ6RI/CBr7ajHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e88IPqYHxi/PH4IrGy8qpjb4boJvg8/M
	srjzrtwVq/n25KqOPMBf30PagDmLzW2SZQpQJBk+Lrt4SHeSI2zvZGvlRSpkqNfw
	YGcogru1//J01RI97l632UAc/ynfyVYQ4yVqlFwM8yzlwV7VrNND2Q9y/2W93xtE
	vZjjPA3Jzr4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44AB27A22;
	Tue, 14 Aug 2012 14:37:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BAA57A1F; Tue, 14 Aug 2012
 14:37:53 -0400 (EDT)
In-Reply-To: <CAJo=hJu7W6JnNLYvahaQ43ZNqDtrurTOLCnLfZacVJKeL6VMFg@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 14 Aug 2012 10:26:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 287DE48A-E63F-11E1-8E90-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203421>

Shawn Pearce <spearce@spearce.org> writes:

> But seeing this, yes, that is a bad idea. Better to treat that like a
> hook, where exit status 0 allows the connection to continue, and exit
> status non-zero causes the connection to be closed. Maybe with an
> error printed to stderr (if any) being echoed first to the client if
> possible using the ERR formatting notation.

Yeah, note that we can only give a single "ERR " line, though.

Something like this?  Totally untested, of course ;-)

 daemon.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/daemon.c b/daemon.c
index ab21e66..41a9679 100644
--- a/daemon.c
+++ b/daemon.c
@@ -30,6 +30,7 @@ static const char daemon_usage[] =
 "           [--interpolated-path=<path>]\n"
 "           [--reuseaddr] [--pid-file=<file>]\n"
 "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
+"           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
 "           [<directory>...]";
@@ -256,6 +257,73 @@ static int daemon_error(const char *dir, const char *msg)
 	return -1;
 }
 
+static char *access_hook;
+
+static int run_access_hook(struct daemon_service *service, const char *dir, const char *path)
+{
+	struct child_process child;
+	struct strbuf buf = STRBUF_INIT;
+	const char *argv[8];
+	const char **arg = argv;
+	char *eol;
+	int seen_errors = 0;
+
+#define STRARG(x) ((x) ? (x) : "")
+	*arg++ = access_hook;
+	*arg++ = service->name;
+	*arg++ = path;
+	*arg++ = STRARG(hostname);
+	*arg++ = STRARG(canon_hostname);
+	*arg++ = STRARG(ip_address);
+	*arg++ = STRARG(tcp_port);
+	*arg = NULL;
+#undef STRARG
+
+	memset(&child, 0, sizeof(child));
+	child.use_shell = 1;
+	child.argv = argv;
+	child.no_stdin = 1;
+	child.no_stderr = 1;
+	child.out = -1;
+	if (start_command(&child)) {
+		logerror("daemon access hook '%s' failed to start",
+			 access_hook);
+		goto error_return;
+	}
+	if (strbuf_read(&buf, child.out, 0) < 0) {
+		logerror("failed to read from pipe to daemon access hook '%s'",
+			 access_hook);
+		strbuf_reset(&buf);
+		seen_errors = 1;
+	}
+	if (close(child.out) < 0) {
+		logerror("failed to close pipe to daemon access hook '%s'",
+			 access_hook);
+		seen_errors = 1;
+	}
+	if (finish_command(&child) < 0) {
+		logerror("failed to finish-command daemon access hook '%s'",
+			 access_hook);
+		seen_errors = 1;
+	}
+	if (!seen_errors) {
+		strbuf_release(&buf);
+		return 0;
+	}
+
+error_return:
+	strbuf_ltrim(&buf);
+	if (!buf.len)
+		strbuf_addstr(&buf, "service rejected");
+	eol = strchr(buf.buf, '\n');
+	if (eol)
+		*eol = '\0';
+	errno = EACCES;
+	daemon_error(dir, buf.buf);
+	strbuf_release(&buf);
+	return -1;
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -304,6 +372,13 @@ static int run_service(char *dir, struct daemon_service *service)
 	}
 
 	/*
+	 * Optionally, a hook can choose to deny access to the
+	 * repository depending on the phase of the moon.
+	 */
+	if (access_hook && run_access_hook(service, dir, path))
+		return -1;
+
+	/*
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
 	 */
@@ -1142,6 +1217,10 @@ int main(int argc, char **argv)
 			export_all_trees = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--access-hook=")) {
+			access_hook = arg + 14;
+			continue;
+		}
 		if (!prefixcmp(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			continue;
