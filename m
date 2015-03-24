From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Tue, 24 Mar 2015 11:37:02 -0700
Message-ID: <xmqqwq265jjl.fsf@gitster.dls.corp.google.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaThh-00008V-Af
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbbCXShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 14:37:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753677AbbCXShK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:37:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31F3341854;
	Tue, 24 Mar 2015 14:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bsvi57ePsu1rEvhkBUUtSgFa/S0=; b=UIykjd
	HFLmxR6oq9BjvM935flp3CM7IE5loLfU4SXeCcBP6/hoJlDwWirBTXpI3G4Qsht5
	fpm6YJ8g6KzgR92o2+cAlOMdoZGx4KeEbXTLEeDCp4CoVXHUCIBOZXdIDsCsHs4w
	MTaxsiDCro4M5UJcjuxJQAwUdeEdhueN/7+Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZN8S4j88BbxEJjiNb9qRNd6fuy3ZTrqW
	TGZ+aRKmronXQRRHGHYcwF7eBLabOvSfmeq4JWJSyuU7rNO4PdXd3h50DZDLKhnb
	eFmaj4NnJl+HLpaX6bjHkZvlNJ8dvWfVUZ8qRRwg5V+chi2Ej90+ftfgRDJEbU3k
	4/ZahGy0kAc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B70A41853;
	Tue, 24 Mar 2015 14:37:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97BE341852;
	Tue, 24 Mar 2015 14:37:03 -0400 (EDT)
In-Reply-To: <20150324163730.GA8366@yoshi.chippynet.com> (Paul Tan's message
	of "Wed, 25 Mar 2015 00:37:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C40EB470-D254-11E4-84C2-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266219>

Paul Tan <pyokagan@gmail.com> writes:

> ..., I propose the following requirements for the rewritten code:
>
> 1. No spawning of external git processes. This is to support systems with high
>    ``fork()`` or process creation overhead, and to reduce redundant IO by
>    taking advantage of the internal object, index and configuration cache.

I suspect this may probably be too strict in practice.

True, we should never say "run_command_capture()" just to to read
from "git rev-parse"---we should just call get_sha1() instead.

But for a complex command whose execution itself far outweighs the
cost of forking, I do not think it is fair to say your project
failed if you chose to run_command() it.  For example, it may be
perfectly OK to invoke "git merge" via run_command().

> 3. The resulting builtin should not have wildly different behavior or bugs
>    compared to the shell script.

This on the other hand is way too loose.

The original and the port must behave identically, unless the
difference is fixing bugs in the original.

> Potential difficulties
> =======================
>
> Rewriting code may introduce bugs
> ...

Yes, but that is a reasonable risk you need to manage to gain the
benefit from this project.

> Of course, the downside of following this too strictly is that if there were
> any logical bugs in the original code, or if the original code is unclear, the
> rewritten code would inherit these problems too.

I'd repeat my comment on the 3. above.  Identifying and fixing bugs
is great, but otherwise don't worry about this too much.

Being bug-to-bug compatible with the original is way better than
introducing new bugs of an unknown nature.

> Rewritten code may become harder to understand
> ...

And also it may become harder to modify.

That is the largest problem with any rewrite, and we should spend
the most effort to avoid it.

A new bugs introduced we can later fix as long as the result is
understandable and maintainable.

> For the purpose of reducing git's dependencies, the rewritten C code should not
> depend on other libraries or executables other than what is already available
> to git builtins.

Perhaps misphrased; see below.

> We can see that the C version requires much more lines compared to the shell
> pipeline,...

That is something you would solve by introducing reusable code in
run_command API, isn't it?  That is how various rewrites in the past
did, and this project should do so too.  You should aim to do this
project by not just using "what is already available", but adding
what you discover is a useful reusable pattern into a set of new
functions in the "already available" API set.
