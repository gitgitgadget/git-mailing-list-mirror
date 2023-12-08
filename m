Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bnL7ZwbE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD4122
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:54:59 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F82F1C73F;
	Fri,  8 Dec 2023 17:54:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vQrIalxt8dPx
	iHBvTaL5GxqySMEovO7sWqvVq/mBP0k=; b=bnL7ZwbEH7S65acuLkgYv7m49WpY
	DrOU3ciDRNXBGxQtRjSL3QQveoS0Oy1+89L8hSqSMn4nkjFvfh6gu74gcwQu9fyZ
	QDEdfzjnNnf3BMEetP8JazgNINPEGOoDG8YJqibInyF/9WktKEDK5MoubPI2gF27
	ZhR/036zZDASzo4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 57D0D1C73E;
	Fri,  8 Dec 2023 17:54:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 184FC1C73D;
	Fri,  8 Dec 2023 17:54:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] setup: extract function to create the refdb
In-Reply-To: <ZXFy0_T1AZLh058g@tanuki> (Patrick Steinhardt's message of "Thu,
	7 Dec 2023 08:22:59 +0100")
References: <cover.1701863960.git.ps@pks.im>
	<b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
	<CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com>
	<ZXFy0_T1AZLh058g@tanuki>
Date: Sat, 09 Dec 2023 07:54:52 +0900
Message-ID: <xmqq1qbw1f0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CD35B734-961C-11EE-922F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Dec 06, 2023 at 10:10:37PM +0100, Karthik Nayak wrote:
>> On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
>> > +static void create_reference_database(const char *initial_branch, i=
nt quiet)
>> > +{
>> > +       struct strbuf err =3D STRBUF_INIT;
>> > +       int reinit =3D is_reinit();
>> > +
>> > +       /*
>> > +        * We need to create a "refs" dir in any case so that older
>> > +        * versions of git can tell that this is a repository.
>> > +        */
>>=20
>> How does this work though, even if an earlier version of git can tell
>> that this is a repository, it still won't be able to read the reftable
>> backend. In that sense, what do we achieve here?
>
> This is a good question, and there is related ongoing discussion about
> this topic in the thread starting at [1]. There are a few benefits to
> letting clients discover such repos even if they don't understand the
> new reference backend format:
>
>   - They know to stop walking up the parent-directory chain. Otherwise =
a
>     client might end up detecting a Git repository in the parent dir.
>
>   - The user gets a proper error message why the repository cannot be
>     accessed. Instead of failing to detect the repository altogether we
>     instead say that we don't understand the "extensions.refFormat"
>     extension.

Yup, both are very good reasons.  Would it help to sneak a condensed
version of it in the in-code comment, perhaps?
