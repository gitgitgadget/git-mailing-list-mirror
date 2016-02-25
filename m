From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 02:00:36 -0500
Message-ID: <20160225070036.GA5654@sigill.intra.peff.net>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <20160225014149.GA31616@sigill.intra.peff.net>
 <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 08:00:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpun-0004lA-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 08:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbcBYHAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 02:00:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:48863 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752006AbcBYHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 02:00:39 -0500
Received: (qmail 18469 invoked by uid 102); 25 Feb 2016 07:00:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 02:00:39 -0500
Received: (qmail 17185 invoked by uid 107); 25 Feb 2016 07:00:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 02:00:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 02:00:36 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287336>

On Wed, Feb 24, 2016 at 10:23:28PM -0800, Jacob Keller wrote:

> >> +# Sanitize the local git environment for use within a submodule. We
> >> +# can't simply use clear_local_git_env since we want to preserve some
> >> +# of the settings from GIT_CONFIG_PARAMETERS.
> >> +sanitize_local_git_env()
> >> +{
> >> +     local sanitized_config = $(git submodule--helper sanitize-config)
> >> +     clear_local_git_env
> >> +     GIT_CONFIG_PARAMETERS=$sanitized_config
> >> +}
> >
> > Do we need to export GIT_CONFIG_PARAMETERS? I guess not; if it is
> > already exported, we don't need, and if it isn't, then by definition
> > $sanitized_config will be empty.
> >
> How does modifying an exported variable work?

Generally, variables which came to the shell from the environment are
marked for export, and modifying a marked-for-export variable will not
change its export flag.

I have a nagging feeling that there was some shell deep in the past
where that was not the case, but I can't find any mention of it. So
either I dreamed it, or it is so old and broken that even the autoconf
portability page does not bother with it. ;)

> I 100% agree. I think the test file is useful for now, and there are
> (currently) no other tests for submodule--helper, so I'd like to get
> them all confined to this test. I think we need a real way to test the
> change here, but I think figuring out how to test the
> credential.helper is a bit outside the scope of what i had time for
> today. I can try to find some cycles to check out tomorrow. You
> mentioned we'd need a test in the same idea as one of the http clone
> tests? I don't know where to start with something like this though.

I think something like this would work:

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6414635..c5ce8ff 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -91,6 +91,20 @@ test_expect_success 'configured username does not override URL' '
 	expect_askpass pass user@host
 '
 
+test_expect_success 'cmdline credential config passes to submodules' '
+	git init super &&
+	set_askpass user@host pass@host &&
+	(
+		cd super &&
+		git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
+		git commit -m "add submodule"
+	) &&
+	set_askpass wrong pass@host &&
+	git -c "credential.$HTTPD_URL.username=user@host" \
+		clone --recursive super super-clone &&
+	expect_askpass pass user@host
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&

but it does not seem to pass with your patch (even after I fixed up the
weird "local" thing). I think the problem is that we ask
submodule--helper to do the clone, and it uses local_repo_env. So in
addition to your patch, you probably need a C version of the same thing
which outputs to an argv_array.

-Peff
