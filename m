From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 15:51:34 -0500
Message-ID: <20071217205134.GB2105@coredump.intra.peff.net>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com> <20071217195658.GB13515@fieldses.org> <1197921847.27386.16.camel@localhost> <20071217201219.GC13515@fieldses.org> <1197922971.27386.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:52:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MwU-0003gP-9q
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbXLQUvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbXLQUvi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:51:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3393 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbXLQUvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:51:37 -0500
Received: (qmail 13246 invoked by uid 111); 17 Dec 2007 20:51:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 15:51:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 15:51:34 -0500
Content-Disposition: inline
In-Reply-To: <1197922971.27386.32.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68617>

On Mon, Dec 17, 2007 at 12:22:51PM -0800, Joe Perches wrote:

> $ let count=0 ; for line in $(cat patch_order) ; do ((count++)); \
> 	printf -v tmp "%04u-Spelling-%s" $count $line ; \
> 	tmp=${tmp//\//-} ; tmp=${tmp// /}; \
> 	git-format-patch -N --thread --start-number $count -s \
> 	-o patch3 \
> 	--subject-prefix="[PATCH] Spelling: $line" master $line  ; done
> [converted the subjects appropriately]
> $ git-send-email --smtp-server <foo> --smtp-user <bar> \
> 	--from "Joe Perches <joe@perches.com>" \
> 	--to "linux-kernel@vger.kernel.org" \
> 	--cc "Andrew Morton <akpm@linux-foundation.org>" \
> 	--cc-cmd "../get_maintainer.pl --nogit" \
> 	--no-thread --suppress-from patch3

Ah. The problem is that git-send-email unconditionally adds a
message-id. Usually git-format-patch doesn't add one, but for obvious
reasons, it must when doing --thread. Here is a fix.

-- >8 --
git-send-email: avoid duplicate message-ids

We used to unconditionally add a message-id to the outgoing
email without bothering to check if it already had one.
Instead, let's use the existing one.

Signed-off-by: Jeff King <peff@peff.net>
---
It will also happily add duplicate --in-reply-to and --references
headers, but those can be suppressed with --no-thread. Arguably, it
should detect this case and turn on --no-thread, but looking at
git-send-email makes me want to claw my eyes out.

 git-send-email.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1d6f466..083466a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -580,7 +580,7 @@ sub send_message
 		$ccline = "\nCc: $cc";
 	}
 	my $sanitized_sender = sanitize_address($sender);
-	make_message_id();
+	make_message_id() unless defined($message_id);
 
 	my $header = "From: $sanitized_sender
 To: $to${ccline}
@@ -718,6 +718,9 @@ foreach my $t (@files) {
 					}
 					push @xh, $_;
 				}
+				elsif (/^Message-Id: (.*)/i) {
+					$message_id = $1;
+				}
 				elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
 					push @xh, $_;
 				}
-- 
1.5.4.rc0.1146.gc97f-dirty
