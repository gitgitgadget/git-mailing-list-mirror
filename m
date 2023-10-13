Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B92EC6
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u/cECX7f"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE283
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:52:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F5681A86ED;
	Fri, 13 Oct 2023 14:52:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k6Ma6jeXtIbsGQ0/V8KP8mJ3q1XbyrrpWm+zy5
	4HkAM=; b=u/cECX7fVV8HWi0A6/wM15VnlzVlwLi0xbvpbc+ODV8k0wPAW+XFGb
	Tt3rNRwOy6pkT+QjRxt0ABWM7Fcn8Z6Xq2jaWh57iRSal1K8sqL2/RcD6JcsMB+R
	BZVDI5WHXuCnYxR5d+o81k9BI1lkgD8hS80OHViGWmiPUQYBSyHPk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 759AB1A86EC;
	Fri, 13 Oct 2023 14:52:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 968721A86EB;
	Fri, 13 Oct 2023 14:52:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Jonathan Tan
 <jonathantanmy@google.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 0/2] attr: add attr.tree config
In-Reply-To: <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Fri, 13 Oct 2023 17:39:28 +0000")
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
	<pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
Date: Fri, 13 Oct 2023 11:52:07 -0700
Message-ID: <xmqqmswmz76w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C5FCF9A-69F9-11EE-A026-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v4:
>
>  * removed superfluous test

An alternative would have been to point with the ref some non-tree
object like a blob, but as the outcome should be the same as missing
case (from the code --- which is not exactly kosher), it should be
OK.

	if (repo_get_oid_treeish(the_repository,
				 default_attr_source_tree_object_name,
				 attr_source) && !ignore_bad_attr_tree)
		die(_("bad --attr-source or GIT_ATTR_SOURCE"));

OOPS!  Sorry for not noticing earlier, but repo_get_oid_treeish()
does *NOT* error out when the discovered object is not a treeish, as
the suggested object type is merely supplied for disambiguation
purposes (e.g., with objects 012345 that is a tree and 012346 that
is a blob, you can still ask for treeish "01234" but if you ask for
an object "01234" it will fail).

So, the alternative test would have caught this bug, no?  Instead of
silently treating the non-treeish as an empty tree, we would have
died much later when the object supposedly a tree-ish turns out to
be a blob, or something?



