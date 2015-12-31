From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Wed, 30 Dec 2015 16:23:09 -0800
Message-ID: <xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com>
References: <cover.1451298323.git.mostynb@opera.com>
	<xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
	<5681D02C.1040609@opera.com>
	<xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
	<5684702C.3040802@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Mostyn Bramley-Moore <mostynb@opera.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aER1R-0007b1-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbbLaAXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:23:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750966AbbLaAXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:23:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7B12379AE;
	Wed, 30 Dec 2015 19:23:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOdbtzMUPjRMliEEVq2OVUfUl4o=; b=gcSJtd
	BbcCzfeyS0RQsn23WE68L5SdofOxQeT4HUHI+3+0yUnsg5eN3s6TjYjc2W1VH8UR
	ULF5AMfXbEWX59rebM01jyMrvlqhzgQFR0mNXmfE8DL7bU5pc7WZZDb4YgEiGSJf
	oDtyA/OPKPS+igK8KaewoUKbVt8b2Hl2HK9K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h2KK3U+zbswXB7ncJg9LgnJgszMYBTf4
	AvE4h7dcaeBgB1qjXrngUIn8Py1ubTQQ3UL5TPlq74ZM1rMrRq2djeBAobZsJZQI
	at4/7QC/nxYSd8GUxjhmTfUpe0PjhOR2H/o/Y6DRxB8DFxUvlazPKJW9UQXpKATo
	xZGaeUmXZ3I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF23F379AD;
	Wed, 30 Dec 2015 19:23:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 267B8379AC;
	Wed, 30 Dec 2015 19:23:11 -0500 (EST)
In-Reply-To: <5684702C.3040802@opera.com> (Mostyn Bramley-Moore's message of
	"Thu, 31 Dec 2015 01:00:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC8D033C-AF54-11E5-A130-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283222>

Mostyn Bramley-Moore <mostynb@opera.com> writes:

> OK, brainstorming a bit, how about either of these:
>
> 1)
> --match-pattern-type=<glob|fixed-strings|basic-regexp|extended-regexp|perl-regexp>
>
> It's a bit lengthy (maybe --match-type would be sufficient), but I
> like that the value names are shared with git grep etc option names.
> And it seems future-proof- if we ever need to support different
> pattern types for other arguments, a --foo-pattern-type flag could be
> added and make obvious sense.

Swapping the option key and value may not be a bad idea, but one
problem that the above does not solve, which I outlined in the
message you are responding to, is that "match-pattern-type" does not
give any hint that this is about affecting the match that is done to
"refs", e.g. you cannot tell in

  $ git mgrep --match-pattern-type=perl-regexp -e foo --refs 'release_*'

if the perl-regexp is to be used for matching branch names or for
matching the strings the command looks for in the trees of the
matching branches.

Magic pattern annotation like we do for pathspecs Duy raised may not
be a bad idea, either, and would probably be easier to teach people.
Just like in Perl "(?i)$any_pattern" is a way to introduce the case
insensitive match with $any_pattern, we may be able to pick an
extensible magic syntax and decorate the pattern you would specify
for matching refnames to tell Git what kind of pattern it is, e.g.

  $ git mgrep -P -e foo --refs '/?glob/release_*'

I am not suggesting that we must use /?<pattern type name>/ prefix
as the "extensible magic syntax" here--I am just illustrating what
I mean by "extensible magic syntax".
