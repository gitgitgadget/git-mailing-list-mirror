From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git update-ref --stdin : too many open files
Date: Mon, 22 Dec 2014 13:22:45 -0800
Message-ID: <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com>
References: <54954E44.1080906@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3ARJ-0001Ew-3T
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbaLVVWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:22:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754781AbaLVVWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:22:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20D70298F4;
	Mon, 22 Dec 2014 16:22:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wCQNerE5iH4MIEP4iiDDv1CTqWM=; b=kPZPMT
	mLXNXM9cmS3IbbDgACMO0TqwSpMhOUa/3fqhA9EgWGvKs0PJhX3fMfRbZXY8Bhg0
	WDyX0quz8ML3lRWR3MbvwYm+JZSb+JrvF3DjWX/rpaKTBQpoaa9t/fxoS2vtffa6
	z+WeYB5KlKKGuFq3+LPVMKf9k5wOJGCONxoW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wd9nUM+adMoh3qROWqTOc2ljbY0hQGPa
	/406boQCuaxgEj/7wdw1+lMFcjKSAM2kMY4JSsfOrMZBxw/itrlTRam2iBJ/1dh9
	9FoVN6AvDsvNDF977UuNTYqOPh8+t57tWwqaiiQXmrm2vEtiYd5Op8EiC4hQNtDv
	UXQ+19CiFds=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1745E298F3;
	Mon, 22 Dec 2014 16:22:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93BA0298F2;
	Mon, 22 Dec 2014 16:22:46 -0500 (EST)
In-Reply-To: <54954E44.1080906@dachary.org> (Loic Dachary's message of "Sat,
	20 Dec 2014 11:24:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC89EAEE-8A20-11E4-AE5A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261670>

Loic Dachary <loic@dachary.org> writes:

> Hi,
>
> Steps to reproduce:
>
> $ git --version
> git version 1.9.1
> $ wc -l /tmp/1
> 9090 /tmp/1
> $ head /tmp/1
> delete refs/pull/1/head
> create refs/heads/pull/1 86b715f346e52920ca7c9dfe65424eb9946ebd61
> delete refs/pull/1/merge
> create refs/merges/1 c0633abdc5311354c9729374e0ba25c97a89f69e
> ...
> $ ulimit -n
> 1024
> $ git update-ref --stdin < /tmp/1
> fatal: Unable to create
> /home/gitmirror/repositories/Ceph/ceph/refs/heads/pull/1917.lock': Too
> many open files
> $ head -20 /tmp/1 | git update-ref --stdin
> $ echo $?
> 0
>
> The workaround is to increase ulimit -n
>
> git update-ref --stdin should probably close some files.
>
> Cheers

Sounds like the recent "ref update in a transaction" issue to me.

Stefan, want to take a look?  I think we do need to keep the .lock
files without renaming while in transaction, but we do not have to
keep them open, so I suspect that a fix may be to split the commit
function into two (one to close but not rename, the other to
finalize by renaming) or something.

Also the version of transaction series we have queued seem to lock
these refs very late in the process, but as we discussed privately
a few weeks ago, we would want to move the lock much earlier, when
the first update is attempted.
