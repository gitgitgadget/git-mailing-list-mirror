From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Fri, 18 Mar 2011 16:14:19 -0500
Message-ID: <20110318211418.GA23407@elie>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0h0C-0007lD-Oz
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab1CRVO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:14:29 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45252 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366Ab1CRVO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:14:27 -0400
Received: by yia27 with SMTP id 27so1753316yia.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pWhj8b9Z9R5g+mzbFHRszBRVGRZjWRoqV0lV6N3T+W8=;
        b=BYGCJnY9RzFKQYlRIXotOMaYuX8lznPIL8AM6MVJiE+dX/IFg9TOc1ly5N/np8SnIq
         0t6t+OF4TvsCo706j7M7ucsYEWA3kFcXvc5EjKdpZ2QMc0m8xOzEChLBA00Udg0Gw3Y4
         QFVbihDNxlPloUqbQI/htkv4fxIpdBXiJfOzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kl+vybtCTql1aexWzHc0p6bbK0AS6eSLgZ0VsC+/diLe+J/9QKfRuUk+OFTTXsPkb0
         /XLv8CSVDXTSg4+FR9AM0L7/8BLyEcdb2Wi8OY57QBoW0eN0Bm506Erb0wHolThBiai5
         FdKvSjkU0PrS4A/Dm94iuucmIboxyAPeSLkfc=
Received: by 10.150.254.1 with SMTP id b1mr1677724ybi.324.1300482867032;
        Fri, 18 Mar 2011 14:14:27 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id p33sm235092ybk.17.2011.03.18.14.14.25
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 14:14:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169361>

Hi,

Michael J Gruber wrote:

> [Subject: rev-list --min-parents,--max-parents: doc and test and completion]
>
> This also adds test for "--merges" and "--no-merges" which we did not
> have so far.

Minor nit: the life of reviewers is easier when the documentation and
tests are squashed with the implementation (or if anything, the
documentation comes first) so they can look at what the code tries to
do before seeing how it does it.

> --- a/t/t6009-rev-list-parent.sh
> +++ b/t/t6009-rev-list-parent.sh
> @@ -1,6 +1,6 @@
[...]
> -test_description='properly cull all ancestors'
> +test_description='ancestor culling and limitting by parent number'

sp: limiting

Thanks for updating the description.  It's easy to forget.

> @@ -28,4 +28,72 @@ test_expect_success 'one is ancestor of others and should not be shown' '
[...]
> +check_revlist () {
> +	> expect &&
> +	for c in $2; do echo "$c" >> expect; done &&
> +	git rev-list $1 master | git name-rev --name-only --tags --stdin >actual &&
> +	test_cmp expect actual
> +}

Pedantic nits:

 * if global functions are defined before all test_expect_success stanzas,
    (1) it is easier to reuse them in tests throughout the script;
    (2) it is easy to see at a glance what primitives a test script
        will be using when getting acquainted with it and what
        syntax might be worth lifting to test-lib or other test
        scripts when shopping for that
 * style: no space between >redirection operators and their argument
   for consistency (maybe because > &2 is a syntax error)
 * might be simpler to pass one rev per argument.  Like so:

	rev_list_args=$1 &&
	shift &&
	printf '%s\n' "$@" >expect &&
	git rev-list $rev_list_args master ...

   Avoiding the for loop means errors from 'echo' before the last
   iteration are not ignored; a more verbose way to write the same
   thing is

	for commit
	do
		printf '%s\n' "$commit" ||
		return
	done >expect &&
	git rev-list ...
 * this does not catch errors from rev-list!  how about

	git rev-list $rev_list_args master >rev-list &&
	git name-rev ... <rev-list >actual &&
	test_cmp expect actual

   Junio will probably complain that this is not meant to be a test
   for name-rev; indeed, filling "expect" by computing commit names
   might be even better (because faster).

> +test_expect_success 'rev-list roots' '
> +test_expect_success 'rev-list no merges' '
> +test_expect_success 'rev-list no octopusses' '
> +test_expect_success 'rev-list no roots' '
> +test_expect_success 'rev-list merges' '

Neat. :)


> +test_expect_success 'rev-list octopus' '
> +
> +	check_revlist "--min-parents=3" "octopus"
> +'

Might make sense to check a dodecapus (with --min-parents=3 still) as
well.

> +test_expect_success 'rev-list override and infinities' '

Ah, here's the test I suggested in reply to patch 1.  But this is not
about overriding but the lack thereof, no?  So I'd be happier reading
something like

	test_expect_success '--no-merges --merges yields the empty set' '
		check_revlist "--no-merges --merges" &&
		check_revlist "--min-parents=2 --no-merges"
	'

	test_expect_success 'last --max-parents wins' '
		check_revlist "--min-parents=2 --no-merges --max-parents=3" octopus normalmerge &&
		check_revlist "--min-parents=2 --max-parents=3 --no-merges" ...
	'

	test_expect_success '--max-parents=infinity' '
		...
	'

	test_expect_success '--min-parents=infinity' '
		...
	'

	test_expect_failure '--max-parents=gobbledegood errors out' '
		...
	'

Thanks for your attention to detail, and hope that helps.

Ciao,
Jonathan
