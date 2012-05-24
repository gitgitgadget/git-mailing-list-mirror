From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Thu, 24 May 2012 21:20:08 +0200
Message-ID: <vpq7gw1z8rb.fsf@bauges.imag.fr>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
	<20120524182110.GE3161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: roucherj <roucherj@telesun.imag.fr>, git@vger.kernel.org,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 21:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXdas-00050i-PX
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 21:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934077Ab2EXTU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 15:20:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45760 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934315Ab2EXTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 15:20:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4OJC9ix003749
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 21:12:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXdZx-0007HR-Ma; Thu, 24 May 2012 21:20:09 +0200
In-Reply-To: <20120524182110.GE3161@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 May 2012 14:21:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 May 2012 21:12:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4OJC9ix003749
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338491534.35225@uT/an5CzrietyGwQ9Dr0Aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198409>

Jeff King <peff@peff.net> writes:

>   https://github.com/git/git/blob/master/Documentation/technical/api-credentials.txt

I just re-read that document (I had a quick glance only before), and
started to understand. I think the document really lacks the "big
picture". I took time to understand whether the API was to call
credential helpers, or to write a new one. Actually, there are two
"API": the C one, and the specification of what may flow on the pipe
between the two processes.

Perhaps something like this should be added:

Subject: [PATCH] credential-helper documentation: show the big picture first

---
 Documentation/technical/api-credentials.txt |   47 +++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..5a872c0 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -6,8 +6,40 @@ password credentials from the user (even though credentials in the wider
 world can take many forms, in this document the word "credential" always
 refers to a username and password pair).
 
+When a function in Git or one of its remote-helpers needs to obtain
+credentials (either by asking the user or by fetching from a store),
+it can call the functions in the C API. These functions will fork a
+new process, and communicate with it by passing command-line arguments
+and then communicating through a pipe (see 'Credential Helpers'
+below). The credential helper process will be in charge of actually
+prompting the user and/or storing and fetching the credentials.
+
+For example, the execution of a command connecting to an HTTP server
+and using the credential helper "cache" will have the following
+structure:
+
+------------
++-----+ -----> +-----------------+
+| git |  pipe  | git remote-http | --- to HTTP server --->
++-----+ <----- +-----------------+
+                    ^      |
+                    | pipe |
+                    |      v
+             +----------------------+
+             | git credential-cache |
+             +----------------------+
+------------
+
+git remote-http will take care of contacting the HTTP server, do the
+actual authentication and see if it's accepted by the server. The
+credential helper will deal with the credential store (which can be
+done by contacting a keyring daemon) and the prompting if needed.
+
+C API
+-----
+
 Data Structures
----------------
+~~~~~~~~~~~~~~~
 
 `struct credential`::
 
@@ -28,7 +60,7 @@ This struct should always be initialized with `CREDENTIAL_INIT` or
 
 
 Functions
----------
+~~~~~~~~~
 
 `credential_init`::
 
@@ -72,7 +104,7 @@ Functions
 	Parse a URL into broken-down credential fields.
 
 Example
--------
+~~~~~~~
 
 The example below shows how the functions of the credential API could be
 used to login to a fictitious "foo" service on a remote host:
@@ -130,6 +162,9 @@ int foo_login(struct foo_connection *f)
 Credential Helpers
 ------------------
 
+Choosing the credential helper command
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 Credential helpers are programs executed by git to fetch or save
 credentials from and to long-term storage (where "long-term" is simply
 longer than a single git process; e.g., credentials may be stored
@@ -176,6 +211,9 @@ users by naming their program "git-credential-$NAME", and putting it in
 the $PATH or $GIT_EXEC_PATH during installation, which will allow a user
 to enable it with `git config credential.helper $NAME`.
 
+Credential helper command-line arguments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 When a helper is executed, it will have one "operation" argument
 appended to its command line, which is one of:
 
@@ -191,6 +229,9 @@ appended to its command line, which is one of:
 
 	Remove a matching credential, if any, from the helper's storage.
 
+Credential helper protocol
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The details of the credential will be provided on the helper's stdin
 stream. The credential is split into a set of named attributes.
 Attributes are provided to the helper, one per line. Each attribute is
-- 
1.7.10.363.g7fcd3d.dirty

Also, shouldn't the documentation about choosing the command name be
moved to git-config.txt, to document credential.helper? It really seems
to be a user documentation, not a technical one meant for Git
developers.

> But that is the C API, and I assume you are building on the existing
> mediawiki helper that is written in perl.

Right.

> So I think what you really want is a "git credential" command that
> will let scripts hook into the credential API. Something like:
>
>   $ git credential get https://example.com
>   username=bob
>   password=secret
> [...]

This is almost already done by test-credential.c indeed. But that's
probably the simplest way to expose the C API to a perl program.

> Do you guys want to try writing "git credential" as above? It might be a
> fun side project, but I know you are also on a limited timeframe for
> your project. I can work on it if you don't have time.

I leave it up to the students.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
