From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: fix t7001 cp to use POSIX options
Date: Fri, 11 Apr 2014 12:23:59 -0700
Message-ID: <xmqq1tx3u0ts.fsf@gitster.dls.corp.google.com>
References: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c>
	<20140411114338.GD28858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:24:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYh3i-0005Kz-TO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbaDKTYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:24:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378AbaDKTYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:24:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C09C37A14F;
	Fri, 11 Apr 2014 15:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mgGgielmTcvqo0tWogaaqvzFZoQ=; b=wEv2b2
	fUXPDSG6Ohk06jVc4ZSx4s+J1KW5ERfCWexkH6JgrELFvCzugFnGAN+eaYgDCTA6
	6Ik989BlBh3mNVrd4rMnHCAxI4rTjIa9suncIsoowdgJ968Kng20Yix7OOZU7Jvs
	i6eGJAdEY3IX7ho1ITDC+fl86ba/78ZS5gwi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXAcpyjHr92lAut3ohBasbeKwYRoEnz0
	upI97T2O6Ll5pO4S1U/HQGUeI1MEVr3YKyim+845pJWgvZg06uRp/osmx6/nxmqv
	etjD1HxTJtxFtQBdzmgD4CFpuG9YP+U/6yEO/cHEb44+kJTZWAQT9WdHPI/KFEU2
	39WDhuOtas0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A99287A14E;
	Fri, 11 Apr 2014 15:24:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F5DD7A14B;
	Fri, 11 Apr 2014 15:24:00 -0400 (EDT)
In-Reply-To: <20140411114338.GD28858@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Apr 2014 07:43:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D60ABFB4-C1AE-11E3-9C3B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246131>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 11, 2014 at 01:24:02AM -0700, Kyle J. McKay wrote:
>
>> Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
>> t7001-mv test has used "cp -a" to perform a copy in several of the
>> tests.
>> 
>> However, the "-a" option is not required for a POSIX cp utility and
>> some platforms' cp utilities do not support it.
>> 
>> The POSIX equivalent of -a is -R -P -p.
>> 
>> Change "cp -a" to "cp -R -P -p" so that the t7001-mv test works
>> on systems with a cp utility that only implements the POSIX
>> required set of options and not the "-a" option.
>
> I wonder if the "-R" is the part that we actually care about here.
> Including the others does not hurt in that case, but using only "-R"
> would perhaps make it more obvious to a later reader of the code exactly
> what we are trying to do.

These calls to "cp" are about "We know that earlier 'update' created
the GIT_DIR of the submodule in the top-level superproject, because
we are running a modern Git.  But we want to make sure the command
we are testing, "git mv", would work correctly if the repository
were made with an older Git that created the GIT_DIR embedded in the
working tree of the submodule, so let's emulate that case."  As we
create files and directories in GIT_DIR with explicit permission
bits, we may care about

 (1) making sure "git mv" can actually move the directory, with some
     paths having mode bits different from the umasked default; and

 (2) checking that the GIT_DIR after "git mv" has the permission
     bits right.

and if we cared, "-R -p" would be required here, not just "-R".

If core.prefersymlinkrefs is set, GIT_DIR would have a symbolic link
HEAD pointing at the current branch, and "-P" may become relevant,
but manually running "cp -R .git git && ls -l git/HEAD" in such an
old repository tells me that symbolic link HEAD is not dereferenced
without an explicit "-L", so I dunno.

Because we do not check anything inside GIT_DIR of the moved
submodule after "git mv" is done, the more correct use of "cp" is
moot for the purpose of (2), but it could be possible that "git mv"
fails to move a submodule with GIT_DIR created embedded in its
working tree by an older version of Git, while successfully copying
an emulated one, due to differences such as modes and symlinks.

The current implementation just does rename(2) on the whole
submodule working tree and let its contents move together, so I do
not think it matters at the moment for the purpose of (1); use of
flags other than "-R" are purely for future-proofing, I would think.
