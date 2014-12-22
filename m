From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 15:25:44 -0800
Message-ID: <xmqqd27b6zd3.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CMJ-0007kx-B3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbaLVXZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:25:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754049AbaLVXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:25:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FFD22981B;
	Mon, 22 Dec 2014 18:25:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t3/TmzYzUhqYYDCKfVrH8v/1vUw=; b=ltVr6J
	5qG19f/SJz/oIW8YmuasdWQ3kJIsmd/y6QPt/EnC1J5khl2eC1wWsG6qIZL6Pusj
	qthve0j7cdBxM5Yu6GB20p2haykd4JxOO7fDc1XO+DCcwYVI9yCJaM4FxXsdPnIi
	DNbfzqePNKPE11hCyRaiReWeyBNdDmJBSH8KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lI0HtTiw11GubDpLfozoF+btGhp2iYEe
	dMiglXrsy1tLgRr+aAE4J/RUWY57HpB25saJ/BqBM/nFVTk2ACXtSB8OTa4pZA+p
	rWeO8tuWvPpeQHm/gaz0FXVlTFRG8cdsA/XoRx0asW9Ml/gRaqZfOzT0d+l0yELf
	b6+W3P05uu8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 873C529818;
	Mon, 22 Dec 2014 18:25:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F42529817;
	Mon, 22 Dec 2014 18:25:46 -0500 (EST)
In-Reply-To: <1419270744-1408-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Mon, 22 Dec 2014 17:52:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB11F6E8-8A31-11E4-92BB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261699>

From: Ben Walton <bdwalton@gmail.com>

The awk statements previously used in this test weren't compatible
with the native versions of awk on Solaris:

    echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
    awk: syntax error near line 1
    awk: bailing out near line 1

    echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
    0

And with GNU awk for comparison:

    echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
    1

Work it around by using $1 != "" to state more explicitly that we
are skipping empty lines.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bdwalton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Then let's queue this, perhaps?

 t/t0090-cache-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 067f4c6..601d02d 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
-	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 {++c} END {print c}') &&
+	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
 	entries=$(git ls-files|wc -l) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
