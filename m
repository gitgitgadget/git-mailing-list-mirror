From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 14:37:05 -0800
Message-ID: <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Namhyung Kim <namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 23:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoU6-00012r-75
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab1CJWhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:37:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1CJWhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:37:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7F914ED1;
	Thu, 10 Mar 2011 17:38:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n8ubaoGzrG945aEpyKyVQAQwZSY=; b=ZRv3s2
	XPaV881teIb8iso8wEaKBGhfoxzSW7dGPeXEE4tyDgv5zh0Ea/wXBbjAuYlm6ccW
	C/7MPHr0j7emxafKP9uSasdLlM9PdEMrQqkZ76zTFf68dtF5Q39foSEiBS8RQUj0
	YgUjnsZt6wO1kUALN9VoczObyGpFFCr5j6jYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c25NlkDCLtV6dmrROEkRHAE8Ff4PJ/9o
	KS9nCakSXSi3GJcaJiArcTB4J/41yt7prqhYHJK857uqn6I12O2apORBW9ZZ4NQY
	gOXumpqu3xPw3jG7h/5JuhPtU4GT18ocDk7ajji/H2D2+jIqNPrxfuPcedjkpvkx
	gc4Kc6/3R1I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 869FB4ED0;
	Thu, 10 Mar 2011 17:38:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F7204ECE; Thu, 10 Mar 2011
 17:38:36 -0500 (EST)
In-Reply-To: <7veiba9ev2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Oct 2010 14:39:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2623320E-4B67-11E0-A2BD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168859>

The caller of this function wants to ensure that the returned string is a
unique abbreviation of the object name, and at least "len" characters
long.  When "len" is too short to ensure uniqueness with only that many
characters, it returns minimally unique prefix (i.e. if you dropped the
last character, there would be two or more objects that share that same
prefix as their names in the repository).

An earlier change introduced core.abbrevguard configuration with a
realization that a short prefix that is unique today may not stay unique
forever, as new objects are added to the repository. When "len" is shorter
than the length necessary to ensure uniqueness today, instead of returning
a string that is only one character longer than the longest ambiguous
prefix, we want to add that many extra characters (in addition to the "one
character that is absolutely needed to make it unique today") to ensure
uniqueness for longer time.

The code however forgot that the function may be called with a "len" that
is long enough.  If an object is uniquely identifiable with only 4 leading
characters today, and if the caller gives 7 as len and the guard is set to
3, it returned 10 hexdigits, which was 3 characters longer than necessary.
We should instead return 7 leading characters in such a case, as that is
in line with the original intention of using 3 characters more than
absolutely necessary to give the disambiguation we find today a better
chance to survive.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A three-line patch, with 35 new comment lines and four paragraph commit
   log message, to fix a stupid thinko that I noticed during a separate
   discussion with Namhyung-ssi, who wanted to add an option to ensure
   uniqueness of the truncated commit name in the human-readable blame
   output.

 sha1_name.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4a226ad..62950aa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -191,6 +191,26 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
+/*
+ * The caller wants a unique abbreviation of the full object name in
+ * "sha1" that is at least "len" characters long.  A string is a unique
+ * abbrevation of the full object name when:
+ *
+ * (1) there is no other object that shares the returned string as the
+ *     prefix of its name, if sha1 identifies an existing object; or
+ *
+ * (2) there is no object that has the returned string as the prefix
+ *     of its name, if sha1 does not identify any existing object.
+ *
+ * If there exist two or more objects that share the same N characters
+ * at the beginning of their object names, N+1 leading characters is
+ * sufficient to make the abbreviation unique today.  As the number of
+ * objects in the repository grows, however, such an abbreviation
+ * won't stay unique forever.  core.abbrevguard configuration variable
+ * can be used to add extra G characters when ensuring the uniqueness
+ * of the abbreviation, i.e. making N+1+G characters the minimum in
+ * order to keep the result unique a bit longer, instead of just N+1.
+ */
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	int status, exists;
@@ -200,6 +220,24 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
+	/*
+	 * Try to see how short a prefix we can feed to get a unique
+	 * hit.  When len is sufficiently long, we may find the
+	 * absolute minimum abbreviation that is a lot shorter than
+	 * len, so we try from (len - unique_abbrev_extra_length), to
+	 * avoid the final addition of u_a_e_l to the result getting
+	 * longer than necessary.  E.g. an object that is ambiguous
+	 * today with only 3 but is unique with 4 leading characters,
+	 * it should yield 7 character result if the caller called us
+	 * with len=7 with u_a_e_l=3 (or shorter), so we start from 4
+	 * in such a case.  When len is shorter than the minimum
+	 * required to make the result unique, the loop counts up and
+	 * finds the absolute minimum (just one character longer than
+	 * ambiguous truncation) and then we add u_a_e_l to it.
+	 */
+	len -= unique_abbrev_extra_length;
+	if (len <= 0)
+		len = 1;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-- 
1.7.4.1.373.g37629
