From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] t2100: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Tue, 04 Jun 2013 15:04:59 -0700
Message-ID: <7v8v2p5y7o.fsf@alter.siamese.dyndns.org>
References: <cover.1370076477.git.j6t@kdbg.org>
	<e232ae3efc6f7b282d4402e6e6976b34d34ab3e7.1370076477.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 00:05:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjzLp-00030c-1v
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 00:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3FDWFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 18:05:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab3FDWFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 18:05:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C120825C65;
	Tue,  4 Jun 2013 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5jQbZTsLitDlfzh0lScvoNjTeno=; b=S4KA7U
	DsrYvE75HodSqmpS5iD7NxKrb6a58RPZD0hmxSRReqSzIHHICRcJl2CYLD+Amwdo
	yGOroajcm6LkJZ2wx2k91v1aanIUpvO1Axru8jNKnv+vs8pp2gVvX73gD66UDkEl
	idACccjFXQPEHf4LZ8qfLvO2cYcvaWAzggPGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gg9IJTETCOmihqnxIqnZ+DdurWCLVd3a
	eLoPrGmd9jlOppCjO19dgTUuM3AeBxNcnB4YRKc9YinpXKXAuW6o8JDp1/tnQkl/
	qk07WwmpFn0F8OOxV6mGHMs5qZbkcfkcFDGKwGwgAxY0zgrDy+nvb75cBt59UTf4
	2fpsDQjwNSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B573125C64;
	Tue,  4 Jun 2013 22:05:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A88D25C60;
	Tue,  4 Jun 2013 22:05:01 +0000 (UTC)
In-Reply-To: <e232ae3efc6f7b282d4402e6e6976b34d34ab3e7.1370076477.git.j6t@kdbg.org>
	(Johannes Sixt's message of "Sat, 1 Jun 2013 11:34:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDA45BC8-CD62-11E2-9C76-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226417>

Johannes Sixt <j6t@kdbg.org> writes:

> @@ -62,12 +57,7 @@ test_expect_success 'git update-index to add conflicting file path2 should fail'
>  
>  test_expect_success 'git update-index to add conflicting symlink path3 should fail' '
>  
> -	if test_have_prereq SYMLINKS
> -	then
> -		ln -s xyzzy path3
> -	else
> -		date >path3
> -	fi &&
> +	test_ln_s xyzzy path3 &&
>  	test_must_fail git update-index --add -- path3
>  '

This is also borderline questionable.  With path2, we are already
testing that adding a regular file (one variant of "non directory")
at a path that the index expects to see a directory (the index has
path2/file2 in it at this point) fails, and the test about path3 is
to make sure that an attempt to add a symbolic link, the other
variant of "non directory", is rejected the same way.  So it may
make more sense to skip this test when !SYMLINKS.

If we want to really test the equivalent on a filesystem without
symbolic links, it would be a more faithful test to attempt to add
it using "--add --cacheinfo" and see it fail, i.e.

   test_must_fail_to_ln_s_add xyzzy path3

which would be a copy of test_ln_s_add but has test_must_fail before
two calls to git_update_index it makes.

I think all the test_ln_s_add conversion in the series make sense,
but many uses of test_ln_s are questionable, and I suspect it would
invite similar confusion down the road.
