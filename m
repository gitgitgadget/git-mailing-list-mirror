From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Wed, 29 Jul 2009 11:31:17 -0700
Message-ID: <7v63dbuyru.fsf@alter.siamese.dyndns.org>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "Pickens\, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWDw7-0001Fg-EJ
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZG2Sb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 14:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZG2Sb1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 14:31:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZG2Sb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 14:31:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74AC715454;
	Wed, 29 Jul 2009 14:31:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8EF021544A; Wed, 29 Jul 2009
 14:31:19 -0400 (EDT)
In-Reply-To: <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 (James E. Pickens's message of "Wed\, 29 Jul 2009 10\:48\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 071068EC-7C6E-11DE-944B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124377>

"Pickens, James E" <james.e.pickens@intel.com> writes:

> This test creates two directories, a/b and a/b-2, then replaces a/b with
> a symlink to a/b-2, then merges that change into another branch that
> contains an unrelated change.

Thanks.

> Note that using the resolve strategy instead of recursive makes the
> second bug go away, but not the third one.

It is better to have separate tests for documentation purposes to help
people who track down the breakage in such a case.

> +test_expect_failure 'checkout should not have deleted a/b-2/c/d' '
> +       test -f a/b-2/c/d
> +'
> +
> +test_expect_success 'clean the work tree and do the merge' '
> +       git reset --hard &&
> +       test -f a/b-2/c/d &&
> +       echo x > a/x &&
> +       git add a/x &&
> +       git commit -m x &&
> +       git merge master
> +'
> +
> +test_expect_failure 'merge should not have deleted a/b-2/c/d' '
> +       test -f a/b-2/c/d
> +'

So...

	test_expect_success 'setup for merge test' '
        	...
                git commit -m x &&
                git tag baseline
	'

	test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
		git reset --hard &&
        	git checkout baseline^0 &&
                git merge -s resolve master
	'

	test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
		git reset --hard &&
        	git checkout baseline^0 &&
                git merge -s recursive master
	'

Likewise for the other one.
