From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sat, 22 Oct 2011 22:51:27 -0700
Message-ID: <7vipng5k80.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
	<avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 07:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHr03-0005Pa-Lz
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 07:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1JWFvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 01:51:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab1JWFvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 01:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266503A95;
	Sun, 23 Oct 2011 01:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tZFIPDRVQIiCH8uCcZYv0tR/fo=; b=fuR4je
	Cmk+4t218UAISFeCchiAWrtlbK4zi6lYMCUlyeQjGZ0bKjKj2heDMQS3vn7xpS7n
	6NrGW/RouOm9w/vWvu3UjRE5C9KdM2w9tYIozsy6X5KgbLVARU66HCjNmpY0aFr5
	wjG3I/ykau0FHlBtBJluaa+y2uaF89LV39BB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sfznl7REjt8407mU22YrBaHQhamRc8ch
	9X+50dOz4hnyUSfbCCjQcsJSD4ZPQwIOP/xTLa9/QraSab7fc2LaE5UtqOsqzEwh
	0wo2sscLRfK8ARaWqy6CSOWsaOGH0FqSKiS2GrQqFPLFldK0fmVceKmbfDs7Bzvo
	7EiTolKvwnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E0AE3A94;
	Sun, 23 Oct 2011 01:51:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 939B63A93; Sun, 23 Oct 2011
 01:51:29 -0400 (EDT)
In-Reply-To: <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 23 Oct 2011 12:24:25 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DB7B038-FD3B-11E0-ADE8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184126>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> We could allocate just one block with length as the first field:
>
> struct commit_buffer {
>         unsigned long len;
>         char buf[FLEX_ARRAY];
> };
>
> The downside is commit_buffer field type in struct commit changes,
> which impacts many codepaths.

I think that is a good thing overall to _force_ us to audit all the code,
*if* our goal were to avoid losing bytes. And the solution above is better
than adding a length field to "struct commit". It certainly is better than
quoting NUL byte to ^@, keep using the "char *" field and risking some
codepaths forget to convert it back to NUL. For types of payloads for
which losing everything after the first NUL matters, converting NUL to ^@
and then forgetting to convert it back to NUL is equally bad breakage to
the payload anyway, so such a conversion would not be a particularly good
approach to avoid losing bytes.

But as Jeff suggested, we should step back a bit and think what our goal
is.

The low level object format of our commit is textual header fields, each
of which is terminated with a LF, followed by a LF to mark the end of
header fields, and then opaque payload that can contain any bytes. It does
not forbid a non-Git application to reuse the object store infrastructure
to store ASN.1 binary goo there, and the low level interface we give such
as cat-file is a perfectly valid way to inspect such a "commit" object.

But when it comes to "Git" Porcelains (e.g. the log family of commands),
we do assume people do not store random binary byte sequences in commits,
and we do take advantage of that assumption by splitting each "line" at
LF, indenting them with 4 spaces, etc. In other words, a commit log in the
Git context _is_ pretty much text and not arbitrary byte sequence. Even
the "--pretty=raw" option for "log" family is not about the "raw" body;
the "raw"-ness applies only to the header fields. So even if we _were_ to
update the codepaths involved to avoid losing bytes, the end result will
not be useful for users to whom ability to include NUL matters.

So in that sense, I do not think it is unreasonable to chop it off at the
first NUL, which is the current behaviour. IOW, it is entirely sane to
argue that there is nothing to fix.
