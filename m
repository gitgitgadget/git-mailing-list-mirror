From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 10:06:17 -0700
Message-ID: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
References: <17231378818848@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tvangeste <i.4m.l33t@yandex.ru>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJROU-000824-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab3IJRGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:06:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab3IJRGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:06:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A0D4086E;
	Tue, 10 Sep 2013 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KaOUxO2P0kA7Slo7hJScJ6kkI0I=; b=DIIyQ/
	jTjbpXIOgkFPQgH8UXhnlTZb8CFQVN3ZC2bkwHPjSnUeLbqUOXO6Y7PeC8dSaIY3
	yN0pr+iTVmOrbsk4/u5a0ekrIm/Ye/u4jmxTHxVjxf49tjTZu6V36drCm5DbnOrT
	ZnddtQDYsXqvKakzVCNXH2hCgGcFVEtYqw46Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0T3P91nuhV00OCZJnkmM04fw2jgcuqc
	kNHT0yNWuWt9EqfZAH+u95TJz2jAqoba55HCDzn8d1GBnGsKYmjHMxrzVwUScS3Y
	orXf3nFNerrk1/H+A/GhrQ7v70GJWzT0VVn5dCKKNN9HqWiIkRRKAMqPss0fWbTb
	1mDFzY0jdaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5561F4086D;
	Tue, 10 Sep 2013 17:06:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E614A40867;
	Tue, 10 Sep 2013 17:06:19 +0000 (UTC)
In-Reply-To: <17231378818848@web5m.yandex.ru> (Tvangeste's message of "Tue, 10
	Sep 2013 15:14:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5017CB7E-1A3B-11E3-98D7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234446>

Tvangeste <i.4m.l33t@yandex.ru> writes:

> Hi,
>
> After bisecting this problem I ended up with the mentioned commit that completely breaks git-svn for me on Windows (mingw/msys version).
>
> ==========
> #> git svn rebase
> warning: unable to access '': Invalid argument
> warning: unable to access '': Invalid argument
> fatal: unable to access '../../../../w:/work/my/repo.git/.git/config': Invalid argument
> fatal: index file open failed: Invalid argument
> Cannot rebase: You have unstaged changes.
> Please commit or stash them.
> rebase refs/remotes/trunk: command returned error: 1
> ==========
>
> Please note that I use the official git repository as-is, this one (no additional patches):
> git://git.kernel.org/pub/scm/git/git.git
>
> e02ca72f70ed8f0268a81f72cb3230c72e538e77 is the first bad commit
> commit e02ca72f70ed8f0268a81f72cb3230c72e538e77
> Author: Jiang Xin
> Date:   Tue Jun 25 23:53:43 2013 +0800
>
>     path.c: refactor relative_path(), not only strip prefix
>
> Thanks,
>   --Tvangeste

The suspect commit and symptom look consistent.  You started from a
directory whose absolute path is "w:/work/..." and the updated code
mistakenly thoguht that something that begins with "w" (not '/') is
not an absolute, so added a series of ../ to make it relative, or
something silly like that.

Jiang?
