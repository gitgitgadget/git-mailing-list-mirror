From: Jeff King <peff@peff.net>
Subject: Re: Disabling credential helper?
Date: Wed, 3 Dec 2014 20:33:06 -0500
Message-ID: <20141204013306.GA9406@peff.net>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
 <20141203012148.GB29427@peff.net>
 <20141203012950.GC6527@google.com>
 <20141203013607.GA30037@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 02:33:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwLIB-0007rQ-J2
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 02:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbaLDBdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 20:33:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:48096 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752607AbaLDBdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 20:33:10 -0500
Received: (qmail 3938 invoked by uid 102); 4 Dec 2014 01:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 19:33:09 -0600
Received: (qmail 2358 invoked by uid 107); 4 Dec 2014 01:33:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 20:33:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 20:33:06 -0500
Content-Disposition: inline
In-Reply-To: <20141203013607.GA30037@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260719>

On Tue, Dec 02, 2014 at 08:36:07PM -0500, Jeff King wrote:

> But to answer your question: you can't currently. I would be happy to
> have a config syntax that means "reset this multi-value config option
> list to nothing", but it does not yet exist. It would be useful for more
> than just credential-helper config.

This is something I've wanted for a while, so I took another peek at it.
It turns out to be rather complicated.

This is the initial patch I came up with (don't bother reading it too
closely):

diff --git a/credential.c b/credential.c
index 1886ea5..9e84575 100644
--- a/credential.c
+++ b/credential.c
@@ -43,9 +43,6 @@ static int credential_config_callback(const char *var, const char *value,
 	if (!skip_prefix(var, "credential.", &key))
 		return 0;
 
-	if (!value)
-		return config_error_nonbool(var);
-
 	dot = strrchr(key, '.');
 	if (dot) {
 		struct credential want = CREDENTIAL_INIT;
@@ -63,8 +60,13 @@ static int credential_config_callback(const char *var, const char *value,
 		key = dot + 1;
 	}
 
-	if (!strcmp(key, "helper"))
-		string_list_append(&c->helpers, value);
+	if (!strcmp(key, "helper")) {
+		if (value)
+			string_list_append(&c->helpers, value);
+		else
+			string_list_clear(&c->helpers, 0);
+	} else if (!value)
+		return config_error_nonbool(var);
 	else if (!strcmp(key, "username")) {
 		if (!c->username)
 			c->username = xstrdup(value);


It allows you to do:

  git -c credential.helper [-c credential.helper=foo] fetch ...

The first one "resets" the list to empty, and then you can further
append to the list after that. There are a bunch of shortcomings,
though:

  1. I chose the value-less boolean as a token to reset the list (since
     it is otherwise an unmeaningful error). The example above shows its
     use with "-c", but you could also do:

       [credential]
       helper
       helper = foo

     in a config file itself.  This is probably rather unintuitive.

     But whatever syntax is chosen would need to have some mechanism for
     specifying it in the config file itself, as well as in the
     command-line (and therefore in the semi-public
     GIT_CONFIG_PARAMETERS environment variable which is passed around).
     So this is at least backwards-compatible, "just works" with
     existing config code, and won't stomp on any existing working
     values.

     If we can accept stomping on an unlikely-used token, something
     like:

       git -c credential.helper=RESET fetch ...

     is more sensible (and we can argue about the exact token used).
     If we can accept new syntax and new config code, something like:

       git -c '!credential.helper' fetch ...

     is probably workable.

  2. Notice how we didn't touch the config code at all here. That's
     because it doesn't know anything about whether a config item is a
     multi-valued list, or that the string list exists. It is up to each
     individual consumer of the config callbacks to implement this
     list-clearing mechanism (and obviously we should make them all
     agree on the token used). So we'd probably want to make similar
     changes everywhere that multi-values are used (which, to be fair,
     really isn't that many, I don't think).

  3. Running `git config credential.helper` doesn't know about this
     mechanism either. You can either get the "last one wins" behavior,
     or you can use --get-all to get all instances. We'd probably have
     to teach it a new `--get-list` that recognized the magic reset
     token.

None of those problems is insurmountable. It just takes a little more
code than what I wrote above. But for credential helpers specifically,
it's a bit more challenging. Because we're _not_ constructing just a
list of just credential.helper here. We're constructing a list of all
matching credential.*.helper config keys. So in something like:

  [credential "http://example.com"]
  helper = foo
  [credential]
  helper = bar

if you run "git fetch http://example.com", you'll get both helpers, in
sequence.

What should adding:

  [credential]
  helper = RESET

do on top of that?  Intuitively, I'd say that it would only touch the
credential.helper variables. But that's not what the user probably
wants. They probably want to reset _any_ helpers that have matched. And
that's actually what the code I posted above would do. So that's good, I
guess. But I wonder if this approach is introducing more confusion than
it is worth.

Having a separate --no-respect-credential-helpers is conceptually much
simpler. But it also does not allow you to reset the list and add in a
new helper.

-Peff
