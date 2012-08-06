From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 01/16] Modify cache_header to prepare for other
 index formats
Date: Sun, 05 Aug 2012 18:17:32 -0700
Message-ID: <7v8vds3jkj.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyBwz-0004m0-Fi
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab2HFBRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:17:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051Ab2HFBRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:17:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1A4881C;
	Sun,  5 Aug 2012 21:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7KSCkHzGO5vPu+IJRv86+B2QuVg=; b=gyfHOa
	Zm8rYTXiPhAAQa8MHg4ztIZTxwi3P8kFWNSMjOjEwZpM0OOanXAp46wbdL/mw4V7
	CAl0qOSGEiF7puhh1xMOtmDA/arQYML5H4yFjuHhtHnalbKsIIh3HUNjJKbQ7pe6
	GlZA1alPugSSCgCzfh4yjNR7vugp+4DKf/H/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o1NsBFSaBk2oN6sKhW0PWSsNqQMgptaZ
	E+P6i7028HXWzWC1OpH2CTMSWf4rsu6VkOEXE64zBZUMUdlQ958y0C2KcmnqjRb3
	jwUc5X1rYHRj7qIIoVdS756AJ2U+JB+/hrM6ByBEjFvvQ/I+3Muv8fscl6TOkK/3
	FrDNOvsqF4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1833C881B;
	Sun,  5 Aug 2012 21:17:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57E17881A; Sun,  5 Aug 2012
 21:17:34 -0400 (EDT)
In-Reply-To: <1344203353-2819-2-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:48:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 808A862E-DF64-11E1-A5F8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202942>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index 2f8159f..5d61d92 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1433,7 +1446,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  
>  	errno = EINVAL;
>  	mmap_size = xsize_t(st.st_size);
> -	if (mmap_size < sizeof(struct cache_header) + 20)
> +	if (mmap_size < sizeof(struct cache_version_header) + 20)
>  		die("index file smaller than expected");

At the design level, I have a large problem with this change.  I
understand that you wanted to make sure that some versions can lack
the num-entries word in the header, but then what is the point of
keeping that "+20" here?  Are all versions of the file format still
required to have the 20-byte trailing SHA-1 sum over the whole file?

	Side note: I am actually fine with that "sum at the end"
	requirement, but then it needs to be documented what are
	assumed to be unomittable and why.

        I also do not see why v5 *needs* to drop the num-entries
        word from the header in the first place.

At the practical level, we used to error out, upon seeing a file
that claims to be v2 in the header but is too small to hold the
version header, the number of entries word and the trailing SHA-1
sum.  We no longer do this and happily call verify_hdr() in the
following code even when the file is too small, no?

> @@ -1442,11 +1455,13 @@ int read_index_from(struct index_state *istate, const char *path)
>  		die_errno("unable to map index file");
>  
>  	hdr = mmap;
> +	hdr_v2 =  mmap + sizeof(*hdr);
>  	if (verify_hdr(hdr, mmap_size) < 0)
>  		goto unmap;
