From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Specifying a private key when connecting to a remote SSH repo
Date: Wed, 11 Sep 2013 21:39:55 -0700
Message-ID: <xmqqeh8ur6uc.fsf@gitster.dls.corp.google.com>
References: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Breck Yunits <breck7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 06:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJyhT-0008Vb-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 06:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab3ILEkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 00:40:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678Ab3ILEkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 00:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D6C3979B;
	Thu, 12 Sep 2013 04:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d17tbb4RPse2g4OxlmTSyMOYvhU=; b=j/EJjo
	wKV5orxVFnX1CjkxOJFWPPjR8HYJK59YP2ny9LXPwTcHsFsPH34rwsJoJ4qsKJvc
	QpZ8amVzTLd2FeapXZaGxO6NKtO9pH/zKZpBWZJHW1XtkskJsBQHxRjhWXN42zpb
	VQWReTY4VdJ63vyeTfiq8PhHBBhdAmyh8cNGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SbXI9eZFAO9KBmec0TSjAUcG1e1R0o+o
	N0jfPwC6mBu0krOA2/D0QFI6rojUsiPByPEdu8+gwly64tm8C/ug2Eh+/Eju2Y+D
	/ex0j6xM4wjAQJSvS7VtZS7Pk5F0viBL9hn40QgFKJnCIBhy54VeeTPZWOIZP6eN
	1ED+VmyFcRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ADE939795;
	Thu, 12 Sep 2013 04:40:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99AE539785;
	Thu, 12 Sep 2013 04:39:59 +0000 (UTC)
In-Reply-To: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
	(Breck Yunits's message of "Wed, 11 Sep 2013 16:19:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 621516D0-1B65-11E3-BE74-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234622>

Breck Yunits <breck7@gmail.com> writes:

> It would be very helpful if you could specify the path to the private
> key to use for ssh remotes just like in ssh.

You could add a support for the "remote.<name>.sshIdentityFile"
configuration variable, i.e.

	[remote "origin"]
		url = breck@example.com:projects/w.git
                sshIdentityFile = ~/.ssh/id_for_example_com

and then teach the codepath that leads to connect.c::git_connect()
to pass it down, and add "-o 'IdentityFile %s'" to the command line
that invokes "ssh".

But you would need the same number of configuration as you have
remotes that need such custom identity files, which happens to be
the same number of entries you would normally configure with the
standard ~/.ssh/config file, so I do not think it is worth it.

If the only thing you are interested in supporting is a one-shot
invocation, i.e. giving which identity file to use from the command
line when you run either "git push" or "git fetch", I suspect that
you could play with GIT_SSH environment variable, e.g.

    GIT_SSH_IDENTITY_FILE=$HOME/.ssh/id_for_example_com git push

and do something ugly like the attached, I suppose.

It also crossed my mind that you could (ab)use the credential helper
framework and ask it to return not the password but the identity
filename, and pass it down the callchain to git_connect(), but again
you will have to teach the credential helper as many settings as you
would need to make in ~/.ssh/config anyway, so I find it dubious how
it would be a win.

 connect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index a80ebd3..87b7ceb 100644
--- a/connect.c
+++ b/connect.c
@@ -623,9 +623,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		die("command line too long");
 
 	conn->in = conn->out = -1;
-	conn->argv = arg = xcalloc(7, sizeof(*arg));
+	conn->argv = arg = xcalloc(20, sizeof(*arg));
 	if (protocol == PROTO_SSH) {
 		const char *ssh = getenv("GIT_SSH");
+		const char *ssh_ident = getenv("GIT_SSH_IDENTITY_FILE");
 		int putty = ssh && strcasestr(ssh, "plink");
 		if (!ssh) ssh = "ssh";
 
@@ -637,6 +638,12 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			*arg++ = putty ? "-P" : "-p";
 			*arg++ = port;
 		}
+		if (ssh_ident) {
+			char *ident_arg = xmalloc(strlen(ssh_ident) + 50);
+			sprintf(ident_arg, "IdentityFile %s", ssh_ident);
+			*arg++ = "-o";
+			*arg++ = ident_arg;
+		}
 		*arg++ = host;
 	}
 	else {
