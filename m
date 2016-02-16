From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Mon, 15 Feb 2016 19:19:07 -0800
Message-ID: <xmqqziv1mjf8.fsf@gitster.mtv.corp.google.com>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
	<20160215140422.GA1747@mitoraj.siccegge.de>
	<xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
	<20160216012210.GB11961@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Egger <christoph@christoph-egger.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:20:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWC8-00076h-OA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbcBPDUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:20:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752932AbcBPDTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:19:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BB534518B;
	Mon, 15 Feb 2016 22:19:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iNLC+Of3DK2/ekCNNUwqHQjoZrk=; b=jotU9L
	HDYHRKKfCU2wDse82iLCJ2CtGcZrJeJEm2IXUyWoXa9klR90C4RABaW1anWPmvhK
	xx8tMaA6FWmPW/pXtgzndITgKBHHBSus7YMey7thxoV+P4ivQCEqfNXz1jazsbIE
	rzWcbi9etqrCLcsiD7S7ZEKexkntXRkzEW4vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SjAJ+/I69xyiMmSFrUjYgCQJ+VY3xYV+
	ZPnTE39I8e2JfaKrM5v9dV8MSTa3aV58sQCcxtIJQGYiOXF/Akz6DCQ/zpn4c5c7
	wasgGgEKgZUxWndcJ7iN7jg+fpi2RL9ku1VxG1kSiV5nXVEfurG5KvoS2Qsv0+d6
	cxbNKOBZaVg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1384E4518A;
	Mon, 15 Feb 2016 22:19:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 84E8045188;
	Mon, 15 Feb 2016 22:19:08 -0500 (EST)
In-Reply-To: <20160216012210.GB11961@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 15 Feb 2016 20:22:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AA8DEA6-D45C-11E5-8F9E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286309>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 15, 2016 at 03:25:32PM -0800, Junio C Hamano wrote:
>
>> Thanks.  This, when applied on top of 2.7.1, however seems to break
>> at least t5541 and t5551.
>
> Hrm. I cannot see how the new code can possibly do anything unless
> http.pinnedpubkey is set, and our tests don't do that. Neither t5541 nor
> t5551 fails for me with the patch on top of v2.7.1 (or current "pu", for
> that matter).

> What does the failure look like?

In t5541, #17 "push (chunked)" fails.

The test expects to see "POST git-receive-pack (chunked)" in the
error output, but here is what I see in $TRASH/test_repo_clone/err:

    Pushing to http://127.0.0.1:5541/smart/test_repo.git
    POST git-receive-pack (467 bytes)
    To http://127.0.0.1:5541/smart/test_repo.git
       8598732..09a7db2  master -> master
    updating local tracking ref 'refs/remotes/origin/master'

"git reset --hard HEAD^" to get rid of this patch before retesting
makes the same test pass, so even though I cannot see how this could
make any difference, it apparently is making some difference.

#define LIBCURL_VERSION_NUM 0x072300

I suspect that "#else" is too agressive to bail out or something
silly like that.

Oh, I think I found it.

@@ -216,6 +219,13 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 #endif
+	if (!strcmp("http.pinnedpubkey", var))
+#if LIBCURL_VERSION_NUM >= 0x072c00
+		return git_config_pathname(&ssl_pinnedkey, var, value);
+#else
+		warning(_("Public key pinning not supported with cURL < 7.44.0"));
+		return 0;
+#endif

We are not writing in Python.  Indenting the second line the same
way does not make it part of the block.  Of course by inserting the
new config in the earlier part of the function, it broke everything
that comes after.




 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -415,6 +425,10 @@ static CURL *get_curl_handle(void)
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+	if (ssl_pinnedkey != NULL)
+		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
+#endif
 	if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
