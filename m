From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] for-each-ref: Always check stat_tracking_info()'s
 return value.
Date: Sat, 3 Jan 2015 06:41:13 -0500
Message-ID: <20150103114113.GC27793@peff.net>
References: <1420232513-13867-1-git-send-email-raphael.kubo.da.costa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 12:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7N6K-00072C-E9
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 12:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbbACLlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 06:41:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:58531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750966AbbACLlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 06:41:15 -0500
Received: (qmail 26428 invoked by uid 102); 3 Jan 2015 11:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 05:41:16 -0600
Received: (qmail 20976 invoked by uid 107); 3 Jan 2015 11:41:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 06:41:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Jan 2015 06:41:13 -0500
Content-Disposition: inline
In-Reply-To: <1420232513-13867-1-git-send-email-raphael.kubo.da.costa@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261996>

On Fri, Jan 02, 2015 at 11:01:53PM +0200, Raphael Kubo da Costa wrote:

> In this case, num_ours and num_theirs had undefined values and a call to
> `git for-each-ref --format="%(upstream:track)"` could print spurious
> values such as
> 
>   [behind -111794512]
>   [ahead 38881640, behind 5103867]
> 
> even for repositories with one single commit.
> 
> We now properly verify stat_tracking_info()'s return value and do not
> print anything if it returns -1. This behavior also matches the
> documentation ("has no effect if the ref does not have tracking
> information associated with it").

Thanks, this iteration looks good to me, and this is definitely a bug
worth fixing.

> +test_expect_success 'Check that :track[short] works when upstream is gone' '
> +	git branch --track to_delete master &&
> +	git branch --track parent_gone to_delete &&
> +	test_when_finished "git branch -D parent_gone" &&
> +	git branch -D to_delete &&
> +	git for-each-ref --format="%(upstream:track)" refs/heads/parent_gone >actual &&
> +	git for-each-ref --format="%(upstream:trackshort)" refs/heads/parent_gone >>actual &&
> +	test_cmp expected actual
> +'

I think you could minimize this quite a bit as:

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index cba3454..f259c22 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -340,12 +340,11 @@ cat >expected <<EOF
 EOF
 
 test_expect_success 'Check that :track[short] works when upstream is gone' '
-	git branch --track to_delete master &&
-	git branch --track parent_gone to_delete &&
-	test_when_finished "git branch -D parent_gone" &&
-	git branch -D to_delete &&
-	git for-each-ref --format="%(upstream:track)" refs/heads/parent_gone >actual &&
-	git for-each-ref --format="%(upstream:trackshort)" refs/heads/parent_gone >>actual &&
+	test_when_finished "git config branch.master.merge refs/heads/master" &&
+	git config branch.master.merge refs/heads/does-not-exist &&
+	git for-each-ref \
+		--format="%(upstream:track)$LF%(upstream:trackshort)" \
+		refs/heads/master >actual &&
 	test_cmp expected actual
 '
 

which IMHO makes it a little more obvious what the setup is doing. But I
am OK with it either way.

-Peff
