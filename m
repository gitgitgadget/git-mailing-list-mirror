From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Mon, 21 Feb 2011 15:32:57 -0800
Message-ID: <7vbp25hsk6.fsf@alter.siamese.dyndns.org>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
 <1298121481-7005-8-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfFn-0002VX-8i
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab1BUXdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:33:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab1BUXdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:33:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58B393FBC;
	Mon, 21 Feb 2011 18:34:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=x9UTGFwAjW8xeIyzjl9xMp09e4E=; b=WGoVQg62aO4zrGb3w4PUfQG
	yKl7qVKCgxncB5G/moooKsO6CqehOi1khti4liadFWUdGNOKfVT3dqUoZ9Yye8+q
	ZMbLB0iIXyBZqdcJsKmYPoRLnHYN3ybLMiBYtlcVoJ0+SHWWR8Ko+clMdQwbkJHE
	TnlH7wLNUirCHUy6R5nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=o6OYdfRmPqKSKRPnjxpQhVH16tyJvU4lIn/RkFl+zi+QrlN9F
	0C4udGLOHiBU2JWeZKnfUYmiJ26LjOFU61bs876iA5HaPRdbpdWzENclE+M7aD77
	trC9BWnU95o8BM+VGHLZHG3EInseE5k1zqsp51jkHwE+2w7+YEXqYchHZo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15C2A3FB8;
	Mon, 21 Feb 2011 18:34:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6715E3FB5; Mon, 21 Feb 2011
 18:34:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18ACE036-3E13-11E0-BDDF-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167510>

Pete Wyckoff <pw@padd.com> writes:

> There are four wildcard characters in p4.  Files with these
> characters can be added to p4 repos using the "-f" option.
> They are stored in %xx notation, and when checked out, p4
> converts them back to normal.
>
> This patch does the same thing when importing into git,
> converting the four special characters.  Without this change,
> the files appear with literal %xx in their names.
>
> Be careful not to produce "*" in filenames on windows.  That
> will fail.

> +    # P4 wildcards are not allowed in filenames.  P4 complains
> +    # if you simply add them, but you can force it with "-f", in
> +    # which case it translates them into %xx encoding internally.
> +    # Search for and fix just these four characters.  Do % last so
> +    # that fixing it does not inadvertently create new %-escapes.
> +    #
> +    def wildcard_decode(self, path):
> +        # Cannot have * in a filename in windows; untested as to
> +        # what p4 would do in such a case.
> +        if not self.isWindows:
> +            path = path.replace("%2A", "*")

I'll queue the patch as-is, but perhaps we can ask for help from people
who have access to P4 on both non-Windows and Windows to run a small test
to determine what happens in the native client?

 1. On a non-Windows client, add a path with '*' in it to the depot;
    perhaps "p4 add" might fail at this point, in which case we don't
    need to worry about this issue at all.
 
 2. Create a p4 client on Windows against that depot, and sync it; unless
    the previous step failed, we will see what happens (I would imagine it
    either dies or mangles the pathname and warns), so that we have
    something to emulate.

and then the quoted part can be further refined in a separate patch later.

Thanks.
