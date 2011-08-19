From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Fri, 19 Aug 2011 10:20:19 -0700
Message-ID: <7vk4a948to.fsf@alter.siamese.dyndns.org>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
 <7vd3g272tk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Troxel <gdt@ir.bbn.com>, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 19:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuSk9-0001NF-KM
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 19:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab1HSRUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 13:20:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756589Ab1HSRUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 13:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45C6D46F0;
	Fri, 19 Aug 2011 13:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i33grkuqqmK8rHbhtV32nblSWrQ=; b=mgKrcu
	tsm0UVTBTTLJtrOFT9YVEzhR+Qy1E7pzHdXiElS/G/aIIgCElOWT9wG8YnP9PJLe
	NOh3/lBSRj+2jzq5xOqy4FLeaJR+U59byQGzYEB2HeG+lJxu6tfUQkbPqsNdUo6X
	YDu0/SBIEw4fHoYxCaHKKbBZeP+Hdj7oNw27k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ekZSrYMvNYrPdE+EjfoO2kTuMh0xJvmB
	ayvk9hvuoh2l4F9By+dV8UGjDxxOE0Lz8hsH1NqmC+6hBYj+PVYSqzZaELqAqBgq
	0hPzUjVlilA1GOCsVJIcgC+kgPMNMYW9Y91xxhasB1gNY8IEVAzvO4bYMP/f3uFY
	G9OpubgpOl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D38A46EF;
	Fri, 19 Aug 2011 13:20:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B6246ED; Fri, 19 Aug 2011
 13:20:21 -0400 (EDT)
In-Reply-To: <7vd3g272tk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 18 Aug 2011 15:49:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84C6DDD4-CA87-11E0-B331-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179711>

Junio C Hamano <gitster@pobox.com> writes:

> As "update-index --index-info" predates "submodule" by a few years or
> more, I wouldn't be surprised if the code didn't notice it was fed a wrong
> input and produced nonsensical result that happened to be a commit.
>
> The command could just instead barf, saying the input is wrong, but the
> option was so low-level that it was deliberately written to accept and
> store anything you throw at it --- even when it is nonsensical for the
> version of plumbing, later updates to the data structure might have made
> it making sense, which was the way to ease development of the system.

The second paragraph needs a bit of clarification. What I meant to say was
that the --index-info and its command line cousin --cacheinfo interfaces
are designed to be used like using a hex editor on the disk block device
to modify the file system in a random way, and just like a hex editor does
not prevent you from writing a data to the disk that is not understood or
misunderstood by the current filesystem implementations, ideally it should
allow you to put data that is beyond the current design of the index, so
that it can be used as a way to experiment while developing enhancements
to the index further. That in fact was how I experimented with updates to
the code to read from the index (in read-cache.c) in early days. Also they
do not even look at the object name they are given, and that is very much
deliberate---otherwise you cannot even stuff gitlinks in the index---and
in general, the less sanity-checks we do in that interface, the better off
we will be. After all we may someday start adding a tree entry in the
index for a reason unknown to us today.

I am all for documenting that today's index holds only regular blobs (mode
100644), executable blobs (mode 100755), symlink blobs (mode 120000), and
gitlinks (mode 160000), somewhere in the general part of the document not
specific to these options, and also documenting that the result of the
operation is undefined if anything outside the officially supported kinds
of input is fed to --index-info/--cacheinfo.

Thanks.
