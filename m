From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Wed, 25 Feb 2009 13:58:17 -0800
Message-ID: <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRnF-0007yH-5C
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758960AbZBYV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757454AbZBYV6Z
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:58:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699AbZBYV6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:58:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EBFA71381;
	Thu, 26 Feb 2009 16:58:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 34E8F137D; Thu,
 26 Feb 2009 16:58:18 -0500 (EST)
In-Reply-To: <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Tue, 24 Feb 2009 18:40:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94E439D2-0450-11DE-BB05-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111503>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -419,6 +419,41 @@ test_expect_success 'push with config remote.*.push = HEAD' '
>  git config --remove-section remote.there
>  git config --remove-section branch.master
>  
> +test_expect_success 'push with --repo=repourl from non-tracking branch' '
> +
> +	mk_test heads/master &&
> +	git push --repo=testrepo &&
> +	check_push_result $the_commit heads/master
> +'
> +
> +# set up fake remote config
> +test_expect_success 'push with --repo=remoterepo from non-tracking branch' '
> +
> +	mk_test heads/master &&
> +	git config remote.testremote.url testrepo &&
> +	git push --repo=testremote &&
> +	check_push_result $the_commit heads/master
> +'
> +
> +# set up fake tracking info; testrepo exists, origin does not.
> +test_expect_failure 'push with --repo=repo from tracking branch with bad config' '
> +
> +	mk_test heads/master &&
> +	git config branch.master.remote origin &&
> +	test_must_fail git push --repo=testrepo
> +'

At this point, you have:

	branch.master.remote = origin
        remote.testremote.url = testrepo

and nothing else related to push.  And you are asking a "git push but
instead of origin please default to testrepo".

In response to that request, in order to figure out what refs to push by
default, remote.testremote.push instead of remote.origin.push will be
consulted, and we won't even have to notice nor complain the missing
remote.origin.  remote.testremote.push is missing, so the push defaults to
the "matching ref" behaviour.

I do not understand why you expect the above to fail.

> +test_expect_failure 'push with --repo=repo from tracking branch with good config' '
> +
> +	mk_test heads/master &&
> +	git config branch.master.remote testrepo &&
> +	git push --repo=origin &&
> +	check_push_result $the_commit heads/master
> +'

Likewise.

I think the "good/bad config" labels given to your two test scripts are
swapped and there is no bug or misfeature here.
