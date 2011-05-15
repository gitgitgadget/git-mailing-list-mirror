From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] sh-setup: Make die take the error code as param.
Date: Sun, 15 May 2011 13:46:39 -0700
Message-ID: <7vzkmnofo0.fsf@alter.siamese.dyndns.org>
References: <cover.1305462132.git.iveqy@iveqy.com>
 <1f45f5634f08cb0f63d61d8b734a2cf7bebf591b.1305462132.git.iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLiHQ-00009A-KL
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab1EOUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:46:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab1EOUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:46:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79D7351D1;
	Sun, 15 May 2011 16:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GtG5vddLxuzEz8rDQXMi+GrX6ns=; b=euO9eK
	bGcv/EaFN6nG1y1XmHOB5rUIT2YZQh9L9PYx1+kHeIb/kuFkc/vsFqi1eEmzJPVx
	4sIB8BcOS7MyaXgEtej37iWn3U1Ar0+SOKAWrpF23qkW6O1a/4d23ArgBXbtkLkc
	vwEtT6pR5MazzMkr2SVCl03Gthws6/M2OWWLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NlartztDmWsmXvm6yx5pyBheiYIpXGqM
	Ce+JjHNc8LkNmjHsV6a0Jj1FANrWfBTDGeGKcqqeaqaL99k1/1u25nIxhYTVQWDq
	CNUyRvqsEaHYNplfkyWtPm/RUYNz1Q7zx0qkbZfCbPmZaXnzoxeudHJDFXpCXk3q
	m2Y9xJ4sAA0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3916151CD;
	Sun, 15 May 2011 16:48:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D64A051CC; Sun, 15 May 2011
 16:48:46 -0400 (EDT)
In-Reply-To: <1f45f5634f08cb0f63d61d8b734a2cf7bebf591b.1305462132.git.iveqy@iveqy.com>
 (Fredrik Gustafsson's message of "Sun, 15 May 2011 14:42:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDDA9AA0-7F34-11E0-A7D0-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173665>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> die used to print all parameters and then exit with code 1. Now die
> prints the first parameter and uses the optional second parameter as the
> exit code. The default exit code is 1.
>
> This allows scripts to control the exit code when they call die.
>
> All current git-code only uses the first parameter of die today so this
> change has no impact on them.

There are two issues in that logic.

The git-sh-setup API is a published interface that third-party Porcelains
can use, so it is insufficient to audit only the in-tree code.

Besides, your audit of in-tree code is insufficient. See output from this:

    $ git grep -A1 -n -e 'die .*\\$' -- '*.sh'

The hits in git-bisect.sh and git-rebase--merge.sh both pass two strings.

Can't you instead introduce a new "die_with_status" function and use it?
