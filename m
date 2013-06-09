From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sun, 09 Jun 2013 11:49:44 -0700
Message-ID: <7v8v2jqfuf.fsf@alter.siamese.dyndns.org>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkgZ-00006L-G1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab3FISts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:49:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab3FIStq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 14:49:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24F6C257E6;
	Sun,  9 Jun 2013 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MhsePdupjLiE
	UO9du6f/CbV/49Y=; b=bhsWGjvTpKDFwkKiLLmwTT1nFTSHxp9On6bOddZB53Qh
	rEgen7mc4/UDF3Gz/ktrzKQxzxjRIas46fLPiknITYxu1pegpYEX/L6dkPZ3kfy/
	vVg0uWub0dG94KNTCgJIJ2c6Yl3VLdf+Mf6Lt9iwr/u7v2mrR6F60K/YxtyhauE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rcdYn1
	iXkXIeKJoKOe4E3QcKc8U3nyVdynlvioVpjW04HC6vVA94xOExKfCKgSwlEXf3z0
	YNFXnmKfNS04a8jCDFMdRH7AW+GfphBtM+e43hmDO3N7b0OE9eOC8UB6JgzIH+rk
	MyHfXE3e0uvsNp4UrzlDbe3HwMxOozrO/vqHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD90257E4;
	Sun,  9 Jun 2013 18:49:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79DDF257E3;
	Sun,  9 Jun 2013 18:49:45 +0000 (UTC)
In-Reply-To: <51B32FFD.5070302@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Sat, 08 Jun 2013 15:22:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A6D0016-D135-11E2-AA2B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227095>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> A comment before read_index_from says "remember to discard_cache()
> before reading a different cache!".  That is probably a reminder that
> read_index_from does nothing if ->initialized is set.  Entries added
> before calling read_index_from make up a different cache, however, so
> I think this comment applies for the call sequence above as well.

Yes, you can lose the probably from there.  Back when he comment was
added at 8fd2cb406917 (Extract helper bits from c-merge-recursive
work, 2006-07-25), there was only one in-core index, and checking
active_cache or cache_mmap is not NULL was a way to say "Have we
loaded from $GIT_DIR/index already?  If so, there is nothing more to
do".

Later unpack_trees() added a way to populate the index not by
reading from $GIT_DIR/index and the original "Has file, hence is
loaded, so ignore read_cache()" caused issues.  A discussion was in=20

    http://thread.gmane.org/gmane.comp.version-control.git/93260/focus=3D=
93469

which brought the "initialized" bit in, which lead to 913e0e99b6a6
(unpack_trees(): protect the handcrafted in-core index from
read_cache(), 2008-08-23).

> Side note: I wonder why we need to guard against multiple
> read_index_from calls in a row with ->initialized.  Wouldn't it be
> easier to avoid the duplicate calls in the first place?  Finding them
> now might be not so easy, though.
