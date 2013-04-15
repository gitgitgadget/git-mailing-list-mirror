From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/14] dir.c: unify is_excluded and is_path_excluded
 APIs
Date: Mon, 15 Apr 2013 14:35:36 -0700
Message-ID: <7vwqs3pjdj.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
 <516C510E.5000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 23:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URr3w-00066a-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3DOVfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:35:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab3DOVfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:35:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3D61640F;
	Mon, 15 Apr 2013 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c3KmND0H6hOhkez6mLmeCn6dWKs=; b=rzJUX7
	p8BehD12YPtY4yTD/26Gi0kPIjiNAGh+PgsT7G9G3jX2qlJu9X8N6Y0cFwFKVaV3
	0QaZ4omDVZlFoWHyyaScaCXdCcWFlaY6kl75enpVq1gngOJGvwgFNS+mUJ+y/sK9
	8rv3gaqCnOuut7d6ZuCbVUy5K3waIm+30qPJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YYqWcX06/qXcAeXJ5IPK6Oqeb5j5dQDZ
	OOKlgiCdEfowpQbnG3s5MDPTkOzM2KCtq7PkN273Opmik0oTyJLCFyGDjTtqVrI7
	Me76GB1eRkBdmN8Y/3NZntUk7lvMAAAX62NEcBqq+VE73OK9GK4vHTCdiSMiKfXn
	yB9U0kECBmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22DD1640E;
	Mon, 15 Apr 2013 21:35:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63C311640D; Mon, 15 Apr
 2013 21:35:38 +0000 (UTC)
In-Reply-To: <516C510E.5000606@gmail.com> (Karsten Blees's message of "Mon,
 15 Apr 2013 21:12:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A248AA2-A614-11E2-BE93-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221318>

Karsten Blees <karsten.blees@gmail.com> writes:

> is_excluded doesn't handle ignored directories, results for paths within
> ignored directories are incorrect. This is probably based on the premise
> that recursive directory scans should stop at ignored directories,...

Correct.  Long time ago, we used to have strange rules in a case
like this:

	.gitignore has "d/" to exclude it;
        d/.gitignore says "!f" to cause d/f included.

and when you ask about d/f, we would say "d/ is ignored, so we
wouldn't even bother checking and declare it ignored", while asked
about "f" from within "d/" by first chdir'ing to it, we said "the
fact that you are inside d/ alone means you are interested in
looking at its contents, and checking d/.gitignore tells us that you
are interested in f". "recursion stops at ignored paths" mattered
back then.

I think we consistently honors higher level .gitignore files these
days.

> Teach is_excluded / prep_exclude about ignored directories: whenever
> entering a new directory, first check if the entire directory is excluded.
> Remember the excluded state in dir_struct. Don't traverse into already
> ignored directories (i.e. don't read irrelevant .gitignore files).
> ...
> Here's some performance data from the linux and WebKit repos (best of 10
> runs on a Debian Linux on SSD, core.preloadIndex=true):
>
>        | ls-files -ci   |    status      | status --ignored
>        | linux | WebKit | linux | WebKit | linux | WebKit
> -------+-------+--------+-------+--------+-------+---------
> before | 0.506 |  6.539 | 0.212 |  1.555 | 0.323 |  2.541
> after  | 0.080 |  1.191 | 0.218 |  1.583 | 0.321 |  2.579
> gain   | 6.325 |  5.490 | 0.972 |  0.982 | 1.006 |  0.985

Nice.
