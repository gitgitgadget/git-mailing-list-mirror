Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995626293
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q8LPOLpp"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0471BE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:31:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A21951A978;
	Fri, 13 Oct 2023 16:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8og6hdUrkcu6Io1IRlUmo3vpAvUwUmUC3os8RZ
	TBcBk=; b=Q8LPOLppI2RklEoJSqJ2MhRY/ALELS3ayGFzQNe+eh1DWAyUAHf5B+
	YFp+iLX907hlGTH1fUGJWxrPTP58SqfIS9xlVCBeiQewA1VO0YIulAhzedemcRs6
	J1MhafrdOSjr/5bUz275p4mmBUpuek1ouz/YJ0UV1y2uIVeGzWJmY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 99AFD1A977;
	Fri, 13 Oct 2023 16:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C505F1A976;
	Fri, 13 Oct 2023 16:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Jonathan Tan
 <jonathantanmy@google.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 0/2] attr: add attr.tree config
In-Reply-To: <xmqqmswmz76w.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Oct 2023 11:52:07 -0700")
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
	<pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
	<xmqqmswmz76w.fsf@gitster.g>
Date: Fri, 13 Oct 2023 13:31:19 -0700
Message-ID: <xmqqa5smz2lk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78277282-6A07-11EE-BAAC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Junio C Hamano <gitster@pobox.com> writes:

> 	if (repo_get_oid_treeish(the_repository,
> 				 default_attr_source_tree_object_name,
> 				 attr_source) && !ignore_bad_attr_tree)
> 		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
>
> OOPS!  Sorry for not noticing earlier, but repo_get_oid_treeish()
> does *NOT* error out when the discovered object is not a treeish, as
> the suggested object type is merely supplied for disambiguation
> purposes (e.g., with objects 012345 that is a tree and 012346 that
> is a blob, you can still ask for treeish "01234" but if you ask for
> an object "01234" it will fail).
>
> So, the alternative test would have caught this bug, no?  Instead of
> silently treating the non-treeish as an empty tree, we would have
> died much later when the object supposedly a tree-ish turns out to
> be a blob, or something?

There indeed is a bug, but not really.  If we add this test:

test_expect_success 'attr.tree that points at a non-treeish' '
	test_when_finished rm -rf empty &&
	git init empty &&
	(
		cd empty &&
		echo "f/path: test: unspecified" >expect &&
		H=$(git hash-object -t blob --stdin -w </dev/null) &&
		git -c attr.tree=$H check-attr test -- f/path >actual 2>err &&
		test_must_be_empty err &&
		test_cmp expect actual
	)
'

repo_get_oid_treeish() returns a blob object name and we end up
storing a blob object name in "attr_source" static variable of
default_attr_source() function.

Later this is fed to read_attr() by bootstrap_attr_stack() and then
to read_attr_from_blob() that uses it to call get_tree_entry(),
which fails for any path because it is a blob.  We do not give any
errors or error messages during the whole process.

So in a sense, for !!ignore_bad_attr_tree case, the code ends up
doing the right thing.  But if !ignore_bad_attr_tree is true, i.e.,
a blob object name is given via --attr-source or GIT_ATTR_SOURCE,
then the bug will be uncovered.

 t/t0003-attributes.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
index ecf43ab545..0f02f22171 100755
--- c/t/t0003-attributes.sh
+++ w/t/t0003-attributes.sh
@@ -394,6 +394,18 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success '--attr-source that points at a non-treeish' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "$bad_attr_source_err" >expect_err &&
+		H=$(git hash-object -t blob --stdin -w </dev/null) &&
+		test_must_fail git --attr-source=$H check-attr test -- f/path 2>err &&
+		test_cmp expect_err err
+	)
+'
+
 test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
 	test_when_finished rm -rf empty &&
 	git init empty &&

