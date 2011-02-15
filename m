From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] smart-http: Don't use Expect: 100-Continue
Date: Tue, 15 Feb 2011 11:42:00 -0800
Message-ID: <7vr5b9nkzb.fsf@alter.siamese.dyndns.org>
References: <1297789044-17978-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 20:42:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpQn5-0003rl-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 20:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab1BOTmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 14:42:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab1BOTmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 14:42:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDAA93556;
	Tue, 15 Feb 2011 14:43:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRvqXvZh2aow/zYuaLV2DobDe+Y=; b=iJWw52
	y/6epqn1qLYTvcvmZ8v2lYmjBiilsIHPqrn7fJieMSE6zDLGFf+vVbgk8JQ3zC4U
	oFfcoyWxiJ15BSaFZgX8jAzkndeOccpL6SuFe06IrGP3fzT/zoxi/Lu8Z37Z16f5
	CHGom3TRvHNt4bapKCNvvGxEmuLstkqoCKtz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P66jozHChCd1ewGdlqgw19cO4mlsuWEF
	Z6li14ytDmJzL53eGCnSWIKZswmNFngSUMSC/KDRfzQ/E9L6wRsos3cuvanhGCzd
	+ORwJPy13j3V+UPzjlN1+4PHt28mzsIMHOtFh9q3r6vpquK0zut/ewXXw7tr/+g4
	0Ld1X9wkQdI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BCFA73555;
	Tue, 15 Feb 2011 14:43:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9755A3554; Tue, 15 Feb 2011
 14:43:08 -0500 (EST)
In-Reply-To: <1297789044-17978-1-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Tue\, 15 Feb 2011 08\:57\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D305F850-393B-11E0-891D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166869>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/remote-curl.c b/remote-curl.c
> index 04d4813..3d82dc2 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -356,14 +356,59 @@ static size_t rpc_in(const void *ptr, size_t eltsize,
> ...
> +static int probe_rpc(struct rpc_state *rpc)
> +{
> +...
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_FILE, buf);
> +
> +	err = run_slot(slot);
> +
> +	curl_slist_free_all(headers);
> +	strbuf_release(&buf);
> +	return err;
> +}

Hmm, I am getting

    remote-curl.c:403: error: call to '_curl_easy_setopt_err_cb_data' declared
    with attribute warning: curl_easy_setopt expects a private data pointer as
    argument for this option

Shouldn't the above be giving a pointer to buf anyway?

 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 297ecf7..256326a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -400,7 +400,7 @@ static int probe_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, buf);
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
 
 	err = run_slot(slot);
 
