From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Sun, 29 May 2011 23:33:38 -0700
Message-ID: <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 08:33:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQw31-0002p3-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab1E3Gdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 02:33:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1E3Gdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:33:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A7936A0B;
	Mon, 30 May 2011 02:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IE4mX8mMB6RoQRgsQYz+VfHLRaM=; b=M8lNSi
	Wqyv+vqhIu5PfY8h7kugFyalIf3OQ9lcWyZPzkUnZYOWMkIw886k0QRG9TxmpgwV
	H0hg23+vg5ktHOigGzoWqCqjV6UUlnXWIEV1FhfwMolT4ynH41eWQF1QyU+w+g+x
	KjWYRVDxdPwClI+4jd9f27yCX2kA/Vr26WMpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F3RV84nvPg4MkiO4N5bkBxNKPUXnJmVv
	f6lkbHGigsTJg95NT9IrEi16nSnWxIeyNDr7lpN3QaOUhu32Lp2CCJVNC//7DiwP
	eOw56yDHJftSTAU8McLmR6eGeBOCRyGGFIHnPCW10T5hVf7r8H3FXVqVVDR51kfs
	UZNYzLHdoi8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 099526A0A;
	Mon, 30 May 2011 02:35:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B43A66A09; Mon, 30 May 2011
 02:35:48 -0400 (EDT)
In-Reply-To: <20110523202734.GC6298@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 May 2011 16:27:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 117A4112-8A87-11E0-98DD-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174726>

Jeff King <peff@peff.net> writes:

> @@ -852,6 +862,29 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  		}
>  	}
>  
> +	if (userdiff->binary != -1)
> +		is_binary = userdiff->binary;
> +	else {
> +		is_binary = buffer_is_binary(result, result_size);
> +		for (i = 0; !is_binary && i < num_parent; i++) {
> +			char *buf;
> +			unsigned long size;
> +			buf = grab_blob(elem->parent[i].sha1,
> +					elem->parent[i].mode,
> +					&size);
> +			if (buffer_is_binary(buf, size))
> +				is_binary = 1;
> +			free(buf);
> +		}
> +	}

Two comments.

 - This loop will grab the blob from all parents just to peek and discard
   for most of commits. It feels somewhat wasteful, especially because
   "binary" that is not marked as binary is a rare minor case (most of the
   paths are text). Stopping immediately at the first binary blob does not
   optimize the loop even though it is better than not having one.

 - It may make sense to compare [i].sha1 with earlier [j].sha1 (j < i) and
   avoid grab_blob() altogether?  Cf. 3c39e9b (combine-diff: reuse diff
   from the same blob., 2006-02-01).
