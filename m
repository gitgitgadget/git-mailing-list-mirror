From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Mon, 25 Jul 2011 16:44:01 -0700
Message-ID: <7vbowiq62m.fsf@alter.siamese.dyndns.org>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 01:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlUom-0004Le-Ci
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 01:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404Ab1GYXoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 19:44:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab1GYXoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 19:44:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 163A350A9;
	Mon, 25 Jul 2011 19:44:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ePOrHRkKuoGdIjJsAo+2B0r2mZg=; b=wKS/sc
	nK8Tly6KMfI4w6eLWQyzm4rDQQ0XjldA5VSfTrDsSCr6Z8KbV1j3vG7HAHKLyjZB
	DivsAdWNpxazPHATwSZqGXGO/lFkUO7OfMIA+OA4j52hqyk8+De6/PWxFxyA3N25
	omSdxmuGuN+zjrjJOoB72KV2h9AgWNBtPr3uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XSeQocTy3XMq+NXDH6bFt+K0K+IYjwK2
	6TvbxG/LcmuOkGHFW0PSNqE9/0+U7IIce0i4Ap4H1UNRnLG3eZV/WaKTmi1l8lht
	KjHSe5w0NJRJz0Lk6JSv8qvzre2H8ozRFXeU6DZs4rbendbO9urB/JK8aq/7p61Z
	UUl3JODHLpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C2C50A8;
	Mon, 25 Jul 2011 19:44:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78FEB50A7; Mon, 25 Jul 2011
 19:44:03 -0400 (EDT)
In-Reply-To: <20110725215553.GA23145@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Jul 2011 15:55:55 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA72C8C8-B717-11E0-A929-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177835>

Jeff King <peff@peff.net> writes:

> However, I'm not sure I would trust my regex to actually get all of the
> changes needed for the refactoring (e.g., there might be nearby hunks
> related to the refactoring that are not specifically in the same hunk as
> the word "foo"). So I tend to just "git add -p" and flip through the
> changes manually.

Yes, that is a valid concern.

> You can already skip around in the hunk list using "/regex". Might that
> be enough for you? I think you're stuck typing "/yoursearch" over and
> over, though. It would be nice if doing just "/" would search again for
> the previous regex.

Yes, I think that makes a lot more sense than the current "Ah, empty? ask
from the terminal" behaviour.

 git-add--interactive.perl |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..0b6f8a6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1257,7 +1257,7 @@ sub display_hunks {
 
 sub patch_update_file {
 	my $quit = 0;
-	my ($ix, $num);
+	my ($ix, $num, $last_search_string);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
 	($head, my $mode, my $deletion) = parse_diff_header($head);
@@ -1395,11 +1395,12 @@ sub patch_update_file {
 			}
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
-				if ($1 eq "") {
-					print colored $prompt_color, "search for regex? ";
-					$regex = <STDIN>;
-					if (defined $regex) {
-						chomp $regex;
+				if ($regex eq "") {
+					if ($last_search_string) {
+						$regex = $last_search_string;
+					} else {
+						error_msg "Need a regexp to search\n";
+						next;
 					}
 				}
 				my $search_string;
@@ -1412,6 +1413,7 @@ sub patch_update_file {
 					error_msg "Malformed search regexp $exp: $err\n";
 					next;
 				}
+				$last_search_string = $regex;
 				my $iy = $ix;
 				while (1) {
 					my $text = join ("", @{$hunk[$iy]{TEXT}});
