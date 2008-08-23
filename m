From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix in-index merge.
Date: Sat, 23 Aug 2008 03:00:04 -0700
Message-ID: <7v7ia8126z.fsf@gitster.siamese.dyndns.org>
References: <20080823060839.GB23800@genesis.frugalware.org>
 <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 <48AFD62F.2090500@gnu.org> <7vej4g12dv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpvq-0002JR-58
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYHWKAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYHWKAO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:00:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbYHWKAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 06:00:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A049A643A8;
	Sat, 23 Aug 2008 06:00:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 375BC643A4; Sat, 23 Aug 2008 06:00:06 -0400 (EDT)
In-Reply-To: <7vej4g12dv.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Aug 2008 02:55:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 47014578-70FA-11DD-824F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93454>

Junio C Hamano <gitster@pobox.com> writes:

> Here is a tentative fix on top of Miklos's two patches, even though I
> won't take them as-is until the test scripts are cleaned up.
>
>  t/t7605-merge-resolve.sh |    4 +++-
>  unpack-trees.c           |    2 ++
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git c/t/t7605-merge-resolve.sh w/t/t7605-merge-resolve.sh
> index ee21a10..be21ded 100755
> --- c/t/t7605-merge-resolve.sh
> +++ w/t/t7605-merge-resolve.sh
> @@ -36,7 +36,9 @@ test_expect_success 'merge c1 to c2' '
>  	git diff --exit-code &&
>  	test -f c0.c &&
>  	test -f c1.c &&
> -	test -f c2.c
> +	test -f c2.c &&
> +	test 3 = $(git ls-tree -r HEAD | wc -l) &&
> +	test 2 = $(git ls-files | wc -l)
>  '

Sorry, the last "2" should obviously be "3".  We are making sure all three
paths are included in the result.

>  
>  test_expect_success 'merge c2 to c3 (fails)' '
> diff --git c/unpack-trees.c w/unpack-trees.c
> index cba0aca..016fd46 100644
> --- c/unpack-trees.c
> +++ w/unpack-trees.c
> @@ -378,6 +378,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	memset(&o->result, 0, sizeof(o->result));
>  	if (o->src_index)
>  		o->result.timestamp = o->src_index->timestamp;
> +	if (o->dst_index)
> +		o->result.alloc = xmalloc(1);
>  	o->merge_size = len;
>  
>  	if (!dfc)
