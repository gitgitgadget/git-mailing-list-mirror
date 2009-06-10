From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] send-email: fix threaded mails without chain-reply-to
Date: Tue, 09 Jun 2009 22:51:56 -0700
Message-ID: <7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 07:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEGjF-0007rD-JI
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 07:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZFJFv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 01:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZFJFvz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 01:51:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43443 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZFJFvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 01:51:55 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610055156.ENGM20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Wed, 10 Jun 2009 01:51:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 25rx1c0014aMwMQ045rxyP; Wed, 10 Jun 2009 01:51:57 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=DTURR59ZX_YA:10 a=9gWHBb600ogA:10
 a=yxE0wBN2gSfxrL5ecBMA:9 a=ruozNAu3Df6wd-CoCJrwFubauwcA:4 a=MCAouRVjatsA:10
 a=5KVauyKsRKMA:10 a=cMVlMV7zS7C0XS9h:21 a=TmMq-uWV5dDJTlnD:21
X-CM-Score: 0.00
In-Reply-To: <1244410857-920-4-git-send-email-markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\,  7 Jun 2009 23\:40\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121251>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> These commands didn't send threaded mails anymore:
>
>     $ git format-patch <revision range>
>     $ git send-email --thread --no-chain-reply-to <files>
>
> This regression was introduced in commit 15da108 ("send-email:
> 'References:' should only reference what is sent", 2009-04-13) by a
> hidden code style change:
>
>     ! defined $reply_to || length($reply_to) == 0
> was changed to
>     not defined $reply_to || length($reply_to) == 0
> which is
>     not (defined $reply_to || length($reply_to) == 0)
> instead of
>     (not defined $reply_to) || (length($reply_to) == 0)
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ...
> -	if ($message_was_sent and $chain_reply_to || not defined $reply_to || length($reply_to) == 0) {
> +	if ($message_was_sent and $chain_reply_to || !defined $reply_to || length($reply_to) == 0) {

You were too polite to say "by a hidden code style change", instead of
saying something stronger, like "without understanding the operator
precedence rules", but I actually thing that is what is going on.  Not
just the original author of 15da108 but no reviewer noticed when the patch
was posted on the list.

The problem description strongly suggests to me that we should probably
fix the use of "and" here as well in order to avoid confusing ourselves.

You have another patch that touches this area that adds "and $thread", but
I think it is much less error prone if we stick to && and || with explicit
parentheses to clarify the precedence we want to see.
