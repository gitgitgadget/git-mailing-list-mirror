From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Wed, 15 Aug 2012 16:15:08 -0700
Message-ID: <7va9xv4uir.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
 <7vd32whgvl.fsf@alter.siamese.dyndns.org>
 <20120813170221.GB6418@book.hvoigt.net>
 <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
 <20120815165054.GA43523@book.hvoigt.net>
 <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
 <20120815222911.GA44080@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 01:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1mo6-00035n-34
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 01:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2HOXPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 19:15:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab2HOXPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 19:15:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C39479053;
	Wed, 15 Aug 2012 19:15:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dumQJ9WznNO0rglvMZlEOp/NdYc=; b=fIg42A
	f0L36beE3NINmZlzJu180R9XdMH91BYDPKPIQTAN1vHODy7ZG1NK6c1o4zvy5o7q
	dQaFY925CfBHCFwTlL8OlCCwUqeztjuXN51PKn8RjHWUSmM8hJtSFobB3DKzZiPr
	CUIVRLj1dk0RfI1yqh8PtxDW4/f/e8pXNHnjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwCB3NytbR8arxCTGIFXZ0aBMQ+k9bTx
	Q4rfi594YEy9ZpwEIjrJ7PwFFfIFMsp9OPUbDW8N1s0PKkf4cbNrGPfnbNX6oQeL
	T7rvVU9kISCcVaVCAu3DjbK5QD+obzlQwMGnbmQr3qU0soaGw7pfXzG0itvFojih
	z9sfC5N9MqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFB489052;
	Wed, 15 Aug 2012 19:15:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 205229051; Wed, 15 Aug 2012
 19:15:11 -0400 (EDT)
In-Reply-To: <20120815222911.GA44080@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 16 Aug 2012 00:29:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FBDCD20-E72F-11E1-B608-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I do not know why you are against filling that information into "struct
> stat".

Because it is *WRONG*.  Isn't it a good enough reason?

If the issue you are trying to solve were """stat emulation on
Windows and Cygwin does not give the correct x-bit (and the user
sometimes has to work it around with "update-index --chmod"), and by
using other clues the emulation can be improved to give a better
result""", I agree that it would be a good solution to have the
"""Does it exist as a regular file and ends with ".exe"?  Otherwise
does it start with "MZ" or "#!"?""" heuristics in a helper function
correct_executable_stat(), and to have the implementation of stat
emulation on these two platforms call that shared helper function.

But look at the caller again.  The problem the caller wants this
function to solve is not "I want you to stat this file."  It has a
pathname, and only wants to know if it is an executable file.  It
does not care about who owns it, what time it was last touched,
etc., but calling the incomplete stat emulation on Windows will try
to come up with an answer, and the is_executable() function discards
most of it.  

In other words, you are solving a wrong problem with that approach.

"Run stat() and look at S_IXUSR" happens to be an implementation
detail that is valid only on POSIX systems for a function to answer
the question: "Is this an executable file?", and in that specific
implementation, the answer to that question appears in the S_IXUSR
bit of st.st_mode.  That does not mean the "struct stat" is the best
container for the answer to that question on other platforms.  So
why structure your abstraction around the inappropriate data
structure?  Between the function (is_executable) and its callers,
there is only one bit that needs to be passed.

My preference is to remove "static int is_executable()" function
from help.c, have an "extern int is_executable(const char *)" that
has platform-specific implementation in compat/ layer, and call it
from help.c::list_commands_in_dir() without any #ifdef.  In
git-compat-util.h, have something like:

	#ifdef __CYGWIN__
	#define is_executable(path) cygwin_is_executable(path)
	#else
        # ifdef WIN32
        # define is_executable(path) win32_is_executable(path)
	# endif
	#endif

        #ifndef is_exectutable
	#define is_executable(path) posix_is_executable(path)
	#endif

        extern int is_executable(const char *);

I wouldn't mind seeing the implementation of posix_is_executable()
in help.c, which will be dead-code on Windows and Cygwin, if that
makes linking and Makefile easier.
