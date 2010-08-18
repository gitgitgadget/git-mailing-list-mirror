From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: should git rev-parse exit with non-zero status if ref@{n}
 is not valid?
Date: Wed, 18 Aug 2010 13:50:18 -0700
Message-ID: <7vsk2b8x2t.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 22:50:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olpap-0000yg-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 22:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0HRUub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 16:50:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab0HRUu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 16:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5719ECECC4;
	Wed, 18 Aug 2010 16:50:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dfCXT/HFt+N5qTt1TtKIe2MjIUs=; b=RUQv/G
	ED8adZVDjp7H0uaL2WL4UhXalY1DdVE5+8ztoY2/y/td8DR4D/NKVYkKJ4bCLFKO
	lL6s9ntrPlL7hiLImM5t7p2UgOxJ4AMFFc2ujohLCSSHt8c5rkAq5UDx12r8eeXr
	roffi8ScfeX/vUb3jGGoI/v63/rNpe1aivfcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lGm9K85KTKSNe2F92e/C0MvjXH6uzT1Q
	EryRTIMclcpSeR/80WDvQojbZkpl3VrjENTZaq+pRt81y22rDzqiL1ISC49FNPP+
	p2K6SYHeKldFaeejqPIKDL42+nnpGXQtQ010xBtqCpLui/EvtzJDz47ZwW0GR++d
	1QJYDC+PPJs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32A02CECBC;
	Wed, 18 Aug 2010 16:50:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D998CECAF; Wed, 18 Aug
 2010 16:50:22 -0400 (EDT)
In-Reply-To: <AANLkTi=Ktz=ARx0qUqB0844aYuq8BbqYUM8g726r9o5t@mail.gmail.com>
 (Jon Seymour's message of "Wed\, 18 Aug 2010 21\:36\:11 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39C5EF70-AB0A-11DF-8AF8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153884>

Jon Seymour <jon.seymour@gmail.com> writes:

> I understand why ref@{time-spec} might behave this way, but I reckon
> that if you ask for ref@{n} for n > N-1, where N is the length of the
> reflog, then you should either get empty output and a non-zero status
> (preferred) or a ref@{N-1} on the output with a status code of zero
> and a warning message (less optimal, IMHO).

Yeah, the behaviour of ref@{...} syntax parser is way suboptimal:

    $ git rev-parse --verify jch@{99999}; echo $?
    warning: Log for 'jch' only has 1368 entries.
    cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
    0

It even knows that it is running off the cut-off point; it should just
cause the caller to notice that fact.  I don't think changing it to error
out should cause any harm to existing callers.

It may just be the matter of doing something like this (totally
untested)...

 sha1_name.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4af94fa..c1e51c9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
+	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.\n";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
@@ -390,7 +390,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		return -1;
 
 	if (warn_ambiguous_refs && refs_found > 1)
-		fprintf(stderr, warning, len, str);
+		fprintf(stderr, warn_msg, len, str);
 
 	if (reflog_len) {
 		int nth, i;
@@ -426,14 +426,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
-				fprintf(stderr,
-					"warning: Log for '%.*s' only goes "
+				warning("Log for '%.*s' only goes "
 					"back to %s.\n", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
 			else
-				fprintf(stderr,
-					"warning: Log for '%.*s' only has "
-					"%d entries.\n", len, str, co_cnt);
+				return error("Log for '%.*s' only has "
+					     "%d entries.\n", len, str, co_cnt);
 		}
 	}
 
