From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 02:24:27 -0700
Message-ID: <7vpr1tb1kk.fsf@alter.siamese.dyndns.org>
References: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com>
 <7vtyr5cxnz.fsf@alter.siamese.dyndns.org>
 <i2r41f08ee11004210202r642aa25dy32b06c33ed98ba4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 11:24:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4WAo-0007w7-J2
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 11:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0DUJYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 05:24:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0DUJYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 05:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F35ADAC1F4;
	Wed, 21 Apr 2010 05:24:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=unF4jRqPGM91p5uNC/3A9r7BksM=; b=ZT0B5X
	lv7+R2yP0yHZdxUiowL1vz1l2DmjiXt4pGq6sAWpU90mFdAH1x7stzLPYTaYEwYq
	unvV/F7Sq3AvbEIuv4BqG6bd0ZzGn912EMe68BvDgv3P9COAkJQ3TfhkZ6AoqFmL
	YWsxGeQJJ0SPq0a9H0knW0BodabjlmigpK8oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N78pTz6GOSCcbeJw15R5pSjCHxZj8AB4
	SZ/NXPD/5uLBg9VAnNXp3mQlsQHeya4lyfNSSVciKmFWj29m7l3Fx+3JnR9s4KO3
	7rt7rATWYLugvynJybQzdguddYVWR9RYDH2mpVKTwPz7kOMw1yqQjOdqGVC6D7AU
	OGnRd+SVXSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B94AC1EE;
	Wed, 21 Apr 2010 05:24:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5687AC1EA; Wed, 21 Apr
 2010 05:24:28 -0400 (EDT)
In-Reply-To: <i2r41f08ee11004210202r642aa25dy32b06c33ed98ba4c@mail.gmail.com>
 (Bo Yang's message of "Wed\, 21 Apr 2010 17\:02\:24 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B26CB7CE-4D27-11DF-94AF-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145423>

Bo Yang <struggleyb.nku@gmail.com> writes:

> I am really wondering, when -R is used, how the file rename/copy
> should defined? Now, I can make -R works with --follow, and it produce
> something like:
>
> byang@byang-laptop:~/git/git$ ./git diff --follow --name-status maint
> master -- builtin/log.c
> R089    builtin-log.c   builtin/log.c

As I already said, it is a bug that "diff" does not diagnose it an error
when you give it the "--follow" option.  It was designed to be used with
"log" family, and never with "diff" family.

When a command from the "log" family traverses the history, it internally
runs "diff-tree" between the commit C it is currently looking at, and its
parents C^$n.  When you give one path and --follow [*1*], it may notice
that C has the named path and C^$n doesn't.

At that point, it internally runs "diff -M C^$n C" to see if there is a
corresponding path in C^$n, and switch to follow the path it found in
the parent commit.

The logic only detects the case where "new" side has a path that "old"
side doesn't [*3*], and it is not even designed to be used with -R (where
it needs to be given a path that does not exist anymore on the "new" side
but used to exist in the "old" side).

Heck, it is not even designed to be used with "diff" as I already said
twice ;-).

Even in the context of "log", it is a hack.  It globally keeps one single
path that it follows, which obviously would not work in a history with
merges.


[Footnote]

*1* "log" command line parser enforces this "only one path" condition;
"diff" doesn't even bother catching it as an error to give "--follow", so
it lacks the logic to further catch it as an error to give more than one
paths.

*2* No, I don't think there is an interface to tweak the -M to -C or -C
-C; see tree-diff.c and look for try_to_follow_renames().  I think it is
probably Ok to make this tweakable, and I suspect that is what your patch
is about, but don't use "git diff" as an example nor in any of your tests.

*3* This is exactly why "diff --follow maint master -- builtin/log.c"
appears to do something remotely sensible (notice that the path is what
exists in the "new" side) but "maint master -- builtin-log.c" does not.
The logic doesn't even care if the named path does not appear in the "new"
side at all, because that is not useful at all in the way "log" internally
uses "diff-tree" logic.
