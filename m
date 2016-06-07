From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Tue, 07 Jun 2016 11:10:14 -0700
Message-ID: <xmqqziqwq395.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:11:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bALSs-0003nA-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 20:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbcFGSKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 14:10:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422795AbcFGSKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 14:10:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E2923B39;
	Tue,  7 Jun 2016 14:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SeuuYlN3zfvdbl9UA2BZ4Ii7mYM=; b=o97f2Xj7t+y/pWe7fXUf
	rtM4XzpHvhNX+hiMPnMmu17AnjlU8Q3UbWugckbPzdKhG3iuYisGT7ykEGLfcqjW
	XqpXICyFSusLQXPThMY29F7Xr8RJpxUtt6h1Hnb+rgXMahlil38EB2Fc5Jon/hB3
	QeEsAGq0QjVDdVaSIxKN1bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oDbzQkukpwGT00XYPftHpbgLIRCUPhAPeNFVBrNf9aVyYY
	d+PmgsFvDAQ3kn+BUH28KvPCq9y9Hl4/AYf7tkP+W086sI5NP85Y07qn1lICkYDC
	v5rcGg/5lgYZHY5+QOVetfOSoUPk84VOFTtnQ3i4dS965tKdZy0hMXK+iAVi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9FB923B38;
	Tue,  7 Jun 2016 14:10:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 648C323B37;
	Tue,  7 Jun 2016 14:10:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 164B59FA-2CDB-11E6-86E9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296706>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

>> Perhaps I made it clearer by using a more exaggerated example e.g. a
>> typical expected buffer size of 128 bytes, but the third line of
>> 1000 line input file was an anomaly that is 200k bytes long.  I do
>> not want to keep that 200k bytes after finishing to process that
>> third line while using its initial 80 bytes for the remaining 977
>> lines.
>
> "its initial 128 bytes", rather than "its initial 80 bytes", no?

Either way would work, but 80 is closer to what I had in mind, as
the set-up of the example is "I know 99% of my input will fit within
80, but I'll allocate 128 to avoid realloc cost when there are rare
ones that bust 80.  I do not want to die only because there is an
occasional oddball that needs 200".

> The "fixed" feature was aimed to allow the users to use strbuf with
> strings that they doesn't own themselves (a function parameter for
> example). From Michael example in the original mail:
>
> void f(char *path_buf, size_t path_buf_len)
> {
>     struct strbuf path;
>     strbuf_wrap_fixed(&path, path_buf,
>     strlen(path_buf),
>     path_buf_len);
>     ...
>     /*
>      * no strbuf_release() required here, but if called it
>      * is a NOOP
>      */
> }

Think what does the "..." part would do using the "path" strbuf.

If 'f()' is meant to take the "dying is perfectly fine if the data
we have to process exceeds the area we were given even by one byte"
attitude, then the "capped to the same length as allocated" is
perfectly fine, but if 'f()' cannot afford to die() and instead has
to signal an error condition to its caller, then this function has
to check the length currently in use (i.e. path.len) and how much
more memory it can still use, before making each call to strbuf_*()
functions, no?

If we were to add "fixed" feature, we'd want to see it to help a
function like f() that cannot afford to die() and does not want to
malloc()/realloc().  I do not think what was in this series was it.
