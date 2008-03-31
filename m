From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: Fix renaming a directory in the
 tree-filter
Date: Mon, 31 Mar 2008 01:40:09 -0700
Message-ID: <7v3aq7mgly.fsf@gitster.siamese.dyndns.org>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca>
 <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at>
 <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-Fran=C3=A7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>, Git <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Mar 31 10:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgFa8-0002ze-QK
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 10:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbYCaIkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 04:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbYCaIkS
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 04:40:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbYCaIkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 04:40:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A720F24CD;
	Mon, 31 Mar 2008 04:40:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E169824CC; Mon, 31 Mar 2008 04:40:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78570>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> 2. Then filter-branch checks out the files for the next commit. This
>    leaves the new directory behind because there is no real "branch
>    switching" involved that would notice that the directory can be
>    removed.

Thanks.

It obviously is a correct fix to use "clean -d" here, but I strongly
suspect this awkwardness comes from the fact that there is no clear
invariant in this loop.

For example, if you make it the invariant that $T contains the tree that
matches the contents of the "$tempdir/t" work tree left in the previous
round of filter-tree (and obviously you would want to do this only
filter_tree is in effect), the "checkout-index + clean" would become a
proper "branch switching".

This is obviously untested, and you would need to prime $T with an empty
tree before entering the loop (but you could cheat by initializing T with
an empty string), but it might make the code a bit more readable than the
current mess.  I dunno.

	if [ "$filter_tree" ]; then
-		git checkout-index -f -u -a ||
-			die "Could not checkout the index"
-		# files that $commit removed are now still in the working tree;
-		# remove them, else they would be added again
-		git clean -d -q -f -x
+		git read-tree -m -u $T $commit
		eval "$filter_tree" < /dev/null ||
			die "tree filter failed: $filter_tree"

-		(
-			git diff-index -r --name-only $commit
-			git ls-files --others
-		) |
-		git update-index --add --replace --remove --stdin
+		git add -u && git add . && T=$(git write-tree)
	fi
