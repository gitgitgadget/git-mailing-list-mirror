From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Thu, 10 Mar 2011 01:19:56 -0800
Message-ID: <7vlj0n5o3n.fsf_-_@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
 <7vbp1kayoe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxc2g-00086o-7O
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab1CJJUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 04:20:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab1CJJUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 04:20:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37DE230D1;
	Thu, 10 Mar 2011 04:21:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JkLkQYZpz1YeW3AmtAqRIq6AJns=; b=Yasa9+
	HfUQ1xYSS5oj/erf6mrMhJi+j/dMS2L9eAkt0M5N6LVeQPrljAYYVIawDx0Eq+hj
	WbZZe8lquN6qhl7vTodaKCmzN1Ne8dyLCtNAir/wo6jdedGYpx0rzw9sgAu9flvl
	u1wbB+0jrMfvxhFAJpeUzgD8OQsy4uuIVSPs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ALxOWzJiL3h9XC0OxjETNpwSVE65ojzF
	CejACXQA0lKs40caLSytAZiG3j19uXsFeZAW8TQiBrg3wphtR/2vXGmYZ8AiYNEd
	cbR2KJlcIrlUzTh3X6e6rv1EKjuoCi0iFgcLCo7yzGA5AC0TYNWMaf3Fumx7sV4s
	81n7P5i86Vo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4959F30CE;
	Thu, 10 Mar 2011 04:21:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C99630CA; Thu, 10 Mar 2011
 04:21:26 -0500 (EST)
In-Reply-To: <7vbp1kayoe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Mar 2011 11:20:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C87DDB00-4AF7-11E0-B81F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168799>

Junio C Hamano <gitster@pobox.com> writes:

> I think what may be desirable is to honor the caller-supplied "len" a bit
> better.  If an object is uniquely identifiable with only 4-hexdigit today,
> and if the caller gives 7 as len and the guard is set to 3, we return 10
> hexdigits with the current code.  We should instead return 7 hexdigits in
> such a case, as that is in line with the "use 3 extra to give the
> disambiguation we find today a better chance to survive".

And here is an attempt to do so.  I have to admit that I didn't give it
too much thought, though, so please be careful when reviewing the logic.

-- >8 --
Subject: find_unique_abbrev(): honor caller-supplied "len" better

The caller of this function wants to ensure that the returned string is a
unique abbreviation of the object name, and at least len characters long.
When "len" is sufficiently short and we cannot ensure uniqueness with only
"len" bytes, we returned minimally unique prefix (i.e. if you dropped the
last character, there would be two or more objects that share that same
prefix as their names in the repository).

An earlier change introduced core.abbrevguard configuration with a
realization that a short prefix that is unique today may not stay unique
forever, as new objects are added to the repository. When "len" is shorter
than the length necessary to ensure uniqueness today, instead of returning
a string that is only one character longer than the longest ambiguous
prefix, we wanted to add that many extra characters to ensure uniqueness
for longer time.

However, the code forgot that "len" may be sufficiently long.  If an
object is uniquely identifiable with only 4-hexdigit today, and if the
caller gives 7 as len and the guard is set to 3, we returned 10 hexdigits,
which was 3 characters longer than necessary.  We should instead return 7
hexdigits in such a case, as that is in line with the original intention
of using 3 extra hexdigits to give the disambiguation we find today a
better chance to survive.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 709ff2e..0f81581 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -193,6 +193,23 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
+/*
+ * The caller wants a unique abbreviation of the full object name in
+ * "sha1" that is at least "len" characters long.
+ *
+ * (1) If sha1 identifies an existing object, there must be no other
+ *     object that shares the returned string as the prefix of its
+ *     name;
+ *
+ * (2) If no object with the given object name exists, there must be
+ *     no object that has the returned string as the prefix of its
+ *     name.
+ *
+ * Usually we try to return as short a string as possible, but the
+ * core.abbrevguard configuration may tell us to use at least that
+ * many characters more than necessary to make the result unique,
+ * in order to keep it unique a bit longer.
+ */
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	int status, exists;
@@ -202,6 +219,13 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
+	len -= unique_abbrev_extra_length;
+	if (len <= 0)
+		len = 1;
+	/*
+	 * Try to see how short a prefix we can feed to get
+	 * the desired unique hit
+	 */
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
