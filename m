From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Mon, 11 Jan 2010 12:05:31 -0800
Message-ID: <7v3a2cif04.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <7vpr5krxoo.fsf@alter.siamese.dyndns.org>
 <7v4omte72j.fsf@alter.siamese.dyndns.org> <201001112022.31257.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUQWO-0008Rj-9w
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 21:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab0AKUFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 15:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003Ab0AKUFn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 15:05:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab0AKUFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 15:05:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29F049036F;
	Mon, 11 Jan 2010 15:05:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NheDCXXrSUeJE0IJ6ihPIA3psg0=; b=E7a+FS
	Gk4uKn1uRxyfk0IqdCmKmPeBdPYTErRjgkwJ3bSh89x1lbA5q6zMgR3iEdL3KHc8
	1+hX0lg2Thb9zv3voxzD8TPy0jMYwVOTBQBOZbabdwwvM7AtmMrC8WcMiz1Dp8fd
	smdNoIGPAXlnr8WSdFPK82HYr1srVmqwFGnVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hsOSFhesrPqn963G5JFWCGbpB+Yk8hug
	ka09PPRHWxsY79IqYdwbqQD/UcDADHSqObOBoY+57EwkZwhB7qzE6+2BvF+UTKoe
	iw6QatsSzfwyrq4EopldfK+qlV2cLP9Ur2w9BXGxts1VO2VbX29ddFFmPkAqw4m/
	fGGdg75RAUI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 059619036D;
	Mon, 11 Jan 2010 15:05:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BBC490369; Mon, 11 Jan
 2010 15:05:33 -0500 (EST)
In-Reply-To: <201001112022.31257.j6t@kdbg.org> (Johannes Sixt's message of
 "Mon\, 11 Jan 2010 20\:22\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE6DA0B8-FEEC-11DE-A212-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136660>

Johannes Sixt <j6t@kdbg.org> writes:

> I did encounter a case where the same resolution would apply to all
> conflicts that have the same conflict hash, so it's not quite what you
> talk about. But not all conflicts were automatically resolved. I haven't
> yet analyzed what happened - it could just be that the xdl_merge call
> fails due to the differences in the text immediately outside the
> conflict markers.

Actually it is _very_ easy to fool rerere to do something totally
unexpected, and I have been thinking about using the similarity comparison
algorithm on the region outside the conflicted area between preimage and
thisimage and reject use of rerere.

Try this in an empty directory.

-- >8 --

#!/bin/sh

git init

create_numbers () {
	for n in 0 1 2 3 4 "$1" 5 6 7 8 9
	do
		echo $n
	done >numbers.txt
}

create_letters () {
	for l in a b c d e "$1" f g h i j
	do
		echo $l
	done >letters.txt
}

create_files () {
	create_numbers "$1"
	create_letters "$1"
}

create_files ""
git add numbers.txt letters.txt
git commit -m initial
git branch side

create_files "+"
git commit -a -m master

git checkout side
create_files "-"
git commit -a -m side

mkdir -p .git/rr-cache

# On this history we changed an empty line to +; merge
# with another history that changed it to -
git checkout master^0
git merge side

# The above should have conflicted.  The resolution is to '='

create_numbers "="
git rerere

git rerere status
git rerere diff
cat numbers.txt
cat letters.txt

-- 8< --

Now, immediately after this sequence, rerere will give you an disaster.
