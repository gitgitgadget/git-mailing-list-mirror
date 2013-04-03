From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 03 Apr 2013 11:05:11 -0700
Message-ID: <7vbo9v5w2w.fsf@alter.siamese.dyndns.org>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
 <1365004329-15264-1-git-send-email-jkoleszar@google.com>
 <20130403161038.GB16885@sigill.intra.peff.net>
 <20130403161600.GC16885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Koleszar <jkoleszar@google.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 03 20:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNS4F-00023A-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 20:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762992Ab3DCSFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 14:05:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762890Ab3DCSFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 14:05:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBA5512A46;
	Wed,  3 Apr 2013 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=62kjyXBEHIIDM8rgp//ppwpLrgE=; b=PmzQ15
	fTLYjoU7Wtdz2Z6OpDppzTOK29ObBtntP8BAdn+/pOboGsKn5fC0q4D4ijz7D5L5
	Zso2pOZJUcOYU+lEJJiDueHDVjj6nPdwErlkixgIs7Q+1RE+taNCb+nh9fqgu6zQ
	ROO9frY8asOPQJHhtCERDRKFmwIQC6ICWbSFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LSOp04GnMfg78Sq+UT2QnvRg9rECEnUi
	8uk9M4dHymb/cRwiTJOY2u9JM3DT+5GAMQR0IOe1ksh9bMR2NhwHWQK2YBxowaNX
	sBZIcpD2ri8JH9T6igdPURAuzWSM1z2XIv+Aq5Ox4MHSdNiSa73GqsiIY1UP7wFt
	+wDqo1vdGSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F0812A45;
	Wed,  3 Apr 2013 18:05:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40D7012A42; Wed,  3 Apr
 2013 18:05:13 +0000 (UTC)
In-Reply-To: <20130403161600.GC16885@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Apr 2013 12:16:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07F8F014-9C89-11E2-83CB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219957>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 03, 2013 at 12:10:38PM -0400, Jeff King wrote:
>
>> Hmm. This is testing just the ref advertisement. It would be nice to see
>> a complete transaction tested with namespaces turned on. Something like
>> this (squashed into your patch) seems to work for me:
>
> Actually, I guess the point of your patch was to fix the
> dumb-via-http-backend transport. So this would be more complete:

Yeah, sounds sensible to me.

> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index 47eb769..b5032bd 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -162,6 +162,28 @@ test_expect_success 'invalid Content-Type rejected' '
>  	grep "not valid:" actual
>  '
>  
> +test_expect_success 'create namespaced refs' '
> +	test_commit namespaced &&
> +	git push public HEAD:refs/namespaces/ns/refs/heads/master
> +'
> +
> +test_expect_success 'smart clone respects namespace' '
> +	git clone --bare "$HTTPD_URL/smart_namespace/repo.git" ns-smart.git &&
> +	echo namespaced >expect &&
> +	git --git-dir=ns-smart.git log -1 --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'dumb clone via http-backend respects namespace' '
> +	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> +		config http.getanyfile true &&
> +	GIT_SMART_HTTP=0 git clone --bare \
> +		"$HTTPD_URL/smart_namespace/repo.git" ns-dumb.git &&
> +	echo namespaced >expect &&
> +	git --git-dir=ns-dumb.git log -1 --format=%s >actual &&
> +	test_cmp expect actual
> +'
> +
>  test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
>  
>  test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
