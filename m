From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 14 Feb 2013 08:31:58 -0800
Message-ID: <7vpq023lhd.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <CACBZZX6BVuQWtrLuTVXZo+77sT4yZQ3pvN=_fMma24-zd0NNqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:32:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61jZ-00017t-8p
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3BNQcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 11:32:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab3BNQcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:32:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 757C1B0DC;
	Thu, 14 Feb 2013 11:32:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bxHYUdxkA8Ih
	lt7JemnRIq6SLME=; b=T4BcFAahP1hki+1QuoqYtZ4BuF3n7FKMjwnyLX5E9bFK
	R6CF2CVI/HXDB8EqOB9kjmFj3l7W816/Wgs7M/2QRqmdi2nEUyvOR+BRzJEXnJOs
	SegmxrzdTb86g3a8kNhV/Keq1jccAZtcCPe4M4oGGfRbv/9CoVIXyj0WrpzDUvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cC8n4X
	DRoJatxDL0istdNn8IlhADBQlAR2RLqawYGOOPtEd16NM6fw0fF0Pt96y9AswJaY
	2Nmvtpj8uGgqXIZawGeXsl8iSe2nPx33LiAhUvdtcMzvnFn8pHANn3ZC74dGrQ3S
	SNbXW7i76sm3rKs0fRSixExgY9b54QqWxuqUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E51B0DB;
	Thu, 14 Feb 2013 11:32:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0D75B0DA; Thu, 14 Feb 2013
 11:31:59 -0500 (EST)
In-Reply-To: <CACBZZX6BVuQWtrLuTVXZo+77sT4yZQ3pvN=_fMma24-zd0NNqA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 14 Feb
 2013 16:16:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E402D24-76C4-11E2-898B-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216319>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I looked into this a long while ago and remembered that rebase was
> doing something like a git status for every commit that it made to
> check the dirtyness.
>
> This could be vastly improved by having an unsafe option to git-rebas=
e
> where it just assumes that the starting state + whatever it wrote out
> is the current state, i.e. it would break if someone stuck up on your
> checkout during an interactive rebase and changed a file,...

You could make it a lot safer than "just assumes", and the result
may become generally usable, I think.  For example, you can set a
"magic" bit somewhere in $GIT_DIR/rebase-i while you are in "I am
doing pick/pick/pick and the user will not interfere me" mode, and
clear that bit upon "rebase --continue".  And you cheat only while
that "magic" bit is set.
