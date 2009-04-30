From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't crash if ai_canonname comes back as null
Date: Thu, 30 Apr 2009 09:57:03 -0700
Message-ID: <7viqkm5bc0.fsf@gitster.siamese.dyndns.org>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
 <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
 <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
 <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com>
 <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com>
 <7v63gn59mw.fsf@gitster.siamese.dyndns.org>
 <A85E96CC-CF0B-40F9-9960-00485285E6ED@gmail.com> <E1LzX1N-0003sw-2y@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Augie Fackler <durin42@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Benjamin Kramer <benny.kra@googlemail.com>
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzZZk-0003ZL-2V
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 18:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763561AbZD3Q5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760416AbZD3Q5N
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 12:57:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762687AbZD3Q5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 12:57:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F2EE1351E;
	Thu, 30 Apr 2009 12:57:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 069DF13515; Thu,
 30 Apr 2009 12:57:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F27DBB62-35A7-11DE-BD40-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118033>

Jon Loeliger <jdl@jdl.com> writes:

>> > I've been waiting for feedback to a patch proposed earlier in the same
>> > area, which is <49F5BA55.3060606@googlemail.com> ($gmane/117670).  How
>> > does this new one relate to it?
>> ... 
> So, I wasn't CC'ed on the referenced patch ($gmane/117670), but it

You did got CC'ed, but I got a bounce from your freescale address, so this
time I tried another address of yours I knew about.

> seems to me that there might be value in actually looping over the
> whole list of addrinfo results exactly in the case that it does
> return a null canonical name for one of its addresses?

That is what I speculated when commenting on ($gmane/117670), but I think
the original loop was not doing any check, and instead always exited early
during its first iteration.  Perhaps we can re-add a loop that does
something useful, but I do not know what it would be offhand.

> Perhaps an
> inverse call to getnameinfo() is warranted too?

In this case the name being looked up is _ours_; it is not like "the
client claims to be frotz---does frotz reverse map to him correctly?"
situation, so reverse lookup might not be so interesting.

There is one thing that could potentially be useful when the daemon runs
on a multi-homed host; git.jdl.com may have eth1 facing public and eth0
facing internal networks.  Depending on which address you got the request
to, you may want to serve different contents, and if you got request to
"hostname" that is not you as far as getaddrinfo() is concerned, you may
want to do yet another thing that is different from the two name-addr
mapping returned by getaddrinfo().

I do not see enough information to do that kind of thing is passed to the
parse_extra_args() function in the current callchain, though.  We do have
a call to getpeername() but we do not seem to do getsockname() to learn
about our end of the connection.
