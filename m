From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 16:22:50 -0700
Message-ID: <xmqqsicwbos5.fsf@gitster.dls.corp.google.com>
References: <20150322095924.GA24651@peff.net>
	<20150322100724.GC11615@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:23:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpCv-00060m-HT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbCVXW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:22:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbbCVXWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:22:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0A5D421AB;
	Sun, 22 Mar 2015 19:22:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQKeUPbmJUsqytKTJkVRfZVD4U0=; b=PYPkXZ
	TEoiiflHjYk0f9bwLfqPZ7PokYZ9V7LJeLVnD6Ua+wJiakygU+QbVG8dFC88lkjS
	EerfLH+k18BFLWhGtMFKC4k8YH9lwQnBtm9tc9/FwbaSTQhJ0ATslpzzxdtgG8P0
	E5+RFaSFdeXAQUWUoRN/hmnaOFdzxE17TtzV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aPSofkTrS4Ayr806L1/M60+uXQVZ9dAk
	m+0R2sKPs2BtUQNd5uTy8yD+mbAtnr/t2YpxwQge5HWKaWugNo3+dSwoAWs+zDhq
	44JVegK4AuuAg58HC4QeifrC7tvJy8kb1MgjoTMOq18//mfPR6E0cranCgiAfu7d
	O2GvqSp1NJM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7CC9421AA;
	Sun, 22 Mar 2015 19:22:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08717421A9;
	Sun, 22 Mar 2015 19:22:51 -0400 (EDT)
In-Reply-To: <20150322100724.GC11615@peff.net> (Jeff King's message of "Sun,
	22 Mar 2015 06:07:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C7B6B2A-D0EA-11E4-A435-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266103>

Jeff King <peff@peff.net> writes:

> diff --git a/strbuf.h b/strbuf.h
> index 1883494..93a50da 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -1,6 +1,8 @@
>  #ifndef STRBUF_H
>  #define STRBUF_H
>  
> +struct child_process;
> +
>  /**
>   * strbuf's are meant to be used with all the usual C string and memory
>   * APIs. Given that the length of the buffer is known, it's often better to
> @@ -373,6 +375,14 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
>  extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>  
>  /**
> + * Execute the given command, capturing its stdout in the given strbuf.
> + * Returns -1 if starting the command fails or reading fails, and otherwise
> + * returns the exit code of the command. The output collected in the
> + * buffer is kept even if the command returns a non-zero exit.
> + */
> +int strbuf_read_cmd(struct strbuf *sb, struct child_process *cmd, size_t hint);
> +
> +/**
>   * Read a line from a FILE *, overwriting the existing contents
>   * of the strbuf. The second argument specifies the line
>   * terminator character, typically `'\n'`.

It is an unfortunate tangent that this is a bugfix that may want to
go to 'maint' and older, but our earlier jk/strbuf-doc-to-header
topic introduces an unnecessary merge conflicts.

I've wiggled this part and moved the doc elsewhere, only to remove
that in the merge, which may not be optimal from the point of view
of what I have to do when merging this topic down from pu to next
to master to maint, but I do not see a good way around it.

Thanks.  The whole series looks very sensible.
