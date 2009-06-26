From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] read-tree: migrate to parse-options
Date: Fri, 26 Jun 2009 10:23:21 -0700
Message-ID: <7vab3uucxi.fsf@alter.siamese.dyndns.org>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
	<1245993250-8213-1-git-send-email-bebarino@gmail.com>
	<1245993250-8213-2-git-send-email-bebarino@gmail.com>
	<4A445CB0.4010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKF98-0005JW-4S
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 19:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbZFZRXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 13:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZFZRXT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 13:23:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49502 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbZFZRXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 13:23:19 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090626172320.MNMO18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Fri, 26 Jun 2009 13:23:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8hPM1c00K4aMwMQ04hPMM0; Fri, 26 Jun 2009 13:23:21 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=XzB1hdDWffMA:10 a=pGLkceISAAAA:8
 a=DO18-AkTYmQzAZKMYVUA:9 a=hxc2hsTdTB8K2sMctrqLCr6v7D4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A445CB0.4010506@gmail.com> (Stephen Boyd's message of "Thu\, 25 Jun 2009 22\:29\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122310>

Stephen Boyd <bebarino@gmail.com> writes:

> Sorry I went a little overboard with s/:1// on unpack_tree_options.
> You'll probably want to squash this on top.
>
> diff --git a/unpack-trees.h b/unpack-trees.h
> index d19df44..f344679 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -21,14 +21,14 @@ struct unpack_trees_options {
>                      merge,
>                      update,
>                      index_only,
> -                    nontrivial_merge,
> +                    nontrivial_merge:1,
>                      trivial_merges_only,
>                      verbose_update,
>                      aggressive,
> -                    skip_unmerged,
> -                    initial_checkout,
> -                    diff_index_cached,
> -                    gently;
> +                    skip_unmerged:1,
> +                    initial_checkout:1,
> +                    diff_index_cached:1,
> +                    gently:1;

Let's look at this (not this follow-up patch) the other way around.

Six months down the load, somebody may ask you:

    Is there a good reason why many are not bitfields but only selected
    few are bitfields in this structure?  Most of these can and should be
    bitfields, as far as I can see, because the code uses them as
    booleans, and the only breakage it may cause if we change them to
    bitfields to shrink this structure would be the option parsing code.

What would be your answer?  Doesn't it feel wrong to do such a conversion
only to work around the current limitation of parseopt?

By the way, has it been verified that all the users of these fields are OK
with this change when they use these fields?  I am not worried about them
reading the value command line option parser set, but more worried about
reading after other codepaths set/modified these fields.  The command line
parser that uses parseopt may correctly set only 0 or 1 to these fields
initially and we should be able to verify that from the patch text, but
there is no guarantee that this conversion is even correct at runtime
without an audit, no?

The callers have long relied on the fact that reading from these bitfields
yields either 0 or 1 and never 2 or larger, but they are now widened to
full-width unsigned.  A pattern like this:

	uto.field = ~uto.field;
        if (uto.field == 1) {
        	field now set;
	} else {
        	field now unset;
	}

would be broken by widening "unsigned field:1" to "unsigned field", right?
I am not saying this is the only pattern that would break, nor I know
there are codepaths that use this pattern, but I think you got my point.
