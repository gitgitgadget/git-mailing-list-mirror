From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 6/7] bisect: add tests for the --no-checkout option.
Date: Wed, 03 Aug 2011 17:43:45 -0700
Message-ID: <7voc066m66.fsf@alter.siamese.dyndns.org>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
 <1312408626-8600-7-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 02:43:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qom2S-0000Tn-QV
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 02:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab1HDAnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 20:43:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756140Ab1HDAnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 20:43:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EF1640B9;
	Wed,  3 Aug 2011 20:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=uP2xH8E9U/dyl6GoDZq24a+K1qg=; b=urAzJBrFBWd6rx7rBO+4
	bNzJman8HyQ5SFqvDTLsE58Fh5TypnKttC2cT49L7m2g1m50des5AgALaw6vWLxc
	9Gm1O8eO2/C/dCrZGISDH+FoW43WsVuN/Av4wbQEvvYOpjbDaOpNgc5Nfd9vNiXN
	Msk1v9Q8lJHgqsLSKZkIZYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kMxxC4wAQxiPqxGJydw+d83j2M1AOpAmOoPw7F30CMnAZL
	BpSixfbGbXFmN6WwlvJ20TAHUY74poj5H4oU1GtNq5I1huyLEOZcbzhvRezzCfco
	x3ciRz91tUoq4x4IKeW8fby3Zj/o2uCQCOk29ixlHa9OkGW2KDzUD1PIQmfFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45B8740B8;
	Wed,  3 Aug 2011 20:43:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF90040B6; Wed,  3 Aug 2011
 20:43:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFF2CEA0-BE32-11E0-877F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178648>

Jon Seymour <jon.seymour@gmail.com> writes:

> @@ -616,6 +628,14 @@ cat > expected.missing-tree.default <<EOF
>  fatal: unable to read tree 39f7e61a724187ab767d2e08442d9b6b9dab587d
>  EOF
>  
> +check_same()
> +{
> +    echo "Checking $1 is the same as $2" &&
> +    git rev-parse "$1" > expected.same &&
> +    git rev-parse "$2" > expected.actual &&
> +    test_cmp expected.same expected.actual

Please indent with tabs; I know some existing lines in this file needs
fixing in a separate patch, but we do not have to make it worse.

> +test_expect_success 'bisect: demonstrate identification of damage boundary' "
> +	git bisect reset &&
> +	git checkout broken &&
> +	git bisect start broken master --no-checkout &&
> +	git bisect run sh -c '
> +		GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*) &&

I have a suspicion that the dq around the format=%(...) here does not do
what you seem to think; doesn't it just step outside of the dq context of
the second parameter of the outermost test_expect_success?  Wouldn't your
shell see

	git for-each-ref --format=%(objectname)

without dq and barf on () as a consequence?
