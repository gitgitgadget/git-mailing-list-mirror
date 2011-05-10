From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] fix overslow :/no-such-string-ever-existed diagnostics
Date: Tue, 10 May 2011 12:05:01 -0700
Message-ID: <7vvcxiidgi.fsf_-_@alter.siamese.dyndns.org>
References: <7vhb92jujt.fsf@alter.siamese.dyndns.org>
 <7vzkmuidk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 21:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsFB-0004HK-9O
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab1EJTFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:05:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1EJTFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 435195392;
	Tue, 10 May 2011 15:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c9I4WMxP8t096ihaoN8zEfPts2g=; b=TOvivn
	O3/lOlcJXyeBXdMjtgEY7+Ue22KRKr5Cb5QH1iCMSPB2HlzkUMaGa5jUVotf7YOy
	ZDUjxnyKLzZI+6a1Vkv58UKBX2Hia7f/R/LNB/mwByQ7UYlUQVHpuqTvaAX9+nWL
	j9SKhSY/DhV+HnDVtVg/qhc87mKZLLrnlKZrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgkMJEIA+/V9W/iNY3BZAedP7iPCGkpm
	L3dVs2134aQC1Z9OiwjqNIrxtimnTtT/uwvwsriTxbDcU910eMkjZBHy68Jeh2Kd
	n16dFXYBXc+akx0xJSnKmcS3d2Ii7pxHnqJbjemi6evLegKdmCs1FqMStNhy/TiC
	Kg98c0ipB70=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FB475387;
	Tue, 10 May 2011 15:07:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28DBC537D; Tue, 10 May 2011
 15:07:08 -0400 (EDT)
In-Reply-To: <7vzkmuidk1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 10 May 2011 12:02:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5DA3694-7B38-11E0-9EA6-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173347>

Junio C Hamano <gitster@pobox.com> writes:

>    We may want to add a guard at the beginning of die_verify_filename() to
>    omit the extra call to get_sha1_with_mode_1(only_to_die=1) when arg
>    looks like a magic pathspec, i.e. ":" followed by anything !isalnum().

... which would look like this.

diff --git a/setup.c b/setup.c
index 50e8548..fd4ce59 100644
--- a/setup.c
+++ b/setup.c
@@ -85,8 +85,17 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
 {
 	unsigned char sha1[20];
 	unsigned mode;
-	/* try a detailed diagnostic ... */
-	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
+
+	/*
+	 * Saying "'(icase)foo' does not exist in the index" when the
+	 * user gave us ":(icase)foo" is just stupid.  A magic pathspec
+	 * begins with a colon and is followed by a non-alnum; do not
+	 * let get_sha1_with_mode_1(only_to_die=1) to even trigger.
+	 */
+	if (!(arg[0] == ':' && !isalnum(arg[1])))
+		/* try a detailed diagnostic ... */
+		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
+
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
 	    "Use '--' to separate paths from revisions", arg);
