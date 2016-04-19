From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Tue, 19 Apr 2016 09:22:37 -0700
Message-ID: <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:22:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYQL-0000uY-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbcDSQWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:22:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932482AbcDSQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:22:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0BE9140A1;
	Tue, 19 Apr 2016 12:22:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qnmObmKDFWi6mMbRqeBBULCO50=; b=m0gyd9
	SG1uDn1fw8yNdf/IsBIxNQ8JZ9UwkNpuqDHengsxbzFwL9tXV8Zh1FxIRC6JxGjI
	SW43opM4sNBYZOSBAcGQE3A4PNeobt8xBmf1v2c2qjeDbHDdcJAex/y6Kacv/r8L
	GalCORCS6n0sx7O5ER6vtBYYuwfYNnVY7qlKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jb10bwHbm5IGtb18cDWfjdio64HrZyta
	Cam8XL5x4Do5K/bTZziIojLCSAYAuXJ1BCXe6PdahCbQ2QGO54tOHvoLvnxO7/O+
	VDppdhIJGLp3M/sfCb5/wqMRE5DTZWDIXUuQm3mjGdUrN3xPcEEgkBkVk8Nru0uy
	0hqvpWyWrOU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8A85140A0;
	Tue, 19 Apr 2016 12:22:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4489F1409E;
	Tue, 19 Apr 2016 12:22:38 -0400 (EDT)
In-Reply-To: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 19 Apr 2016 16:37:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEAB594C-064A-11E6-80A7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291877>

"git blame -L475,6 builtin/replace.c" points at b892bb45 (replace:
add --edit option, 2014-04-26) and the commit log message names two
people who can review this change, so that is what I am doing here.

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We simply need to read the config, is all.
>
> This fixes https://github.com/git-for-windows/git/issues/733
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/replace.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 748c6ca..02b13f6 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -475,6 +475,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		return replace_object(argv[0], argv[1], force);
>  
>  	case MODE_EDIT:
> +		git_config(git_default_config, NULL);
>  		if (argc != 1)
>  			usage_msg_opt("-e needs exactly one argument",
>  				      git_replace_usage, options);

The placement of git_config() makes me wonder why.

I can understand "we only know edit mode needs config, and we know
it will never affect other modes to have the new call here", and it
would be good for an emergency patch for ancient maintenance track
that will not get any other changes or enhancements.  I do not think
it is a sound reasoning to maintain the codefor the longer term,
though.
