From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] ewah: compressed bitmap implementation
Date: Mon, 24 Jun 2013 18:10:43 -0700
Message-ID: <7v7ghj571o.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-9-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 03:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrHmU-0001Wc-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 03:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab3FYBKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 21:10:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab3FYBKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 21:10:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC2820011;
	Tue, 25 Jun 2013 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bu7IMWTvp5pIyyNnmVNi08DF3Vk=; b=h5hzVK
	BGxoIBcHYt8rf1dVPBaaACixZw4i1GC5WSsrPIctmnbZIhAt6FEbjYMZbk0lmXjx
	ABMMSMMpJe9PCR9KWfaa++iAlnXQB97fWHBR6ubKG4t4NHdPCHuAVKBMac6VxHnd
	BFkUvYaRwnHQK+JEaYr8aV69gsF4k8pTlflJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsN4YT+JT4xAKiA1+eI0di8FVT62b5We
	YdikP+94WCzh5SMeCYk+V+wvfEiQt/7OLEKA2hHsGtZotrJhIyf4+BOwc74aAe+J
	Cr3/phpz3y4aSV+nJpr/nheBIsgqVaf+UnTQoFzyW/KfmOREl5aW+l9XaklIWM2I
	GC7eAjew7k8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 922722000D;
	Tue, 25 Jun 2013 01:10:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1BFE2000C;
	Tue, 25 Jun 2013 01:10:44 +0000 (UTC)
In-Reply-To: <1372116193-32762-9-git-send-email-tanoku@gmail.com> (Vicent
	Marti's message of "Tue, 25 Jun 2013 01:23:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FDC5668-DD34-11E2-9993-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228938>

Vicent Marti <tanoku@gmail.com> writes:

> The library is re-licensed under the GPLv2 with the permission of Daniel
> Lemire, the original author. The source code for the C version can
> be found on GitHub:
>
> 	https://github.com/vmg/libewok
>
> The original Java implementation can also be found on GitHub:
>
> 	https://github.com/lemire/javaewah
> ---

Please make sure that all patches are properly signed off.

>  Makefile           |    6 +
>  ewah/bitmap.c      |  229 +++++++++++++++++
>  ewah/ewah_bitmap.c |  703 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ewah/ewah_io.c     |  199 +++++++++++++++
>  ewah/ewah_rlw.c    |  124 +++++++++
>  ewah/ewok.h        |  194 +++++++++++++++
>  ewah/ewok_rlw.h    |  114 +++++++++

This is lovely.  A few comments after an initial quick scan-through.

 - The code and the headers are well commented, which is good.

 - What's __builtin_popcountll() doing there in a presumably generic
   codepath?

 - Two variants of "bitmap" are given different and easy to
   understand type names (vanilla one is "bitmap", the clever one is
   "ewah_bitmap"), but at many places, a pointer to ewah_bitmap is
   simply called "bitmap" or "bitmap_i" without "ewah" anywhere,
   which waas confusing to read.  Especially, the "NAND" operation
   for bitmap takes two bitmaps, while "OR" takes one bitmap and
   ewah_bitmap.  That is fine as long as the combination is
   convenient for callers, but I wished the ewah variables be called
   with "ewah" somewhere in their names.

 - I compile with "-Werror -Wdeclaration-after-statement"; some
   places seem to trigger it.

 - Some "extern" declarations in *.c sources were irritating;
   shouldn't they be declared in *.h file and included?

 - There are some instances of "if (condition) stmt;" on a single
   line; looked irritating.   

 - "bool" is not a C type we use (and not a particularly good type
   in C++, either).

That is it for now. I am looking forward to read through the users
of the library ;-)

Thanks for working on this.
