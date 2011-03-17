From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash: status from current dir not top dir?
Date: Thu, 17 Mar 2011 12:30:48 -0700
Message-ID: <7vsjul35p3.fsf@alter.siamese.dyndns.org>
References: <4D7A8AC9.1030506@gmail.com>
 <20110311223232.GA21410@sigill.intra.peff.net> <4D7B358A.5010101@gmail.com>
 <7v1v2agnww.fsf@alter.siamese.dyndns.org> <4D7E7065.20908@gmail.com>
 <4D824F46.70107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Iua-0004mh-1e
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab1CQTbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:31:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1CQTbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:31:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7A3D37F0;
	Thu, 17 Mar 2011 15:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V7oT0WaMN5OaQhWzM06ryxIxAZ0=; b=UkUOMR
	IPO98CxNQO+GrDaNwVKhcIj+uybpIyTWlJ1TXD1H3ZQa+16uLLjEWPtVGQ8FMrFO
	87NDEukCf0E2enrjC9K3DFKdBUZifTskziR0pzVfuQM9F1Ca/3lE5e3FuQOEi8wV
	Y+V0Kti3SBBsAF2lXg6kGxq9OaoCEMlTdkbpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jxgksrDSTqtGFYqaeA/pYgHEvibFij1f
	BYrsmFe0XANMQtIfM5BNvEQo/NSqz3MkFSfHd2zRlF4G/l/mmOXPq7WWNHLO5Tgq
	UXXjEmsj8362BwRnQg2TjvztapPJG/Rj9dIV5BQcCcGfvCLZFX4HL/gOTDiZE5+5
	3ulQVd6G8Sg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 963D137EA;
	Thu, 17 Mar 2011 15:32:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 452FB37E9; Thu, 17 Mar 2011
 15:32:23 -0400 (EDT)
In-Reply-To: <4D824F46.70107@gmail.com> (Piotr Krukowiecki's message of "Thu,
 17 Mar 2011 19:13:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B70C38A-50CD-11E0-8DD8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169261>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Now I don't know how should I handle this:
>
>     1. unset it just before "git stash apply" in my test
>        A safe, local change

This is the preferred method; in addition to "a safe local", more
importantly, at that point you are testing what you _want_ to be testing,
namely, how the output appears to the _real_ end users who do not use
verbose message. So for that purpose, mucking locally with MERGE_VERBOSITY
is perfectly acceptable.

You would not just "unset it just before", but "unset around it" in a
subshell like this:

	git stash &&
	(
		sane_unset GIT_MERGE_VERBOSITY &&
	        git stash apply
	) >../actual &&
	git status >../expect &&
        test_cmp ../expect ../actual

so that if somebody adds new tests later in the script, they are not
affected by this change.

Write your test_cmp always to compare expected with actual, not the other
way around, so that the diff output you see when the test is run under -v
option shows the changes from what is expected.

Thanks.
