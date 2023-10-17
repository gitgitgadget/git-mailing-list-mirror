Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E722EB13
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="To3qHlMU"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F9C6
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:36:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0992F18D43;
	Tue, 17 Oct 2023 17:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4nf5VMdX5dHN+TmWKF3c+M3hKwQG/R2DmGScdW
	5S6AE=; b=To3qHlMUoqzzrc8l1RsmZ6k8HgJkZbIsk7Hj9P4+wsJLgH1rOkTq7P
	D+PpiObFeUSg1F6opfUiLTnhPZbvKzMHaiU6vWJkyB7aszWmydJ5XSy7BdMKTB5o
	1tGGbkC0pq+w16aXFfc40UxYMCmIRO+Yx8jH1McrNw4YctaS0zNhI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01ABF18D42;
	Tue, 17 Oct 2023 17:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7283918D33;
	Tue, 17 Oct 2023 17:36:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  Joanna Wang <jojwang@chromium.org>
Subject: Re: Supporting `git add -a <exclude submodules>`
In-Reply-To: <CAMmZTi-xOWxpzL1SvErgri0_gwvED5Vu2NfeGVcW7jCN8gyEDQ@mail.gmail.com>
	(Joanna Wang's message of "Tue, 17 Oct 2023 16:59:30 -0400")
References: <CAMmZTi-xOWxpzL1SvErgri0_gwvED5Vu2NfeGVcW7jCN8gyEDQ@mail.gmail.com>
Date: Tue, 17 Oct 2023 14:36:39 -0700
Message-ID: <xmqqo7gxx76g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42B424C0-6D35-11EE-93B8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Joanna Wang <jojwang@google.com> writes:

>> choose among attr:submodule, attr:type=<what>, attr:bits=<permbits>, decide what keyword to use

> Whatever we choose, do we want to block these keywords from being used
> by folks in their .gitattributes files?
> That would break any existing usage of the keywords. Is this a concern?

> Option A: To keep things working, we could add this support for attr,
> but then always prioritize whatever is set in .gitattributes. So this
> new behavior would only be triggered if the keywords (e.g.
> "submodule", "type", "bits") aren't set in .gitattributes (or w/e list
> of attributes are being read).

Without thinking things through, I think this sounds easier to
explain to the users.  I have to wonder how one would implement such
override, though.  Suppose we are doing attr:bits=160000, so we ask
git_check_attr() about "bits" attribute. In collect_some_attrs(), we
will have "bits" in the check[] array.  We prepare the attr_stack
and fill(), which would go grab whatever is defined in the
attributes system.  We'll lstat() or do the equivalent conversion
from the tree_entry.mode to permission bits only if the attributes
system has nothing to say for that "bits" attribute.  I think a few
key things that needs to be thought out are:

 (1) where in that callchain would we intercept and insert our own
     "bits" value based on the filesystem property?

 (2) does collect_some_attrs() or git_check_attr() leave enough
     information in check[] to tell between [a] the attr stack had
     no opinion on "bits" attribute and [b] the attr stack
     explicitly said "bits" attribute is unspecified?

