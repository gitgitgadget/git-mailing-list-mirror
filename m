From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Wed, 09 Jan 2013 16:39:03 -0800
Message-ID: <7vobgx3m8o.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org> <20130110001844.GC21054@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt6B6-0000uY-8T
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 01:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab3AJAjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 19:39:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224Ab3AJAjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 19:39:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6520EAF87;
	Wed,  9 Jan 2013 19:39:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9TRkAgOe8tBpgpkAJKHogQ0SK78=; b=le+CU2
	wy9n90ZtJvumR8OukYw1yX01MsIh9ZyvmMLgAjBLqLSPb4sRkm+Z8pFsrz8nIBgW
	jATMMatSVK7UVmJSuYbDDcPBSKJ2kvZQXfneV+7ORu2PL5LtRA3LuiQYdS/6Bx8w
	I0g4CVBnzQKc03C/6rQPYlEhuAOoH/3gCWxDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LTUDsDfUQsK9eaxr/8H0H9gcQRsCymAj
	BBKWl42u4rmRhhhvXhTRZOBmHc4P0nh8ngh/TdHbQAPpsbRB152t6Noe+8bsTOli
	Oq1e5zghiGSdZzRZ5na4zc+1/TlyzHlGHh1bFI+JLZ8qIlDqRJ3Dcyd6NUaGKmiG
	BRSBRppKihM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DBAAF86;
	Wed,  9 Jan 2013 19:39:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC944AF85; Wed,  9 Jan 2013
 19:39:04 -0500 (EST)
In-Reply-To: <20130110001844.GC21054@google.com> (Jonathan Nieder's message
 of "Wed, 9 Jan 2013 16:18:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22B5989C-5ABE-11E2-9612-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213117>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'm not sure whether there are SIGPIPE instances we really don't want
> to be silent about, though.  I suspect not. ;-)
>
> Compare <http://thread.gmane.org/gmane.comp.version-control.git/2062>,
> <http://thread.gmane.org/gmane.comp.version-control.git/48469/focus=48665>.

Yeah, thanks for the pointer to 48665.  Quoting from there:

    So EPIPE really _is_ special: because when you write to a pipe,
    there's no guarantee that you'll get it at all, so whenever you get
    an EPIPE you should ask yourself:

     - what would I have done if the data had fit in the 64kB kernel
       buffer?

     - should I really return a different error message or complain just 
       because I just happened to notice that the reader went away
       _this_ 
       time, even if I might not notice it next time?

    In other words, the "exit(0)" is actually _more_ consistent than
    "exit(1)", because exiting with an error message or with an error
    return is going to depend on luck and timing.

and I think I still agree with the analysis and conclusion:

    So what _should_ you do for EPIPE?

    Here's what EPIPE _really_ means:

     - you might as well consider the write a success, but the
       reader isn't actually interested, so rather than go on, you
       might as well stop early.

    Notice how I very carefull avoided the word "error" anywhere.
    Because it's really not an error. The reader already got
    everything it wanted. So EPIPE should generally be seen as an
    "early success" rather than as a "failure".
