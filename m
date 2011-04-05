From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 05 Apr 2011 10:34:26 -0700
Message-ID: <7v4o6cob4t.fsf@alter.siamese.dyndns.org>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Ma?= =?utf-8?Q?rt=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7A9R-0006AR-9h
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab1DEReo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 13:34:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1DERen convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 13:34:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CC0C3AE2;
	Tue,  5 Apr 2011 13:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mJcZVisxnTn0
	FidJcpzT6Ew1eSo=; b=YJy0QfLesxkS9GcfkN78QjMAvz1LnhFBKmOqug0P09ja
	jpZSmEDg931stHqlWgQO8GmsS0Jsx+Oj5COSPzigcoObE0tUKeD+f83/BT3OFAjH
	4VKlSOAIxKhH1QJx+RJ0zaDGGusL08nbsDyg6EQk7xhKaPCmtsKNGu+xGNHxpaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xgUT9U
	ecuU7AtrRRNB0d1wV9AIJGJ6VIvhdyGZEk1sNHGyMgz15ZCI3pXPqdnlRFwXxsDv
	IcOeCSJVY9f7++2V6eX+0rRj0VFnUzSTpy43S5OJA+z4WLqrNbFlZtPzfedUFHsa
	JzJwytAtsJpyapGyyE6ornnZaleKoYMR3BsO4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A33F3ADF;
	Tue,  5 Apr 2011 13:36:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F9BB3ADD; Tue,  5 Apr 2011
 13:36:21 -0400 (EDT)
In-Reply-To: <20110405154100.GC16031@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 5 Apr 2011 17:41:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BFCB43A-5FAB-11E0-B3CF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170892>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>  Say I have the following commits:
>
>     5154127 fixup! fixup! one
>     0d130d8 fixup! one
>     0869d30 one
>
> because I keep executing `git commit -a --fixup HEAD`. When I want to
> squash them all into 0869d30, I do `git rebase -i --autosquash
> 0869d30^` and I get
>
>     pick 0869d30 one
>     fixup 0d130d8 fixup! one
>     pick 5154127 fixup! fixup! one

The way Kevin's d3d7a42 (rebase: better rearranging of fixup!/squash!
lines with --autosquash, 2010-11-04) series works is to match "fixup!"
only with "pick"; a later "fixup!" never matches an earlier "fixup!" bu=
t a
"pick" can be matched against more than one "fixup!".

I think one way to make this work is to fix what Pat did in d71b8ba
(commit: --fixup option for use with rebase --autosquash, 2010-11-02).

Perhaps like this, but I'll leave additions of test scripts to t3415 to
others.

-- >8 --
Subject: commit --fixup: do not duplicate "fixup! " at the beginning

The "rebase -i" command can match more than one "fixup!" against a sing=
le
"pick" in the right order thanks to the earlier d3d7a42 (rebase: better
rearranging of fixup!/squash! lines with --autosquash, 2010-11-04), but=
 a
"fixup!" entry is never matched with another "fixup!" entry.

When creating a commit marked to fix up an earlier commit with --fixup,=
 we
can mark it to look for the original and fix that one up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 67757e9..b3c4d63 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -668,6 +668,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		ctx.output_encoding =3D get_commit_output_encoding();
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
+		while (!prefixcmp(sb.buf, "fixup! fixup!"))
+			strbuf_splice(&sb, 0, 7, "", 0);
 		hook_arg1 =3D "message";
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
