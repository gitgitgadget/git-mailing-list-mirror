From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog-walk: don't segfault on non-commit sha1's in the reflog
Date: Wed, 30 Dec 2015 13:41:54 -0800
Message-ID: <xmqq1ta3ehr1.fsf@gitster.mtv.corp.google.com>
References: <20151230131914.GA27241@lanh> <20151230152245.GA30549@spirit>
	<xmqqege3eiqb.fsf@gitster.mtv.corp.google.com>
	<1451511208.9251.21.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:42:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOVN-0004ef-A8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbbL3Vl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:41:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbL3Vl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:41:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C99335C19;
	Wed, 30 Dec 2015 16:41:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pdRK1Z1rDd1k+bNQXFNAUh6brPw=; b=txr+QH
	jXJmlFYiUOK/LNWYfuNABvWzdKBk8cQy3ymb0ND9HGlzovslCvh3IwYRy+PBiueJ
	d4gooeQbSdZi6vriyju+whPA82/IOnD4pO2YO9/Mqo1cJT8C7zuwSEQABEL7tqwk
	Y6PX53j2i161lX783Xx5I32aBJQ4/6clWRQtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nNZeCfj5IzP4F50gFQLpToJ6Fz3LhXi7
	tBCBSM4k4UktOpcSfHSvRmQzhqwXyGWpoopyE+Grf7RPie28sj5YjdbTt61dhOVT
	ev+YWJ54ep1sHrrBwm1ewh4Ead77zjh2WknySvyz41gRDzs7IreRgyx6EGZQtOp6
	nX9e64eujBY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7439F35C18;
	Wed, 30 Dec 2015 16:41:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E169335C17;
	Wed, 30 Dec 2015 16:41:55 -0500 (EST)
In-Reply-To: <1451511208.9251.21.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Wed, 30 Dec 2015 22:33:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25A95412-AF3E-11E5-812E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283203>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On wo, 2015-12-30 at 13:20 -0800, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> 
>> > diff --git a/reflog-walk.c b/reflog-walk.c
>> > index 85b8a54..b85c8e8 100644
>> > --- a/reflog-walk.c
>> > +++ b/reflog-walk.c
>> > @@ -236,8 +236,8 @@ void fake_reflog_parent(struct reflog_walk_info
>> > *info, struct commit *commit)
>> >  	reflog = &commit_reflog->reflogs->items[commit_reflog
>> > ->recno];
>> >  	info->last_commit_reflog = commit_reflog;
>> >  	commit_reflog->recno--;
>> > -	commit_info->commit = (struct commit *)parse_object(reflog
>> > ->osha1);
>> > -	if (!commit_info->commit) {
>> > +	commit_info->commit = lookup_commit(reflog->osha1);
>> > +	if (!commit_info->commit || parse_commit(commit_info
>> > ->commit)) {
>> >  		commit->parents = NULL;
>> >  		return;
>> 
>> This looks somewhat roundabout and illogical.  The original was bad
>> because it blindly assumed reflgo->osha1 refers to a commit without
>> making sure that assumption holds.  Calling lookup_commit() blindly
>> is not much better, even though you are helped that the function
>> happens not to barf if the given object is not a commit.
>> 
>> Also this changes semantics, no?  Trace the original flow and think
>> what happens, when we see a commit object that cannot be parsed in
>> parse_commit_buffer().  parse_object() calls parse_object_buffer()
>> which in turn calls parse_commit_buffer() and the entire callchain
>> returns NULL.  commit_info->commit will become NULL in such a case.
>> 
>> With your code, lookup_commit() will store a non NULL in
>> commit_info->commit, and parse_commit() calls parse_commit_buffer()
>> and that would fail, so you clear commit->parents to NULL but fail
>> to set commit_info->commit to NULL.
>>
>> Why not keep the parse_object() as-is and make sure we error out
>> unless the result is a commit with a more explicit check, perhaps
>> like this, instead?
>
> lookup_commit actually returns NULL (via object_as_type) for objects
> that are not commits, so I don't think the above is true.

I think you did not read what you are responding to.  I was talking
about the error case where the object _is_ a commit (hence lookup
returns it), but parse_commit_buffer() does not like its contents.

> The code below also loses the diagnostic message about the object
> not being a commit.

Giving such a diagnostic message is a BUG.

A ref can legitimately point at any type of object (only refs under
refs/heads/, aka "branches", must point at commits), so you MUST NOT
complain about seeing a non-commit in a reflog in general.
