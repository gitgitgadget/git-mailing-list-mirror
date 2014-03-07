From: Junio C Hamano <gitster@pobox.com>
Subject: [micro] Use 'env' on test_must_fail as appropriate
Date: Thu, 06 Mar 2014 17:14:31 -0800
Message-ID: <xmqqfvmuvmh4.fsf@gitster.dls.corp.google.com>
References: <xmqq1tyex6by.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:14:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLjN1-0002eU-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 02:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaCGBOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 20:14:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaCGBOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 20:14:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFDA721AA;
	Thu,  6 Mar 2014 20:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2qrUr2Tw52MZQ/mMYbFTnJLKBIo=; b=DHFt8T
	P/Sonoo2AdeIahRe3vWi5CucQ3YR46q1J7vJE9hdy1XdRItFoLz5GAae7UrmVecw
	v4mslAkdaL/lC6hgtxVKbbsiR7bqFgaAOHKFpGuvCZOy5K5U4RWkXiercfngnZXS
	ns/fO50S+Ba88r8QSIjcB1QeUkVx5TllsFo30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GVu+FoT0PkigwEHs8J1WhafnvMVWNSkc
	WuSiiO/yjyekK6aS3yBvkomYGMf51jtW7lto8PZ5MimDPkf950DP95gMl4UPlr5h
	wBr8pff3P0ozEJDlHj8Ay3oHC6xqTyCRpuCiP3ZiMkpUTLb8gxCH+MIFgbdqu6i5
	oRXHmll9FrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9F0721A9;
	Thu,  6 Mar 2014 20:14:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B026721A7;
	Thu,  6 Mar 2014 20:14:33 -0500 (EST)
In-Reply-To: <xmqq1tyex6by.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 06 Mar 2014 15:20:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D7535FD2-A595-11E3-AC77-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243580>

Because "VAR=VAL command" is sufficient to run 'command' with
environment variable VAR set to value VAL without affecting the
environment of the shell itself, but we cannot do the same with a
shell function (most notably, "test_must_fail"), we have subshell
invocations with multiple lines like this:

	... &&
	(
        	VAR=VAL &&
                export VAR &&
                test_must_fail git command
	) &&
        ...

which could be expressed as

	... &&
        test_must_fail env VAR=VAL git comand &&
	...

Find and shorten such constructs in existing test scripts.

Note that I am not 100% convinced myself that it is a good idea to
do this, so please do not add this to the list without seeing it
discussed.

Thanks.
