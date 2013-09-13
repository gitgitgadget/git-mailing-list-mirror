From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 15:16:34 -0700
Message-ID: <xmqqfvt8iczh.fsf@gitster.dls.corp.google.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
	<1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
	<xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
	<CAPig+cQxvHPbxy9YE7qYTVEXy1JCXkmBi48QrkL=bvhKRgryuQ@mail.gmail.com>
	<CAPc5daVtDByrA6yakk_1fq9g5Hv3naNDzEho5G4Ghxc6jzpawg@mail.gmail.com>
	<CAPig+cS4x1h3v2=0T95+g2_08_7qZj7fUsSiLgDtFyRSbFE0bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbfN-0006MX-P9
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3IMWQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:16:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302Ab3IMWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98204171E;
	Fri, 13 Sep 2013 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QJrOcb771dwJzw3Ph/OpGr3la6Q=; b=AfYBBk
	tQUURRKfXLKGXcqRJ8EpnQdCtFB4V32BF0tPRowp3pXGX6fwgVUv9toJsjc4+VOz
	SORxIBK3hiH+cUxrxFKJNiGwB0JMLtyXkh7+wpF9xEPHa9ALduTQVvaJp5hvPaon
	/8Pruny2JNT01MiszcSJq9XNRygR0z71zvXnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GA2us+SccFjbNPCa5BZ/STPVf5+KVt+s
	cPMhqXYGdjtdoXZc6ApBkIBrQ2775mQU0mFdNXg7RnJz+7OuEJb7jBULwZCJQzvS
	/9LmFoPk5fe7sHu6hO7NOFiE+nn59FCTAL0QA9pX4yKBB/qvxbPL841ZTcygBhtc
	EfBbUUWSQiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECEB4171D;
	Fri, 13 Sep 2013 22:16:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 279D541716;
	Fri, 13 Sep 2013 22:16:36 +0000 (UTC)
In-Reply-To: <CAPig+cS4x1h3v2=0T95+g2_08_7qZj7fUsSiLgDtFyRSbFE0bA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 13 Sep 2013 17:44:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 27699444-1CC2-11E3-8573-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234777>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Given the above. How should I proceed? Do you still feel that it is
> advisable to keep an index_name_exists() around for compatibility
> reasons in case any new callers are introduced? Regardless of that
> answer, do you want index_name_exists() renamed to
> index_file_exists()?

Renaming *_name_exists() to *_file_exists() without keeping a
compatibility one will force new topics to be rebased on this
series.  Alternatively we could merge them to 'pu' (and later 'next'
and 'master') with evil merges to adjust the change in the semantics
of the called function.  That increases the risk of accidental
breakages, I think.

It is safer to keep index_name_exists() around with the older
semantics, if we can, and rename your "file only" one to a different
name.  That way, even if a new topic still uses index_name_exists()
expecting the traditional behaviour, it will not break immediately
and we do not need to risk evil merges making mistakes.

Later, we can "git grep _name_exists" to spot them and convert such
old-style calls to either "directory only" or "file only" variants
after this series and these follow-on topics hit 'master' (and we do
not know at this point in what order that happens).

Hmm?
