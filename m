Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C81C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79029206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IuNBB/P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfL3UdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:33:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58098 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3UdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 15:33:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CA8F3B8E8;
        Mon, 30 Dec 2019 15:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d3VMYJ4k/oLVQ1NDqKWaIdFnVfo=; b=IuNBB/
        P/8ApEOEG3MgSG714osUrsCBi9/8CAzBzWD41UvUxbEARbbNJQQ4QcavRwWDThdQ
        dJ6gKmHYBLH/bONqFVhj34JpafMfR1bUUKikk2v5/sTiIEeZx7II9HlGJzLnvcUy
        qaKWr5u45EsHYbClc1fpNezrhCUK5skbpHZQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TiSjoXRqZUGNY4ZEyKilbc3Urf/C2EUN
        ZkO4FQ4YfCSu/dzsuEi36dZH51O5NrJN4z+HZyVp6un0zZwGDfeLc5JjLGDzi7Ye
        2SpkIYNOusKrcWTTAJ2SfhmKa7f7vf/ZJUEVcHet5zmLLnwjyfJz5zX8ZTez/h1C
        CopMNQ1XsI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 339333B8E6;
        Mon, 30 Dec 2019 15:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89F573B8E5;
        Mon, 30 Dec 2019 15:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matvore@google.com
Subject: Re: [PATCH] revision: allow missing promisor objects on CLI
References: <xmqqlfqxhzvu.fsf@gitster-ct.c.googlers.com>
        <20191230183801.28538-1-jonathantanmy@google.com>
Date:   Mon, 30 Dec 2019 12:33:00 -0800
In-Reply-To: <20191230183801.28538-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 30 Dec 2019 10:38:01 -0800")
Message-ID: <xmqq1rslh7ur.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92E9F5D8-2B43-11EA-9A3B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> >  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
>> >  	if (!object)
>> > -		return revs->ignore_missing ? 0 : -1;
>> > +		/*
>> > +		 * Either this object is missing and ignore_missing is true, or
>> > +		 * this object is a (missing) promisor object and
>> > +		 * exclude_promisor_objects is true.
>> 
>> I had to guess and dig where these assertions are coming from; we
>> should not force future readers of the code to.
>> 
>> At least this comment must say why these assertions hold.  Say
>> something like "get_reference() yields NULL on only such and such
>> cases" before concluding with "and in any of these cases, we can
>> safely ignore it because ...".
>
> OK, will do.
>
>> I think the two cases the comment covers are safe for this caller to
>> silently return 0.  Another case get_reference() yields NULL is when
>> oid_object_info() says it is a commit but it turns out that the
>> object is found by repo_parse_commit() to be a non-commit, isn't it?
>> I am not sure if it is safe for this caller to just return 0.  There
>> may be some other "unusual-but-not-fatal" cases where get_reference()
>> does not hit a die() but returns NULL.
>
> I don't think there is any other case where get_reference() yields NULL,
> at least where I based my patch (99c33bed56 ("Git 2.25-rc0",
> 2019-12-25)). Quoting the entire get_reference():
>
>> static struct object *get_reference(struct rev_info *revs, const char *name,
>>                                     const struct object_id *oid,
>>                                     unsigned int flags)
>> {
>>         struct object *object;
>> 
>>         /*
>>          * If the repository has commit graphs, repo_parse_commit() avoids
>>          * reading the object buffer, so use it whenever possible.
>>          */
>>         if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
>>                 struct commit *c = lookup_commit(revs->repo, oid);
>>                 if (!repo_parse_commit(revs->repo, c))
>>                         object = (struct object *) c;
>>                 else
>>                         object = NULL;

This is the case where oid must be COMMIT from oid_object_info()'s
point of view, but repo_parse_commit() finds it as a non-commit, and
object becomes NULL.  This is quite different from the normal lazy
clone case where exclude-promisor-objects etc. wants to cover, that
the object whose name is oid is truly missing because it can be
fetched later from elsewhere.  Instead, we have found that there is
an inconsistency in the data we have about the object, iow, a
possible corruption.

>>         if (!object) {
>>                 if (revs->ignore_missing)
>>                         return object;
>
> Return NULL (the value of object).
>
>>                 if (revs->exclude_promisor_objects && is_promisor_object(oid))
>>                         return NULL;
>
> Return NULL.
>
>>                 die("bad object %s", name);
>
> Die (so this function invocation never returns). In conclusion, if
> object is NULL at this point in time, get_reference() either returns
> NULL or dies.

And when !object, this does not die if

 - ignore-missing is in effect, or
 - exclude-promisor is in effect and this is a promisor object that
   is missing from the local repository.

and instead return NULL.

It just felt funny that the "we found something fishy about the
asked-for object" case is treated the same way for the purpose of
ignore-missing and exclude-promisor.  The asked-for objet is
certainly not missing (i.e. we know more than we want to know about
the object---some part of our database says it is a commit and some
other part says it is not).
