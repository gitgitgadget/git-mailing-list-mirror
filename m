From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 09 Apr 2013 10:31:25 -0700
Message-ID: <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Nguy=E1=BB=85n?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcOQ-0003fC-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765592Ab3DIRba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:31:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765519Ab3DIRb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:31:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55CC11A4D;
	Tue,  9 Apr 2013 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArxLTKN2w6HRDsVIzMPJEsEw9dA=; b=KzOKRh
	sXRVElsO8ujaRVOFH8dK9qv0/seFEzPpOAMJPpCubonS6PY+EB3VFS/q3pF7TW3Q
	WgImsK3sOT/SCmhWoJ1Drx5U4J2GEMlUbGY5cZp4CO24lsKVJHljqiRxeePQj8R1
	PCOnZyiuEq2R3tGQ5UmeI15BxG2HlvHrKHVnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QstTB6gXNgsZNhKedZUzGbWTfTFGIIfD
	PYMdBf/1NsZVn3sj+DLcCr5BbMoPKlA6yWybdi/vmcolN1jgb9uK9f+6M1zb8P1a
	f3hxWhqf4p/RwVqNGOBZGdH7cUNK+vxie9iRG7ySAfHXdip2/kvzeiaBTtdsTB8h
	xM7+sQ6YIZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD27211A4C;
	Tue,  9 Apr 2013 17:31:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F41411A46; Tue,  9 Apr
 2013 17:31:27 +0000 (UTC)
In-Reply-To: <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 17:14:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EC76E92-A13B-11E2-9980-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220592>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jeff King wrote:
>> So you would need some heuristics based on whether something was a valid
>> refspec, or could be a valid remote name or URL.
>
> All refspecs conform to a very simple format:
>
>     quux
>     +quux
>     quux:baz
>     +quux:baz
>
> All of them fail at git_connect().  The third and fourth are
> equivalent and take a little longer to fail than the first two,
> because ssh tries to resolve the hostname "quux" or "+quux".

host:foo/bar (take my "host" branch, push it to their "foo/bar"
branch) could be tricky, no?  It could be trying to go over the ssh
to "host" and access repository at $HOME/foo/bar.  The git_connect()
call may even succeed and you cannot use the failure as a hint to
disambiguate.

Also the request may genuinely be to access foo/bar repository at
the host, but the network layer had trouble connecting temporarily
to the host.  After disambiguating incorrectly to push to the
origin, mapping our host branch to their foo/bar branch, that push
might even succeed.
