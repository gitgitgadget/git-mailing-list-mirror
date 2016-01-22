From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge markers
Date: Fri, 22 Jan 2016 11:08:19 -0800
Message-ID: <xmqqa8nxv3do.fsf@gitster.mtv.corp.google.com>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
	<c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
	<xmqqmvrxv5tn.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601221937440.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:08:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMh4N-0005Zf-6u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbcAVTIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:08:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751431AbcAVTIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:08:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCA9B3DCEA;
	Fri, 22 Jan 2016 14:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LNxe6KzqtH2/ldAY3Kcr3vxzndA=; b=JuHDS8
	M8fczd1o4/i2Ta+QiTehpajzXVWQyEUeo6cbII+pXIPGFI5p0OV/6KTq5+gKzIDT
	NiJIZhaGH7heEEn0df+Qyktvpep6qIiOIFutHFrfOZmWmbXHxplyuA4/USRy9zHa
	WnEw1RhRveuhPHY+UO5LYv8os5exCpnfSV5K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=egbTbClqOJMOJWfqaOWIwQynNg6veOW0
	sj1RoMc2e5F/GLoKzcSapazCgfSFfaRniwKRF8JPLmka9ocAZUqvAc56LA0H8vub
	udnyjrIeWHpJhljDjntatEcyOih6OK6MWH29LgDqUVYx8TD12rdmLfjjPkPR4wCp
	PyKt6+4LONg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4B2C3DCE9;
	Fri, 22 Jan 2016 14:08:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 346C23DCE8;
	Fri, 22 Jan 2016 14:08:21 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601221937440.2964@virtualbox> (Johannes
	Schindelin's message of "Fri, 22 Jan 2016 19:47:38 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80C4B882-C13B-11E5-823F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284585>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
>> > command, the merge_content() function) to convert the merge result
>> > into the correct working file contents, and ll_merge() should not muck
>> > with line endings at all.
>> 
>> Hmph, aren't there people who use CRLF throughout their set-up (that is,
>> it is normal for both of their blobs and working tree files to use CRLF
>> line endings)?  Or is such a setting illegal and unsupported?
>
> Good point.
>
> While I would love to simply not support such a case, it would be turning
> a blind eye to reality.
>
> So I guess I need another patch like this (plus a test case):
>
> -- snipsnap --
> t a/ll-merge.c b/ll-merge.c
> index 0338630..4a565c8 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -111,6 +111,7 @@ static int ll_xdl_merge(const struct ll_merge_driver
> *drv_unused,
>  		xmp.style = git_xmerge_style;
>  	if (marker_size > 0)
>  		xmp.marker_size = marker_size;
> +	xmp.crlf = eol_for_path(NULL, src1->ptr, src1->size) == EOL_CRLF;
>  	xmp.ancestor = orig_name;
>  	xmp.file1 = name1;
>  	xmp.file2 = name2;

What I do not understand is that you already had xmp.crlf even the
log message claimed that the caller is supposed to feed LF blobs and
the ll_merge() shouldn't have to worry about this.

If the user sets the repository up to use CRLF in working tree and
LF in blob (e.g. crlf = input), shouldn't cmd_merge_file() be doing
the convert_to_git() to the buffer stored in mmfs[] before calling
down to xdl_merge() so that ll_merge() layer will see LF not CRLF?

And if the interface is truly done in such a way that was outlined
in the proposed log message, I do not think xmp.crlf is a good name
for the new field.  What the updated code needs is a boolean option,
xmp.end_marker_with_crlf, that is set only when the internal blob
encoding is CRLF and affects only the ending of the marker strings.

It looks to me that the code is doing something different from what
the proposed log message claimed, which is puzzling.
