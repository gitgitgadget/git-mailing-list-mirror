Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC74C90
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lNbw8mv1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F404D327F4;
	Tue, 26 Dec 2023 16:35:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wtO+0l2AXoq2mW66BzX9tfo3id8JMSfn6h2np8
	tdjO0=; b=lNbw8mv1vl7IGSFXgIw2zwN/2hvbHRC6Em4Aco7lINEpUptyD6jycJ
	OBuHgs+v1RB37EoygTX6qZjgrcGANSCeV3uapc78+6h9L0PGSlOuMqUPVhBt7hGp
	TrT6qZwCIJ2WnVALi2eQvJkepEg5+1M+rYyP6VO4A4B8lKxvs6FM4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ED028327F3;
	Tue, 26 Dec 2023 16:35:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91C3D327F2;
	Tue, 26 Dec 2023 16:35:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <xmqqv88kfzpr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Dec 2023 12:58:24 -0800")
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
	<pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de>
	<xmqq4jg4j28z.fsf@gitster.g> <xmqqv88kfzpr.fsf@gitster.g>
Date: Tue, 26 Dec 2023 13:35:49 -0800
Message-ID: <xmqqcyusfxze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BDE4CFEA-A436-11EE-88BE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> As pointed out e.g. by t2016.3(git checkout -p), if the patch is to be
>>> applied in reverse (`git apply -R`), then the `old_mode` is actually 0,
>>> and we must use `new_mode` instead.
>>
>> Good finding.
>
> Hmph, this is puzzling and I spoke way before I understand why/how
> the fixup patch works X-<.
>
> The caller of check_preimage(), check_patch(), should happen only
> after reverse_patches() swapped old and new names and modes in
> apply_patch(), so at this point, we should be able to consistently
> use old_mode for checking, shouldn't we, even with "-R"?

I think I figured it out.  When we parse an incoming patch, unless
the patch is about changing the mode, we only fill old_mode (e.g.,
follow the callflow from gitdiff_index() -> gitdiff_oldmode() ->
parse_mode_line() to see how this is done).  In check_patch(), which
is the caller of check_preimage() in question, there are lines that
propagate old_mode to new_mode (because unfilled new_mode can come
only because there was no mode change), but that happens much later
after check_preimage() was called and returned.

I also suspect that this copying from old to new should be done much
earlier, after parse_chunk() finds out the (old)mode by calling
find_header(), and by doing so, you wouldn't have been hit by the
"-R makes old_mode 0" because both sides would be correctly filled
before we call reverse_patches() gets called.  But I haven't traced
all existing codepaths to see if such a change has unintended
consequences (e.g., somebody may incorrectly assuming that "old_mode
== new_mode == 100644" and "old_mode == 100644, new_mode == 0" mean
different things and acting differently).

In any case, I suspect that a better check is not about "are we
applying in reverse?", but more like the attached patch, i.e. if old
side is not filled, then we should pick up the other side.

 apply.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git c/apply.c w/apply.c
index 697ab2eb1f..5896056a69 100644
--- c/apply.c
+++ w/apply.c
@@ -3779,12 +3779,18 @@ static int check_preimage(struct apply_state *state,
 	}
 
 	if (!state->cached && !previous) {
-		if (!trust_executable_bit)
-			st_mode = *ce ? (*ce)->ce_mode :
-				(state->apply_in_reverse
-				 ? patch->new_mode : patch->old_mode);
-		else
+		if (!trust_executable_bit) {
+			if (*ce && !(*ce)->ce_mode)
+				BUG("ce_mode == 0 for path '%s'", old_name);
+			if (*ce)
+				st_mode = (*ce)->ce_mode;
+			else if (!patch->old_mode)
+				st_mode = patch->new_mode;
+			else
+				st_mode = patch->old_mode;
+		} else {
 			st_mode = ce_mode_from_stat(*ce, st->st_mode);
+		}
 	}
 
 	if (patch->is_new < 0)
