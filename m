From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Sat, 21 Nov 2009 17:21:07 -0800
Message-ID: <7veinrnym4.fsf@alter.siamese.dyndns.org>
References: <4B059280.40902@ramsay1.demon.co.uk>
 <7vd43d8yva.fsf@alter.siamese.dyndns.org>
 <7vlji17i02.fsf@alter.siamese.dyndns.org>
 <4B072D98.6020101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 22 02:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC18l-0007cH-Op
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 02:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZKVBVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 20:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbZKVBVL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 20:21:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZKVBVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 20:21:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E91481AEE;
	Sat, 21 Nov 2009 20:21:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B0qYA8xQg9SpOylIciVO+HYH/pY=; b=iD///s
	rmKGys0IRfeGr3rcM5qX5VdF/qupL8Dst5l3nvsrYvmxk+fTvGLdxIqUdcpuJvuP
	fLz6mn0QzG+bRlB9w3bUVRWq0eSe2psvX3RC3c3Q2USyrAOG1EWLXBmlRCngLkuA
	jZP3/bP2q0T7BSK2JWH/9dKk/OX8/t+bLRuy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJ6wRi/QHCRaVCJBBpEvR8nhCPg9Iu+V
	9zsbBvxYdcSXQl8aRSn47TzxMRhh+LTY/lxoCyCho8kAc+NrHxJf+4888RrT0v0u
	Lc2Zo2uycI58V1BnW8YN9/QamsLa1S1Sa9NNcr2AVxBFQY2bvcqnWosUifZ1QlWD
	m45RCtlgTVQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED7F81AEA;
	Sat, 21 Nov 2009 20:21:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52E3181AE8; Sat, 21 Nov
 2009 20:21:09 -0500 (EST)
In-Reply-To: <4B072D98.6020101@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat\, 21 Nov 2009 00\:00\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 521A351A-D705-11DE-BBF9-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133417>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I haven't tried this patch, but I think you may need to add something like
> the following (*not tested*):
>
> --- >8 ---
> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index b4a51b9..7e9edec 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -53,6 +53,7 @@ static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
>  		buf->st_size = (off_t)fdata.nFileSizeLow;
>  #endif
>  		buf->st_blocks = size_to_blocks(buf->st_size);
> +		buf->st_blksize = 512;
>  		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
>  		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
>  		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
> --- >8 ---

Doesn't this contradict with everything you said?

You are forcing st_blksize to 512 but still return the same old st_blocks;
I do not understand what that would achieve.

In your experiments, st_blocks was reported in 1024-byte blocks and that
size coincided with what was reported in st_blksize, and that was the
whole point of the approach taken by the ST_BLOCKS_COUNTS_IN_BLKSIZE
patch.
