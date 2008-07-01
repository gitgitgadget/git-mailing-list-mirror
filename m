From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with
 "--root=<root>"
Date: Tue, 01 Jul 2008 02:21:55 -0700
Message-ID: <7vvdzqnemk.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807010043440.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDc58-0003rQ-5e
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbYGAJWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbYGAJWN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:22:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbYGAJWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:22:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F244F1DBB1;
	Tue,  1 Jul 2008 05:22:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A1AD1DBAE; Tue,  1 Jul 2008 05:22:03 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807010043440.9925@racer> (Johannes
 Schindelin's message of "Tue, 1 Jul 2008 00:44:47 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E8A6A80-474F-11DD-8409-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87013>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With "git apply --root=<root>", all file names in the patch are prepended
> with <root>.  If a "-p" value was given, the paths are stripped _before_
> prepending <root>.

> @@ -182,6 +182,10 @@ behavior:
>  	by inspecting the patch (e.g. after editing the patch without
>  	adjusting the hunk headers appropriately).
>  
> +--root=<root>::
> +	Prepend <root> to all filenames.  If a "-p" argument was passed, too,
> +	it is applied before prepending the new root.
> +

I looked for precedence of this concept outside git but did not find
anything that exactly matched.

The -p<num> came from patch where it is also called --strip=num.  This new
option --root is about the reverse operation and it is about inserting at
the beginning --- it is rerooting, in other words, but then --root is good
enough and shorter.  mkisofs uses the word "graft" when it allows tree
shifting (enabled with --graft-points), but the word "graft" means a
totally different thing to us, so we would not want to use that word.

I am not complaining (--root is fine by me), but just thinking aloud,
hoping somebody's brainwave is provoked while reading this babbling and
comes up with a better wording ;-).

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 9fcfe39..d56d913 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -58,6 +58,8 @@ static int whitespace_error;
> @@ -3240,6 +3252,18 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
>  			options |= RECOUNT;
>  			continue;
>  		}
> +		if (!strncmp(arg, "--root=", strlen("--root="))) {

prefixcmp()?

> +			arg += strlen("--root=");
> +			root_len = strlen(arg);
> +			if (root_len && arg[root_len + 1] != '/') {

Ah, being nice not to force trailing slash on users --- how unlike you ;-)
but I think you meant "arg[root_len - 1]" there...

Other than that, the change looks fine.  Thanks.
