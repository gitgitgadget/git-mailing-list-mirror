From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -g bizarre behaviour
Date: Mon, 01 Feb 2016 15:37:24 -0800
Message-ID: <xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
References: <1454241144.2822.7.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQO2K-00085R-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 00:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbcBAXha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 18:37:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751488AbcBAXh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 18:37:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 625094141E;
	Mon,  1 Feb 2016 18:37:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KeKkRV7rhc7P48kehFFTdCc6O3o=; b=RMNAoq
	sh3CB6gDu9KRWb2dB3+8+1wzx3ovTP/+jZGCD32gX8cU12yBMjuiiSvpBj/yS1N+
	yRBmdy4S1sNhfoP+vR+WqY8sZCIv4GxdwQ6ff9TO/c5kqJzOKPvaG6/F3Nn0/jlM
	FGVSQniZvTr4KUsRm2G7UkQeW5RuEAvH5wG6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trsbJEt/yONrMOEa6n9eLa3tyZHlie3I
	RFj0S8eZu/XOxkg5Q3GhU0ZoS6uW5ik5uGL3MbUwS4SI5sjU4LzUC/0xdRaHoA/2
	j2QjV/gYPdBMnIIMh8gvUVii/M5iJxgPo940007YMhtMgCnVl4EvPjORbKqVL4gg
	5jTzLhKbmb8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59DE44141D;
	Mon,  1 Feb 2016 18:37:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CDE554141C;
	Mon,  1 Feb 2016 18:37:25 -0500 (EST)
In-Reply-To: <1454241144.2822.7.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Sun, 31 Jan 2016 12:52:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFD92270-C93C-11E5-B5BF-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285226>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I'm attempting to understand the log [-g] / reflog code enough to
> untangle them and make reflog walking work for more than just commit
> objects [see gmane 283169]. I found something which I think is wrong,
> and would break after my changes.
>
> git log -g HEAD^ and git log -g v2.7.0^ give no output. This is
> expected, as those are not things that have a reflog.

OK.

> But git log -g v2.7.0 seems to ignore -g and gives the normal
> log.

That sounds clearly broken, and I think I see how that happens from
the hacky way the "-g" traversal was bolted onto the revision
traversal machinery.

I _think_ "git log -g" (and by extension "git reflog" which is just
a short-hand to giving a few more options to that command) ought to

 * Iterate over the _objects_ that used to be at the tip of the ref;
 * Show each of these objects as if they were fed to "git show".

This clearly is not possible without major surgery, including
ripping out the hacky "-g" traversal from the revision traversal
machinery and perhaps lifting it up a few levels in the callchain,
as many functions in that callchain want to work on commits.

Contrast these two:

    $ git log -1 v2.7.0
    $ git show v2.7.0

> I'd like to make git log -g / git reflog abort early when trying to
> display a reflog of a ref that has no reflog. Objections?

Do you mean

	$ git checkout -b testing
        $ rm -f .git/logs/refs/heads/testing
        $ git log -g testing

will be changed from a silent no-op to an abort with error?

I do not see a need for such a change--does that count as an
objection?

Thanks.
