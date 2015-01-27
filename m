From: Junio C Hamano <gitster@pobox.com>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Tue, 27 Jan 2015 15:10:16 -0800
Message-ID: <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
References: <20150126172409.GA15204@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:10:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGFHE-0007to-40
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 00:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbbA0XKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 18:10:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755974AbbA0XKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 18:10:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0D5D33AEE;
	Tue, 27 Jan 2015 18:10:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cwhy95bTr1H5UUxUDiRjF9o6zc=; b=hV09Wy
	y0sHrYtxNZ9dMKN1n7j4LISy/l/qU8brAer99axZ8ZfOoCZUCAcUIjm6DufbmVhI
	WvYvzuoROXSnUQv18SxMmOPMFqVFfdlLOyNyGHjOOQ8/D0o1DPJZ30UqCtixUVIJ
	CyUkuCXS3Qhcgdw6U+IEsN7vq0qnrJr6i5a4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJbAi6yovdW7UkZgSfK4C875Ng7Rav9H
	tIvmFb2pMwXRSKNgYvS1eKRh8ASPSnQU2VeZtyafnNaN+B6RGfUpxkNb2PuxWnwj
	fLE5lBfA17RUFELe+Qca49UtAUsGpNAf58aSg/0F0s8bWFH82SEHaupnOcnNBqyP
	QRKyLFIR45o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D85A733AED;
	Tue, 27 Jan 2015 18:10:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C82B33AEC;
	Tue, 27 Jan 2015 18:10:18 -0500 (EST)
In-Reply-To: <20150126172409.GA15204@aepfle.de> (Olaf Hering's message of
	"Mon, 26 Jan 2015 18:24:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8EB9FB6-A679-11E4-BC29-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263094>

Olaf Hering <olaf@aepfle.de> writes:

> Several files in Documentation have an unstable 'Last updated' timestamp. The
> reason is that their mtime changes every time, which prevents reproducible
> builds.
>
> 341 technical/api-index.txt: technical/api-index-skel.txt \
> 342         technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> 343         $(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
>
> 388 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
> 389         $(QUIET_GEN)$(RM) $@+ $@ && \
> 390         '$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
> 391         mv $@+ $@
>
> 399 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
> 400         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> 401         sed -e '1,/^$$/d' $< | \
> 402         $(TXT_TO_HTML) - >$@+ && \
> 403         mv $@+ $@

All of them seem to have dependencies so it seems to me that two
builds back to back without actually changing their input would not
re-build anything.  What am I missing???

> What file timestamp should be used for them? Likely "../version"?

I tend to think the "Last updated" timestamp taken from the
filesystem timestamp is a bad practice inherited by these tools from
the days back when nobody used any revision control systems.

If I check out v1.8.5 and build documentation now, it does not
matter if the generated documentation had the timestamp of the
checkout of individual files or that of a single file generated
during the build process, i.e. ../version.  Neither has much
relevance to the time the actual contents of the documentation was
prepared or what vintage of the software the documentation is for.

I am fine with branding generated documentation with the version
number (i.e. "You are reading the documentation for Git version
2.2.0").  Replacing that statement with "You are reading the
documentation for a version of Git that was committed on such and
such time" is also fine.  But using file timestamp would not help
either.

And that practice of using file timestamp is doubly bad by leading
misguided people to want to set timestamps of all the files by
copying commit timestamp.  That is backwards, I would think.
