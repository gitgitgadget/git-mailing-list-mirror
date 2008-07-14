From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-add -i accept ranges like 7-
Date: Mon, 14 Jul 2008 11:15:13 -0700
Message-ID: <7vfxqcgwni.fsf@gitster.siamese.dyndns.org>
References: <1216058784-32584-1-git-send-email-ciaran.mccreesh@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISb0-0007QL-2Q
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYGNSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbYGNSPX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:15:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYGNSPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:15:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A13D42BBF7;
	Mon, 14 Jul 2008 14:15:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 87F002BBF5; Mon, 14 Jul 2008 14:15:15 -0400 (EDT)
In-Reply-To: <1216058784-32584-1-git-send-email-ciaran.mccreesh@googlemail.com> (Ciaran
 McCreesh's message of "Mon, 14 Jul 2008 19:06:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D13DA072-51D0-11DD-962B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88443>

Ciaran McCreesh <ciaran.mccreesh@googlemail.com> writes:

> git-add -i ranges expect number-number. But for the supremely lazy, typing in
> that second number when selecting "from patch 7 to the end" is wasted effort.
> So treat an empty second number in a range as "until the last item".

You didn't describe why you changed the first regexp from \d+ to \d*,
which would allow "-9" as a valid input as well.

But in that case $bottom will become an empty string.  Don't you need to
adjust the users of this data in the codepaths that follow this part?  I
didn't check.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 801d7c0..72a8858 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -406,9 +406,9 @@ sub list_and_choose {
>  			if ($choice =~ s/^-//) {
>  				$choose = 0;
>  			}
> -			# A range can be specified like 5-7
> -			if ($choice =~ /^(\d+)-(\d+)$/) {
> -				($bottom, $top) = ($1, $2);
> +			# A range can be specified like 5-7 or 5-.
> +			if ($choice =~ /^(\d*)-(\d*)$/) {
> +				($bottom, $top) = ($1, length($2) ? $2 : 1 + @stuff);
>  			}
>  			elsif ($choice =~ /^\d+$/) {
>  				$bottom = $top = $choice;
> -- 
> 1.5.6.2
