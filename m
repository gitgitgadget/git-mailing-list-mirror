From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: fix detection of duplicate s-o-b
Date: Wed, 06 Apr 2016 07:57:01 -0700
Message-ID: <xmqqr3eizsxu.fsf@gitster.mtv.corp.google.com>
References: <20160312130844.GA25639@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, Willy Tarreau <w@1wt.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 16:57:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anotQ-0003ZW-8r
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 16:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbcDFO5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 10:57:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753299AbcDFO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 10:57:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0309952AA0;
	Wed,  6 Apr 2016 10:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzpcFeqS3AgZmg3WgdpHcheoKsE=; b=l2bWMr
	ylV/k1O+LZkSUrH4w2E6MgXqxct7u9m96kVUdVVuYMg5PU9EuH0aZ3sCG+bd16Sv
	DQ4K4NAJdKQ/xyiON4LbhG0nkF602knWVLyrTDg6VELeWmRTuAsw70SmNfDH3XHu
	sjvNybYTls7k3h+zvcx0vAHxTf0QV1cxDMibg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tlw3DcvA/pv9yTcIrwg+GHWIzWK8Ekoo
	qSepBQObrgPpc0A+CfnaJNdUciYgWGDprz30DyOb1Ftg7VLdJHhqTYvti/W2Mg27
	xyw/c27OqrxY663GsG302gnwo5gjYnRCY1Rg19txQy/fBYTE5MSpOxzksg18BHYh
	0ZUCuUYi+2A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED98552A9F;
	Wed,  6 Apr 2016 10:57:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5951C52A98;
	Wed,  6 Apr 2016 10:57:03 -0400 (EDT)
