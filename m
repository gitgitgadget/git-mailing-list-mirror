From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git index containing tree extension for unknown path
Date: Wed, 21 Jan 2015 12:39:04 -0800
Message-ID: <xmqqr3unx40n.fsf@gitster.dls.corp.google.com>
References: <CAENte7gqKpqr=ENOEN_3s3Fz6gc-Kt70OJyZojbgwhR7YVX6Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE23m-0001iM-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 21:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbbAUUjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 15:39:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753716AbbAUUjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 15:39:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4BCB2FE62;
	Wed, 21 Jan 2015 15:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UzAb+iIhpdNBpDIJRm690iTEjoY=; b=M9Z1at
	ROuLeKPWT9wp04wfhit+0ER6vcYxZFz0XO5pySQLariz/bR+ipM1hUzW5uuhIojn
	UL+sWOVL61NhbeloEPOPtPFzpvuPdykps1FpWk3g2T+4hxwC6XAxRL/Zab6ZPtDD
	oriRs8ITEvoYjdTK6eVbyRKzlUBSPfvRMH+ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=STc/tPKgiWSDrXKtznXBKvl4Jdc/NfeZ
	+imBOjaHwq1r3o6JlZYT+ntoBEs71UFX1O6mobGonAMQ2DzIDN7ax92WnMiV1bAW
	aduEX4lepdXkHWeLwZK/RlRA2zU1n2xtzj4714EV/E/2crp2JOXXBThg6SDeBI4n
	pyW5DO27QEo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 990372FE60;
	Wed, 21 Jan 2015 15:39:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1185A2FE5D;
	Wed, 21 Jan 2015 15:39:05 -0500 (EST)
In-Reply-To: <CAENte7gqKpqr=ENOEN_3s3Fz6gc-Kt70OJyZojbgwhR7YVX6Zg@mail.gmail.com>
	(Christian Halstrick's message of "Wed, 21 Jan 2015 17:14:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AF776FE-A1AD-11E4-9B8E-D3749F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262766>

Christian Halstrick <christian.halstrick@gmail.com> writes:

> Is it allowed that the git index contains a tree extension mentioning
> patch 'x/y/z' while the only entry in the index is a '.gitattributes'
> files in the root?

Depends on the definition of "mention", but it is not unexpected
that you see "x", "y", and "z" in the cache-tree extension as
invalidated nodes after you do something like this:

	rm -fr test &&
        git init test &&
        cd test
        mkdir -p x/y/z &&
        >x/y/z/1 &&
        git add x &&
        git write-tree && # cache-tree is fully valid
        mv x/y/z x/y/a &&
        git add x # cache-tree invalidated

"z", if appears, should still know that "y" is its parent and "y",
if appears, should still know that "x" is its parent.  All of the
three should say they have been invalidated by showing a negative
entry-count and show the "correct" subtree count that appear in the
extension (i.e. if "z" is there as an invalidated leaf, it should
say "-1 0" to indicate an invalidated entry by a negative entry count,
with zero subtrees, and "y" would show "-1 1" to indicate an
invalidated entry with one subtree, namely "z", etc.).
