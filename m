From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Tue, 3 Apr 2012 17:04:14 -0400
Message-ID: <20120403210414.GC24815@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vlimhk7rz.fsf@alter.siamese.dyndns.org>
 <20120403205906.GB24815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFAto-0005uv-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab2DCVEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:04:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684Ab2DCVEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:04:15 -0400
Received: (qmail 321 invoked by uid 107); 3 Apr 2012 21:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 17:04:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 17:04:14 -0400
Content-Disposition: inline
In-Reply-To: <20120403205906.GB24815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194646>

On Tue, Apr 03, 2012 at 04:59:07PM -0400, Jeff King wrote:

> > +		if (!push_url_of_remote(remote, &dest_url) ||
> > +		    !push_url_of_remote(branch_dest, &branch_dest_url) ||
> > +		    strcmp(dest_url[0], branch_dest_url[0]))
> > +			die(_("You are pushing to remote '%s', which is not the "
> > +			      "upstream of your\ncurrent branch '%s'.\n"),
> > +			    remote->name, branch->name);
> > +	}
> 
> Hmm. So this will actually detect "git push $URL" when $URL matches the
> remote's configured URL. I feel like this distinction has come up
> before, and we decided not to equate the two. But now I can't remember
> where (maybe it when fetching via URL versus via remote?).
> 
> What should happen if there are multiple push URLs configured? Your code
> will match iff it is the first one. I would think it should either
> require all to match, or it should proceed if any of the URLs match.
> I think the latter makes more sense, though personally I would simply
> have compared the remote names.

If this is the behavior we want, here are some squashable tests (on top
of my other tests) to check the URL-matching, and to expose the
multiple-URL case.

---
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index c334c51..d809615 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -51,4 +51,29 @@ test_expect_success '"upstream" does not push when remotes do not match' '
 	test_must_fail git push parent2
 '
 
+test_expect_success '"upstream" remote-match checks URLs' '
+	git checkout master &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit six &&
+	git push repo1 &&
+	echo six >expect &&
+	git --git-dir=repo1 log -1 --format=%s foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure '"upstream" remote-match checks all URLs' '
+	git checkout master &&
+	git config --add remote.parent1.push repo2 &&
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config push.default upstream &&
+	test_commit seven &&
+	git push repo2 &&
+	echo seven >expect &&
+	git --git-dir=repo2 log -1 --format=%s foo >actual &&
+	test_cmp expect actual
+'
+
 test_done
