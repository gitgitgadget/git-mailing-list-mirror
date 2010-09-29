From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Wed, 29 Sep 2010 15:59:24 -0700
Message-ID: <7v4od8ma0j.fsf@alter.siamese.dyndns.org>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
 <1285792134-26339-4-git-send-email-judge.packham@gmail.com>
 <4CA3BBD7.3090006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 30 00:59:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P15ck-0008Cu-MT
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 00:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0I2W7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 18:59:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab0I2W7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 18:59:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03853D9FC5;
	Wed, 29 Sep 2010 18:59:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jrxupztFsa/kKoOi/9ljomckkJg=; b=fWE0tp
	bmDV4UZxClB0xgy0uT4PoOQfC9ry2aiP61QnnVnsc6OD3cynhdGntLXqo6Va/0+k
	QFWeB5UT8/ue5iYRYvQX4TmWfJCI/WfJpqE1PnLIcC3DYdaPtOFrjy1/s4NnfTtk
	i2h0iABsev5LTkXnstZR623R//Km00y5migIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wJguweqzrqvMJW5OdyJbEXKQ8p3dPK4n
	fZSn0lBAoZiJJ4KvXby6Y6LOiyyst4HxVcbuRk/F8ij11BKlhV0gT7yAKMGUDtQi
	zQmtqmVk3h7E7LyK3w1wPkB54c8TydqYCCSU7m/IWNImxuuRiYXaZ4oifojH3rYx
	AoX10c+y1vM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD0ED9FC0;
	Wed, 29 Sep 2010 18:59:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C90B0D9FBE; Wed, 29 Sep
 2010 18:59:26 -0400 (EDT)
In-Reply-To: <4CA3BBD7.3090006@web.de> (Jens Lehmann's message of "Thu\, 30
 Sep 2010 00\:21\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37DA7F08-CC1D-11DF-BAD5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157617>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Hm, at a quick glance it might be much easier to copy argc & argv
> in cmd_grep() before parse_options() starts manipulating it.

Yes, I think that is a much saner direction to go.  Otherwise, you would
need to unparse grep boolean expressions as well.

A few more things to think about.

1. What does this mean:

    $ git grep --recursive -e frotz master next

It recurses into the submodule commits recorded in 'master' and 'next'
commits in the superproject, right?

How do the lines output from the above look like?  From the superproject,
we will get lines like these:

    master:t/README:  test_description='xxx test (option --frotz)
    master:t/README:  and tries to run git-ls-files with option --frotz.'

What if we have a submodule at git-gui in the superproject, and its README
has string frotz in it?  Should we label the submodule commit we find in
'master' of superproject as 'master' as well, even if it is not at the tip
of 'master' branch of the submodule?  Or do we get abbreviated hexadecimal
SHA-1 name?  IOW, would we see:

    master:git-gui/README: git-gui also knows frotz

or

    deadbeef:git-gui/README: git-gui also knows frotz

where "deadbeaf...." is what "git rev-parse master:git-gui" would give us
in the superproject?

I tend to think the former is preferable, but then most likely you would
need to pass not just submodule-prefix but the original ref name
(i.e. 'master') you started from down to the recursive one.

2. Now how would this work with pathspecs?

    $ git grep --recursive -e frotz -- dir/

This should look for the string in the named directory in the superproject
and if there are submodules in that directory, recurse into them as well,
right?

What pathspec, if any, will be in effect when we recurse into the
submodule at dir/sub?  Limiting to dir/ feels wrong, no?

3. Corollary.

Is it reasonable to expect that we will look into all shell scripts, both
in the superproject and in submodules, with this:

    $ git grep --recursive -e frotz -- '*.sh'

Oops?  What happened to the "we restrict the recursion using pathspec, and
we do not pass down the pathspec" that was suggested in 2.?
