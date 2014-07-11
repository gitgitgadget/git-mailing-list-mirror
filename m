From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Fri, 11 Jul 2014 08:40:40 -0700
Message-ID: <xmqq7g3j6gzr.fsf@gitster.dls.corp.google.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	<1405038686-1138-3-git-send-email-dturner@twitter.com>
	<CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
	<xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5cwP-0005xK-AW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 17:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbaGKPkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 11:40:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59232 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbaGKPks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 11:40:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE94826FC1;
	Fri, 11 Jul 2014 11:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xRpnDqdlzJGwHTL9uuZ7atkUdb4=; b=PYOhPo
	uU8Koa1zV5mgD8q6/sdXPPaa1DZG41a00nJLLKAfprslo097NKMAld9XjSPhb7bJ
	vDwa4z394HHGfRJcXk8OIHIq43WxlCodmO+33xF02T9RzkBiPWZFP9XuKHIe3WlR
	CVkgjuxmz94reaKuSB3hk2bNogyAdJYSpoLfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wty68WxzE3OyWURXHIJdYGBqZtoeobUQ
	u1YjD++rgjnVIwU2gLsjClfjMTPfTB8Rlg8xz9rVz1zaqR/+5AcS1v9k6u/FfJx0
	xjbZ2kBrNKwcQtD9BFTvLJCB5YE+uJletapyQjSSwBNM8r6U35Jkia+DjHOt+t+W
	ROEH9CEmwT4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4DEC26FBD;
	Fri, 11 Jul 2014 11:40:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6134A26F9A;
	Fri, 11 Jul 2014 11:40:27 -0400 (EDT)
In-Reply-To: <xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 11 Jul 2014 08:27:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE77014C-0911-11E4-B1AF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253283>

Junio C Hamano <gitster@pobox.com> writes:

>>> +       sed -n -e "s/[0-9]* subtrees//" -e '/#(ref)/d' -e '/^invalid /p' >actual &&
>
> Is the second one to remove "#(ref)", which appears for a good
> "reference" cache tree entry shown for comparison, necessary?  Do
> they ever begin with "invalid"?  If they ever begin with "invalid"
> that itself may even be a noteworthy breakage to catch, no?

Answering to myself...

Because test-dump-cache-tree uses DRY_RUN to create only an in-core
copy of tree object, and we notice that the reference cache-tree
created in the tests contains the object name of a tree that does
not yet exist in the object database.  We get "invalid #(ref)" for
such node.

In the ideal world, I think whoever tries to compare two cache-trees
(i.e. test-dump-cache-tree) should *not* care, because we are merely
trying to show what the correct tree object name for the node would
be, but this is only for testing, so the best way forward would be
to:

 - Stop using DRY_RUN in test-dump-cache-tree.c;

 - Stop the code to support DRY_RUN from cache-tree.c (nobody but
   the test uses it); and

 - Drop the "-e '#(ref)/d'" from the above.

I would think.
