From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Thu, 06 Sep 2012 10:34:52 -0700
Message-ID: <7vharb3vib.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
 <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com>
 <7v1uif7s1d.fsf@alter.siamese.dyndns.org>
 <20120906054407.GA25981@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Orgad and Raizel Shaneh <orgads@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:35:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9fyq-0001rz-OV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab2IFRe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:34:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab2IFRe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:34:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7812A8EB0;
	Thu,  6 Sep 2012 13:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fl0Hxaae5qgEmYRLDPmUILKkh24=; b=cMpG/B
	w/iogw9Kt3V3hbzf5SIW3Ham2V+oUYy1gj1DN7ul6l+/x94TeTWeOFYFUkxzjoKf
	Qas3O7RlsYbkk+P07VXVGXwHCOw3bUfixbzDHGReuSsVh07smqJj/SrNDVOu/ukf
	85lhjwC2Ihfnd8O+aeB2BOD6d5puBCAKIGe8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hbfvb3wKqQoLkLZYs1NTa8pm9CP9mxoY
	vWl+5WasiH49Cc2VvR6Ior3wgXhgppbXho6YzIzbU3t9U0ggnffwF5XCL1K2QFVm
	66m95+lMCNg4sDHWc8XSKGXrIpYTHM26SZxZ5iL7SsYZdRGJfzJDY97iy8z4K1Mw
	LVCwtSI6bCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 669FF8EAF;
	Thu,  6 Sep 2012 13:34:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F2768EAC; Thu,  6 Sep 2012
 13:34:54 -0400 (EDT)
In-Reply-To: <20120906054407.GA25981@duynguyen-vnpc.dek-tpc.internal> (Nguyen
 Thai Ngoc Duy's message of "Thu, 6 Sep 2012 12:44:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B70878A-F849-11E1-8857-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204906>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Just an idea. We could unify "[a-z]:" and "//host" into "dos root"
> concept. That would teach other code paths about UNC paths too.
> ...
> diff --git a/path.c b/path.c
> index 66acd24..0e4e2d7 100644
> --- a/path.c
> +++ b/path.c
> @@ -498,11 +498,12 @@ const char *relative_path(const char *abs, const char *base)
>  int normalize_path_copy(char *dst, const char *src)
>  {
>  	char *dst0;
> +	int i, len;
>  
> -	if (has_dos_drive_prefix(src)) {
> +	len = offset_1st_component(src, 1);
> +	for (i = 0; i < len; i++)
>  		*dst++ = *src++;
> -		*dst++ = *src++;
> -	}
> +
>  	dst0 = dst;

Modulo that I suspect you could get rid of offset_1st_component()
altogether and has_dos_drive_prefix() return the length of the "d:"
or "//d" part (which needs to be copied literally regardless of the
"normalization"), what you suggest feels like the right approach.
Why do you need the "keep_root" parameter and do things differently
depending on the setting by the way?  Wouldn't "skip the root level
when computing the offset of the first path component" something the
caller can easily decide to do or not to do, and wouldn't it make
the semantics of the function cleaner and simpler by making it do
only one thing and one thing well?
