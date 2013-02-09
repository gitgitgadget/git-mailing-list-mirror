From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Feb 2013 18:37:24 -0800
Message-ID: <7vwquiw6u3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <CACsJy8DW=tkEy2iOAZxQ+ZyVQ+L11JsPcSxrES5YY7gECmX7UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U40K7-0003AZ-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 03:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565Ab3BICh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 21:37:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760527Ab3BICh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 21:37:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A8B2B06B;
	Fri,  8 Feb 2013 21:37:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MOtTWghgAVQy+Cj5BcLKr22zM54=; b=KE5JOb
	zukFJOUCN/Ln1D0/i3TKcJqrrOljfaN4hmZgVzTcpRvH4DuXofLHtqsO4bVhfao5
	Ev8PZzp/XFyUUYIkTtANGPoExpTOc8M9pk2U8AIQz9jr3+bJKAFpriHT0cH5PGxT
	Smx88KIRiXBsRJSVvZuGI7l2Mjb6DqedLSm2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xYMOhT10XqdR74GbeCwmjN5D0CDexVgP
	eiarbnFafmTbx3/SZIYqVGsIShlqnrO/ctsnpXsXWTCU8icxkNiNdqe4kNFwbz8R
	tHQHL/0t4j2N/VGlD/h6CIJHM8nn9OcUqwtC+28vNgmfD8ySaOeMPRZpkblRaakt
	5jhMQwnzXw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED71B06A;
	Fri,  8 Feb 2013 21:37:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FEFFB065; Fri,  8 Feb 2013
 21:37:26 -0500 (EST)
In-Reply-To: <CACsJy8DW=tkEy2iOAZxQ+ZyVQ+L11JsPcSxrES5YY7gECmX7UQ@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 9 Feb 2013 09:10:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4314B90-7261-11E2-ABD1-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215847>

Duy Nguyen <pclouds@gmail.com> writes:

> Can we replace "open a socket to our daemon" with "open a special file
> in .git to get stat data written by our daemon"? TCP/IP socket means
> system-wide daemon, not attractive. UNIX socket is not available on
> Windows (although there may be named pipe, I don't know).

I do not think TCP/IP socket is too bad (you have to be able to read
the index file to be able to ask questions to the daemon to begin
with, so you must have list of paths already; the answer from the
daemon would not leak anything more sensitive than you can already
know), and UNIX domain socket is not too bad either.

Just like the implementation detail of the daemon itself may differ
on platforms (does Windows have the identical inotify interface?  I
doubt it), I expect the RPC mechanism between the daemon and the
client would be platform dependent.  So take that "open a socket" as
a generic way to say "have these two communicate with some magic",
nothing more.
