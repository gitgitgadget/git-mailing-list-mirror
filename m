From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 08:27:05 -0800
Message-ID: <7vd2worm3q.fsf@alter.siamese.dyndns.org>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
 <CACsJy8A5VJ4EchbeFEC5ikLYgHze47_xyLTtgH=kqVpP15Hogw@mail.gmail.com>
 <7vk3qwrmea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0E27-0006gz-MS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab3A2Q1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:27:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab3A2Q1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:27:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5B39B3EF;
	Tue, 29 Jan 2013 11:27:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfB5hpDBUyeUf9RpT/zosjXkXeA=; b=lz/xbv
	1iSUJKT4uYRyCAFlhg4cpW8UBCgg5j1SBMJQcj3eZ50srONWjf5GLcDPBSVSp37C
	sC6KJ/uPoQq5cQTC0eF3n0S+Cgoy4CqRNH1CpBN5Ym9NKvSXFqwry0W1JBB3/G23
	owmQvs+5hj3w9OSf2AUtI+kUO8cKAikiVp90A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gq6aGtinrjqLkN72JoqVj9CYvkA35ufL
	8hH4ArnifYQrUVNIpuFZF/TsuNsEfzjYQxfugyIsUWZ8z+AnqzVFWT02Me0wA+kO
	ZIa9Az3LPTPPtFMDY+CpTVoeh+v5oyPb7V8oBgeJsOifOfYDdmPKtyCoN0sQx6DZ
	s/XAFJ/QKc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAD04B3EE;
	Tue, 29 Jan 2013 11:27:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55AE6B3E6; Tue, 29 Jan 2013
 11:27:07 -0500 (EST)
In-Reply-To: <7vk3qwrmea.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Jan 2013 08:20:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B941BBE8-6A30-11E2-A2A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214946>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Jan 29, 2013 at 11:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> :(glob) magic
>>> =============
>>>
>>> This magic is for people who want globbing. However, it does _not_ use
>>> the same matching mechanism the non-magic pathspec does today. It uses
>>> wildmatch(WM_PATHNAME), which basically means '*' does not match
>>> slashes and "**" does.
>>>
>>> Global option --glob-pathspecs is added to add :(glob) to all
>>> pathspec. :(literal) magic overrides this global option.
>>
>> I forgot one thing. The current pathspec behavior, the pattern "[a-z]"
>> would match a file named "[a-z]" (iow, wildcards are also considered
>> literal characters).
>
> That sounds like a blatant bug to me (unless you are talking about
> "literal" case).  We should fix it before we include it in any
> released version, I think.

Ah, no, I misread what you meant.

Yes, historically when matching a path with a pattern "a/b[c-d]/e",
we tried to first literally match the path with it (this allows the
path "a/b[c-d]/e" to match with the pattern), and if it did not
match, used fnmatch(3) to allow "a/bc/e" to also match.  This was an
ugly hack to cope with the possiblity that such a funny path is
actually used in projects.

With :(literal) magic and its friends you are working into the
system, the hack should disappear at the same time when you stop
running fnmatch(3) without FNM_PATHNAME.  That should happen no
later than Git 2.0.

But until then, we should keep matching both paths "a/bc/e" and
"a/b[c-d]/e" with pattern "a/b[c-d]/e", for backward compatibility.

Sorry about the earlier confusion.
