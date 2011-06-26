From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use correct value when hinting strbuf_read()
Date: Sun, 26 Jun 2011 12:37:18 -0700
Message-ID: <7vzkl4z8nl.fsf@alter.siamese.dyndns.org>
References: <1308161318-25637-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QavE7-0001We-ER
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 21:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab1FZTjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 15:39:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab1FZThW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 15:37:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C629C542A;
	Sun, 26 Jun 2011 15:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AfwpCss2sH1D5UunVdNFm5nWqak=; b=CI5QOy
	G2ghqZsvrzyGnHBFwnEfgLvHEJgxChU/gY1DXKhuNk8yqXbWZgLxWp9/7zDApP1H
	vGAyyajmky/6Uxe4x3rhElU6ukXSNrtDfGzHNZSuTXnZGSSc4l3CVeC+m0ZDvhOn
	XCuysYlGecGWwFu6zJTHDOQKYeSz1cXUCpxZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1kwKdOcJlq4RYustdmV2VJoNEazH7mQ
	jXPs08qtjE/Zsqt8HG9e0mfb/hNFig5Mc1+6NSjCUpaR3+jPhVBtcCGdq3Dx7UoQ
	k7OyZSFy9wuoaLsHi9Y1q9Y3AvnKZT0TW/BV7ZD1VkcQspJfE5uvsePVa0QcEUuT
	yVSxrZaaSgw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD01F5429;
	Sun, 26 Jun 2011 15:39:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CADC5428; Sun, 26 Jun 2011
 15:39:32 -0400 (EDT)
In-Reply-To: <1308161318-25637-1-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Wed, 15 Jun 2011 20:08:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03A52E98-A02C-11E0-B11C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176329>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/submodule.c b/submodule.c
> index b6dec70..86baf42 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -326,7 +326,7 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
>  		cp.no_stdin = 1;
>  		cp.out = -1;
>  		cp.dir = path;
> -		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
> +		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
>  			is_present = 1;

The change is not incorrect per-se. If the original used 41 and a patch
tried to update it to 1024, we wouldn't accept such a patch, but on the
other hand, I do not think this patch would make much difference (any
value would do here as it is merely a hint, and if the patch does make a
difference, we would have a bigger problem, either by forking too often
with run_command(), or by leaking buf.buf every time we do so).

It however raises a more interesting question.

This function tries to see, even a commit object name, if it is fully
connected to any ref (IOW the tip of a branch or a tag). There are three
outcomes:

 - It is reachable from a ref, and we get nothing from the command;

 - It is not, and we get the commit object name back (and nothing else);

 - We get something unexpected. Perhaps an error found in the repository
   (strictly speaking I do not think we would catch this as we are not
   capturing stderr at all).

The first one is what this if() condition catches, but we do not tell the
second and the third apart. I wonder if we should.
