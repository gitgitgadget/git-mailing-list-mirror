From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 10:35:48 -0700
Message-ID: <7vppunllzf.fsf@alter.siamese.dyndns.org>
References: <51E029B9.20108@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 19:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhG8-0000Bv-AO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080Ab3GLRfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:35:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813Ab3GLRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:35:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 395F22F91A;
	Fri, 12 Jul 2013 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RNFbJZCnPwtW3nVlluht0glOJvs=; b=vWM9TD
	VfnZNKjZzFsRV0seVTvv2EVEqiEFOHvGTYO/VuFn1DTS1+12W7mDfibQgeNiuMYN
	psn94yXx6xKNrRy/cBebWBq9wGrEyECU+6ACTsXti88F/F/Sqg5zucuFmG4toKYW
	99Ml/oU4tu8YDXY6QIwNO/kMQlQk9e3GkiQts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T65lb8Z3tyPHen6nxZeu8TFqLchU9a1e
	sdASbOzcVE5VXdbXBkhqWNhcSK7ejbqNj84tQdjKOTsr2wSwe6Gob1yrP8T8VnWG
	ZmKnoZc/5A+Kd10UU8rQv6Q145NkxEkQPct2MNre8Z9B67ZRQkIM0zr+hxTVBFV0
	N5/xTuUv6BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2142F919;
	Fri, 12 Jul 2013 17:35:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A2132F917;
	Fri, 12 Jul 2013 17:35:50 +0000 (UTC)
In-Reply-To: <51E029B9.20108@googlemail.com> (Stefan Beller's message of "Fri,
	12 Jul 2013 18:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E836596-EB19-11E2-AA4F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230232>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Hello,
>
> you may have noticed I am currently trying to bring the 
> mailmap file of git itself up to date. I noticed
> some behavior, which I did not expect. Have a look yourself:
>
> ---
> 	# prepare test environment:
> 	mkdir testmailmap
> 	cd testmailmap/
> 	git init
>
> 	# do a commit:
> 	echo "asdf" > test1 
> 	git add test1
> 	git commit -a --author="A <A@example.org>" -m "add test1"
>
> 	# commit with same name, but different email 
> 	# (different capitalization does the trick already, 
> 	# but here I am going to use a different mail)
> 	echo "asdf" > test2
> 	git add test2
> 	git commit -a --author="A <changed_email@example.org>" -m "add test2"
>
> 	# how do we know it's the same person?
> 	git shortlog
> 	A (2):
> 		  add test1
> 		  add test2

You don't, and it is a long known behaviour.

> 	# reports as expected:
> 	git shortlog -sne
> 		  1  A <A@example.org>
> 		  1  A <changed_email@example.org>

Yes.

> 	# Adding the line to the mailmap should make life easy, so we know
> 	# it's the same person
> 	echo "A <A@example.org> <changed_email@example.org>" > .mailmap
>
> 	# Come on, I just wanted to have it reported as one person!
> 	git shortlog -sne
> 		 1  A <A@example.org>
> 		 1  A <a@example.org>

Err, where does the lowercase a@ come from in the above?  Are we
missing some steps before we get here?

> 	# So let's try another line in the mailmap file, (small 'a')
> 	echo "A <a@example.org> <changed_email@example.org>" > .mailmap

This is ">", not ">>", I presume?  Otherwise changed_email is mapped
to two destination, no?

> 	# We're not there yet?
> 	git shortlog -sne
> 		 1  A <A@example.org>
> 		 1  A <a@example.org>

Expected, as long as some hidden set-up you did not describe that
caused me to say "Err, where does the lowercase a@ come from" is
there, i.e. one of the two commits is done by <a@example.org>.

> 	# Now let's write it rather explicit: 
> 	# (essentially just write 2 lines into the mailmap file)
> 	cat << EOF > .mailmap
> 	A <a@example.org> <changed_email@example.org>
> 	A <a@example.org> <A@example.org>
> 	EOF
> 		 
> 	# works as expected now
> 	git shortlog -sne
> 		 2  A <a@example.org>

Makes sense.

> 	# works as expected now as well
> 	git shortlog      
> 	A (2):
> 		  add test1
> 		  add test2
