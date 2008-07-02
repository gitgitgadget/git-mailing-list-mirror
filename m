From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-add--interactive: remove hunk coalescing
Date: Wed, 02 Jul 2008 15:26:02 -0700
Message-ID: <7vtzf77wjp.fsf@gitster.siamese.dyndns.org>
References: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
 <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEAnB-0001lB-V4
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbYGBW0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756726AbYGBW0P
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 18:26:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbYGBW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 18:26:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 682869F41;
	Wed,  2 Jul 2008 18:26:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 55CF69F3F; Wed,  2 Jul 2008 18:26:06 -0400 (EDT)
In-Reply-To: <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Wed, 2 Jul 2008 23:59:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E06E0838-4885-11DD-BD9D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87202>

Thomas Rast <trast@student.ethz.ch> writes:

> Current git-apply has no trouble at all applying chunks that have
> overlapping context, as produced by the splitting feature. So we can
> drop the manual coalescing.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  git-add--interactive.perl |   89 ---------------------------------------------
>  1 files changed, 0 insertions(+), 89 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index e1964a5..a4234d3 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -682,93 +682,6 @@ sub split_hunk {
>  	return @split;
>  }
>  
> -sub find_last_o_ctx {
> ...
> -}
> -
> -sub merge_hunk {
> ...
> -}
> -
> -sub coalesce_overlapping_hunks {
> ...
> -}
>  
>  sub help_patch_cmd {
>  	print colored $help_color, <<\EOF ;
> @@ -962,8 +875,6 @@ sub patch_update_file {
>  		}
>  	}
>  
> -	@hunk = coalesce_overlapping_hunks(@hunk);
> -
>  	my $n_lofs = 0;
>  	my @result = ();
>  	if ($mode->{USE}) {
> -- 
> 1.5.6.1.276.gde9a

I think [1/3] makes sense as we trust --recount anyway (and more
importantly if the user did not muck with the patch --recount would be a
no-op), but I am not sure about this one.  I suspect this change reduces
the precision and safety of the patch application, especially when the
user does not edit hunks.

When you "[s]plit" a hunk like this:

	@@ -n,7 +m,6 @@
         con
         text
        -deleted preimage
        +replaced postimage
	 more
	 line of context
        -deleted another
	 context

into two, we prepare these two hunks internally:

	@@ -n,5 +m,5 @@
         con
         text
        -deleted preimage
        +replaced postimage
	 more
         line of context

	@@ -l,4 +k,3 @@  -- l=n+5, k=m+5
	 more
         line of context
        -deleted another
	 context

So that applying only one piece without applying the other would still
have correct context to locate where to apply.  However, if the user says
"I want to apply both after all", we would need to remove the overlap when
merge them back.  If you don't, you would be feeding a nonsense patch to
"git apply" that goes back in context.

Blindly concatenating the above two and feeding them to "git apply" *may*
happen to work by accident, not by design.  This very much feels like a
hack of "This works most of the time for me, your mileage may vary" kind,
which we would want to avoid when we can.
