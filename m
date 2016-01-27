From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 27 Jan 2016 12:49:31 -0800
Message-ID: <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
References: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
	<xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
	<xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
	<20160127151602.GA1690@ecki.hitronhub.home>
	<xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOX29-0007a8-IU
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbcA0Uti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:49:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161343AbcA0Ute (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:49:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B1D83E926;
	Wed, 27 Jan 2016 15:49:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FdPJ8dihCPg8Hm8f+CO5p/NL3Ws=; b=aFT7zg
	koiX59dz4CTkmV/xtmLb73Oz63COQE2Q4Ty8GC4eubjvBWVEnXb0QWIyp2piRPk2
	2Ng2VtuwnRVGBoI100GVsw/goYuDouA7krELdHFYH7di2S5CkFrxg5h2j35l4ZPQ
	5+Gha8muGztdmtyveDQdqMvN878dFml+gUZaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jXYdr3BBvUkS+z3QfiTl2m4c8B9HkZ0z
	0XyQ+gprR0oKm/4lH106upqYWEEdz2VmG2pcRsUViM+o7faSnqQ0GWajsagtdmGw
	feNqx/Rh7usMQcJzt9VS9JA+mTu06NySv7RKO8XF4sKDZKanS9fkwRNv1qS0wXu2
	ldOG3kGcSaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71DE03E925;
	Wed, 27 Jan 2016 15:49:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C4EAC3E922;
	Wed, 27 Jan 2016 15:49:32 -0500 (EST)
In-Reply-To: <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Jan 2016 11:05:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77D3911C-C537-11E5-BEB6-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One way to solve (1) I can think of is to change the definition of
> ce_compare_data(), which is called by the code that does not trust
> the cached stat data (including but not limited to the Racy Git
> codepath).  The current semantics of that function asks this
> question:
>
>     We do not know if the working tree file and the indexed data
>     match.  Let's see if "git add" of that path would record the
>     data that is identical to what is in the index.
>
> This definition was cast in stone by 29e4d363 (Racy GIT, 2005-12-20)
> and has been with us since Git v1.0.0.  But that does not have to be
> the only sensible definition of this check.  I wonder what would
> break if we ask this question instead:
>
>     We do not know if the working tree file and the indexed data
>     match.  Let's see if "git checkout" of that path would leave the
>     same data as what currently is in the working tree file.
>
> If we did this, "reset --hard HEAD" followed by "diff HEAD" will by
> definition always report "is clean" as long as nobody changes files
> in the working tree, even with the inconsistent data in the index.
>
> This still requires that convert_to_working_tree(), i.e. your smudge
> filter, is deterministic, though, but I think that is a sensible
> assumption for sane people, even for those with inconsistent data in
> the index.

Just a few additional comments.

The primary reason why I originally chose "does 'git add' of what is
in the working tree give us the same blob in the index?" as opposed
to "does 'git checkout' from the index again will give the same
result in the working tree?" is because it is a lot less resource
intensive and also is simpler.  Back then I do not think we had a
streaming interface to hash huge contents from a file in the working
tree, but it requires us to read the entire file from the filesystem
just once, apply the convert_to_git() processing and then hash the
result, whether we keep the whole thing in core at once or process
the data in streaming fashion.  Doing the other check will have to
inflate the blob data and apply the convert_to_working_tree()
processing, and also read the whole thing from the filesystem and
compare, which is more work at runtime.  And for a sane set-up where
the data in the index does not contradict with the clean/smudge
filter and EOL settings, both would yield the same result.

If we were to switch the semantics of ce_compare_data(), we would
want a new sibling interface next to stream_blob_to_fd() that takes
a file descriptor opened on the file in the working tree for reading
(fd), the object name (sha1), and the output filter, and works very
similarly to stream_blob_to_fd().  The difference would be that we
would be reading from the fd (i.e. the file in the working tree) as
we read from the istream (i.e. the contents of the blob in the
index, after passing the convert_to_working_tree() filter) and
comparing them in the main loop.  The filter parameter to the
function would be obtained by calling get_stream_filter() just like
how write_entry() uses it to prepare the filter parameter to call
streaming_write_entry() with.  That way, we can rely on future
improvement of the streaming interface to make sure we keep the data
we have to keep in core to the minimum.

IOW, I am saying that the "add --fix-index" lunchbreak patch I sent
earlier in the thread that has to hold the data in-core while
processing is not a production quality patch ;-)
