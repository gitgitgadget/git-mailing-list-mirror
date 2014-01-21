From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 01:13:07 -0500
Message-ID: <20140121061307.GE5878@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
 <xmqqiotiwfdk.fsf@gitster.dls.corp.google.com>
 <xmqq61piw4yf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 07:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5UaZ-0003NC-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 07:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbaAUGNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 01:13:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:36088 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbaAUGNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 01:13:09 -0500
Received: (qmail 8274 invoked by uid 102); 21 Jan 2014 06:13:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jan 2014 00:13:09 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jan 2014 01:13:07 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61piw4yf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240746>

On Fri, Jan 17, 2014 at 03:42:32PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps we can start it like this.  Then pager.c can iterate over
> > the PAGER_ENV string, parse out LESS=, LV=, etc., and do its thing.
> >
> > We would also need to muck with git-sh-setup.sh but that file is
> > already preprocessed in the Makefile, so we should be able to do
> > something similar to "# @@BROKEN_PATH_FIX@@" there.
> 
> And here is such an attempt.  There may be some missing dependencies
> that need to be covered with a mechanism like GIT-BUILD-OPTIONS,
> though.

Perhaps instead of just dumping it into a macro, we could actually parse
it at compile time into C code, and store the result as a header file.
Then that header file becomes the proper dependency, and this run-time
error:

> +	while (*pager_env) {
> +		struct strbuf buf = STRBUF_INIT;
> +		const char *cp = strchrnul(pager_env, '=');
> +
> +		if (!*cp)
> +			die("malformed build-time PAGER_ENV");

would become a compile-time error. We could do the same for the shell
code, too.

I'm thinking something like:

diff --git a/Makefile b/Makefile
index b4af1e2..3a8d15e 100644
--- a/Makefile
+++ b/Makefile
@@ -2182,6 +2182,16 @@ GIT-LDFLAGS: FORCE
 		echo "$$FLAGS" >GIT-LDFLAGS; \
             fi
 
+GIT-PAGER-ENV:
+	@PAGER_ENV='$(PAGER_ENV)'; \
+	if test x"$$PAGER_ENV" != x"`cat GIT-PAGER-ENV 2>/dev/null`"; then \
+		echo "$$PAGER_ENV" >GIT-PAGER-ENV; \
+	fi
+
+pager-env.h: GIT-PAGER-ENV mkcarray
+	$(SHELL_PATH) mkcarray pager_env <$< >$@+
+	mv $@+ $@
+
 # We need to apply sq twice, once to protect from the shell
 # that runs GIT-BUILD-OPTIONS, and then again to protect it
 # and the first level quoting from the shell that runs "echo".
diff --git a/mkcarray b/mkcarray
index e69de29..5962440 100644
--- a/mkcarray
+++ b/mkcarray
@@ -0,0 +1,21 @@
+name=$1; shift
+guard=$(echo "$name" | tr a-z A-Z)
+
+cat <<-EOF
+#ifndef ${guard}_H
+#define ${guard}_H
+
+static const char *${name} = {
+EOF
+
+for i in $(cat); do
+	# XXX c-quote the values?
+	printf '\t"%s",\n' "$i"
+done
+
+cat <<EOF
+	NULL
+};
+
+#endif /* ${guard}_H */
+EOF
