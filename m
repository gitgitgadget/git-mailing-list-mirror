From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and related stuff
Date: Wed, 09 Mar 2016 15:09:15 -0800
Message-ID: <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	<1457548582-28302-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:09:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adnES-0001fx-1Q
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 00:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934433AbcCIXJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 18:09:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934397AbcCIXJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 18:09:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B947F4A313;
	Wed,  9 Mar 2016 18:09:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=huU1i1PA9WHU
	8XbpelKNVd7v9Yw=; b=F4EZZBqadAcFwxklK1i7AbJOApQrM8e2xqcJAVMtk2xA
	jPgG/L1iAXrtr5WZLn4swDNCU1ab3UW23vwxFuUxldoW+BkS3ssFEAeIgJTmsKjw
	5IDenMigEsZcALKLFZaMvM9MpYwV6AVyq70tDGsoMhAu2AnP65qmfxTDWeiI804=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w9qlqK
	BWzE//QgwfQ9oUqxQidiTYm+7u+tbTnpLlPznKDEAikiKpPWMUvX4taMN9eaBkP1
	Ylc626lRLSuvEr3yEKI++OYN+o9pjOqtgROdCBz7yXop7foH96re46lv2X7h07QZ
	XMTfkSlB2w8svk4QgWKY97ny2UhaQpA0UUdeM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFAA14A312;
	Wed,  9 Mar 2016 18:09:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32C084A311;
	Wed,  9 Mar 2016 18:09:16 -0500 (EST)
In-Reply-To: <1457548582-28302-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 9 Mar 2016 13:36:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F207BC9E-E64B-11E5-8377-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288581>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Instead of reading the index from disk and worrying about disk
> corruption, the index is cached in memory (memory bit-flips happen
> too, but hopefully less often). The result is faster read. Read time
> is reduced by 70%.
>
> The biggest gain is not having to verify the trailing SHA-1, which
> takes lots of time especially on large index files. But this also
> opens doors for further optimiztions:
>
>  - we could create an in-memory format that's essentially the memory
>    dump of the index to eliminate most of parsing/allocation
>    overhead. The mmap'd memory can be used straight away. Experiment
>    [1] shows we could reduce read time by 88%.
>
>  - we could cache non-index info such as name hash
>
> The shared memory's name folows the template "git-<object>-<SHA1>"
> where <SHA1> is the trailing SHA-1 of the index file. <object> is
> "index" for cached index files (and may be "name-hash" for name-hash
> cache). If such shared memory exists, it contains the same index
> content as on disk. The content is already validated by the daemon an=
d
> git won't validate it again (except comparing the trailing SHA-1s).

This indeed is an interesting approach; what is not explained but
must be is when the on-disk index is updated to reflect the reality
(if I am reading the explanation and the code right, while the
daemon is running, its in-core cache becomes the source of truth by
forcing everybody's read-index-from() to go to the daemon).  The
explanation could be "this is only for read side, and updating the
index happens via the traditional 'write a new file and rename it to
the final place' codepath, at which time the daemon must be told to
re-read it."
