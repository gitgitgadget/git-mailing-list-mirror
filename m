From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched
 branch
Date: Sun, 16 Sep 2012 21:48:02 -0700
Message-ID: <7vobl5xnjx.fsf@alter.siamese.dyndns.org>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
 <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTFp-0005BL-It
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 06:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2IQEsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 00:48:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2IQEsG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 00:48:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCC396E4;
	Mon, 17 Sep 2012 00:48:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OXBjWOOzPviuyMAFHkZzp8Rzk9o=; b=L30szR
	03y0KSPgX/TmdUcyA1W5PGwDnHW/td9nOU7B8F42oMmoJr0T7KqVBhSCzlsbwbHy
	02MpLZHIRCiWcTVoXyL/Utkhzz1exsV0lKL0i9X2QXGuK4pS+qvvt9246GjYHaVj
	Ki6Bc3bEZ+wZIIhA/XO5D+qU/wP+VRwjtI5t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qklKK7hHmzpSfUPX+8TNgNpLMbCZIayu
	Nlw8Xjp6n6FC0pv1LNIBapgp0oW3S48eGTQDDkbtz3Iv2CQ7//nWAF7bgZo7S4QD
	VvmVlRMGOvzh1ywc5oQvwXZvnnwnjyo4sS/6eNBqvAmLxVSvGQ2stFZLomJjKh+e
	Obwd9NSN2yo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC97996E3;
	Mon, 17 Sep 2012 00:48:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03A7D96DD; Mon, 17 Sep 2012
 00:48:03 -0400 (EDT)
In-Reply-To: <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Sun, 16 Sep 2012 10:13:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDB9E468-0082-11E2-B48A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205640>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> - add tests for the refspec installed by the clone command

Thanks.

> +test_expect_success 'refspec contains all branches by default' '
> +	git clone "file://$PWD" dir_all &&

There have been numerous "on windows which should we use, $PWD or
$(pwd)?" gotchas.  In this particular case, wouldn't the tests work
equally well with "." to avoid the uneasiness factor?

> +	echo "+refs/heads/*:refs/remotes/origin/*" > expected &&
> +	git --git-dir=dir_all/.git config --get remote.origin.fetch > actual &&
> +	test_cmp expected actual

I am a bit torn with this one.

We'd want to make sure a single clone from a repository with two
branches will not result in a repository where the next fetch will
not pull in the other branch, and the value of the
"remote.origin.fetch" is an implementation detail that happen to be
what affects the outcome.  The test is not checking the expected
outcome in a direct way (imagine how this test will break when we do
another change similar to the migration from .git/remotes/origin to
the remote.origin.fetch variables).

I'll let it pass for now, though.

> +test_expect_success 'no refspec is written if remotes HEAD is detached' '
> +	git checkout two^ &&
> +	git clone --single-branch "file://$PWD" dir_detached &&
> +	rm expected && touch expected &&

If earlier tests failed, there may not be any expected file and the
"rm expected" will fail.  You can just say

	>expected &&

instead.  "touch" is a way to update the timestamp of the file; do
not use it when you want to make sure an empty file exists.

> +	git --git-dir=dir_detached/.git config --get remote.origin.fetch > actual
> +	test_cmp expected actual
> +'

I'd feel better if the test were like this instead:

	git checkout two^ &&
        git clone --single-branch . dir_detached &&
        (
		cd dir_detached &&
                git fetch &&
                git for-each-ref refs/remotes/origin >actual
	) &&
        >expect &&
        test_cmp expect actual

That is what I would call "testing the desired results in the most
direct way".

Perhaps like this?

-- >8 -- t5709-clone-refspec.sh -- >8 --
#!/bin/sh

test_description='test refspec written by clone-command'
. ./test-lib.sh

test_expect_success 'setup' '
	# Make two branches, "master" and "side"
	echo one >file &&
	git add file &&
	git commit -m one &&
	echo two >file &&
	git commit -a -m two &&
	git tag two &&
	echo three >file &&
	git commit -a -m three &&
	git checkout -b side &&
	echo four >file &&
	git commit -a -m four &&
	git checkout master &&

	# default clone
	git clone . dir_all &&

	# default --single that follows HEAD=master
	git clone --single-branch . dir_master &&

	# default --single that follows HEAD=side
	git checkout side &&
	git clone --single-branch . dir_side &&

	# explicit --single that follows side
	git checkout master &&
	git clone --single-branch --branch side . dir_side2 &&

	# --single that does not know what branch to follow
	git checkout two^ &&
	git clone --single-branch . dir_detached &&

	# advance both "master" and "side" branches
	git checkout side &&
	echo five >file &&
	git commit -a -m five &&
	git checkout master &&
	echo six >file &&
	git commit -a -m six
'

test_expect_success 'by default all branches will be kept updated' '
	(
		cd dir_all && git fetch &&
		git for-each-ref refs/remotes/origin |
		sed -e "/HEAD$/d" \
		    -e "s|/remotes/origin/|/heads/|" >../actual
	) &&
	# follow both master and side
	git for-each-ref refs/heads >expect &&
	test_cmp expect actual
'

test_expect_success '--single-branch while HEAD pointing at master' '
	(
		cd dir_master && git fetch &&
		git for-each-ref refs/remotes/origin |
		sed -e "/HEAD$/d" \
		    -e "s|/remotes/origin/|/heads/|" >../actual
	) &&
	# only follow master
	git for-each-ref refs/heads/master >expect &&
	test_cmp expect actual
'

test_expect_success '--single-branch while HEAD pointing at side' '
	(
		cd dir_side && git fetch &&
		git for-each-ref refs/remotes/origin |
		sed -e "/HEAD$/d" \
		    -e "s|/remotes/origin/|/heads/|" >../actual
	) &&
	# only follow side
	git for-each-ref refs/heads/side >expect &&
	test_cmp expect actual
'

test_expect_success '--single-branch with explicit --branch side' '
	(
		cd dir_side2 && git fetch &&
		git for-each-ref refs/remotes/origin |
		sed -e "/HEAD$/d" \
		    -e "s|/remotes/origin/|/heads/|" >../actual
	) &&
	# only follow side
	git for-each-ref refs/heads/side >expect &&
	test_cmp expect actual
'

test_expect_success '--single-branch with detached' '
	(
		cd dir_detached && git fetch &&
		git for-each-ref refs/remotes/origin |
		sed -e "/HEAD$/d" \
		    -e "s|/remotes/origin/|/heads/|" >../actual
	)
	# nothing
	>expect &&
	test_cmp expect actual
'

test_done
