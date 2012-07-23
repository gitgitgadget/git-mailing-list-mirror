From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer
 conversion that violates alignment constraints
Date: Sun, 22 Jul 2012 22:42:23 -0700
Message-ID: <7vboj7nidc.fsf@alter.siamese.dyndns.org>
References: <20120722233547.GA1978@burratino>
 <7v8vebp0cl.fsf@alter.siamese.dyndns.org> <20120723045148.GA13623@burratino>
 <7vobn7njtz.fsf@alter.siamese.dyndns.org> <20120723052605.GA13728@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:43:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StBQG-0004Qj-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab2GWFm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:42:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab2GWFm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:42:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1B76095;
	Mon, 23 Jul 2012 01:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=stCuOfdZU/EBa74xDn/a2XFR8Xc=; b=EuEzQV
	2GIvVxdw8f942i0e9tBFtBdoitxrUP4SHOrTHL7HA9v8ndsIZ/okl3WcZ6s4mH5T
	pv0TS+7LWwxvDhHrLfmSW/XUazmf+gmlzBAZjhpSB2z/qMuq+wqvwEhxaMCLTjJD
	InPDw1M4Bm0dNgMS2l/4JAfrYxtCvXI3tQxPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEWwpNhzCrVozJAlFR3dCp4UV33cKkNO
	t4UjPjicDgydTJYHjlQm+OIKrxHzGl0Aydrw2ofOq5ttQlSst590X2S1Bihg7bZK
	HEyJqH05b6NvQ8JR4zg/jt7AVtxyA8h7OiE3+QwoFSqonUfvYDrjun5+YdM1Ln0V
	WV8nBeVMOjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C2A6094;
	Mon, 23 Jul 2012 01:42:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB2236093; Mon, 23 Jul 2012
 01:42:24 -0400 (EDT)
In-Reply-To: <20120723052605.GA13728@burratino> (Jonathan Nieder's message of
 "Mon, 23 Jul 2012 00:28:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E4926A8-D489-11E1-A219-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201904>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> The big-endian part was just my idiocy, sorry.
>>
>> Hrm, do we want an update log message for 1/2 then?
>
> Hm, I thought all the crazy had been eliminated already.
>
> *looks again*
>
> I guess "using a single 32-bit load" makes it sound like it's using a
> big-endian load instead of a load followed by twiddling in registers.
>
> Simplest fix would be to drop the phrase "by using a single 32-bit
> load", leaving "... and gcc takes full advantage, resulting in a whole
> bunch of unaligned access traps."

I was just being stupid, misread the original code and did not
realize that the generic code quoted in your log message:

	#define get_be32(p) ( \
        	... byte-at-a-time implementation )

is not limited to big endian boxes [*1*].  So I think the message is
fine as-is.


[Footnote]

*1* In other words, the ntohl(*(uint *)(p)) is used only on selected
little endian boxes, but that does not mean the generic code was
big-endian only.  Little endian boxes that are not listed in #if
block do use the generic byte-at-a-time macro.
