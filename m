From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show and the --quiet option
Date: Sat, 28 May 2011 12:17:40 -0700
Message-ID: <7vhb8eprcb.fsf@alter.siamese.dyndns.org>
References: <4DE12888.1040506@isy.liu.se>
 <20110528172611.GB28708@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat May 28 21:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQP1H-0001VY-VO
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab1E1TRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 15:17:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab1E1TRu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2011 15:17:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F73F4B9B;
	Sat, 28 May 2011 15:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kWpwCgs6b612
	PS+XyN0v8SJQbmE=; b=U3E60XjDZTkXzTxXCl5Y/cDj1DC7QDrljHowSoQkp1SX
	E6HTArfKpU6C7CZtmvCM2VeU/GodeLjRIX/yErLpmfbkHEtSrigtBw0GiLxbBMBg
	5EE+TxsNJpUgPRhri3AxkqoaBAbxki2jwfQLGE5LjQshiKnVdcRirnZla+dWrLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WVmX57
	JYzIDcW2YJXKORM34rbkFmvktFf4Rnt+NafSzGLII1Foh0bYfZ8WiRXoagEickHj
	/xYywHaTT9o6bhP/Ff8J9i0jw5zGkGmKNpAIbrot3eDH45Xf+apsAFWfL2gMpInK
	/FCy9zquHHxm8LKeEWAvqy1opgEPnaTTJOvkA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F2DF4B91;
	Sat, 28 May 2011 15:19:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4DEC74B90; Sat, 28 May 2011
 15:19:50 -0400 (EDT)
In-Reply-To: <20110528172611.GB28708@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 28 May 2011 19:26:11
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77A190FE-895F-11E0-B980-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174672>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> 1c40c36b ("log: convert to parse-options").  Was this intentional?
>
> Very much so.
>> ...
> The long answer is that the log family (and git-format-patch, which
> is where this started) never actually accepted --quiet, so it would
> get passed down to the diff machinery. This (for complicated reasons
> I'm not sure I comletely understand, but that have to do with the
> internal handling of 'quiet' as 'quick') caused every second commit
> not to show.

Yes, "git format-patch" that gives empty patch for every other commit
would have been incorrect, but "--quiet" to squelch patch output,
especially in the context of "show" whose default is to show patch, is
something people would naturally expect, even though admittedly it was
doing so by accident.

How does this patch look?

It does not fix "git show master~10 master^..master", but instead of ju=
st
hijacking and ignoring the --quiet option like your patch did, it actua=
lly
flips the option the user wanted to affect from the command line.

 builtin/log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 27849dc..224b167 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -107,6 +107,8 @@ static void cmd_log_init_finish(int argc, const cha=
r **argv, const char *prefix,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
 	argc =3D setup_revisions(argc, argv, rev, opt);
+	if (quiet)
+		rev->diffopt.output_format |=3D DIFF_FORMAT_NO_OUTPUT;
=20
 	/* Any arguments at this point are not recognized */
 	if (argc > 1)
