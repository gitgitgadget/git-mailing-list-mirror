From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: implement '--follow' option for `git blame`
Date: Tue, 07 Apr 2015 19:48:36 -0700
Message-ID: <xmqqvbh7baij.fsf@gitster.dls.corp.google.com>
References: <4215491428322362@web26m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: KES <kes-kes@yandex.ua>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfg2l-00038S-In
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 04:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbDHCsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 22:48:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751522AbbDHCsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 22:48:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08F7F47F67;
	Tue,  7 Apr 2015 22:48:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q8zdKsec1GeDiIbvzhs1eUwKFRY=; b=fOmKUe
	4rxeWyY4aBr2ehMFSTdwmGQldwAzz74bsQvm6c60ydDD2+IuIUePd0IPx7jRO86D
	fITBOb5/XXaUz3pGP3QYvN31bNyKuYsA5yowfFfmPLk5PjOy27G8GEuN8fqZdE5N
	NSuiCbaLPmz5Xd2NQBcsdznCU93+As4/tGEu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TE19ic2dyLRzVPiiSNgOssWfLs9ToTzO
	3mVuc3m4mCe9DT5rskAJSvk6/JC+aRhEcQW86vPARVsdgHs01kx1V9ADTubinjAS
	8YyE2rKBwTtLI6Vpzy4edxc7AwApV7n7AcoLKsdNhojccWiNWOJYN8KpTdPjKz6U
	CdUgOj8plE0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0280147F66;
	Tue,  7 Apr 2015 22:48:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A1FF47F64;
	Tue,  7 Apr 2015 22:48:37 -0400 (EDT)
In-Reply-To: <4215491428322362@web26m.yandex.ru> (KES's message of "Mon, 06
	Apr 2015 15:12:42 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C18FCCDE-DD99-11E4-BD7B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266948>

KES <kes-kes@yandex.ua> writes:

> **UPDATE:** Short answer
>
> `git blame` follow renames but not for `git blame COMMIT^ -- <filename>`

Suppose you have file A and file B in your version v1.0.

Six month down the road, the code was much refactored, and you do
not need the contents of these two files separately.  You have
removed A and B and much of what they had is now in file C.  That is
the current state.

    git blame -C HEAD -- C

may follow the contents from both just fine, but if you _were_
allowed to say

    git blame v1.0 -- C

what does it even mean?  C did not exist v1.0 at all.  Are you
asking to follow the contents of A back then, or B?  How did you
tell you meant A and not B when you told it C in this command?

"git blame" follows content movements, and never treats "renames" in
any special way, as it is a stupid thing to do to think a rename is
somehow special ;-)

The way you tell what content to start digging from to the command
from its command line is to give starting point commit (defaults to
HEAD but you may give COMMIT^ as your example) and the path in that
starting point.  As it does not make any sense to tell C to Git and
then magically make it guess you meant A in some cases and B in some
other.  If v1.0 did not have C, the only sensible thing to do is to
exit instead of making a guess (and without telling the user how it
guessed).
