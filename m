From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Thu, 19 Nov 2009 23:00:09 -0800
Message-ID: <7vd43d8yva.fsf@alter.siamese.dyndns.org>
References: <4B059280.40902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 20 08:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBNTw-0001VH-Vb
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 08:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbZKTHAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 02:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbZKTHAN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 02:00:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbZKTHAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 02:00:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 924ADA0E03;
	Fri, 20 Nov 2009 02:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bkg4Aro6vL1Nb2KyYDtADlTZJaA=; b=dCjDx7
	RKdhoj1Gx+fLc0S2XQTILTN84964MDTShd5YoQO27uac4tGD7yPi8DZp4g7cDhVf
	Se+P2w+vh6WfIXsyFn42wm8ZAzThKyK4+IpBzBfvS3WzYFsP1JPbEyASveIOvPbO
	CvhZXCOwoHs1XZlNMCOLGkKZaaiPC/vSfBpas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sd2P00FAkAqZSe0UQE/AfE20mzHPMedL
	IKlKfCA9htF5VWcvCtI+e8IIv3VdsAVa7tRF6T92g2+IRFiTBicuZgOEkOywqOy4
	6TFYGZ94hIxp7nsvrFGjzDeE6EucmsR36T5z2Cx+OnUAsaKOwPnObxm/+E0nKnV1
	ChfZeBnmIRY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B647A0E02;
	Fri, 20 Nov 2009 02:00:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A1D0A0E01; Fri, 20 Nov 2009
 02:00:11 -0500 (EST)
In-Reply-To: <4B059280.40902@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Thu\, 19 Nov 2009 18\:46\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A4AD85C-D5A2-11DE-B4EC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133308>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

Could you write a concise summary in the commit log message to explain why
it is a correct fix?  Your detailed analysis after three dash lines was an
amusing read, but people who will be reading "git log" output 6 months
down the road won't have an access to it.  Something like...

    Cygwin has st_blocks in struct stat, but at least on NTFS, the field
    counts in blocks of st_blksize bytes, not in 512-byte blocks.

The Makefile already explains what NO_ST_BLOCKS_IN_STRUCT_STAT is about:

    # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
    # field that counts the on-disk footprint in 512-byte blocks.

so the above explanation should be enough.

Note that this is not any standard compliance.  POSIX cops out like this
in the <sys/stat.h> description:

    The unit for the st_blocks member of the stat structure is not defined
    within POSIX.1-2008. In some implementations it is 512 bytes. It may
    differ on a file system basis. There is no correlation between values
    of the st_blocks and st_blksize, and the f_bsize (from
    <sys/statvfs.h>) structure members.

IOW, a system like Cygwin that does not use 512-byte is not in violation.

> diff --git a/Makefile b/Makefile
> index 5d5976f..5624563 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -783,6 +783,10 @@ ifeq ($(uname_O),Cygwin)
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
>  	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
>  	OLD_ICONV = UnfortunatelyYes
> +	# The st_blocks field is not in units of 512 bytes, as the code
> +	# expects, which leads to an under-estimate of the disk space used.
> +	# In order to use an alternate algorithm, we claim to lack st_blocks.
> +	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease

This comment is redundant, as the explanation of the Makefile variable
already said the same thing.

Also it is somewhat wrong to say "claim to lack".  The Makefile variable
merely means "do not use this field".  The reason may be that the platform
lacks it, or it may have it but it does not count in 512-byte blocks.  It
does not matter---either way the field is not usable.
