From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Re: git-am: fix maildir support regression: accept
 email file as patch
Date: Wed, 15 Jul 2009 19:41:31 -0700
Message-ID: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org> <20090716004952.GB12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGuu-0007iu-3R
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757212AbZGPCli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757184AbZGPCli
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:41:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210AbZGPClh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:41:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6935672B8;
	Wed, 15 Jul 2009 22:41:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D31C972B6; Wed, 15 Jul 2009
 22:41:32 -0400 (EDT)
In-Reply-To: <20090716004952.GB12971@vidovic> (Nicolas Sebrecht's message of
 "Thu\, 16 Jul 2009 02\:49\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2EFACE18-71B2-11DE-A175-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123357>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> I don't see the reason to have the option -v. It's only related to
> what's printed to output and doesn't change the exit status which
> tell us if an expression has matched.
>
> This gives:
>
>    grep -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null &&
>    patch_format=mbox

That grep says "if you see a single line that matches the pattern, even if
all the other lines are garbage, report it as a match".

See "something like this" patch in my other message. It filters the entire
header to make sure there is no line that does not match (that is what -v
is about), and make it report success when there is even a signle line
that does not.

    $ (echo yes; echo no) | grep -v -e yes ; echo $?
    no
    0
    $ (echo yes; echo yes) | grep -v -e yes ; echo $?
    1

That is why I wrote the "how about this" patch with "||" like this:

    grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
    patch_format=mbox

If everything is header, grep says "nothing matches", and patch_format
is set to mbox.
