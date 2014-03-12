From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Wed, 12 Mar 2014 18:06:40 -0400
Message-ID: <20140312220640.GA14802@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net>
 <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
 <20140312211415.GA10305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:06:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNrIU-0003lS-N3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 23:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbaCLWGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 18:06:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:38403 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbaCLWGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 18:06:41 -0400
Received: (qmail 8001 invoked by uid 102); 12 Mar 2014 22:06:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 17:06:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 18:06:40 -0400
Content-Disposition: inline
In-Reply-To: <20140312211415.GA10305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244004>

On Wed, Mar 12, 2014 at 05:14:15PM -0400, Jeff King wrote:

> One thing that bugs me about the current code is that the sub-function
> looks one past the end of the length given to it by the caller.
> Switching it to pass "eof - line + 1" resolves that, but is it right?
> 
> The character pointed at by "eof" is either:
> 
>   1. space, if our strchr(line, ' ') found something
> 
>   2. the first character of the next line, if our
>      memchr(line, '\n', eob - line) found something
> 
>   3. Whatever is at eob (end-of-buffer)

This misses a case. We might find no space at all, and eof is NULL. We
never dereference it, so we don't segfault, but it does cause a bogus
giant allocation.

I'm out of time for the day, but here is a test I started on that
demonstrates the failure:

diff --git a/t/t7513-commit-bogus-extra-headers.sh b/t/t7513-commit-bogus-extra-headers.sh
index e69de29..834db08 100755
--- a/t/t7513-commit-bogus-extra-headers.sh
+++ b/t/t7513-commit-bogus-extra-headers.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='check parsing of badly formed commit objects'
+. ./test-lib.sh
+
+EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+
+test_expect_success 'newline right after mergetag header' '
+	test_tick &&
+	cat >commit <<-EOF &&
+	tree $EMPTY_TREE
+	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	mergetag
+
+	foo
+	EOF
+	commit=$(git hash-object -w -t commit commit) &&
+	cat >expect <<-EOF &&
+	todo...
+	EOF
+	git --no-pager show --show-signature $commit >actual &&
+	test_cmp expect actual
+'
+
+test_done

The "git show" fails with:

  fatal: Out of memory, malloc failed (tried to allocate 18446744073699764927 bytes)

So I think the whole function could use some refactoring to handle
corner cases better. I'll try to take a look tomorrow, but please feel
free if somebody else wants to take a crack at it.

-Peff
