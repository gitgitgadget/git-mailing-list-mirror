From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Tue, 19 Feb 2013 15:40:16 -0800
Message-ID: <7v4nh750v3.fsf@alter.siamese.dyndns.org>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com> <7v8v6j52qf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7wnk-0005D9-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 00:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135Ab3BSXkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 18:40:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756502Ab3BSXkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 18:40:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B5C1B335;
	Tue, 19 Feb 2013 18:40:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=phTy0LeN0OOVpHMt/bIyX8I407Q=; b=HwR9TW
	OBnI3VaHZg2KVxV98G4P3AxRlsX5e4Tn5OKxvHa8ANW4yNlnjHIGTpfMX2olpju0
	cv+HY1GaQXgujtPmNfcmQSpn8xz5nDrxRVHjqFwaihb7NDqYni1RU7bUmpYmMhA5
	f4xwvQ2MpnS3kV/GU9aAuW0z6J3dbA5m4FABE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iS5vvn8EjqAKUYb0m3R1BcwkIn4n2K/W
	cHDRlRxyECWXjCmxckzZj6X5pKQjVGGEN8ztkOt+9S7ucNBYfOUXalMIQcG0+nMU
	wmIwjDjTg5WmSbtW8X+cBeqYSnPhDY2e+WAUYNBbm+nuTDjLHQ+rKZVAPdelM4GM
	wwOluxvP5LI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9B9B334;
	Tue, 19 Feb 2013 18:40:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA646B333; Tue, 19 Feb 2013
 18:40:17 -0500 (EST)
In-Reply-To: <7v8v6j52qf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Feb 2013 14:59:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B76C7CF4-7AED-11E2-AC46-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216667>

Junio C Hamano <gitster@pobox.com> writes:

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Html documents will be installed to root dir (/) no matter what prefix
>> is set, if run these commands before `make` and `make install-html`:
>>
>>     $ make configure
>>     $ ./configure --prefix=<PREFIX>
>>
>> After the installation, all the html documents will copy to rootdir (/),
>> and:
>>
>>     $ git --html-path
>>     <PREFIX>
>>
>>     $ git help -w something
>>     fatal: '<PREFIX>': not a documentation directory.
>
> I am not sure if this description is correct.  The generated configure
> seems to set
>
> 	datarootdir='${prefix}/share'
> 	htmldir='${docdir}'
>       docdir='${datarootdir}/doc/${PACKAGE_TARNAME}'
>
> so it is likely you would get not <PREFIX> but <PREFIX>/share, no?

This was a mis-diag; without docdir mentioned in config.mak.in, we
do not even get that far, and htmldir will end up being empty, and
the runtime code adds <PREFIX> to it in system_path().  What I was
describing was what happens when you only mention @docdir@ but not
PACKAGE_TARNAME in the file.

> And the worst part is that having to know that the file needs to
> export docdir and PACKAGE_TARNAME feels to me that we are tying
> ourselves to too much detail in the internal implementation detail
> of versions of autoconf we happen to have for testing this change.

This still stands. It really feels wrong that this file has to be
aware of such an implementation detail of autoconf.  But as an
interim workaround, setting these two otherwise unused variables may
be the best we could do.

I am not sure if such a layout can be actually used for installing,
though.  Didn't we see some issues around the relativeness of
htmldir and mandir vs passing them down to Documentation/Makefile,
or is it not an issue when ./configure and config.mak.autogen is
used?
