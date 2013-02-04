From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 04 Feb 2013 09:43:10 -0800
Message-ID: <7v8v742cwh.fsf@alter.siamese.dyndns.org>
References: <51065540.1090007@renemoser.net>
 <87txq11sbk.fsf@pctrast.inf.ethz.ch> <20130128204140.GA7759@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Rene Moser <mail@renemoser.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Q4w-0001hS-8o
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 18:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab3BDRnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 12:43:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab3BDRnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 12:43:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C124DD0F;
	Mon,  4 Feb 2013 12:43:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pibpf0RNLUBBFO6KiSKybcZDyLA=; b=pqNQ3Y
	1MIC2fnskKL8xp3oNh72D49b2j4fMlPKvhR1AkOgs6UJvwjIbJAy0l3Sn4rureJZ
	zAhga9UF2aTqKaJqbq09Z2ECyrrmzwBMqHnnsElcl9uLwDuVbnbV/5Gvu+SjaExo
	F26CgQTLCcokszRXvPIpnUrgQfQrLNna4TEl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gwcH3VSYTic+o9VTnU6af4QxoCFHwQA3
	JcnFSk/cZ4kY/sJIfU7kzZ3pYLT4D0skkH3/hVL2rCbQnPj/hiD8MbdMJrhRCD79
	JU2f/n6jIlMtTPCDRix6K1CHUZBg4Ew5L9NWrANjctOkW/A1t8OaggH0BEGSsSxA
	saobsvAQEjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A28DD0D;
	Mon,  4 Feb 2013 12:43:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E24D5DD0B; Mon,  4 Feb 2013
 12:43:11 -0500 (EST)
In-Reply-To: <20130128204140.GA7759@google.com> (Jonathan Nieder's message of
 "Mon, 28 Jan 2013 12:41:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 586F1E02-6EF2-11E2-9376-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215402>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no
>> need to read blob from the standard input, 2012-06-27), which is
>> included starting with v1.7.12 and the v1.7.11.3 maint release.  Please
>> upgrade.
>
> Should upgrade-averse folks stuck on 1.7.10.y (like Debian 7.0, which
> is currently in the release candidate stage) take this fix?  Do you
> happen to know of any other fixes such people would want?

I've been wondering if we can help automating this for backporters.

Because of the way my integration branches are managed, if you run

	git log --first-parent v1.8.0..maint-1.8.0
	git log --first-parent v1.8.1..maint

the output should give us a birds-eye view (because most are merges
of one or more patches on a topic) of the changes that are fixes,
excluding any feature enhancements.

You can then iterate over the single patches applied directly on top
of maint (or maint-1.8.0) and tips of the topics merged to maint (or
maint-1.8.0) and see if each of them is applicable to maint-1.7.10
codebase.  I think you can mechanically reject the ones that are on
'maint' that merge topics that were forked from v1.8.1 as too new.
That hopefully culls the topics that needs manual review and
assessment (some may be too minor to be worth backproting, for
example).

You should be able to do the same for

        git log --first-parent v1.8.1..master

There will be fixes and features mixed in the output, but if you
can mechanically narrow down the ones that may be relevant to your
old maintenance track, eyeballing the rest to judge if each of them
is worth backporting will become a manageable task.
