From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon,  4 Apr 2016 17:58:37 -0700
Message-ID: <1459817917-32078-5-git-send-email-gitster@pobox.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 02:58:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFKZ-0002QT-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbcDEA6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 20:58:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbcDEA6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 20:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3179753091;
	Mon,  4 Apr 2016 20:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YpzQ
	SYhW3012MPElTM55F3FKdi0=; b=qDdBnp5QKHDJY549gqZIYv6H0b7KdtVShsHl
	SZXk4yW1cOuNwO6TnyiAoUL5dc+cOvBdUgSL0Gn+mP0io0ZOGnMoAlZEn04vIMwf
	/rZ+GRGrgzNEBmL69Wkrk1x5W2LjPAWIk+S0jCVIHunXyjhKx0SVIJBnUqBW9o/s
	FFkln0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ERGE1+jsWc761YNct4M8WBMBc1QXVzpn+mMvQ738stzS50rrlaUfZE9sDj+gAVRX
	LNm40AShkKOxU9NJtiA0/5cBOWkb/zfIdKDyzl8GJJIDgKaBsl/3+HioYKAD0r/J
	hlJfKzGZRyoxzAJ/+7g2ab/L5UbiGfzBqYvasEuwrh0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 291F453090;
	Mon,  4 Apr 2016 20:58:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A3BE5308E;
	Mon,  4 Apr 2016 20:58:45 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-251-g9997610
In-Reply-To: <1459817917-32078-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8C740B20-FAC9-11E5-B0D7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290743>

The test prepares a simple commit with HT on its log message lines,
and makes sure that

 - formats that should or should not expand tabs by default do or do
   not expand tabs respectively,

 - with explicit --expand-tabs=<N> and short-hands --expand-tabs
   (equivalent to --expand-tabs=8) and --no-expand-tabs (equivalent
   to --expand-tabs=0) before or after the explicit --pretty=$fmt,
   the tabs are expanded (or not expanded) accordingly.

The tests use the second line of the log message for formats other
than --pretty=short, primarily because the first line of the email
format is handled specially to add the [PATCH] prefix, etc. in a
separate codepath (--pretty=short uses the first line because there
is no other line to test).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4213-log-tabexpand.sh | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100755 t/t4213-log-tabexpand.sh

diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
new file mode 100755
index 0000000..74ca03a
--- /dev/null
+++ b/t/t4213-log-tabexpand.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='log/show --expand-tabs'
+
+. ./test-lib.sh
+
+HT="	"
+title='tab indent at the beginning of the title line'
+body='tab indent on a line in the body'
+
+count_expand ()
+{
+	case " $* " in
+	*' --pretty=short '*)
+		line=$title ;;
+	*)
+		line=$body ;;
+	esac
+	expect=
+	count=$(( $1 + $2 )) ;# expected spaces
+	while test $count -gt 0
+	do
+		expect="$expect "
+		count=$(( $count - 1 ))
+	done
+	shift 2
+	count=$1 ;# expected tabs
+	while test $count -gt 0
+	do
+		expect="$expect$HT"
+		count=$(( $count - 1 ))
+	done
+	shift
+	{
+		echo "git show -s $*"
+		echo "$expect$line"
+	} | sed -e 's/ /./g' >expect
+
+	{
+		echo "git show -s $*"
+		git show -s "$@" |
+		sed -n -e "/$line\$/p"
+	} | sed -e 's/ /./g' >actual
+
+	test_cmp expect actual
+}
+
+test_expand ()
+{
+	fmt=$1
+	case "$fmt" in
+	*=raw | *=short | *=email)
+		default="0 1" ;;
+	*)
+		default="8 0" ;;
+	esac
+	case "$fmt" in
+	*=email)
+		in=0 ;;
+	*)
+		in=4 ;;
+	esac
+	test_expect_success "expand/no-expand${fmt:+ for $fmt}" '
+		count_expand $in $default $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs &&
+		count_expand $in 8 0 --expand-tabs $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs=8 &&
+		count_expand $in 8 0 --expand-tabs=8 $fmt &&
+		count_expand $in 0 1 $fmt --no-expand-tabs &&
+		count_expand $in 0 1 --no-expand-tabs $fmt &&
+		count_expand $in 0 1 $fmt --expand-tabs=0 &&
+		count_expand $in 0 1 --expand-tabs=0 $fmt &&
+		count_expand $in 4 0 $fmt --expand-tabs=4 &&
+		count_expand $in 4 0 --expand-tabs=4 $fmt
+	'
+}
+
+test_expect_success 'setup' '
+	test_tick &&
+	sed -e "s/Q/$HT/g" <<-EOF >msg &&
+	Q$title
+
+	Q$body
+	EOF
+	git commit --allow-empty -F msg
+'
+
+test_expand ""
+test_expand --pretty
+test_expand --pretty=short
+test_expand --pretty=medium
+test_expand --pretty=full
+test_expand --pretty=fuller
+test_expand --pretty=fuller
+test_expand --pretty=raw
+test_expand --pretty=email
+
+test_done
-- 
2.8.1-251-g9997610
