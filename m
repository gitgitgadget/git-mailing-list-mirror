From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Sun, 06 Dec 2009 23:27:34 -0800
Message-ID: <7vk4wz9rbt.fsf@alter.siamese.dyndns.org>
References: <1259784061-25143-1-git-send-email-y>
 <7vljhj4wv0.fsf@alter.siamese.dyndns.org> <vpqhbs4dkjr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 07 08:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHY0u-0002bS-S3
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 08:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758631AbZLGH1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 02:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758623AbZLGH1l
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 02:27:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758610AbZLGH1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 02:27:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3FE686F25;
	Mon,  7 Dec 2009 02:27:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mnVQyQVB8t4StddNI/ngNco6+rY=; b=HhVXc6
	YOjNuuG3vckCg0n7FhvdRaPJ1I3eeDh4zCIqhIXF9Me6g6Bcfk/sJBA50D8xRP+n
	zbMWSrioqqdecNeraeOAAvXRvgTHclSf6B3RIgK+nq710FuyrzIkm9yNzxCJtAgd
	aEdTpSX6OPwp1hgiqvwhnSs9RIqzjmk0opQkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PF4D3OPxk8+hHNGLJaVeT3TZoUQDsnvV
	iLgAExUei1Hlg6vsFySYHWB9aE1moVNZapP4bN5BuYFSquqNexyULjTlBlTy5/sy
	y6O5vcq55pNlHp+BzMIyikYiMA0ujVUVo93aezmAubUALRJKUGssCwUB6GJroBaR
	SGHFD3NMpyY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEF2086F24;
	Mon,  7 Dec 2009 02:27:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06F2686F23; Mon,  7 Dec
 2009 02:27:35 -0500 (EST)
In-Reply-To: <vpqhbs4dkjr.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun\, 06 Dec 2009 19\:28\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF7662DA-E301-11DE-9991-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134719>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

The second round still had a few compilation warnings (turned to errors in
my environment) so I fixed them up somewhat.  I stopped before getting a
clean compile, though---you will still get:

  sha1_name.c: In function 'get_sha1_with_mode_1':
  sha1_name.c:956: error: 'object_name' may be used uninitialized in this function

even with this fix-up.

>> Instead of doing a leaky allocation, it may make sense to pass the tree
>> object name as <const char *, size_t> pair, and print it with "%.*s" in
>> the error reporting codepath.  After all, object_name is used only for
>> that purpose in diagnose_invalid_sha1_path(), no?
>
> matter of taste,...

I thought generally it is accepted that I had a better taste on this list?
;-)

-- squashed --

 cache.h     |    4 ++--
 sha1_name.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 952bd51..3f9ee86 100644
--- a/cache.h
+++ b/cache.h
@@ -702,11 +702,11 @@ static inline unsigned int hexval(unsigned char c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
+static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
 {
 	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
 }
-extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 1bc09ac..025244a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -807,7 +807,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 /* Must be called only when object_name:filename doesn't exist. */
 static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
-				       const char *tree_sha1,
+				       const unsigned char *tree_sha1,
 				       const char *object_name)
 {
 	struct stat st;
