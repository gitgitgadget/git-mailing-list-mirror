From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commiting automatically (2)
Date: Sun, 19 Dec 2010 11:32:32 -0800
Message-ID: <7vaak1ftin.fsf@alter.siamese.dyndns.org>
References: <loom.20101219T090500-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Dec 19 20:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUOzw-00068J-RN
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 20:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab0LSTcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 14:32:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424Ab0LSTcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 14:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1192B31AF;
	Sun, 19 Dec 2010 14:33:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKK1BOKF7hzFyzCbDZfvtzWpbkY=; b=RTC3Eg
	mihVTOqAXsqDtcRMWWkYciAWWG7alpu+JHgYUQxcocdbp9bhb4GuUlu6hlNh5lGR
	PKhHFOTQrIZLJknEX5gh897iX4VUSHd2om/byRXKWkxtfgvROvg9q8wv4YLNDljQ
	ru2uAfXLRieTe83OfyRQqcJYmBqawNJhB10kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Af7TYWv0YgvVg8uMuFQUdbagZeaxdoar
	RHhmMo5VZP0ULFwRDlAxmd1WDPk5J1nxp9Jerq8gYUfSsuxrEa/1ySDthoy1Pnka
	/n+Zbw0d8QtkRF9rp00JYZH99qoSLzjRpt6mORRJ7IcEgWpReirBz7y8wIkV4Aug
	2hb4VnRjTao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E370731AD;
	Sun, 19 Dec 2010 14:33:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09DB131AC; Sun, 19 Dec 2010
 14:33:04 -0500 (EST)
In-Reply-To: <loom.20101219T090500-396@post.gmane.org> (Maaartin's message of
 "Sun\, 19 Dec 2010 08\:29\:50 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE8CE620-0BA6-11E0-B246-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163966>

Maaartin <grajcar1@seznam.cz> writes:

> However, when I use my git-autocom script, those files get marked as deleted. 
> This is quite strange, especially because of them still existing. I'd strongly 
> prefer git-autocom to behave just like git commit (i.e., tracking the files).
>
> The relevant part of my script follows:
>
> export GIT_INDEX_FILE=.git/autocom.tmp
> git add -A &&

If you really want "just like commit", then it would be more like "make a
commit object out of the current index, and put that somewhere outside the
current branch", and will not involve any "git add", no?

A useful goal would be "as if I said 'git add -u && git commit' from the
current state" (alternatively, you could say s/-u/-A/).

If this autocom.tmp starts out empty, "add" will of course honor what you
wrote in .gitignore hence would not add ignored files.  You may have '*.o'
in the ignore mechanism to exclude usual build products.  Until you
somehow tell git that you care about a vendor-supplied binary blob file
"binblob1.o" even though it has a name for usual ignored ones, you don't
want to get it tracked, and once you have done so with "git add -f", you
do want to get it tracked from that point.  But your script cannot be
clever enough to selectively say "add -f" for such a file.

The "from the current state" part of the sentence of your goal (clarified
by the second paragraph above) fundamentally means you need to start from
your real index, so "cp -p .git/index $TMP_INDEX" is both appropriate and
inevitable for your script.
