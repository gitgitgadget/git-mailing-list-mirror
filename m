From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 08:06:56 -0700
Message-ID: <7vehn98qcv.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
 <20120814071823.GA21031@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 17:07:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Iie-0003iW-1J
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 17:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656Ab2HNPHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 11:07:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab2HNPG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 11:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AEF8796C;
	Tue, 14 Aug 2012 11:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CNncvbG8VrxTuPxrQPXGGAV9B8M=; b=jjV8Jt
	/rHwM0TIs214a/imaFLbqKtgRY3S7lg+keKvAW1ovXY3PsPFFV28Bw2a4dY10wPY
	e/TBD6svFWWLGx2Alm0F4qzxAG+dzfxZbKwA+RgeUjUxP/BY8xMYxTDo4QprryeF
	NU6nWPVV28o6UjU9P3lDVz2UCp9gzOvYEmHjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TzWGQRJ3updK3nqolJqkzBZc9FTnntKh
	qCZ+FHnRWg5xBsLjpcIqnJbOMnW0sWOvKa+VrYHyTlH4Y8yRc2wktGLWCxcv+kQM
	qCjQo2SEKGJI4BJiF/D5Gor027QXEowKOnHxzD2uICWtejA+MPolCeOwN7kJWudX
	ee2Y9Nfr/v0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ECBF796A;
	Tue, 14 Aug 2012 11:06:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB57A7966; Tue, 14 Aug 2012
 11:06:57 -0400 (EDT)
In-Reply-To: <20120814071823.GA21031@hashpling.org> (Charles Bailey's message
 of "Tue, 14 Aug 2012 08:18:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1297A4C-E621-11E1-BE83-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203404>

Charles Bailey <charles@hashpling.org> writes:

> On Tue, Aug 14, 2012 at 12:07:26AM -0700, David Aguilar wrote:
>> Right now there are two code paths, resolving deletion conflicts
>> and resolving symlink conflicts, in git-mergetool that do not
>> honor --no-prompt.  They force user-interaction with the shell
>> even though the caller (such as a program) said that they do
>> not want to be prompted.
>> 
>> This was an oversight from when this option was first added.
>> 
>> I think a simple and sensible thing to do would be for mergetool
>> to skip over these entries when --no-prompt is supplied.
>> 
>> Does this sound like a good idea?
>
> --no-prompt is designed to remove the prompt before launching a
> mergetool. This is because it is mostly pointless but does provide a
> convenient point to interrupt (C-c) a large multifile conflict
> resolution.
>
> It was never supposed to be a batch mode switch. By it's very nature
> mergetool is interactive so I don't see any advantage to pretending
> otherwise.

Could it be that the calling user or script does not even have a
terminal but still can spawn the chosen mergetool backend and
interact with the user via its GUI?  Or it may have a terminal that
is hard for the user to interact with, and the prompt and "read ans"
may get stuck.

In such an environment, the ideal behaviour for the "git mergetool"
frontend may be not to interact via the terminal at all and instead
run its interaction to choose the resolution using a matching GUI
interface.  I see when "read ans" fails (e.g. the standard input to
the mergetool is closed), resolve_{symlink,deleted}_merge will not
get stuck but instead fail, so perhaps David's issue could be solved
by running "git mergetool --tool=... </dev/null" or something?
