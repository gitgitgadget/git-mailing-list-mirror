Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80743450E7
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kCSRqsVG"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12A6F0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:02:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A27636E7C;
	Tue, 17 Oct 2023 12:02:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FIsai0J2kSTO
	BARw2r2TgsV0anGH5K212bb+79tPKRk=; b=kCSRqsVGlFQiOtCdE70MiO8f8MQa
	sKFrnQvxmnKQwwj+cSIu2+GRzLMVLbsY+3iVTHQjF1G0ohQTUdZRZIZT9gf17DIb
	8utixl1/jzA5RK3MRunQgEJ/Asq7uCaq1Rf6REm4c2uKZh2Ezw9Xp74QnJN/8hTj
	KDtS9/ARBnnHYWs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 325EE36E7B;
	Tue, 17 Oct 2023 12:02:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EF8036E7A;
	Tue, 17 Oct 2023 12:02:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Moritz Widmann" <widmann@tweaklab.org>,  git@vger.kernel.org
Subject: Re: Git Pathspec bug
In-Reply-To: <2c45e813-738a-480f-8c77-8c646df9c0e3@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 17 Oct 2023 12:51:00 +0200")
References: <7368e4ad-b05b-4b8f-a13b-0a68b442e72b@tweaklab.org>
	<2c45e813-738a-480f-8c77-8c646df9c0e3@app.fastmail.com>
Date: Tue, 17 Oct 2023 09:02:00 -0700
Message-ID: <xmqqwmvljkzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 82CB46BC-6D06-11EE-A806-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Tue, Oct 17, 2023, at 11:45, Moritz Widmann wrote:
>> I executed the following command in zsh (added `command` just to be su=
re=20
>> that there's no aliases or functions)
>>
>> command git submodule add=20
>> 'git@github.com:moritz-t-w/Godot-Onscreen-Keyboard.git' '.'
>> fatal: empty string is not a valid pathspec. please use . instead if y=
ou=20
>> meant to match all paths
>>
>> Git Version:=C2=A02.42.0
>>
>> OS: Arch Linux
>
> Is this the same issue?: https://stackoverflow.com/a/53441183/1725151

It does look so.

It is correct to reject such a request to attempt to add a submodule
as if it is overlayed at the same level as its superproject [*].
But the error message is totally bogus, I think.  It is not that the
pathspec the end-user gave us is wrong (the user does not even give
a pathspec in this case---the last one must be a concrete path in
the superproject where the newly added submodule is), and the user
should not be told anything about "valid" pathspec.

Patches welcome ;-)

Thanks.

[Footnote]

* Our submodules do not allow such a layout (and "git add foo" in
  such an environment would not know to which repository between the
  submodule or the superproject that new file "foo" should be added,
  which is just one example why such a layout is not usable).
