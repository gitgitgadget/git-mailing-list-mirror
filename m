From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Thu, 06 Sep 2012 16:08:38 -0700
Message-ID: <7v627q21hl.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Sep 07 01:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9lBp-0004Gs-L0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 01:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab2IFXIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 19:08:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab2IFXIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 19:08:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DCC986C;
	Thu,  6 Sep 2012 19:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=tqnh7QU8UKBlFGGVsZQ0SBuG8vw=; b=EIdIyfTt30YPiIncdX3l
	jmcuViD4PEJNszlze7nATKm8A6bxxfAVSHxmZmAnyAlhxJQPnrEDTuAmZm0W+bwI
	sLZQGcvov0hDPI2iX4/YR/0+boFsOUM+bdAvujoBW+2LykTLgR6jgfgBK1gQOwfX
	6Lf3//VCyYz+gTHDboVMKgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GtsDU1voQ2R0uaVK273lFn+ckyIvJ7WwHF1fubPnwN4X6l
	qlnt4tSYWLBDSwb6ffPcWQ/gPYibFvotJ7Dk3ykayp+9jtD4tTvAZ8xgQSuocPZ1
	Smarlhlv6Iah5j2OABB2mH27rqHIQ+SPn07WrwP0AflgvW1Q9KLLzzT3AKorg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8E6986B;
	Thu,  6 Sep 2012 19:08:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7833F9869; Thu,  6 Sep 2012
 19:08:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB64BAA8-F877-11E1-8155-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204939>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> There is currently a bug: if passed an absolute top-level path that
> doesn't exist (e.g., "/foo") it incorrectly interprets the path as a
> relative path (e.g., returns "$(pwd)/foo").  So mark the test as
> failing.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t0000-basic.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 1a51634..ad002ee 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -458,7 +458,17 @@ test_expect_success 'real path rejects the empty string' '
>  	test_must_fail test-path-utils real_path ""
>  '
>  
> -test_expect_success SYMLINKS 'real path works as expected' '
> +test_expect_failure 'real path works on absolute paths' '
> +	nopath="hopefully-absent-path" &&
> +	test "/" = "$(test-path-utils real_path "/")" &&
> +	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&

You could perhaps do

	sfx=0 &&
        while test -e "/$nopath$sfx"
        do
		sfx=$(( $sfx + 1 ))
	done && nopath=$nopath$sfx &&
	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&

if you really cared.
