From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 14:11:20 -0700
Message-ID: <xmqqk38k1pmv.fsf@gitster.dls.corp.google.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
	<CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvYl1-00074m-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbaFMVL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 17:11:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51942 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaFMVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:11:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23314208BF;
	Fri, 13 Jun 2014 17:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lpbuRajw10urwS+FgxT0r0aC7+c=; b=wwt1v3
	IkTcIJz17zO+vkgK8TSpp3fHsxujDbRZFJOs5iTNKaKeWpOynSEhdxksjyL1FRZk
	K01jTjscrv0rLugL9RgnnePcYZf4UjMMsSnEiXfigVi9NlbFV++2lK4zwtrxwku8
	P0b7FKDw+zhh5YtyTpd1LxA1Yi6ot6IfhC+B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDAu1nXH+vsFDC1HwzYC5LDFVfMCRTBE
	oouCtSPx8msIse7SUtVosFqNfnb0q7ZMgnal+FwtLlAehtuBnjgzDWsXVnTjJCBN
	ouulFJf5ZLA5vz2W/A2GMDgRR4ZbDUBQwFSHxlUxFXR4n9BwVzgzADbJRICr7R3Q
	iZrxQzoxqsM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1882A208B8;
	Fri, 13 Jun 2014 17:11:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8D67208AF;
	Fri, 13 Jun 2014 17:11:21 -0400 (EDT)
In-Reply-To: <CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
	(Ronnie Sahlberg's message of "Fri, 13 Jun 2014 12:05:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4524B758-F33F-11E3-91E6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251636>

Ronnie Sahlberg <sahlberg@google.com> writes:

> ... The first
> backend will be the current files based structure but I also will add
> an optional backend using a TDB database.

I am assuming that as part of the transactions work, accesses to
reflogs will also have their own backends?

> You could then very easily create a new backend, say 'struct refs_be
> refs_files_case_insensitive' where the methods would just convert any
> refnames to/from a case insensitive encoding before invoking the
> default methods from the files backend.
> Perhaps something as simple as converting any upper case characters
> to/from '%xx' representation when accessing the actual files.

Hmm... that would work only when the new implementation of Git is
the only one that accesses the repository.  Other implementations
(e.g. Eclipse via egit, Gerrit via jgit, etc.)  peeking into the
same repository wouldn't know what to do with these encoded
refnames.
