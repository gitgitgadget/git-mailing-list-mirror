From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Tue, 23 Dec 2014 10:26:48 -0800
Message-ID: <xmqqk31i2pef.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
	<xmqqd27b6zd3.fsf@gitster.dls.corp.google.com>
	<xmqq8uhz6za0.fsf@gitster.dls.corp.google.com>
	<20141222233807.GU29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>, dturner@twopensource.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:27:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UAo-0003Ni-OB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbaLWS1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:27:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750725AbaLWS06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:26:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6247D28A39;
	Tue, 23 Dec 2014 13:26:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peIgOfFS74KoC+v8/53GtIQbgkw=; b=BHv9sB
	5YWesox4cNkKOW/NlNwvPGVYz7wnBni7duoP7G39HPzCqIjH2r2ovohc5LDRRwnw
	5pnml9K7OaC/xcJlSPVSVaNfYMY7kvmB3oenLtCoCiiyWmeqo/frkTATNS502b9G
	+spzJMIeYKXw+yx4emwguZLT4fjM9VCEnLlRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nca/GRld7XntVazaJPuHKIuKh4836nel
	ICTNpD5B/WDa+Jvx4Q3faYVC0mnHtvj2Rmc7hWJ0xl7rgST4RUfkhB/oPTAveBAW
	yf3cgtdq/E2Y8dH5RiIUTHsAnw5/WjXztC8rsWt08wGuZU4jMf7BG7fXVIJwPyaJ
	I/hPErqi9q8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5938928A37;
	Tue, 23 Dec 2014 13:26:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C48E628A36;
	Tue, 23 Dec 2014 13:26:49 -0500 (EST)
In-Reply-To: <20141222233807.GU29365@google.com> (Jonathan Nieder's message of
	"Mon, 22 Dec 2014 15:38:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 429A4D52-8AD1-11E4-9E7D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261759>

Jonathan Nieder <jrnieder@gmail.com> writes:

> With the updated subject,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Here is what I tentatively queued for today's pushout.

-- >8 --
From: Ben Walton <bdwalton@gmail.com>
Date: Mon, 22 Dec 2014 15:25:44 -0800
Subject: [PATCH] t0090: tweak awk statement for Solaris /usr/xpg4/bin/awk

The awk statements previously used in this test weren't compatible
with the native versions of awk on Solaris:

    echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
    awk: syntax error near line 1
    awk: bailing out near line 1

    echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
    0

Even though we do not cater to tools in /usr/bin on Solaris that are
overridden by corresponding ones in /usr/xpg?/bin, in this case,
even the XPG version does not work correctly.

With GNU awk for comparison:

    echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
    1

which is what this test expects (and is in line with POSIX; non-empty
string is true and an empty string is false).

Work this issue around by using $1 != "" to state more explicitly
that we are skipping empty lines.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bdwalton@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
-- 
2.2.1-321-gd161b79
