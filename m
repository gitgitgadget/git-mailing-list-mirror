From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Support builds when sys/param.h is missing
Date: Fri, 14 Dec 2012 15:41:53 -0800
Message-ID: <7vpq2curpa.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7mHHy1=aOMfg4hNnDzod4zSnNHZN87isgf6Yxh5cRAf0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 00:42:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjetS-0005XR-02
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 00:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598Ab2LNXl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 18:41:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151Ab2LNXl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 18:41:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCE2DA091;
	Fri, 14 Dec 2012 18:41:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ad4HcGqI3z2eODN1HKTJQKiOCwc=; b=N5iAWR
	gnca+igcyWxULyn8lFaHQ9+lTR52NhlM+Dr+0IIGA1Bj8YSEKHxKknzlHXxIWH8S
	9vslbhbAL4D3LeASDQuxBIGPzS+tsmrFgLsgJxFW8J2b+kzZ2EpJhIPnnVEbvnyC
	3x4nNo2s85fgtZYezu2q3jatssEGUfu7SbmCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S8LkyHcUDvu8D1gaCerrYTXWJ4LSesbV
	GhsPzrVW8mSIvy5TYnvHdgiVjCRtOapIrMihaDLM/I42CpAMCDpSryLnePf34cEo
	vwPlCFmTLHF62170ksu3B+j7LzviBEbJO1U+QVBfHD43ZwmjzTHCacb32p7esR4u
	sruumOtYl8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF98A08E;
	Fri, 14 Dec 2012 18:41:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30B1EA08D; Fri, 14 Dec 2012
 18:41:55 -0500 (EST)
In-Reply-To: <CAEvUa7mHHy1=aOMfg4hNnDzod4zSnNHZN87isgf6Yxh5cRAf0Q@mail.gmail.com> (David
 Michael's message of "Fri, 14 Dec 2012 14:56:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7D2D9B4-4647-11E2-836A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211513>

David Michael <fedora.dm0@gmail.com> writes:

> An option is added to the Makefile to skip the inclusion of sys/param.h.
> The only known platform with this condition thus far is the z/OS UNIX System
> Services environment.
>
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---

Hmm, makes me wonder if we can remove that inclusion everywhere
instead.  What definitions are we getting from it?

8695c8b (Add "show-files" command to show the list of managed (or
non-managed) files., 2005-04-11) added it to show-files, and without
the include the compilation failed due to lack of MAXPATHLEN, but
you shouldn't be using that in the first place (we tend to either
use PATH_MAX or lift the upper limit using strbuf these days.).

65bb491 (Add the ability to prefix something to the pathname to
"checkout-cache.c", 2005-04-21) does the same to checkout-cache.c
to grab MAXPATHLEN.

bb233d6 (Add support for a "GIT_INDEX_FILE" environment variable.,
2005-04-21) moves these two inclusions to cache.h; removing it
bteaks compilation due to lack of MAXPATHLEN, ULONG_MAX, etc.,

I didn't check what else sys/parms.h was accicdentally slurping into
the compilation, but ULONG_MAX is what we explicitly ask for by
including either inttypes or stdint these days.

Later 4050c0d (Clean up compatibility definitions., 2005-12-05)
further consolidated the headers by moving inclusion around.  This
commit did not audit unused headers.

I have this suspicion that nobody would notice if we simply stopped
including the header.
