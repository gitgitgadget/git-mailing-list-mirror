From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Fix memory leak in apply_patch in apply.c.
Date: Fri, 02 Mar 2012 23:41:21 -0800
Message-ID: <7v399q8732.fsf@alter.siamese.dyndns.org>
References: <cover.1330740964.git.jaredhance@gmail.com>
 <03cc2ba05a5744d8b48700556f1942757151ec4b.1330740964.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 08:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3jaq-0004eL-5D
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 08:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab2CCHlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 02:41:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab2CCHlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 02:41:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECAD034B6;
	Sat,  3 Mar 2012 02:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QhY5mCaS37LFeqf3mHgeKwqF/mY=; b=i+rkiy
	B2/XXzERC4JVYxUJOa/C7gNrz3I97Ibt6p188a2bjnsDv1V1DNSdxzfrlLRvheYR
	icm/3VB5BVU2pPOqLmTUmTMGGuv3vxmfF7sDsVSrVa1MDWGLCqAicF2bqVAnlBuV
	Qi19Y3Mimk5XaDgc4fxXY4z912IxxFOY7GCS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBwlXavuWwqh4bo1W7xTx9agUPtDx8DY
	QYjVfFWWFtJAz7/zlbKIo0b4Qc1Jd026O24HRh/g3k66ApdzVHTrVSTRPUYE3FTI
	DSKA81ZUOlXJnvJzCtCNj5egnUCmsvNxW++D1vhJewNk8g8m618Z7I7DfAmwMJYV
	2BUrqw2NyP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E31F634B5;
	Sat,  3 Mar 2012 02:41:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7840034B4; Sat,  3 Mar 2012
 02:41:22 -0500 (EST)
In-Reply-To: <03cc2ba05a5744d8b48700556f1942757151ec4b.1330740964.git.jaredhance@gmail.com> (Jared Hance's message of "Fri, 2 Mar 2012 21:31:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45E98342-6504-11E1-9401-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192097>

Jared Hance <jaredhance@gmail.com> writes:

> @@ -3712,7 +3712,6 @@ static int apply_patch(int fd, const char *filename, int options)
>  			listp = &patch->next;
>  		}
>  		else {
> -			/* perhaps free it a bit better? */
>  			free(patch);

This "free it better" comment is not about how to free the "struct patch"
itself, but is about the piece of memory pointed at it, "struct fragment",
and pieces of patch text pointed at them.  The patch text pointed with
frag->patch starts out as a location in buf.buf (which will be freed later
in this function), but IIRC there were places deeper in the callchain that
replace the pointer with allocated memory.

>  			skipped_patch++;
>  		}
> @@ -3753,6 +3752,13 @@ static int apply_patch(int fd, const char *filename, int options)
>  
>  	if (summary)
>  		summary_patch_list(list);
> +	
> +	patch_iter = list;
> +	while(patch_iter != NULL) {

	while (patch_iter) {

> +	    struct patch *patch_iter_next = patch_iter->next;
> +	    free(patch_iter);
> +	    patch_iter = patch_iter_next;
> +	}
>  
>  	strbuf_release(&buf);
>  	return 0;
