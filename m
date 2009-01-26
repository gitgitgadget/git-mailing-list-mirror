From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across
 --continue
Date: Mon, 26 Jan 2009 13:05:37 -0800
Message-ID: <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
 <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYfl-0004q5-Sj
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbZAZVFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZAZVFq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:05:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZAZVFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:05:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A988594600;
	Mon, 26 Jan 2009 16:05:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40276945FE; Mon,
 26 Jan 2009 16:05:38 -0500 (EST)
In-Reply-To: <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Mon, 26 Jan 2009 10:05:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1833EB9C-EBED-11DD-ABA6-5805C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107276>

Thomas Rast <trast@student.ethz.ch> writes:

> +test_expect_success 'rebase -i --root with conflict (first part)' '
> +	git checkout -b conflict2 other &&
> +	GIT_EDITOR=: test_must_fail git rebase -i --root --onto master &&
> +	git ls-files -u | grep "B$"
> +'

Maybe I am misrecalling things but didn't we have reports from people on
some platforms that single-shot exporting of the environment like this one
does not work for them?

> +test_expect_success 'fix the conflict' '
> +	echo 3 > B &&
> +	git add B
> +'
> +
> +test_expect_success 'rebase -i --root with conflict (second part)' '
> +	git rebase --continue &&
> +	git log --pretty=tformat:"%s" > conflict2 &&
> +	test_cmp expect-conflict conflict2
> +'
> +
> +sed 's/#/ /g' > expect-conflict-p <<'EOF'
> +*   Merge branch 'third' into other
> +|\##
> +| * 6
> +* |   Merge branch 'side' into other
> +|\ \##
> +| * | 5
> +* | | 4
> +|/ /##
> +* | 3
> +|/##
> +* conflict
> +* 2
> +* 1
> +EOF

I do not like this very much.  Future improvements of the graph drawing
algorithm (one obvious "flaw" you are exposing by the above is that it has
trailing whitespaces that can be trimmed, and somebody else may be
inclined to fix) would break the expectation this test vector has.

Do you have to compare the topology this way, or are there other more
reliable ways?
