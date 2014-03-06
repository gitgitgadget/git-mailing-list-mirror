From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3200-branch: test setting branch as own upstream
Date: Thu, 6 Mar 2014 16:00:26 -0500
Message-ID: <20140306210025.GD29659@sigill.intra.peff.net>
References: <xmqqmwh5ikl0.fsf@gitster.dls.corp.google.com>
 <1394004715-18776-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfP6-0006xz-K9
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbaCFVA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:00:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:34333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751548AbaCFVA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:00:27 -0500
Received: (qmail 31097 invoked by uid 102); 6 Mar 2014 21:00:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 15:00:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 16:00:26 -0500
Content-Disposition: inline
In-Reply-To: <1394004715-18776-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243551>

On Wed, Mar 05, 2014 at 04:31:55PM +0900, Brian Gesiak wrote:

> No test asserts that "git branch -u refs/heads/my-branch my-branch"
> emits a warning. Add a test that does so.
> 
> Signed-off-by: Brian Gesiak <modocache@gmail.com>

Thanks, this looks good. Two minor points that may or may not be worth
addressing:

> +test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
> +	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
> +	cat >expected <<EOF &&
> +warning: Not setting branch my13 as its own upstream.
> +EOF

If you spell the EOF marker as:

    cat >expect <<-\EOF

then:

  1. The shell does not interpolate the contents (it does not matter
     here, but it is a good habit to be in, so we typically do it unless
     there is a need to interpolate).

  2. Using <<- will strip leading tabs, so the content can be indented
     properly along with the rest of the test.

> +	test_i18ncmp expected actual &&
> +	test_must_fail git config branch.my13.remote &&
> +	test_must_fail git config branch.my13.merge

I think we could tighten these to:

  test_expect_code 1 git config branch.my13.remote

to eliminate a false-positive success on other config errors. It's
highly improbable for it to ever matter, though (and it looks like we
are not so careful in most other places that call "git config" looking
for a missing entry, either).

-Peff
