From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Mon, 07 Mar 2016 00:14:52 -0800
Message-ID: <xmqqpov6puv7.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
	<xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
	<56DA896A.3050201@web.de>
	<xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
	<56DA986B.6040003@web.de>
	<xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 09:15:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acqJm-0000zg-D9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 09:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbcCGIO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 03:14:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958AbcCGIO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 03:14:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B78B043E59;
	Mon,  7 Mar 2016 03:14:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CoKgkaRfCaCHKQ2yxAjlDTtmpXU=; b=RaT5yq
	1ct59zoMJImVs3s9hZb+jCiYlYqo6GjN7Ftv8ck6hSUuAzr065wumnaM91l598cH
	SiqUX/oLRy6oDeuIzAOe8l7VTCrsiZR/BaFtimhY/rhJ/rq4XWSALGa6GRVLeFq6
	T52GR6XFSArczSqpNNOH8Zs5XKFxxsNpbfxus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnUdUYYIRJhMzVOc/qxjTwQu53zNxPoT
	RAG8nvZOA/WB4sQ16nAUAmIUc2C87rOw6p0Iub7xeuUGy4NoEuIDZgvt7e0DtFSa
	6BUr9na/QKvjwuu4Szr4nz98/dJluS+qdAOpa8mAr43UOM/qNW35rFdAUoq04Q/V
	OpXRM40z7uM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADE2343E58;
	Mon,  7 Mar 2016 03:14:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FEED43E56;
	Mon,  7 Mar 2016 03:14:54 -0500 (EST)
In-Reply-To: <xmqqr3fotyhu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 05 Mar 2016 13:18:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC2723F6-E43C-11E5-89F4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288382>

Junio C Hamano <gitster@pobox.com> writes:

> Besides, it is OK if your status and diff says your worktree is
> dirty immediately after cloning in such a broken situation, I would
> think.  In fact, it may even be preferable to do so, in order to
> indicate that there is something unusual going on.

The above needs a bit of clarifying follow-up.

Some operations (e.g. "apply --index" and "checkout another-branch")
want to make sure that the path in the working tree "matches" what
is in the index before proceeding.  The reason why they require a
match is because they are going to update what is in the index and
then update what is in the working tree to match the result by
checking the updated index entry out to the working tree--if the
working tree and the index are different before they start their
operation, that means you have some changes you made in the working
tree since you checked it out of the index, and their operation will
lose such changes.

Normally, this verification is done by ce_match_stat() and friends,
whose correct operation relies on an earlier refresh_index(), which
in turn makes sure that the result of running the contents in the
working tree through convert_to_git() matches what is in the index.

When your convert_to_working_tree() and convert_to_git() do not
round-trip, however, the result of convert_to_git() on the working
tree contents would not match what is in the index.  That is
inconvenient, and it is something you may want to relax to help such
a broken situation.  Immediately after you "git checkout" (or "git
reset --hard"), you haven't made any changes, and you should be able
to "git checkout another" to go to another branch.

For this reason, I am perfectly OK with an approach to teach the
callers that currently use ce_uptodate() as the only way to make
sure that there is no modification to a given path (and refuse to
work on it if ce_uptodate() says the path is modified) that it is
also OK to clobber a path that does not pass the ce_uptodate() check
as long as the result of running convert_to_working_tree() on the
indexed contents matches what is in the working tree.  These callers
are currently overly strict and you will be relaxing their overly
strict check to help this broken situation.

Perhaps we can introduce a new function can_clobber() that has the
same function signature as ce_uptodate() and update the callers in
apply and unpack-trees (there may be others) to call it instead when
they want to see if they can clobber the working tree file that
corresponds to the cache entry.

For implementing the can_clobber() function, you can use something
along the lines of compare_with_fd() helper function I introduced in
[1] and do something like this, perhaps.

When I send an illustration patch and say "totally untested", I
usually start from the real source file and send "git diff" output
after making changes to the source file, and I may even have at
least compiled the modified result.  The following however is typed
directly into my mail program without touching any existing source
file, so it is truly untested--caveat emptor.

/*
 * We are about to do some operation to the index entry, and
 * write the result out to the working tree.  Would we lose
 * some local change that exist only in the working tree by
 * doing so?  Return 1 if we can safely clobber the working
 * tree file (i.e. no changes) and return 0 if we can't (i.e.
 * there are some changes).
 */
int can_clobber(struct cache_entry *ce)
{
        int fd, match = 0;
        enum object_type type;
	unsigned long size;
        void *data;

        /*
         * Does another "git add -f" of the path result in the
         * identical blob in the index?  If so, the working tree
         * file is expendable.
         */
	if (ce_uptodate(ce))
        	return 1;
	fd = open(ce->name, O_RDONLY);
        if (fd < 0)
		return 0;

	data = read_sha1_file(ce->sha1, &type, &size);
	if (type == OBJ_BLOB) {
		struct strbuf worktree = STRBUF_INIT;
		/*
                 * Does another "git checkout -- path"
		 * recreate what we see in the working tree?
                 * If so, the working tree file is expendable.
                 */
		if (convert_to_working_tree(ce->name, data, size,
					    &worktree)) {
			free(data);
			data = strbuf_detach(&worktree, &size);
		}
		if (!compare_with_fd(data, size, fd))
			match = 1;
	}
	free(data);
	close(fd);

        return match;
}


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/284352/focus=285341
