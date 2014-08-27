From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] teach fast-export an --anonymize option
Date: Wed, 27 Aug 2014 09:01:02 -0700
Message-ID: <xmqq8um9gbwh.fsf@gitster.dls.corp.google.com>
References: <20140821070130.GA15930@peff.net>
	<xmqqiollqzel.fsf@gitster.dls.corp.google.com>
	<20140821224910.GB21105@peff.net> <20140821232100.GA27849@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:01:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMff0-0002HY-NM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935082AbaH0QBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:01:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53001 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934686AbaH0QBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D650E339E8;
	Wed, 27 Aug 2014 12:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTu+hxe/M3bWddfA+VTgZnobN2s=; b=qK7+Gz
	06uSPUrL/TM7PRotcnvklUJvrrqBaNGMAqkuh+ZtmT+W5ujn0YmK7Y2U9y5G4e4j
	XN4Ntfb0qOpmis4OcUgpEiXZCODoB3BdKP6n6cLmOATJP0xO//0kgdj0PlatZWP1
	MdKJNoSKrp2SAzm8mDbpCahmtZO9REFIV/gvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eYVo5txAPkg/LjQoo6wESYvWzyeBNsF1
	2lG5WJku8tSxFq4vc+j3A5ZNVK4yGB4zdFXAaHBKEsZtGcgsltNC/Vn1L92iIN+e
	03ws7JD3JnAQT90sB10zTUwho/WfFjpMnnxd/UMeRufSD9IcMIz2aIl85TC4FKT5
	98fj/nL5bDY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0729339E7;
	Wed, 27 Aug 2014 12:01:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CD64339D9;
	Wed, 27 Aug 2014 12:01:04 -0400 (EDT)
In-Reply-To: <20140821232100.GA27849@peff.net> (Jeff King's message of "Thu,
	21 Aug 2014 19:21:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 595620FA-2E03-11E4-8D13-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256004>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
> new file mode 100755
> index 0000000..f76ffe4
> --- /dev/null
> +++ b/t/t9351-fast-export-anonymize.sh
> @@ -0,0 +1,117 @@
> +#!/bin/sh
> +
> +test_description='basic tests for fast-export --anonymize'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup simple repo' '
> +	test_commit base &&
> +	test_commit foo &&
> +	git checkout -b other HEAD^ &&
> +	mkdir subdir &&
> +	test_commit subdir/bar &&
> +	test_commit subdir/xyzzy &&
> +	git tag -m "annotated tag" mytag
> +'
> +
> +test_expect_success 'export anonymized stream' '
> +	git fast-export --anonymize --all >stream
> +'
> +
> +# this also covers commit messages
> +test_expect_success 'stream omits path names' '
> +	! fgrep base stream &&
> +	! fgrep foo stream &&
> +	! fgrep subdir stream &&
> +	! fgrep bar stream &&
> +	! fgrep xyzzy stream
> +'

I know there are a few isolated places that already use "fgrep", but
let's not spread the disease. Neither "fgrep" nor "egrep" appears in
POSIX and they can easily be spelled more portably as "grep -F" and
"grep -E", respectively.

> +test_expect_success 'stream allows master as refname' '
> +	fgrep master stream
> +'
> +
> +test_expect_success 'stream omits other refnames' '
> +	! fgrep other stream
> +'

What should happen to mytag?

> +
> +test_expect_success 'stream omits identities' '
> +	! fgrep "$GIT_COMMITTER_NAME" stream &&
> +	! fgrep "$GIT_COMMITTER_EMAIL" stream &&
> +	! fgrep "$GIT_AUTHOR_NAME" stream &&
> +	! fgrep "$GIT_AUTHOR_EMAIL" stream
> +'
> +
> +test_expect_success 'stream omits tag message' '
> +	! fgrep "annotated tag" stream
> +'
> +
> +# NOTE: we chdir to the new, anonymized repository
> +# after this. All further tests should assume this.
> +test_expect_success 'import stream to new repository' '
> +	git init new &&
> +	cd new &&
> +	git fast-import <../stream
> +'
> +
> +test_expect_success 'result has two branches' '
> +	git for-each-ref --format="%(refname)" refs/heads >branches &&
> +	test_line_count = 2 branches &&
> +	other_branch=$(grep -v refs/heads/master branches)
> +'
> +
> +test_expect_success 'repo has original shape' '
> +	cat >expect <<-\EOF &&
> +	> subject 3
> +	> subject 2
> +	< subject 1
> +	- subject 0
> +	EOF
> +	git log --format="%m %s" --left-right --boundary \
> +		master...$other_branch >actual &&
> +	test_cmp expect actual
> +'

Yuck and Hmph.  Doing a shape-preserving conversion is very
important, but I wonder if we can we verify without having to cast a
particular rewrite rule in stone.  We know we want to preserve
relative order of committer timestamps (to reproduce bugs that
depend on the traversal order), and it may be OK to reuse the
exactly the same committer timestamps from the original, in which
case we can make sure that we create the original history with
appropriate "test_tick"s (I think test_commit does that for us) and
use "%ct" instead of "%s" here, perhaps?  That way we can later
change the rewrite rules of commit object payload without having to
adjust this test.

> +
> +test_expect_success 'root tree has original shape' '
> +	cat >expect <<-\EOF &&
> +	blob
> +	tree
> +	EOF
> +	git ls-tree $other_branch >root &&
> +	cut -d" " -f2 <root >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'paths in subdir ended up in one tree' '
> +	cat >expect <<-\EOF &&
> +	blob
> +	blob
> +	EOF
> +	tree=$(grep tree root | cut -f2) &&
> +	git ls-tree $other_branch:$tree >tree &&
> +	cut -d" " -f2 <tree >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'tag points to branch tip' '
> +	git rev-parse $other_branch >expect &&
> +	git for-each-ref --format="%(*objectname)" | grep . >actual &&
> +	test_cmp expect actual
> +'

I notice you haven't checked how many tags you have in the
repository, unlike the number of branches which you counted
earlier.

> +test_expect_success 'idents are shared' '
> +	git log --all --format="%an <%ae>" >authors &&
> +	sort -u authors >unique &&
> +	test_line_count = 1 unique &&
> +	git log --all --format="%cn <%ce>" >committers &&
> +	sort -u committers >unique &&
> +	test_line_count = 1 unique &&
> +	! test_cmp authors committers
> +'

Two commits by the same author must convert to two commits by the
same anonymized author, but that is not tested here; the history
made in 'setup a simple repo' step is a bit too simple to do that
anyway, though ;-).

> +test_expect_success 'commit timestamps are retained' '
> +	git log --all --format="%ct" >timestamps &&
> +	sort -u timestamps >unique &&
> +	test_line_count = 4 unique
> +'
> +
> +test_done
