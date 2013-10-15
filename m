From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Tue, 15 Oct 2013 15:55:36 -0700
Message-ID: <xmqq4n8ib0uv.fsf@gitster.dls.corp.google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:55:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDWj-0007Bx-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914Ab3JOWzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:55:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933597Ab3JOWzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:55:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D42934B40C;
	Tue, 15 Oct 2013 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oZsn2ch5SRC5f0FQ7jAyWpc28sA=; b=mQ9Mt/HYZ/HWJiuQoWP0
	vVoxPHrKGXdwV0704G/REvdIfcVz/T+Rg+OIbZG8ZU9yhKpIrUXbH8qM0eM5J4ic
	z2VhISuOQ3+7cPcIi6nVw6ywBeNZTgdf/f/eGIBngeVRc4oUXQRE13CP37Xp7hbc
	vrV8qHlVV/JbzFO3TyavGCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RzLbQ9BbNHrtp2RoEoJtqm/nfP+ByJZjylyVwMc/TK6i/R
	n18wtNmZwAxBgJivgdnafBmt/Qrti/TVkeVeZ+MQ8hsbpghPt8xEUjGySAiWCkMK
	n9WsYzs7foCfP71Q9AGPuI2cXwPieZJgK3XoLksE9VTUCKkWjdBXSpKFRhjTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DFF4B40B;
	Tue, 15 Oct 2013 22:55:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 309874B409;
	Tue, 15 Oct 2013 22:55:38 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E8980A68-35EC-11E3-A3D7-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236214>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> git rev-parse --parseopt does not allow us to see the difference
> between an option with an optional argument starting with a dash, and an
> option with an unset optional argument followed by an other option.
>
> If I use this script :
>
>   $ cat /tmp/opt.sh
>   #!/bin/sh
>   OPTIONS_SPEC="\
>   git [options]
>   --
>   q,quiet         be quiet
>   S,gpg-sign?     GPG-sign commit"
>   echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"
>
> Then the following two commands give us the same result :
>
>   $ /tmp/opt.sh -S -q
>   set -- -S -q --
>   $ /tmp/opt.sh -S-q
>   set -- -S '-q' --
>
> We cannot know if '-q' is an argument to '-S' or a new option.
>
> With this patch, rev-parse --parseopt will always give an argument to
> optional options, as an empty string if the argument is unset.
>
> The same two commands now give us :
>
>   $ /tmp/opt.sh -S -q
>   set -- -S '' -q --
>   $ /tmp/opt.sh -S-q
>   set -- -S '-q' --

Two are different, but the former "set -- -S '' -q --" is not what
you want, either, no?  -S with an explicit empty argument and -S
alone without argument may mean two totally different things, which
is the whole point of "option with an optional parameter".  If some
code that have been using "rev-parse --parseopt" was happy with

	$ /tmp/opt.sh -S
        set -- -S --

and then your updated version gave it this instead:

	$ /tmp/opt.sh -S
        set -- -S '' --

wouldn't it be a regression to them?
