From: Jeff King <peff@peff.net>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Tue, 8 Dec 2009 01:01:09 -0500
Message-ID: <20091208060109.GB9951@coredump.intra.peff.net>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHt8Q-0002Ou-Nx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbZLHGBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 01:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbZLHGBG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:01:06 -0500
Received: from peff.net ([208.65.91.99]:52534 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001AbZLHGBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 01:01:06 -0500
Received: (qmail 7896 invoked by uid 107); 8 Dec 2009 06:05:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 01:05:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 01:01:09 -0500
Content-Disposition: inline
In-Reply-To: <20091208054724.GA21347@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134818>

On Tue, Dec 08, 2009 at 12:47:24AM -0500, Jeff King wrote:

> There is a slightly different approach we could take, too: keep the
> "deletion" hunk as a first-class hunk, and just meld the content hunk's
> output into it. Then both cases would get the "Stage deletion" question
> instead of the "Stage this hunk" you get now for non-empty files (which
> just happens to trigger a deletion due to the headers).

BTW, the code for this is the much smaller change below. If you prefer
that, I can squash in the test and write up an appropriate commit
message.

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 35f4ef1..02e97b9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1217,7 +1217,11 @@ sub patch_update_file {
 	if (@{$mode->{TEXT}}) {
 		unshift @hunk, $mode;
 	}
-	if (@{$deletion->{TEXT}} && !@hunk) {
+	if (@{$deletion->{TEXT}}) {
+		foreach my $hunk (@hunk) {
+			push @{$deletion->{TEXT}}, @{$hunk->{TEXT}};
+			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
+		}
 		@hunk = ($deletion);
 	}
 
