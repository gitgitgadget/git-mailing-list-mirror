From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch[PATCH 2/2]
Date: Thu, 04 Dec 2008 01:00:09 -0800
Message-ID: <7vljuwe2na.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
 <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE68.6030009@gmail.com>
 <7v4p1kalno.fsf@gitster.siamese.dyndns.org> <49377F25.9020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8A5X-00032h-SR
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYLDJAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 04:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYLDJAS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 04:00:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYLDJAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 04:00:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F416984009;
	Thu,  4 Dec 2008 04:00:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9FE384008; Thu,
  4 Dec 2008 04:00:12 -0500 (EST)
In-Reply-To: <49377F25.9020005@gmail.com> (William Pursell's message of "Thu,
 04 Dec 2008 06:56:37 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7C83D66-C1E1-11DD-A37D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102330>

William Pursell <bill.pursell@gmail.com> writes:

> From b039fb8aa03efab3faf46c0a0a8d84cea974f26f Mon Sep 17 00:00:00 2001
> From: William Pursell <bill.pursell@gmail.com>
> Date: Thu, 4 Dec 2008 06:48:57 +0000
> Subject: [PATCH 2/2] Add 'g' command to go to a hunk.
>
> When a minor change is made while the working directory
> is in a bit of a mess (and the user should have done a
> stash before making the minor edit, but didn't) it is
> somewhat difficult to wade through all of the hunks using
> git add --patch.  This allows one to jump to the hunk
> that needs to be staged without having to respond 'n' to
> each preceding hunk.

The issue is not limited to "forgot to stash" situation.

> Signed-off-by: William Pursell <bill.pursell@gmail.com>
> ---

It is customary to explain what you changed since v1 here, after the
three-dash separator, to help reviewers.

>  git-add--interactive.perl |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index b25a841..555c981 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -800,6 +800,7 @@ y - stage this hunk
>  n - do not stage this hunk
>  a - stage this and all the remaining hunks in the file
>  d - do not stage this hunk nor any of the remaining hunks in the file
> +g - select a hunk to goto

"go to"?  There are a few more.

>  j - leave this hunk undecided, see next undecided hunk
>  J - leave this hunk undecided, see next hunk
>  k - leave this hunk undecided, see previous undecided hunk
> @@ -946,6 +947,9 @@ sub patch_update_file {
>  		if ($ix < $num - 1) {
>  			$other .= '/J';
>  		}
> +		if ($num > 1) {
> +			$other .= '/g';
> +		}
>  		for ($i = 0; $i < $num; $i++) {
>  			if (!defined $hunk[$i]{USE}) {
>  				$undecided = 1;
> @@ -979,6 +983,28 @@ sub patch_update_file {
>  				}
>  				next;
>  			}
> +			elsif ($other =~ 'g' && $line =~ /^g(.*)/) {

I think I fixed this with ($other =~ /g/ && ...) when I queued your
previous round to 'pu' tonight.

> +				my $response = $1;
> +				my $i = $ix > 10 ? $ix - 10 : 0;

This is different from v1.  I understand the motivation (i.e. if you are
at 73rd hunk of a 100-hunk series, showing hunks 63-83 instead of starting
from hunk 1-10 would be nicer), but that is something to explain as one of
the "changes since v1".

I think you are inside a loop that is controlled by another $i (see the
context in the hunk before this one) and it would be better to use
different variable, such as $hunk_no (or just $no).

> +				while ($response eq '') {
> +					my $extra = "";
> +					$i = display_hunks(\@hunk, $i);
> +					if ($i < $num) {
> +						$extra = " (<ret> to see more)";
> +					}
> +					print "goto which hunk$extra? ";

"go to"?

Again, this came too late for tonight's round.  I've parked your previous
one with fix-up in 'pu', but you are free to tell me to replace it
(together with [1/2] from your previous round) with an updated pair.
