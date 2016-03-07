From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding RFC 3161 timestamps to git tags
Date: Mon, 07 Mar 2016 12:19:12 -0800
Message-ID: <xmqq4mcioxbz.fsf@gitster.mtv.corp.google.com>
References: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, i4passt@cs.fau.de, phillip.raffeck@fau.de
To: "Anton Wuerfel" <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 21:19:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad1cf-00046U-5B
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 21:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbcCGUTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 15:19:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752868AbcCGUTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 15:19:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4BDF49630;
	Mon,  7 Mar 2016 15:19:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u130H3LNuu25cxOF9WewJJDqBlg=; b=vO+UsA
	YixjXsMD57vSqK2yInCadoWm0uo8jDvvUeMshDj+7ZS829NibuvQ1r36BqqLJ/BJ
	1mviawUxRuiBiHoNXnUfhZq/CJ9AoDLFlQNqORtxLPmMbdJLZhAFlcMAUl4YAkvN
	OEl7psJbuwDeNPxr7E4j73PCX9TAcYgLSUF5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNvjGEzzvvfZd5aBv0VcoIZLBvN9rjV1
	rZutOfoBM4B8CczO+ihVYJ8MN9F1B6P+7dz0ZF/3SkYiRSD44LI9+nOylIoqF3VR
	aWsVWkKS/PIRsr41LLv5Qtf4MRDEJsUQLVyyfttxZAn1mKjU/7Urj6bD+ko+Xk1x
	VW8dIMvBpaw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C13B54962F;
	Mon,  7 Mar 2016 15:19:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 465864962E;
	Mon,  7 Mar 2016 15:19:14 -0500 (EST)
In-Reply-To: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
	(Anton Wuerfel's message of "Mon, 7 Mar 2016 15:15:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC636CF4-E4A1-11E5-BFE0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288397>

"Anton Wuerfel" <anton.wuerfel@fau.de> writes:

> as part of an university project we plan to implement time stamp
> signatures according to RFC 3161. This enables users to create and verify
> cryptographic time stamp signatures to prove that a commit existed at a
> certain point in time.
>
> As a long-term goal, we would like to get this new feature accepted into
> upstream, so we are very interested in your opinions and suggestions for
> our approach described in the following.
>
> We plan to add new command line options to git tag and call openssl
> similar to how "git tag -s" is calling gpg. The time stamp query generated
> by openssl will be sent to the time stamping authority via libcurl.
> Verification of timestamps will be possible via git verify-tag.
>
> In order to store time stamp signatures, the file format for git tags
> needs to be extended. Similar to how gpg signatures are stored, we would
> store the signed time stamp responses in base64 surrounded by BEGIN and
> END tags:
> -----BEGIN RFC3161-----
> Issuer: [issuer-name]
> [time stamp response in base64]
> -----END RFC3161-----
>
> We plan to offer git config options to configure, which timestamping
> authority to use and where trusted certificates are stored.

A few random thoughts that come to mind, none of which is
rhetorical [*1*]:

 - What should happen when the timestamping service is unreachable?
   The user cannot get her work done at all?  A tag is created
   without timestamp and with a warning?  Something else?

 - Is "signed tag" the only thing that will benefit from such a
   certified timestamping mechanism?  Would it be worthwhile to
   offer a similar support for "signed commit"?

 - How would the certified timestamp interact with GPG signing of
   the tag?  Can they both be applied to the same tag, and if so
   what is signed by which mechanism and in what order or are they
   done independently and in parallel?  E.g. would the timestamp be
   done on the contents without GPG signature, and the GPG signature
   be done on the contents without timestamp, and both signature
   blocks concatenated at the end of the original contents?

 - Would it make sense to store the certified timestamp in the
   object header part, like the way GPG signature for signed commit
   objects are stored [*2*], instead of following the old-style
   "signed tag" that concatenates a separate signature at the end?


[Footnote]

*1* ... meaning that when I ask "Is X true?", I do not mean "I think
    X is true" or "I do not think X can possibly be true".

*2* We designed newer places that use GPG signatures (i.e. signed
    commit and merge tag) to store the signature in the header part
    for a reason: the base64 gobbledygook is not for human
    consumption and showing it together with the original contents
    would not help.
