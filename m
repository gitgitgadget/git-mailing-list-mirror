From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: add --directory=<dir> option
Date: Wed, 14 Jan 2009 16:21:38 -0800
Message-ID: <7vzlhtxvu5.fsf@gitster.siamese.dyndns.org>
References: <7vbpudjanf.fsf@gitster.siamese.dyndns.org>
 <20090114234602.GD32313@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Kevin Ballard <kevin@sb.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:23:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNG0v-0001Zt-An
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761607AbZAOAVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761475AbZAOAVt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:21:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761402AbZAOAVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:21:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5CAD9075F;
	Wed, 14 Jan 2009 19:21:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7686A9075E; Wed,
 14 Jan 2009 19:21:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7DEF68F0-E29A-11DD-B551-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105737>

Stephan Beyer <s-beyer@gmx.net> writes:

> Do I have a thinko or should it be this:
>
> +		sed -e 's/'\''/'\''\\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
> 		                   ^^
> 			(added for escaping ' outside single quotes)

Almost.

Certainly my original was bad; shell unquotes to "s/'/'\''/g", but that
backslash is not protected from further interpretation by sed, which
happily turns backslash-single quote into a single quote, which I forgot.

You feed "s/'/'\\\''/g" which correctly protects one backslash from sed by
doubling it, but it has one unnecessary extra backslash.  The extra one
does not hurt because the backslash + single quote is eaten by sed to
produce a single quote, but it is not quite right.

We should be feeding sed with "s/'/'\\''/g", so you need to add one
backslash to mine.

> Have you forgotten to add the files prefixed with "am-test-5-" or is this
> patch based on another one?

The one I actually queued is b47dfe9 (git-am: add --directory=<dir>
option, 2009-01-11) and it does include these test vectors.  My bad.

This patch is relative to b47dfe9.

-- >8 --
Fix git-am shell quoting

Noticed by Stephan Beyer; the new test is mine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh             |    2 +-
 t/t4252-am-options.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git c/git-am.sh w/git-am.sh
index 7e6329b..4beb12d 100755
--- c/git-am.sh
+++ w/git-am.sh
@@ -38,7 +38,7 @@ sq () {
 	for sqarg
 	do
 		printf "%s" "$sqarg" |
-		sed -e 's/'\''/'\''\'\'''\''/g' -e 's/.*/ '\''&'\''/'
+		sed -e 's/'\''/'\''\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
 	done
 }
 
diff --git c/t/t4252-am-options.sh w/t/t4252-am-options.sh
index e91a6da..5fdd188 100755
--- c/t/t4252-am-options.sh
+++ w/t/t4252-am-options.sh
@@ -58,4 +58,12 @@ test_expect_success 'interrupted am --directory="frotz nitfol"' '
 	grep One "frotz nitfol/file-5"
 '
 
+test_expect_success 'apply to a funny path' '
+	with_sq="with'\''sq"
+	rm -fr .git/rebase-apply &&
+	git reset --hard initial &&
+	git am --directory="$with_sq" "$tm"/am-test-5-2 &&
+	test -f "$with_sq/file-5"
+'
+
 test_done
