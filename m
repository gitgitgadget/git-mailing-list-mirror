From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_ functions
Date: Thu, 26 May 2016 10:36:44 -0700
Message-ID: <xmqqd1o8wwk3.fsf@gitster.mtv.corp.google.com>
References: <20160518223712.GA18317@sigill.intra.peff.net>
	<20160518224323.GD22443@sigill.intra.peff.net>
	<20160519000821.GA22543@sigill.intra.peff.net>
	<CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
	<xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
	<20160526165033.GA20355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 19:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5zDJ-0006gH-KT
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbcEZRgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 13:36:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752175AbcEZRgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 13:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 983E11E647;
	Thu, 26 May 2016 13:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DhVkf1t8Q/Axtxef1lFbEupeoSM=; b=j0HPEs
	G369EaEBDQMv/E0wlzqekVbjwd/FVN1WKOVYzTVZIrI8FR4/jJbJNxFqjWS6k5Eq
	2Ty/Tegnrj/Vkz4XBOoXVREp4hI+YSDhG21/xNXSFPHlRqo6OiIM6nTcsbNORUi3
	jHmdYgq8zIuuP5uOrS90pK4UnCA2lsHvbcRW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jEDnGgSVDbXwQ+fnCaIqf4fC3Vj9cfxY
	+OA4s8uoxbsmRWZyuWp/DV/TnFe339mO5P7buBBYY8pTNeH3UaDnpNuhUz5GET8i
	RPtq9uSB+12SxShxAfHJqloMm5cerPQXmBoOF4Imwg+vV8s4n0OePIQ2VXwuhJOW
	fKILyH9eWG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90FB91E646;
	Thu, 26 May 2016 13:36:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D1521E645;
	Thu, 26 May 2016 13:36:46 -0400 (EDT)
In-Reply-To: <20160526165033.GA20355@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 12:50:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BA11448-2368-11E6-874A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295679>

Jeff King <peff@peff.net> writes:

> The problem is running test-config inside of a git alias. The
> bin-wrappers will set the exec-path to the root-level of git's build
> directory, which the git binary will then stick at the front of the
> $PATH.

I was wondering why exec-path does not point at bin-wrappers in the
first place.

A wrapper script needs to know where the real thing lives in order
to "exec" (or "exec gdb") anyway, and it hardcodes the path to it.
It happens to use GIT_EXEC_PATH to shorten the hardcoded path it
uses when it does "exec", but it does not have to.

Wouldn't we want to see "git" use any of these wrapped ones when it
invokes a non-builtin subcommand when it does so normally, honoring
GIT_EXEC_PATH?  Pointing GIT_EXEC_PATH at the top-level means that
wrappers are bypassed for such an invocation (if what is run happens
to have executable at the top-level), and possibly a totally wrong
thing is run (when we start generating the binaries in different
directories, which is what we are seeing here).

> So the simplest solution really is: don't do that. The only debate
> in my mind is whether this is rare enough that it won't bite
> somebody again in the future, or if we should look into a solution
> that makes this Just Work.

I think it was you who alluded to revamping the test framework along
the lines of preparing a "test installation" (aka "make install"
with DESTDIR set to somewhere) and making bin-wrappers to point into
that installation (or if we are testing an installed Git that may be
different from what we have source for, that final installed
location).  An installed version of Git will not have test-* helpers
so they need to come from a freshly built source tree, not from
"test installation" or "installed Git".  There may be other details
that need to be worked out, but as a longer term direction that may
not be a bad idea.
