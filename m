From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/t5510: demonstrate failure to fetch when current
 branch has merge ref
Date: Wed, 25 Aug 2010 14:28:23 -0700
Message-ID: <7vy6bupeko.fsf@alter.siamese.dyndns.org>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
 <O7UxM6KEqdDAhjJAF7ODSonSLShoyHHhaZNp8vb1mx2_JFqmMUj1Op5xiv_-bSd8xW04rLMul2k@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 25 23:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNWj-0007uN-U2
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab0HYV2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:28:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0HYV2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:28:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A12BD0D54;
	Wed, 25 Aug 2010 17:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1BBvfkvLRCPG2jzVZCyNU1RwpX4=; b=U/D68YRJAgobK17JwaTK/PJ
	w3uqzUQcGdhFgiU34ijj+ZUPY5dsoiMZo6UII/ao+u3O6qkixbuV8C68F+4bLt9L
	oIIVIqddMEA1OB59WNelAQTSVaoDtTMQy0YCp9Awa9DXkoahibx4FRqQOuWHlLWT
	Csb51Qa+aP++xdc0K120=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=h2wVbFIjIHiIkJviDmlX9wvbvQ93w+0tKjVIwmETaFpFU+QJz
	xGMOc8mMMpyUIdOkxriEF7diD45q7mX8ri9qR4zN/4FPYD71Bo9wBefifpbq25qz
	6tZz4dQq9ZZsI7oN106/Ac9RlViB+4/VL5EoR6qQNIrV8CcfDiyjw3wBBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5599D0D49;
	Wed, 25 Aug 2010 17:28:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7469D0D43; Wed, 25 Aug
 2010 17:28:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4FEA706-B08F-11DF-87C5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154477>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> When 'git fetch' is supplied just a repository URL (not a remote name),
> and without a fetch refspec, it should fetch from the remote HEAD branch
> and update FETCH_HEAD with the fetched ref.  Currently, when 'git fetch'
> is called like this, it fails to retrieve anything, and does not update
> FETCH_HEAD, if the current checked-out branch has a configured merge ref.
>
> i.e. this fetch fails to retrieve anything nor update FETCH_HEAD:
>
>    git checkout master
>    git config branch.master.merge refs/heads/master
>    git fetch git://git.kernel.org/pub/scm/git/git.git

Hmph, we can call it a regression, since we certainly won't see this
failure with versions of git that is unaware of branch.*.merge.

But what should we be expecting?

Just as a datapoint, an ancient git (e.g. v1.4.0), the above command line
would have fetched the HEAD from the remote side, no matter what that
symref is pointing at.  Your [2/2] patch replicates this behaviour, which
is fine by me [*1*].

Your test only checks if we leave _anything_ in FETCH_HEAD, and does not
check if we only fetch one, if we fetch all the refs, or if we fetch what
the configuration branch.*.merge asks for (but without the corresponding
branch.*.remote configuration, doing so is pointless).

I think it would be better to have two tests.  One arranges the current
branch to track the same branch the HEAD at the remote points at, and the
other arranges the current branch to track a branch different from the
HEAD at the remote points at.  In both cases, as "fetch" should ignore the
configuration, we should get the object pointed by the HEAD on the remote
side.

Thanks.


[Footnote]

*1* A plausible alternative is to match the given URL against list of
existing remote.<name>.url (make sure there is only one), and behave as if
that the remote name is given.  I can be persuaded either way, but not
looking at the configuration feels a lot simpler to explain and understand
(i.e. "with name, we use the set of configuration variable given to that
name; without name, there is no configuration for us to look up").
