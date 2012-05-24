From: Jeff King <peff@peff.net>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Thu, 24 May 2012 16:01:22 -0400
Message-ID: <20120524200122.GA18936@sigill.intra.peff.net>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
 <20120524182110.GE3161@sigill.intra.peff.net>
 <vpq7gw1z8rb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: roucherj <roucherj@telesun.imag.fr>, git@vger.kernel.org,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 24 22:01:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeEC-0006K1-WD
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966186Ab2EXUBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:01:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54133
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965775Ab2EXUBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:01:24 -0400
Received: (qmail 31537 invoked by uid 107); 24 May 2012 20:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 16:01:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 16:01:22 -0400
Content-Disposition: inline
In-Reply-To: <vpq7gw1z8rb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198411>

On Thu, May 24, 2012 at 09:20:08PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   https://github.com/git/git/blob/master/Documentation/technical/api-credentials.txt
> 
> I just re-read that document (I had a quick glance only before), and
> started to understand. I think the document really lacks the "big
> picture". I took time to understand whether the API was to call
> credential helpers, or to write a new one. Actually, there are two
> "API": the C one, and the specification of what may flow on the pipe
> between the two processes.

Right. There are really two audiences for this document: people who are
writing git code that wants to use credentials, and people who want to
write a helper. And it probably makes sense to say that up front, and
point people to the right section.

> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index 21ca6a2..5a872c0 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -6,8 +6,40 @@ password credentials from the user (even though credentials in the wider
>  world can take many forms, in this document the word "credential" always
>  refers to a username and password pair).
>  
> +When a function in Git or one of its remote-helpers needs to obtain
> +credentials (either by asking the user or by fetching from a store),
> +it can call the functions in the C API. These functions will fork a
> +new process, and communicate with it by passing command-line arguments
> +and then communicating through a pipe (see 'Credential Helpers'
> +below).

We might or might not fork a new process. It depends on which helpers
are defined.

> The credential helper process will be in charge of actually
> +prompting the user and/or storing and fetching the credentials.

That's not exactly true; the C credential code will actually prompt the
user if no helper provides it (in early versions, the helpers were
responsible for prompting, but that is no longer the case).

> +For example, the execution of a command connecting to an HTTP server
> +and using the credential helper "cache" will have the following
> +structure:
> +
> +------------
> ++-----+ -----> +-----------------+
> +| git |  pipe  | git remote-http | --- to HTTP server --->
> ++-----+ <----- +-----------------+
> +                    ^      |
> +                    | pipe |
> +                    |      v
> +             +----------------------+
> +             | git credential-cache |
> +             +----------------------+
> +------------
> +
> +git remote-http will take care of contacting the HTTP server, do the
> +actual authentication and see if it's accepted by the server. The
> +credential helper will deal with the credential store (which can be
> +done by contacting a keyring daemon) and the prompting if needed.

I feel like adding remote-helpers into the mix just makes the situation
more complex (and necessitates the diagram). I also don't want to get
too much into "how it works inside" and would rather stay at the level
of "here's how you use it".

What do you think of the patch below? It tries to route the reader to
the most useful spot, and it would naturally extend to mentioning a "git
credential" command when one exists (which would be separately
documented in git-credential.txt).

---
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..f6fa203 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -6,8 +6,27 @@ password credentials from the user (even though credentials in the wider
 world can take many forms, in this document the word "credential" always
 refers to a username and password pair).
 
+This document describes two interfaces: the C API that the credential
+subsystem provides to the rest of git, and the protocol that git uses to
+communicate with system-specific "credential helpers". If you are
+writing git code that wants to look up or prompt for credentials, see
+the section "C API" below. If you want to write your own helper, see
+the section on "Credential Helpers" below.
+
+
+C API
+-----
+
+The credential C API is meant to be called by git code which needs to
+acquire or store a credential. It is centered around an object
+representing a single credential and provides three basic operations:
+fill (acquire credentials by calling helpers and/or prompting the user),
+approve (mark a credential as successfully used so that it can be stored
+for later use), and reject (mark a credential as unsuccessful so that it
+can be erased from any persistent storage).
+
 Data Structures
----------------
+~~~~~~~~~~~~~~~
 
 `struct credential`::
 
@@ -28,7 +47,7 @@ This struct should always be initialized with `CREDENTIAL_INIT` or
 
 
 Functions
----------
+~~~~~~~~~
 
 `credential_init`::
 
@@ -72,7 +91,7 @@ Functions
 	Parse a URL into broken-down credential fields.
 
 Example
--------
+~~~~~~~
 
 The example below shows how the functions of the credential API could be
 used to login to a fictitious "foo" service on a remote host:
