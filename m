From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 11:46:38 -0800
Message-ID: <xmqqoar39y3l.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0y4z-0006hZ-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbaLPTqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:46:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159AbaLPTql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:46:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E08828D8B;
	Tue, 16 Dec 2014 14:46:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90mOeQUV++AQYR/WkO3ECUMDA1o=; b=H3oLRr
	NXKUBJiuuQVvbP+R96Nw1fFdAog6tHoykQopgHGCnsag16DMpgywS1HUYrdDMPEZ
	v2NhpC0oYqomr86umb0MuOI747mTHs+/LYF0caZ/mcpVD2DCqIEe/xvRcBPa89oA
	w4yk7YuKIgbC7JsvNIHuK3wblDJ8t5ntQ4Cbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G/k8/x73olsHrH1aXSTXZDshVKA0TZK6
	SIJhHtTT6wzBgCJX15FKAsL56E8lFV6eLwoXmgKQhdlrENIn22LHzEKfX/GNh3mP
	NqfAtzFO9M/+s9+WQH9ZWaSToiFSgzFj0z7O7JLJJ3ytagAVAurJCSUu5JcCR9j8
	CDkZO/zn2Po=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91F6628D8A;
	Tue, 16 Dec 2014 14:46:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D94828D89;
	Tue, 16 Dec 2014 14:46:41 -0500 (EST)
In-Reply-To: <1418755747-22506-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42204B26-855C-11E4-BC26-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261463>

Stefan Beller <sbeller@google.com> writes:

> +test_description='pushing to a repository using the atomic push option'
> +
> +. ./test-lib.sh
> +
> +D=`pwd`

$(pwd)?

> +mk_repo_pair () {
> +	rm -rf workbench upstream &&
> +	test_create_repo upstream &&
> +	test_create_repo workbench &&
> +	(
> +		cd upstream && git config receive.denyCurrentBranch warn
> +	) &&

I was wondering how you would do this part after suggesting use of
test_create_repo, knowing very well that one of them was a bare one
;-).

We might want to extend test_create_repo to allow creating a bare
repository, but this is also OK.

> +	(
> +		cd workbench && git remote add up ../upstream
> +	)
> +}

> +# refname, expected value, e.g.
> +# test_ref_upstream refs/heads/master HEADS{0}
> +test_ref_upstream () {
> +	test "$#" == "2" # if this fails, we have a bug in this script.

This is not C; "test $# = 2" (notice a single equal sign).  And you
do not need dq-pair around these.

> +	test "$(git -C upstream rev-parse --verify $1)" == "$2"
> +}

Seeing that all callers of test_ref_upstream computes $2 as

	git -C workbench rev-parse --verify <something>

I have a feeling that

> +	test_ref_upstream second second

would be easier for them to write than

> +	test_ref_upstream second $(git -C workbench rev-parse --verify second)

That is

# refname in upstream and expected value from workbench
# E.g. "test_ref_upstream master HEAD" makes sure that HEAD in
# workbench matches the master branch in upstream repository.
test_ref_upstream () {
	test $# = 2 &&
        test "$(git -C upstream rev-parse --verify "$1")" == \
		"$(git -C workbench rev-parse --verify "$2")"
}

or something.  We may however want to do the usual

	test $# = 2 &&
	git -C upstream rev-parse --verify "$1" >expect &&
	git -C workbench rev-parse --verify "$2" >actual &&
        test_cmp expect actual

though.
