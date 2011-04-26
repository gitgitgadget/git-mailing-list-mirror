From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Implemented return value for rev-list --quiet
Date: Tue, 26 Apr 2011 16:02:05 -0700
Message-ID: <7vwrigbor6.fsf@alter.siamese.dyndns.org>
References: <4DB748F5.4050300@boolsoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Gehring <jonas.gehring@boolsoft.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:02:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QErGv-0001Nl-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 01:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426Ab1DZXCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 19:02:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab1DZXCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 19:02:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 215BA5A33;
	Tue, 26 Apr 2011 19:04:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8D3KaV2L3j48+zhn80WYai/j+Hw=; b=eWqvOI
	mPoZY8q0p3bzFAQHRB8NIMjSNq4Kx/29EhPvS1FVvOygkr1O9Nwsm/7TTFtw4xMp
	BH5JS0xSKxVSDGI82TARkcVndkxaa6l4J+rqE+D/2pt3leB/7jJAQyGodTYYHteg
	H7V0dcUQgNPNTWgWaCT8Fr30DSbpx4no8xQy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmoT3sZx7qAQGG/A7to9vAZgDR29ulxq
	CjQ5PX7YuUrkru43NWJftQhXH2n+JcF7mIEhKGXXFfngdI2z025TxkwLyI7b57Xd
	H/ghoo9jffgLmxezNH23lbfz02PpOM85sRJiNCUfQc9mLeBdSAXx5V+nHbUKotdJ
	D9092vtSLiE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECFA75A32;
	Tue, 26 Apr 2011 19:04:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DFB905A30; Tue, 26 Apr 2011
 19:04:08 -0400 (EDT)
In-Reply-To: <4DB748F5.4050300@boolsoft.org> (Jonas Gehring's message of
 "Wed, 27 Apr 2011 00:36:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FC056AE-7059-11E0-90F3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172134>

Jonas Gehring <jonas.gehring@boolsoft.org> writes:

> If --quiet is given, the program will return non-zero if the traversed
> commit set was empty. This way, rev-list can be used to check commit
> ancestry as described by the documentation for --quiet.

Given two commits A and X, "rev-list --objects A..X" is a way to make sure
that everything between A and X exists.  When your ref is at A, you are
trying to fetch from a remote that wants to update you to X, and when you
happen to have X already, you run that command and see if it dies due to
disconnect in the history.  If it doesn't, you know you do not actually
have to transfer anything (this is called quickfetch test).  For the
purpose of this test, the caller is not interested in the output, so it is
perfectly OK to give --quiet to the command.

In reality, you would feed all the refs you locally have on the negative
side (i.e. "rev-list --objects --quiet X --not A B C D ...") to check if X
is connected to something you know you have a connected history behind it.
Returning non-zero to a quickfetch test when X is reachable from some of
your refs will break existing scripts.
