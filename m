From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to update index stat info without reading file content?
Date: Thu, 11 Sep 2014 13:51:53 -0700
Message-ID: <xmqqtx4ddgnq.fsf@gitster.dls.corp.google.com>
References: <99C877A8-8145-4D8E-BE83-0F8A1FC16214@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBLV-0006nO-1c
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 22:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbaIKUv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 16:51:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64275 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbaIKUv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 16:51:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3EB13A632;
	Thu, 11 Sep 2014 16:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=alSJmVuf6HAsz5KPtl5w59FJh7k=; b=unurWN
	Ixq1psX6vvtgADzZhzqAaMzyNOE2Ks4q75kxVPG9ptS5lAHm6Vy1mzWEhxPgrD1c
	AEsjjy7RZ4sDhBnjcsVnFUraXQEyKFNd6qeMPyb05rCsRRglJ00DXj/0Na6XZKKw
	aqaPxbm2TP9gBKtuIJW5m0I16rsFtunLDkvos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VUpP8Uy/pigJTeTwvKEgIFNJ0WVmBsyy
	voK0cr9aeYpDoz7M1bIvBAguOb6FJnOwsGpx63iex5InbnY1JDC5Nd1xF7/4ZPWi
	atA/f92//Q+j7DzEPr/Mdi50Wie78vIE5prG5/ZppI/hd/WJ1fwYo0kvdmJeIBk2
	1n/BjfxjIqg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A8E1D3A630;
	Thu, 11 Sep 2014 16:51:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BA863A62F;
	Thu, 11 Sep 2014 16:51:55 -0400 (EDT)
In-Reply-To: <99C877A8-8145-4D8E-BE83-0F8A1FC16214@zib.de> (Steffen Prohaska's
	message of "Thu, 11 Sep 2014 21:04:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76DC67BC-39F5-11E4-B285-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256876>

Steffen Prohaska <prohaska@zib.de> writes:

> Hi,
>
> Is there a way to update the stat information recorded in the index without reading the file content from disk?
>
> Starting from a clean working copy with a committed `file`, I'd like 
>
>     touch file
>     git <magic-command> file
>
> to bring the index into essentially the same state as
>
>     touch file
>     git status
>
> but without reading the content of `file`.  (I'd be willing to wait a bit between touch and the magic command, to avoid any racy-git-related code paths.)
>
> `git-update-index --assume-unchanged` is related.  But it requires completely manual handling of changes, because git will not look at marked files until told otherwise with `--no-assume-unchanged`.  I'd like to tell git only that the current file content is known to be up-to-date.  Any future changes should be handled as usual.

Yes, "assume-unchanged" is related and it is often abused by
clueless.  The only thing it does is by setting the bit, you promise
Git that the one on the filesystem will be kept the same as the
object recorded in the index forever, one of the implications of
which is that Git is free to use either the version on the
filesystem or data read with read_sha1_file() from the object store,
whichever it finds more convenient, when it needs to read the data
for the object recorded in the index for the path.  You are not
promising the "forever" part, so it is not a good match for what you
are trying to do.

> In the documentation, `git add --refresh file` sounds a bit like
> what I'm looking for.  The documentation of `--refresh` states:
> "Don’t add the file(s), but only refresh their stat() information
> in the index."  But it doesn't do what I want.

No.  It is the same as "update-index --refresh".  You tell it "I've
made this file, which may have had contents different from the
object name recorded in the index before, back to match what is
recorded in the index.", it makes sure that you are not lying, and
then updates the cached stat information so that the next time it
does not have to read the contents.
