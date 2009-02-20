From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] Test fsck a bit harder
Date: Fri, 20 Feb 2009 21:29:51 +0100
Message-ID: <499F12BF.4080405@kdbg.org>
References: <0599d1b4fe0f243b3d86d9afd9c67858861838aa.1235041345.git.trast@student.ethz.ch> <effac809336c1e05613eed315483ec32f3a4c75b.1235158438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lac23-0003Yb-1p
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZBTUaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZBTUaE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:30:04 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:38573 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbZBTUaD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 15:30:03 -0500
Received: from [77.117.112.193] (77.117.112.193.wireless.dyn.drei.com [77.117.112.193])
	by bsmtp.bon.at (Postfix) with ESMTP id C57AB10018;
	Fri, 20 Feb 2009 21:29:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <effac809336c1e05613eed315483ec32f3a4c75b.1235158438.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110886>

Thomas Rast schrieb:
> +test_expect_success 'object with bad sha1' '
> +	sha=$(echo blob | git hash-object -w --stdin) &&
> +	echo $sha &&
> +	old=$(echo $sha | sed "s+^..+&/+") &&
> +	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&

	new=${old%/*}/ffffffffffffffffffffffffffffffffffffff &&

> +	sha="$(dirname $new)$(basename $new)"

	sha=${new%/*}${new##*/} &&

note the '&&'!

> +	mv .git/objects/$old .git/objects/$new &&
> +	git update-index --add --cacheinfo 100644 $sha foo &&
> +	tree=$(git write-tree) &&
> +	cmt=$(echo bogus | git commit-tree $tree) &&
> +	git update-ref refs/heads/bogus $cmt &&
> +	(git fsck 2>out; true) &&

Any particular reason not to use

	test_must_fail git fsck 2>out &&

here?

> +	grep "$sha.*corrupt" out &&
> +	rm -f .git/objects/$new &&
> +	git update-ref -d refs/heads/bogus &&
> +	git read-tree -u --reset HEAD
> +'

Shouldn't the cleanup be outside the test_expect_success so that later 
tests work even if this one fails? (Ditto for subsequent tests.)

> +test_expect_success 'tag pointing to nonexistent' '
> +	tag=$(git hash-object -t tag -w --stdin < invalid-tag) &&
> +	echo $tag > .git/refs/tags/invalid &&
> +	git fsck 2>&1 | tee out &&

	test_must_fail git fsck > out 2>&1 &&

> +	grep "missing commit ffffffffffffffffffffffffffffffffffffffff" out &&
...
> +test_expect_success 'tag pointing to something else than its type' '
> +	tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
> +	echo $tag > .git/refs/tags/wrong &&
> +	git fsck 2>&1 | tee out &&

	test_must_fail git fsck > out 2>&1 &&

> +	grep "Object.*is a blob, not a commit" out &&
...

-- Hannes
