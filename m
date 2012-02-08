From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4] tag: add --points-at list option
Date: Wed, 8 Feb 2012 15:58:57 -0500
Message-ID: <20120208205857.GA22479@sigill.intra.peff.net>
References: <20120208185750.GA22220@sigill.intra.peff.net>
 <1328731972-13137-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 21:59:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvEba-00042l-Au
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 21:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab2BHU7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 15:59:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59707
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2BHU7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 15:59:00 -0500
Received: (qmail 19772 invoked by uid 107); 8 Feb 2012 21:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 16:06:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 15:58:57 -0500
Content-Disposition: inline
In-Reply-To: <1328731972-13137-2-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190254>

On Wed, Feb 08, 2012 at 12:12:52PM -0800, Tom Grennan wrote:

> This filters the list for tags of the given object.
> Example,
> 
>    john$ git tag v1.0-john v1.0
>    john$ git tag -l --points-at v1.0
>    v1.0-john

And probably "v1.0", as well, in this iteration. :)

The patch content itself looks good to me, except:

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
> -'git tag' [-n[<num>]] -l [--contains <commit>]
> +'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>  	[--column[=<options>] | --no-column] [<pattern>...]

What's this "column" stuff doing here? The nd/columns topic is still in
"next", isn't it? Did you base this on "next" or "pu"?

Usually topics should be based on master, so they can graduate
independently of each other. In this case, it might make sense to build
on top of jk/maint-tag-show-fixes (d0548a3), but I don't think that is
even necessary here (my fixes ended up not being too closely related, I
think).

Other than that, I think the patch is fine. There are no tests, so
perhaps these should be squashed in:

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..f61e398 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1269,4 +1269,43 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -v -s
 '
 
+# check points-at
+
+test_expect_success '--points-at cannot be used in non-list mode' '
+	test_must_fail git tag --points-at=v4.0 foo
+'
+
+test_expect_success '--points-at finds lightweight tags' '
+	echo v4.0 >expect &&
+	git tag --points-at v4.0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of commits' '
+	git tag -m "v4.0, annotated" annotated-v4.0 v4.0 &&
+	echo annotated-v4.0 >expect &&
+	git tag -l --points-at v4.0 "annotated*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--points-at finds annotated tags of tags' '
+	git tag -m "describing the v4.0 tag object" \
+		annotated-again-v4.0 annotated-v4.0 &&
+	cat >expect <<-\EOF &&
+	annotated-again-v4.0
+	annotated-v4.0
+	EOF
+	git tag --points-at=annotated-v4.0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'multiple --points-at are OR-ed together' '
+	cat >expect <<-\EOF &&
+	v2.0
+	v3.0
+	EOF
+	git tag --points-at=v2.0 --points-at=v3.0 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.rc2.14.g3da2b
