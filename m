From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: don't trigger detailed diagnosis for file
 arguments
Date: Mon, 18 Jun 2012 10:23:55 -0700
Message-ID: <7vehpc4jpw.fsf@alter.siamese.dyndns.org>
References: <vpq395tvlc0.fsf@bauges.imag.fr>
 <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:24:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgfgV-0002MX-R8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab2FRRYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 13:24:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab2FRRX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 13:23:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B84318283;
	Mon, 18 Jun 2012 13:23:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C0SKqt+4esk/bc1XrEZk9mCvKic=; b=ZrEc9k
	Wv/RYwW02wCKHRHntSswwuFI3suFR/25MOkQO3IZVHbPxl6XM/HOnX+fgDi+Nhbz
	1584glUzvAnbLhLZye0j1o+QfZNfm4jnogsQPoZ8HoGp/W12a6nDp9j0WiMekyb2
	MTDbk+EMJD26S1hEzJQNSiEcDVF30Qcz3Scec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LigQaIGvzBxT3BCRFZHqEOQaep/40bTK
	8ksIosrvtrR1AfX+JC4J0QaHkeic3r8sQYXficZeFghdH3i8ntwyvwigVNJOQD4l
	Jvk3p0k0aZkyDyb5KZ9L4vWPSPdJN+sHi6dnsTVRutXAx44oWFpih26RI3Ylp8VH
	6zBKd2qjy3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF838282;
	Mon, 18 Jun 2012 13:23:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DF818281; Mon, 18 Jun 2012
 13:23:57 -0400 (EDT)
In-Reply-To: <1339958341-22186-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun, 17 Jun 2012 20:39:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62BC00AC-B96A-11E1-B1CB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200147>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diagnose_invalid_sha1_path is normally meant to be called to diagnose
> <treeish>:<pathname> when <pathname> does not exist in <treeish>.
> However, the current code may call it if <treeish>:<pathname> is invalid
> (which triggers another call with only_to_die == 1), but for another
> reason. This happens when calling e.g.
>
>   git log existing-file HEAD:existing-file
>
> (because existing-file is a file and not a revision, the next arguments
> are assumed to be files too), leading to incorrect message like
> "existing-file does not exist in HEAD".
>
> Check that the search for <pathname> in <treeish> fails before triggering
> the diagnosis.
>
> Bug report and code fix by: Junio C Hamano <gitster@pobox.com>
> Test by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>
> This patch is very simple and should be rather uncontroversial.

I am not so sure about that.  The "only-to-die" caller is not even
expecting that the call to this codepath would successfully return.

Or at least, it shouldn't.

So it might not be a bad idea to actually catch this as a
programming error and do

	if (only_to_die) {
        	if (!ret)
                	die("BUG");
		diagnose_invalid_sha1_path(...);
	}

instead, especially since we will have a more fundamental fix with
your 2/2 patch as a longer-term fix.

>  sha1_name.c                    |  2 +-
>  t/t1506-rev-parse-diagnosis.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index c633113..5d81ea0 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1127,7 +1127,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
>  			if (new_filename)
>  				filename = new_filename;
>  			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
> -			if (only_to_die) {
> +			if (ret && only_to_die) {
>  				diagnose_invalid_sha1_path(prefix, filename,
>  							   tree_sha1, object_name);
>  				free(object_name);
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index 0843a1c..4a39ac5 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -171,4 +171,15 @@ test_expect_success 'relative path when startup_info is NULL' '
>  	grep "BUG: startup_info struct is not initialized." error
>  '
>  
> +test_expect_success '<commit>:file correctly diagnosed after a pathname' '
> +	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
> +	test_i18ngrep ! "exists on disk" error &&
> +	test_i18ngrep "unknown revision or path not in the working tree" error &&
> +	cat >expect <<EOF &&
> +file.txt
> +HEAD:file.txt
> +EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
