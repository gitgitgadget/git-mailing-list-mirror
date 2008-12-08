From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: Make following parents atomic
Date: Mon, 08 Dec 2008 00:33:22 -0800
Message-ID: <7v1vwj83sd.fsf@gitster.siamese.dyndns.org>
References: <20081207222444.GA10881@euler>
 <1228717252-1016-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 09:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9bZq-0004L8-0G
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 09:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYLHIdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 03:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbYLHIdc
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 03:33:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbYLHIdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 03:33:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B8947185F9;
	Mon,  8 Dec 2008 03:33:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29021185F8; Mon, 
 8 Dec 2008 03:33:23 -0500 (EST)
In-Reply-To: <1228717252-1016-1-git-send-email-deskinm@umich.edu> (Deskin
 Miller's message of "Mon, 8 Dec 2008 01:20:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3712FB6-C502-11DD-A396-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102536>

Deskin Miller <deskinm@umich.edu> writes:

> +test_expect_success "follow-parent is atomic" '
> +	cd wc &&
> +	svn up &&
> +	svn mkdir stunk &&
> +	cd stunk &&
> +	echo "trunk stunk" > readme &&
> +	svn add readme &&
> +	cd .. &&

If you need to chdir around inside a test, please do that in a subshell,
so that after failing any command in between, the next test will not start
in an unexpected directory.

> +	svn ci -m "trunk stunk" &&
> +	echo "stunk like junk" >> stunk/readme &&
> +	svn ci -m "really stunk" &&
> +	echo "stink stank stunk" >> stunk/readme &&
> +	svn ci -m "even the grinch agrees" &&
> +	cd .. &&
> +	svn copy -m "stunk flunked" "$svnrepo"/stunk "$svnrepo"/flunk &&

> +	(svn cp -m "early stunk flunked too" \
> +		"$svnrepo"/stunk@17 "$svnrepo"/flunked ||
> +	svn cp -m "early stunk flunked too" \
> +		-r17 "$svnrepo"/stunk "$svnrepo"/flunked) &&

On the other hand, I do not see a need for this portion to be in a
subshell.  Wouldn't a normal statement grouping with {} work just as well?
