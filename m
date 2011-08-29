From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not require filters to consume stdin
Date: Mon, 29 Aug 2011 15:53:37 -0700
Message-ID: <7vobz74yoe.fsf@alter.siamese.dyndns.org>
References: <20110829203107.GA4946@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:53:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyAiC-0003QD-CF
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1H2Wxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 18:53:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab1H2Wxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 18:53:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B18765331;
	Mon, 29 Aug 2011 18:53:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wh0+as3lnQYh8gg2hUKMopiN4RQ=; b=eiH7dg
	A1szGJ7cy/lybmUcL5YE8Xn/IIPe+hYXQrB6eSe3oXS+jK6BroY79/t3RCuP+xQ4
	2DNR2jooGsReXG1+GzEzGlhnMHohBM6L3umvkSXWmz1gr+t/P7UzeIHrP55L+c0m
	v5N0JPF6LfmuJDtdw2qxIs20JY2PpZSYXJqf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUHwBIXxHDCIa7rPNZ6HR7Dp5p0g42Hk
	fN7G0qPw0MG/eY5dY4YLzE2BfEjI+8bJyvBbVa5eBLuqNPAI/fqKnkqrU6+zCURv
	E2zRNU9CDcggny5FRfJYN1ik2V2MiJlOVekUdARWTCQYueth098GDSU3F/AayAQk
	Zs0b0q/X0sU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96DB5330;
	Mon, 29 Aug 2011 18:53:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E127532F; Mon, 29 Aug 2011
 18:53:39 -0400 (EDT)
In-Reply-To: <20110829203107.GA4946@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 29 Aug 2011 16:31:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC513436-D291-11E0-9514-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180373>

Joey Hess <joey@kitenet.net> writes:

> There has been discussion before about using clean and smudge filters
> with %f to handle big files in git, with the file content stored outside
> git somewhere.  A simplistic clean filter for large files could look
> like this:
>
> #!/bin/sh
> file="$1"
> ln -f $file ~/.big/$file
> echo $file

Isn't this filter already broken if clean request is for a blob contents
that is different from what is on the filesystem?  The name %f is passed
to give the filter a _hint_ on what the path is about (so that the filter
can choose to work differently depending on the extension, for example),
but the data may or may not come from the filesystem, depending on what is
calling the filter, no?

Most notably, renormalize_buffer() would call convert_to_git() on a buffer
that is internal, possibly quite different from what is in the working
tree.
