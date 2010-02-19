From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Allow Git repositories to be shared using POSIX ACLs
Date: Fri, 19 Feb 2010 09:52:26 -0800
Message-ID: <7vsk8xjep1.fsf@alter.siamese.dyndns.org>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiX1w-000144-GU
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab0BSRwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:52:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab0BSRwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:52:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E7589B44D;
	Fri, 19 Feb 2010 12:52:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hRHE7tm7XCR3AvSJ/Qy7Uh5IrvY=; b=K0pkLamV94DoIl4I18wunVs
	vcqrTUiNwwT00hvmxTvfxfDS0RFdZIIpW4JpLyB43vna33zI851GHdOFg45ytKr5
	UwY9WGSFzfb9vsBLnvekgDXE1y4SrOva0c9ohS6CnnIr/rwcXwwsysaqKcJ5wwEC
	aaIV2jcAS5x80Hc2HMJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=APP0m+gX+IV5gcq7gOvucIEan0NXtq9a492a0Dtosu9W7mHMP
	17X6M7JqD0HVr469A2jxVDUkYW4VHi3Il/qPpJ5XoJdRXww2adKKjMTQN4XHWUKT
	Svy3jHW7iLIVXR2MeFd7zQhEHfijc/vnKcmVb4XEiLT7GFNDHgxIcY4e44=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 371E49B44C;
	Fri, 19 Feb 2010 12:52:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F6A29B448; Fri, 19 Feb
 2010 12:52:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CA2856E-1D7F-11DF-AC04-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140474>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> In short: if a user wants to share a git repository using POSIX
> filesystem ACLs, it seems everything works except pack file creation.
> The problem is that we create the file with a mode 0600, i.e. no
> permission for group,...

Modulo that it is more like "we let mkstemp() to choose whatever file
mode", this is a good analysis.

I think some versions of glibc used to have mkstemp() that creates 0644 or
0664, meaning that the modes left by various implementations of mkstemp()
are different from each other, and also different from what we want.  With
aef5aed (pack-objects: quickfix for permission modes., 2007-04-22) and
b6b32cc (Fix 'quickfix' on pack-objects., 2007-04-22), were attempts to
work around that issue.

By not using mkstemp() from the platform but having our own would allow us
to not even worry about this issue (this can be seen by the removal of a
call to umask() in [PATCH 4/4]).  I see your patches as a "bite-the-bullet
and do the right thing" solution.

> The test-case is really weak: ideally, we should have a real test with
> several users interacting. But that's hardly scriptable in a portable
> way, so the only testcase I added relies on getfacl and "ls -l" to find
> out if the result is correct. However, I did some manual testing, and
> as far as I can say, Git works very well with ACLs with this patch.

Thanks.
