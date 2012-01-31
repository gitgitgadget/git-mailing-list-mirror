From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Tue, 31 Jan 2012 13:20:53 -0600
Message-ID: <20120131192053.GC12443@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsJGT-0006Xp-HU
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 20:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab2AaTVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 14:21:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38475 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2AaTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 14:21:07 -0500
Received: by vbjk17 with SMTP id k17so323247vbj.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1GpLvEOm4TnfWY37vF+8WX5jv8fLiZWtiCYhWW8aDuo=;
        b=IjhdVpO50/v8/eUNBHgoTpl2oKuAG/6o/FZRb93CiUpxxMm5FGNohF/T6o2nzvok+6
         WeseJk/PmndlBjGPQWeSeJi5Te2yMNMLGriNWd7caBApVpatLBX2Vbpu8Pr2LG9cjdMq
         H7N4/IEJibl8xzJojk4SzbfCQNdBzgfYB0nds=
Received: by 10.52.28.238 with SMTP id e14mr11233564vdh.96.1328037665577;
        Tue, 31 Jan 2012 11:21:05 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fw2sm2794655vdc.17.2012.01.31.11.21.03
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 11:21:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F28378F.6080108@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189465>

Hi,

Ramsay Jones wrote:

> In particular, some versions of gcc complains as follows:
> 
>         CC vcs-svn/sliding_window.o
>     vcs-svn/sliding_window.c: In function `check_overflow':
>     vcs-svn/sliding_window.c:36: warning: comparison is always false \
>         due to limited range of data type

Yuck.  Suppressing this warning would presumably also suppress the
optimization that notices the comparison is always false.

The -Wtype-limits warning also triggers in some other perfectly
reasonable situations: see <http://gcc.gnu.org/PR51712>.  I wonder if
we should keep a list of unreliable warnings somewhere (e.g.,
Meta/Make).

[...]
> Note that the "some versions of gcc" which complain includes 3.4.4 and
> 4.1.2, whereas gcc version 4.4.0 compiles the code without complaint.

Thanks for tracking this down.  Interesting.  -Wtype-limits was split
out from the default set of warnings (!) in gcc 4.3 to address
<http://gcc.gnu.org/PR12963>, among other bugs (r124875, 2007-05-20).

[...]
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -300,7 +300,8 @@ void fast_export_blob_delta(uint32_t mode,
>  				uint32_t len, struct line_buffer *input)
>  {
>  	long postimage_len;
> -	if (len > maximum_signed_value_of_type(off_t))
> +	uintmax_t delta_len = (uintmax_t) len;
> +	if (delta_len > maximum_signed_value_of_type(off_t))
>  		die("enormous delta");
>  	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);

Is there some less ugly way to write the condition "if this value is
not representable in this type"?

I guess I could live with something like the following (please don't
take the names too seriously):

	static inline off_t off_t_or_die(uintmax_t val, const char *msg_if_bad)
	{
		if (val > maximum_signed_value_of_type(off_t))
			die("%s", msg_if_bad);
		return (off_t) val;
	}

	...

		off_t delta_len = off_t_or_die(len, "enormous delta");
		postimage_len = apply_delta(delta_len, input, ...);

What do you think?

Jonathan
