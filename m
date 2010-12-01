From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 1 Dec 2010 12:55:17 -0500
Message-ID: <20101201175517.GA7774@sigill.intra.peff.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 18:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqu3-0001rR-WB
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab0LARzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:55:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55737 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab0LARzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:55:19 -0500
Received: (qmail 5784 invoked by uid 111); 1 Dec 2010 17:55:19 -0000
Received: from 129-79-255-226.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 17:55:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 12:55:17 -0500
Content-Disposition: inline
In-Reply-To: <20101201163406.GD26120@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162557>

On Wed, Dec 01, 2010 at 10:34:06AM -0600, Jonathan Nieder wrote:

> (+cc: Jeff, config parsing wizard)

Ugh, that is not a title that I aspire to. :)

> > Good idea, though I'd rather we avoid new convention for multi word
> > names separated with '-' (multi-word), but rather use camel case
> > (multiWord).
> 
> No disagreement there. :)
> 
> > Currently we have only unfortunate exception of `add.ignore-errors',

At some point there was talk of making this add.ignoreErrors in the
docs, and just keeping the add.ignore-errors alias forever for backwards
compatibility.

> Maybe we can teach the config file parser to ignore dashes in addition
> to case (except in the names of [genus "species"] headings)?  That
> would be an incompatible change for third-party tools, though, so
> maybe "git config" would have to take an explicit --strip-dashes
> flag to do it.

But if you require --strip-dashes, then you get potentially differing
behavior for the same set of options (i.e., one tool may accept "foobar"
but the other requires "foo-bar", because the latter has not been
updated to --strip-dashes).

Naively, such a patch would look like:

diff --git a/builtin/add.c b/builtin/add.c
index 22c6329..944c54f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -331,7 +331,7 @@ static struct option builtin_add_options[] = {
 
 static int add_config(const char *var, const char *value, void *cb)
 {
-	if (!strcasecmp(var, "add.ignore-errors")) {
+	if (!strcasecmp(var, "add.ignoreerrors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/config.c b/config.c
index d8ce653..e5cb5f9 100644
--- a/config.c
+++ b/config.c
@@ -211,6 +211,8 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 			break;
 		if (!iskeychar(c))
 			break;
+		if (c == '-')
+			continue;
 		name[len++] = tolower(c);
 		if (len >= MAXNAME)
 			return -1;

but there are a lot of corner cases. What happens with --get-regexp?
What happens with headings like '[foo-bar "baz"]'. When we use
"git-config" to edit, do we properly preserve dashes?

I started to think about all of these things, and then realized it
probably just isn't worth it. If we care about no-dashes, then let's
enforce no-dashes in new options. If we care about the existing
add.ignore-errors, then let's fix it but keep the old version there for
backwards compatibility. Those are easy to do, and then the problem just
goes away.

-Peff
