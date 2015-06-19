From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Fri, 19 Jun 2015 07:38:48 -0400
Message-ID: <20150619113847.GA31824@peff.net>
References: <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
 <20150618204505.GD14550@peff.net>
 <20150618212356.GA20271@peff.net>
 <20150619035408.GA23679@peff.net>
 <xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
 <20150619053223.GA27241@peff.net>
 <20150619073455.GA29109@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5udL-00066L-FO
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbbFSLiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 07:38:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48743 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbbFSLiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 07:38:50 -0400
Received: (qmail 14989 invoked by uid 102); 19 Jun 2015 11:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 06:38:50 -0500
Received: (qmail 14969 invoked by uid 107); 19 Jun 2015 11:38:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 07:38:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 07:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20150619073455.GA29109@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272132>

On Fri, Jun 19, 2015 at 03:34:55AM -0400, Jeff King wrote:

> And here's some more bad news. If you look at the diff for this
> patch itself, it's terribly unreadable (the regular diff already is
> pretty bad, but the highlights make it much worse). There are big chunks
> where we take away 5 or 10 lines from the old code, and replace them
> with totally unrelated lines. We end up highlighting almost the entire
> thing, except for spaces and punctuation.
> 
> We might be able to solve this with a percentage heuristic similar to
> the one Patrick proposed. It's not really interesting to highlight
> unless we're doing it on probably 20% or less of the diff (where 20% is
> a number I just made up).

That turned out to be pretty easy; patch is below (on top of what I sent
earlier). I set the percentage at 50% based on eyeballing "git log -p"
in git.git, and it seems to give good results.

So I think the big remaining issue is improved tokenizing. Maybe Patrick
will want to take a stab at it.

---
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 1525ccc..9454446 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -114,12 +114,32 @@ sub show_hunk {
 			if $bits & 2;
 	}
 
+	my $highlighted = count_highlight(@highlight_a) +
+			  count_highlight(@highlight_b);
+	my $total = length($a) + length($b);
+	my $pct = $highlighted / $total;
+
+	if ($pct > 0.5) {
+		@highlight_a = ();
+		@highlight_b = ();
+	}
+
 	# And now show the output both with the original stripped annotations,
 	# as well as our new highlights.
 	show_image($a, [merge_annotations(\@stripped_a, \@highlight_a)]);
 	show_image($b, [merge_annotations(\@stripped_b, \@highlight_b)]);
 }
 
+sub count_highlight {
+	my $total = 0;
+	while (@_) {
+		my $from = shift;
+		my $to = shift;
+		$total += $to->[0] - $from->[0];
+	}
+	return $total;
+}
+
 # Strip out any diff syntax (i.e., leading +/-), along with any ANSI color
 # codes from the pre- or post-image of a hunk. The result is a string of text
 # suitable for diffing against the other side of the hunk.
