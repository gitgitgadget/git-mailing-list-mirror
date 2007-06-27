From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 09:54:57 -0400
Message-ID: <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com>
References: <87wsxpobf0.fsf@rho.meyering.net> <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com> <87r6nxo8iq.fsf_-_@rho.meyering.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Xz4-00066Z-Ji
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXF0NzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbXF0NzA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:55:00 -0400
Received: from rock.gnat.com ([205.232.38.15]:46949 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbXF0Ny7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:54:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id A9F002A9C54;
	Wed, 27 Jun 2007 09:54:58 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id C-vHaJL3yPoO; Wed, 27 Jun 2007 09:54:58 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 93FBD2A9C28;
	Wed, 27 Jun 2007 09:54:58 -0400 (EDT)
In-Reply-To: <87r6nxo8iq.fsf_-_@rho.meyering.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51043>

On Jun 27, 2007, at 09:02, Jim Meyering wrote:
> -	if (!use_stdout)
> -		realstdout = fdopen(dup(1), "w");
> +	if (!use_stdout) {
> +		int fd = dup(1);
> +		if (fd < 0 || (realstdout = fdopen(fd, "w")) == NULL)
> +			die("failed to duplicate standard output: %s",
> +			    strerror(errno));
> +	}

This makes the code unreadable! A great way to ruin
perfectly fine code is to add tons of error checking.
The error checking is likely wrong (detects non-errors,
or fails to detect real ones), and for sure makes code
untestable  and unreadable.

If we really case about catching such errors, write
the code as:
	if (!use_stdout)
		realstdout = xfdopen(dup(1), "w");
where xfdopen is a wrapper around fdopen that dies in
case of an error. This follows a practice we use elsewhere,
and only adds one character to the code and only affects
readability very slightly.

> Without this, if you ever run out of file descriptors, dup will
> fail (silently), fdopen will return NULL, and fprintf will
> try to dereference NULL (i.e., usually segfault).

As it is unlikely the failure mode will ever occur in practice,
any way of aborting is fine. Even SIGSEGV would do: it would be
trivial to find that we were leaking file descriptors or are out
of memory. Oh, wait, that means we don't need any checking code
at all...

   -Geert
