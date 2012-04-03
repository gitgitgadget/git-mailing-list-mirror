From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Tue, 3 Apr 2012 16:59:07 -0400
Message-ID: <20120403205906.GB24815@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFAot-0002Y4-N3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 22:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab2DCU7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 16:59:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44848
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2DCU7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 16:59:09 -0400
Received: (qmail 32711 invoked by uid 107); 3 Apr 2012 20:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 16:59:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 16:59:07 -0400
Content-Disposition: inline
In-Reply-To: <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194644>

On Fri, Mar 30, 2012 at 04:07:12PM -0700, Junio C Hamano wrote:

> There were two issues I raised in that message.  It turns out that we
> already have the code for the first one.  The second one should look
> something like this:
> 
> -- >8 --
> Subject: push: detect nonsense "upstream" check more carefully

Thanks, I think this is an improvement. I absolutely think the existing
behavior was a bug, but I do wonder if any users were depending on this
"feature".

Squashable tests are below.

> +	if (strcmp(branch->remote_name, remote->name)) {
> +		struct remote *branch_dest = remote_get(branch->remote_name);
> +		const char **branch_dest_url, **dest_url;
> +
> +		if (!push_url_of_remote(remote, &dest_url) ||
> +		    !push_url_of_remote(branch_dest, &branch_dest_url) ||
> +		    strcmp(dest_url[0], branch_dest_url[0]))
> +			die(_("You are pushing to remote '%s', which is not the "
> +			      "upstream of your\ncurrent branch '%s'.\n"),
> +			    remote->name, branch->name);
> +	}

Hmm. So this will actually detect "git push $URL" when $URL matches the
remote's configured URL. I feel like this distinction has come up
before, and we decided not to equate the two. But now I can't remember
where (maybe it when fetching via URL versus via remote?).

What should happen if there are multiple push URLs configured? Your code
will match iff it is the first one. I would think it should either
require all to match, or it should proceed if any of the URLs match.
I think the latter makes more sense, though personally I would simply
have compared the remote names.

-Peff

---
Here are the tests.

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
new file mode 100755
index 0000000..c334c51
--- /dev/null
+++ b/t/t5528-push-default.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='check various push.default settings'
+. ./test-lib.sh
+
+test_expect_success 'setup bare remotes' '
+	git init --bare repo1 &&
+	git remote add parent1 repo1 &&
+	git init --bare repo2 &&
+	git remote add parent2 repo2 &&
+	test_commit one &&
+	git push parent1 HEAD &&
+	git push parent2 HEAD
+'
+
+test_expect_success '"upstream" pushes to configured upstream' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit two &&
+	git push &&
+	echo two >expect &&
+	git --git-dir=repo1 log -1 --format=%s foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"upstream" does not push on unconfigured remote' '
+	git checkout master &&
+	test_unconfig branch.master.remote &&
+	test_config push.default upstream &&
+	test_commit three &&
+	test_must_fail git push
+'
+
+test_expect_success '"upstream" does not push on unconfigured branch' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_unconfig branch.master.merge &&
+	test_config push.default upstream
+	test_commit four &&
+	test_must_fail git push
+'
+
+test_expect_success '"upstream" does not push when remotes do not match' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit five &&
+	test_must_fail git push parent2
+'
+
+test_done
