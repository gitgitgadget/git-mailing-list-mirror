Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D7F1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcHFUFY (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:05:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752020AbcHFUFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:05:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1FC32FC64;
	Sat,  6 Aug 2016 13:29:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suHmgErVVhMh/rNZwZsZif3Xxbo=; b=CdTI1J
	t2U/OwqfvJlVs+X/P7fJ/2/ii8VnESlSGAiKQgaPeXNNhcqZCM9KiuosXSnXqpDB
	2Z3c0a9pWRa5SSyk+y0F+OUuWfwy5UOd8SrALzXiNqw67tBbaWaYaKM9esUez75C
	Lt99kHeZXivZ4hQntdEH9QxVpud2QW83nWtMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NMtWcYhk3/9CIUtU7IKysyB0MEO5LI3I
	d3L6zJNfmJKOUFzhf/z1kd4lRu1ZIcTPXA1D0KBiy3EKRsayh+UU5MDFAtVlgliG
	ijAu19JE1tzDDvehc8WzwQ32MTdT6m66D5SZbHU/7LLfMHEOjDqiERKS7/SkAxD+
	2k3aNAxgOSQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A98102FC62;
	Sat,  6 Aug 2016 13:29:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 316462FC61;
	Sat,  6 Aug 2016 13:29:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jens.Lehmann@web.de, git@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160806012318.17968-1-sbeller@google.com>
Date:	Sat, 06 Aug 2016 10:29:43 -0700
In-Reply-To: <20160806012318.17968-1-sbeller@google.com> (Stefan Beller's
	message of "Fri, 5 Aug 2016 18:23:12 -0700")
Message-ID: <xmqqd1lliz5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DED776C-5BFB-11E6-B868-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  Some submodules in the referenced superproject may not be there, 
>  (they are just not initialized/cloned/checked out), which yields
>  an error for now.

Perhaps you can teach "git clone --reference" an new option
(--reference-if-able) to do this?  Then 

    When `--reference` is given together with `--recursive`,
    the reference repository is assumed to contain the submodules
    as well and the submodules are setup as alternates of the
    submodules in the given reference project.
 
in which "assumed" is a horrible wording (leave the reader
wondering: "so what happens to my data when the assumption does not
hold") can become a lot more reasonable

    When using --reference with --recursive, the --reference is used
    to specify a repository that has a copy of the superproject.  If
    that copy has submodules cloned for itself in its $GIT_DIR/modules,
    they are used as --reference when cloning submodules in the
    resulting clone.

and readers expectation would match with the reality.  Their
submodules would be cloned in a regular fashion if the central
mirror does not have it, and would take advantage of it if there is
already a clone.

Come to think of it, do we even need --super-reference?  "git clone
--reference --recursive" is a two step process, in that first the
superproject is cloned while creating objects/info/alternates, and
then submodules are cloned (via "update --init").  Can we make the
procedure to clone a submodule always look at the reference of the
superproject (i.e. objects/info/alternates) and try to borrow from
the place in it that corresponds to the submodule?  That way, not
just "git clone --reference --recursive" would take advantage of the
existing mirrors of submodules, a user who does this:

    $ git clone --reference $URL super
    $ cd super
    $ git submodule update --init ...

would be able to take advantage of the "what the mirror the
superproject uses already has" when cloning the submodules, no?
