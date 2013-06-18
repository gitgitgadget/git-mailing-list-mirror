From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] test-lib: rearrange start/end of test_expect_* and test_skip
Date: Tue, 18 Jun 2013 11:21:56 -0700
Message-ID: <7v4ncv5lff.fsf@alter.siamese.dyndns.org>
References: <cover.1371557431.git.trast@inf.ethz.ch>
	<0c11f94a00644b0fe8d2fcc3620ece530868f5af.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Phil Hord <phil.hord@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0Xd-0006ba-4z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126Ab3FRSWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:22:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189Ab3FRSV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:21:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D40A029606;
	Tue, 18 Jun 2013 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rpbou0XW4L1c9NNovDGM8d0XGU0=; b=R78lAd
	u4/R0/rxs43xr4xNE/Je2YS15v+kTIuxG3KFi4LaP7eSXwZtAKqCNJCGvobGEAKP
	A7J16yObWCr+84Ql133ESesESul3z+c6zZgyMRahkj/5RAEYaoIBp4j4EEVflRJr
	AFHlBjpTBxO9cNW9ki5Upohjl3O+vjbiClmB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wBOosJvEG9eVQ2uQ5EwA7FISwbSxRH9h
	pASOI08nQrCm5gzHbyxqNklpGX2G88TgROJG2tDEjBUVfZX6F9y832v3GpkGRBCz
	rVQS5Q4ZWpnx+RH+wTXPNRbtq6ZpVYEgtR1qAzgeaD3ceFEvkEhaj6mJ/onE0z4L
	gwaAeeV7o9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8D8A29605;
	Tue, 18 Jun 2013 18:21:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC3E29602;
	Tue, 18 Jun 2013 18:21:58 +0000 (UTC)
In-Reply-To: <0c11f94a00644b0fe8d2fcc3620ece530868f5af.1371557431.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Tue, 18 Jun 2013 14:25:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F66D3D72-D843-11E2-A326-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228291>

Thomas Rast <trast@inf.ethz.ch> writes:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4fa141a..e99b0ea 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -369,8 +369,15 @@ test_run_ () {
>  	return "$eval_ret"
>  }
>  
> -test_skip () {
> +test_start_ () {
>  	test_count=$(($test_count+1))
> +}
> +
> +test_finish_ () {
> +	echo >&3 ""
> +}
> +
> +test_skip () {
>  	to_skip=
>  	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
>  	then

This puzzled me for a few minutes, until I realized that the code
before this patch was using the call to test_skip, whose primary
purpose is to answer "do we want to run this test, or do we want to
skip it?", as a way to increment the test_count variable.  Arguably
each test would call test_skip once, so it may not be too bad, but
it does look like it is depending on a subtle side-effect.

That increment does logically belong to "now we are starting a new
test" much better.  This change makes perfect sense.

Thanks.
