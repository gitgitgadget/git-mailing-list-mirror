From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] builtin/fetch.c: Add pretty_url() and print_url()
Date: Wed, 18 Dec 2013 13:47:11 -0800
Message-ID: <xmqq8uvhhlwg.fsf@gitster.dls.corp.google.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOxi-0005PN-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab3LRVrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:47:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab3LRVrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 754675A2C1;
	Wed, 18 Dec 2013 16:47:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTtEmC90j+CtTOXHTCM/fftrRoI=; b=TBRyIZ
	0NV8paYs8hKHYMT8Q2Vr5TJqnk+DnguHGSdWacwRwJtpuJpIYDc9/xYG/ohCdbDr
	OS1WGEO/TFAZpY9W2at/5c2qIEUIECOf1PlALhXJZVNJwDsidRrz/5SkgBpJN+Lj
	uRkSNpJrTpLYmQUeR5FPRfGtfnJEK5Z46zQGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Am9+dU+mSHYWUV0FYRp0PpRs7J9E+vt1
	jbHM9lYssFjXWHe7tExiuhtcgUxylhngqh+PGo/6+3uKWRXBkfLTTFif0I5GxBCU
	rRuKtmnIwEHnux82ixiXAzUOU2juAhuBGpDE5U/GVgTPayrpmX7QZT869YJBzGOj
	to6C0a7vxpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 560A35A2C0;
	Wed, 18 Dec 2013 16:47:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65B875A2BC;
	Wed, 18 Dec 2013 16:47:13 -0500 (EST)
In-Reply-To: <1387401776-30994-1-git-send-email-jackerran@gmail.com> (Tom
	Miller's message of "Wed, 18 Dec 2013 15:22:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F46476E2-682D-11E3-BF17-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239492>

Tom Miller <jackerran@gmail.com> writes:

> In order to fix branchname DF conflicts during `fetch --prune`, the way
> the header is output to the screen needs to be refactored. Here is an
> exmaple of the output with the line in question denoted by '>':
>
> 	$ git fetch --prune --dry-run upstream
>>	From https://github.com/git/git
> 	   a155a5f..5512ac5  maint      -> upstream/maint
> 	   d7aced9..7794a68  master     -> upstream/master
> 	   523f7c4..3e57c29  next       -> upstream/next
> 	 + 462f102...0937cdf pu         -> upstream/pu  (forced update)
> 	   e24105a..5d352bc  todo       -> upstream/todo
> 	 * [new tag]         v1.8.5.2   -> v1.8.5.2
> 	 * [new tag]         v1.8.5.2   -> v1.8.5.2
>
> pretty_url():
> This function when passed a transport url will anonymize the transport
> of the url. It will strip a trailing '/'. It will also strip a trailing
> '.git'. It will return the newly formated url for use. I do not believe
> there is a need for stripping the trailing '/' and '.git' from a url,
> but it was already there and I wanted to make as little changes as
> possible.

OK.  I tend to agree that stripping the trailing part is probably
not a good idea and we would want to remove that but that definitely
should be done as a separate step, or even as a separate series on
top of this one.

> print_url():
> This function will convert a transport url to a pretty url using
> pretty_url(). Then it will print out the pretty url to stderr as
> indicated above in the example output. It uses a global variable
> named "gshown_url' to prevent this header for being printed twice.

Gaah.  What is that 'g' doing there?  Please don't do that
meaningless naming.

I do not think the change to introduce such a global variable
belongs to this refactoring step.  The current caller can decide
itself if it called that function, and if you are going to introduce
new callers in later steps, they can coordinate among themselves,
no?
