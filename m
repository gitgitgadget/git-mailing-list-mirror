From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Sun, 08 May 2011 21:40:10 -0700
Message-ID: <7voc3cqyfp.fsf@alter.siamese.dyndns.org>
References: <20110505191027.GA3242@camk.edu.pl>
 <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
 <4DC3A685.4080300@drmicha.warpmail.net> <4DC3CBEF.6080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 09 06:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJIGl-0005iO-MY
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 06:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab1EIEk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 00:40:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1EIEk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 00:40:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 526465BE4;
	Mon,  9 May 2011 00:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wHHsLb1ki+YSPE+3+T+nOIBZY4M=; b=dM25UZ
	cCMvSTBP75Rv/aSFcZ4A9S8E41tVd2NAYKxszggcdYbXieL+N87xHAb9gJj0Z/Ro
	vg+k94sHLm8KOfAunf0hSpzZJuM4whnfVwnqU6rC63UNAdQRGPkzPbdM0czitTVy
	79ldihTGfXe/Y6tbpA87GElZnV8GY4KZWas9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGJ/QXNmqY/2o19YZehXBQKDbmgEZXH9
	Q0BuYJY9GYMjNVYItFgBx9zKLSjpEUHcSQ9g6AHP4NoHqZEvHAtoPnp6y8F6ZKI9
	VkyQ6fXzk7Op/a6xNjYe8JppPfKneZCaDda6dIEqRh2xdSzqcDePD8+8A+gd7AM+
	TckeB19r1rU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1127D5BE3;
	Mon,  9 May 2011 00:42:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA1EF5BE2; Mon,  9 May 2011
 00:42:18 -0400 (EDT)
In-Reply-To: <4DC3CBEF.6080303@viscovery.net> (Johannes Sixt's message of
 "Fri, 06 May 2011 12:22:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBBF57DA-79F6-11E0-8413-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173193>

Johannes Sixt <j.sixt@viscovery.net> writes:

> - The behavior of quoting at the right of :- when the ${...:-...} exansion
> appears in double-quotes was debated recently at length at the Austin
> group (which revises the POSIX standard). You better move the expansions
> to assignments of temporary variables,...

What alternative semantics do Austin folks have in mind, by the way?  Just
declare this undefined?

Anyway, let's do this as a future-proofing.  How does this look?

-- >8 --
Subject: t1507: avoid "${parameter<op>'word'}" inside double-quotes

Kacper Kornet noticed that a $variable in "word" in the above construct is
not substituted by his pdksh.  Modern POSIX compliant shells (e.g. dash,
ksh, bash) all seem to interpret POSIX "2.6.2 Parameter Expansion" that
says "word shall be subjected to tilde expansion, parameter expansion,
command substitution, and arithmetic expansion" in ${parameter<op>word},
to mean that the word is expanded as if it appeared in dq pairs, so if the
word were "'$variable'" (sans dq) it would expand to a single quote, the
value of the $variable and then a single quote.

Johannes Sixt reports that the behavior of quoting at the right of :- when
the ${...:-...} expansion appears in double-quotes was debated recently at
length at the Austin group.  We can avoid this issue and future-proof the
test by a slight rewrite.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1506-rev-parse-diagnosis.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 58575d6..a1081a8 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -8,8 +8,11 @@ exec </dev/null
 
 test_did_you_mean ()
 {
-	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
-	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
+	sq="'"
+	cat >expected <<-EOF &&
+	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
+	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
+	EOF
 	test_cmp expected error
 }
 
