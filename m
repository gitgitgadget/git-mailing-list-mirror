From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Thu, 29 Jan 2009 09:19:28 -0800
Message-ID: <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSaZa-0004K1-8W
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 18:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbZA2RTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 12:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZA2RTg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 12:19:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbZA2RTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 12:19:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2697E2A068;
	Thu, 29 Jan 2009 12:19:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3ECC32A067; Thu,
 29 Jan 2009 12:19:30 -0500 (EST)
In-Reply-To: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
 (Brian Gernhardt's message of "Thu, 29 Jan 2009 11:00:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF5E543E-EE28-11DD-B95C-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107704>

Brian Gernhardt <benji@silverinsanity.com> writes:

> The call to "git reset --hard B1" failed on case-insensitive file
> systems (such as the default settings for HFS+) because there was both
> a tag "B1" and a file "b1".  Adding "--" to the command makes it
> clear that we mean commit B1.
>
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> ---
>  t/t3411-rebase-preserve-around-merges.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
> index 6533505..e544451 100755
> --- a/t/t3411-rebase-preserve-around-merges.sh
> +++ b/t/t3411-rebase-preserve-around-merges.sh
> @@ -24,7 +24,7 @@ test_expect_success 'setup' '
>  	test_commit A1 &&
>  	test_commit B1 &&
>  	test_commit C1 &&
> -	git reset --hard B1 &&
> +	git reset --hard B1 -- &&
>  	test_commit D1 &&
>  	test_merge E1 C1 &&
>  	test_commit F1

It is not just B1 that is ambiguous, even though that is the only
ambiguous one this particular test uses.

If we really wanted to care about case-folding file systems, shouldn't we
make test_commit shell function a bit more than the downcasing?  How about
this patch instead?

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index c1839f7..8066c25 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -201,7 +201,7 @@ test_tick () {
 # Both <file> and <contents> default to <message>.
 
 test_commit () {
-	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
+	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}
 	echo "${3-$1}" > "$file" &&
 	git add "$file" &&
 	test_tick &&
