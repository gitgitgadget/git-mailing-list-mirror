From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/8 v2] git_remote_helpers: fix input when running
 under Python 3
Date: Tue, 15 Jan 2013 12:51:13 -0800
Message-ID: <7vbocq2mri.fsf@alter.siamese.dyndns.org>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu> <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu> <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:51:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDTt-0003Ye-Iz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab3AOUvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 15:51:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab3AOUvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:51:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF17B178;
	Tue, 15 Jan 2013 15:51:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JJvMKt1/Jd1aP6x1U5zGcpKRJms=; b=ep+IHm
	DfSOfR61aleu6V96EFxti6Zw5HW9XimT1r+h7MoCO3gb4CwE4lsXerRXFZd/f1P7
	T1j/Mkz+jTzFH0/psG4xgx7em0G1bjmXzTHhUinpRDrSJOPBFsklaLrlEvS/bZNB
	YGcGXi6AC5FPpja7DTKLe1y0Sa2VwxfajRdZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ML+YDvYeOEwg7F0YKNpG/3kzesJUejDb
	FcOlQRERF9UJs6AtqMmJmpJ7T3QseUYHGoOAjQYcAl0AX3Wz4dkzvS+msM8EUBvQ
	TvVpMgLaQaODjMda3/BctyMh9c5HTck/27BvFO+HJj3jau1as3xB8z0tmpCYg4L1
	0qRokTniAsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F038B177;
	Tue, 15 Jan 2013 15:51:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D23B176; Tue, 15 Jan 2013
 15:51:15 -0500 (EST)
In-Reply-To: <20130115194809.GU4574@serenity.lan> (John Keeping's message of
 "Tue, 15 Jan 2013 19:48:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC64AFE-5F55-11E2-9FF8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213676>

John Keeping <john@keeping.me.uk> writes:

> Although 2to3 will fix most issues in Python 2 code to make it run under
> Python 3, it does not handle the new strict separation between byte
> strings and unicode strings.  There is one instance in
> git_remote_helpers where we are caught by this, which is when reading
> refs from "git for-each-ref".
>
> While we could fix this by explicitly handling refs as byte strings,
> this is merely punting the problem to users of the library since the
> same problem will be encountered as soon you want to display the ref
> name to a user.
>
> Instead of doing this, explicit decode the incoming byte string into a
> unicode string.

That really feels wrong.  Displaying is a separate issue and it is
the _right_ thing to punt the problem at the lower-level machinery
level.

> Following the lead of pygit2 (the Python bindings for
> libgit2 - see [1] and [2]),...

I do not think other people getting it wrong is not an excuse to
repeat the same mistake.

Is it really so cumbersome to handle byte strings as byte strings in
Python?