In-Reply-To: <20160312130844.GA25639@1wt.eu> (Willy Tarreau's message of "Sat,
	12 Mar 2016 14:08:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2A6F46A-FC07-11E5-A4E4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290841>

This seems to have been lost, perhaps because the top part that was
quite long didn't look like a patch submission message or something.

Git 1.7.12 is a quite ancient release and I wouldn't be surprised if
we made the behaviour change during the period leading to v2.6 on
purpose, but nothing immediately comes to mind.  Christian (as the
advocate for the trailer machinery) and Brandon ("git shortlog
sequencer.c" suggests you), can you take a look?

Willy Tarreau <w@1wt.eu> writes:

> Hi,
>
> after I upgraded my machine, I switched from git 1.7.12.2 to 2.6.4
> and experienced an annoying regression when dealing with stable
> kernel backports.
>
> I'm using a "dorelease" script which relies on git-cherry-pick's
> ability to properly detect duplicate s-o-b to ensure that all merged
> commits are properly signed in a release. Today while preparing the
> last 2.6.32 release, I did a git log before pushing and found some
> commits having two s-o-b lines with myself. I found that these ones
> were always those containing some backporting notes between the s-o-b
> lines (which we all do in stable branches to indicate what was changed
> in the backport process).
>
> I didn't feel brave enough to individually deal with each offending
> patch by hand so instead I bisected the git changes and found that the
> behaviour changed with commit bab4d10 ("sequencer.c: teach append_signoff
> how to detect duplicate s-o-b").
>
> The reason is that function has_conforming_footer() immediately stops
> after the first non-conforming line without checking if there are
> conforming lines after. But if someone added signed-off-by anywhere
> after a non-conforming block, it should always be considered as part
> of the footer. Thus I adjusted the logic to check till the end of the
> footer and report the presence of valid rfc2822 or cherry-picked lines
> after the last non-conformant one and now it correctly handles all types
> of commits I had to deal with (ie: only adds s-o-b when it doesn't match
> the last one and doesn't add an empty line after a conformant one). For
> example, this footer :
>
>     Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
>     [bwh: Backported to 3.2:
>      - Adjust numbering in the comment
>      - Adjust filename]
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Cc: Byungchul Park <byungchul.park@lge.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Willy Tarreau <w@1wt.eu>
>
> Used to be turned into this :
>
>     Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
>     [bwh: Backported to 3.2:
>      - Adjust numbering in the comment
>      - Adjust filename]
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Cc: Byungchul Park <byungchul.park@lge.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Willy Tarreau <w@1wt.eu>
>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> And is now properly converted to :
>
>     Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
>     [bwh: Backported to 3.2:
>      - Adjust numbering in the comment
>      - Adjust filename]
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Cc: Byungchul Park <byungchul.park@lge.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Willy Tarreau <w@1wt.eu>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> Also, cherry-picking the last commit above again would produce this
> before :
>
>     Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
>     [bwh: Backported to 3.2:
>      - Adjust numbering in the comment
>      - Adjust filename]
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     Cc: Byungchul Park <byungchul.park@lge.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Willy Tarreau <w@1wt.eu>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> And it now is properly left untouched since the last s-o-b line
> is properly matched.
>
> I'm appending the patch, please include it upstream.
>
> Thanks!
> Willy
>
>
> From be9624a0df4c649d452f898925953a81dc9163fc Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sat, 12 Mar 2016 13:35:35 +0100
> Subject: sequencer.c: fix detection of duplicate s-o-b
>
> Commit bab4d10 ("sequencer.c: teach append_signoff how to detect
> duplicate s-o-b") changed the method used to detect duplicate s-o-b,
> but it introduced a regression for a case where some non-compliant
> information are present in the footer. In maintenance branches, it's
> very common to add some elements after the signed-off and to add your
> s-o-b after. This is used a lot in the stable kernel series, for
> example this commit backported from 3.2 to 2.6.32 :
>
>     ALSA: usb-audio: avoid freeing umidi object twice
>
>     commit 07d86ca93db7e5cdf4743564d98292042ec21af7 upstream.
>
>     The 'umidi' object will be free'd on the error path by snd_usbmidi_free()
>     when tearing down the rawmidi interface. So we shouldn't try to free it
>     in snd_usbmidi_create() after having registered the rawmidi interface.
>
>     Found by KASAN.
>
>     Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>     Acked-by: Clemens Ladisch <clemens@ladisch.de>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     [wt: file is sound/midi/usbmidi.c in 2.6.32]
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> Prior to the commit above, a cherry-pick -s would not append an extra s-o-b.
> After this commit, a new line and a second s-o-b are added, making the footer
> look like this :
>
>     Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>     Acked-by: Clemens Ladisch <clemens@ladisch.de>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>     [wt: file is sound/midi/usbmidi.c in 2.6.32]
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> This patch improves the parsing of the footer by considering the
> presence of a valid rfc2822 line after possibly non-conformant lines.
> Indeed, if someone added an s-o-b or CC after some stuff, this line
> must properly be considered as part of the footer and not of the body.
>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  sequencer.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e66f2fe..ab2c18d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -64,6 +64,8 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	int len = sb->len - ignore_footer;
>  	const char *buf = sb->buf;
>  	int found_sob = 0;
> +	int found_valid = 0;
> +	int found_other = 0;
>  
>  	/* footer must end with newline */
>  	if (!len || buf[len - 1] != '\n')
> @@ -96,15 +98,18 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  		if (found_rfc2822 && sob &&
>  		    !strncmp(buf + i, sob->buf, sob->len))
>  			found_sob = k;
> -
> -		if (!(found_rfc2822 ||
> -		      is_cherry_picked_from_line(buf + i, k - i - 1)))
> -			return 0;
> +		else if (found_rfc2822 ||
> +			 is_cherry_picked_from_line(buf + i, k - i - 1))
> +			found_valid = k;
> +		else
> +			found_other = k;
>  	}
>  	if (found_sob == i)
>  		return 3;
> -	if (found_sob)
> +	if (found_sob > found_other)
>  		return 2;
> +	if (found_other > found_valid)
> +		return 0;
>  	return 1;
>  }
