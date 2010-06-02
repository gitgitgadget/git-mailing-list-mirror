From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] t9129: fix UTF-8 locale detection
Date: Wed, 02 Jun 2010 12:14:32 -0700
Message-ID: <7vmxvdckmf.fsf_-_@alter.siamese.dyndns.org>
References: <1274202486.4228.22.camel@localhost>
 <1274203013-1349-1-git-send-email-yann@droneaud.fr>
 <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <yann@droneaud.fr>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 21:15:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJtPT-0006CK-HI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 21:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975Ab0FBTOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 15:14:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969Ab0FBTOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 15:14:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F16ABB708D;
	Wed,  2 Jun 2010 15:14:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O61NyiVb50VIH+ZHTCicIzCL0JA=; b=ron3Ip
	oD1y+AoJH2rAPBzLF0IA8rAZzOicQWH4wzfrlggxHYy5968UN9DMC83yOTzrvrkG
	iYDtwvtYUVLDk8dEOsnWqFteUs95f6eJ5A+c0OQvroQPgVT8dO/Vssw/oY7+RJJ8
	2TI64nFkPbEk++PC1UaL4AAaO/Aajsnyfdewk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xfCar28NQ1wbVdkNokhV55g7o2awFicf
	RF6XNDDb3IjimAlDgK0lp7d4XZKut9LjsVvcUsN5/yc0A21ipqWWpSIHu2q/MbX1
	1mY/q2sT22rLKXwqEpIuE0+5db2a7+rue5xX4yJWUXEuhldq+9YjWA2AUSKsdUvp
	Nvx+FEKbIpo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97174B7089;
	Wed,  2 Jun 2010 15:14:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66326B7087; Wed,  2 Jun
 2010 15:14:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1005181037250.4195@i5.linux-foundation.org>
 (Linus Torvalds's message of "Tue\, 18 May 2010 10\:45\:26 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1753EED6-6E7B-11DF-9E73-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148270>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Wouldn't it be easier to just make it ignore case, and do
>
> 	grep -qi '^en_US\.utf-?8$'
>
> instead?
>
> I'm also not entirely sure you want to make that pattern stricter - the 
> whole problem with the old pattern was that it was too exact, so why add 
> the beginning/end requirement?

Sorry for being late to the party...

The prerequisite test is supposed to protect a real test that does this:

	LC_ALL=en_US.UTF-8 svn log `git svn info --url` | perl -w -e '...'

and the original patch at least matches what we check with what we
actually ask for from the system.

I don't know if the above "svn log" test would still work if we run it
under any locale with UTF-8 (I checked with ja_JP.UTF-8 and it seems to be
Ok), but if it does, then a patch like this might be a better alternative.

 t/t9129-git-svn-i18n-commitencoding.sh |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index b9224bd..1e9a2eb 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -14,10 +14,22 @@ compare_git_head_with () {
 	test_cmp current "$1"
 }
 
+a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
+	p
+	q
+}')
+
+if test -n "$a_utf8_locale"
+then
+	test_set_prereq UTF8
+else
+	say "UTF-8 locale not available, some tests are skipped"
+fi
+
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL=en_US.UTF-8 svn log `git svn info --url` | perl -w -e '
+	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | perl -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
@@ -69,12 +81,6 @@ do
 	'
 done
 
-if locale -a |grep -q en_US.utf8; then
-	test_set_prereq UTF8
-else
-	say "UTF-8 locale not available, test skipped"
-fi
-
 test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
 	(
 		cd ISO8859-1 &&
