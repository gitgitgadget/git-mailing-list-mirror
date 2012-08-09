From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Thu, 09 Aug 2012 15:02:17 -0700
Message-ID: <7vtxwbn2qe.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:02:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzaoE-0000AT-VY
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 00:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759783Ab2HIWCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 18:02:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759733Ab2HIWCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 18:02:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 975F18AFD;
	Thu,  9 Aug 2012 18:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFPUwzVUkIWP2OSuMhaHTKBQIOE=; b=ZIVQYA
	cqjw5bCOQo9mWj3jsbsqlCVFSEnRYGMCIpqHKEq5WIVee8KAlAy/4otPK2sMZgPW
	rdbj4X2Id3hOrX5fXfdV2BlQGhSqgcrrIYi5Qqi6vyEHplMqm6eC69DIspRwKvxY
	Z7DyKlGnCL9y085u3XjrYhtAtRTM7vLZcdWV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jtQTAKQrToVTSCdTzEOYkPpXcu+jAgue
	owwxn54oDPrZI8E/3jyGLDOSO+TT+Fl7LV8tR1DjlaHo9pGmsMdyUXdauwpAhFyn
	CniBJDu/47NBHsCpAI5bXm3kwbt7GftEMeLgya/isM9oOHp1x6aZqLdPdMJTWGSd
	HHq/2AL1NT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8621C8AFC;
	Thu,  9 Aug 2012 18:02:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 033B08AFB; Thu,  9 Aug 2012
 18:02:18 -0400 (EDT)
In-Reply-To: <1344424681-31469-2-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 8 Aug 2012 13:17:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E34AED88-E26D-11E1-8C3A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203183>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  /* remember to discard_cache() before reading a different cache! */
>  int read_index_from(struct index_state *istate, const char *path)
>  {
> ...
>  	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> -	close(fd);
>  	if (mmap == MAP_FAILED)
>  		die_errno("unable to map index file");
>  
>  	hdr = mmap;
> -	if (verify_hdr(hdr, mmap_size) < 0)
> +	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
>  		goto unmap;
>  ...
> +	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
> +		goto unmap;
>  
> +	istate->ops->read_index(istate, mmap, mmap_size, fd);
> ...
> +	close(fd);

This looks utterly wrong.

You already have mapped the whole thing, so there is nothing to be
read from fd.  You have everything in-core.  Leaving fd open and
pass it around looks like it is asking for trouble and confusion.

If you found that an entry you read halfway has an inconsistent crc,
and if you suspect that is because somebody else was writing to the
same index, it is a _sure_ sign that you are not alone, and all the
entries you read so far to the core, even if they weren't touched by
that sombody else when you read them, may be stale, and worse yet,
what you are going to read may be inconsistent with what you've read
and have in-core (e.g. you may have read "f" before somebody else
that is racing with you have turned it into a directory, and your
next read may find "f/d" in the index without crc error).

One sane way to avoid reading such an inconsistent state may be to
redo this whole function, starting from the part that calls mmap().
IOW,

	do {
		fd = open()
		mmap = xmmap(fd);
		close(fd);
                verify_various_fields(mmap);
                status = istate->ops->read_index(istate, mmap, mmap_size));
	} while (status == READ_AGAIN);

I do not think the "pass fd around so that we can redo the mapping
deep inside the callchain" is either a good idea or necessary.
