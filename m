From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C (squashing proposal)
Date: Thu, 22 Aug 2013 13:31:40 -0700
Message-ID: <xmqqmwo9qxg3.fsf@gitster.dls.corp.google.com>
References: <5215EC1A.7060004@kdbg.org>
	<1377201996-27296-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 22:31:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCbXr-0002tK-D0
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 22:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3HVUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 16:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab3HVUbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 16:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B15833BDB9;
	Thu, 22 Aug 2013 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=srhaQa+AutCa/3CrDLoJ389rmdM=; b=HuaMug
	ld6sDuXkCkclhAZQGgwBgp/uOgKm9j1jXx2rwjbHWHEENPuYbu7ipe922fhMZs7+
	2GCtXyu3REWH71auLKv1fdmt6Nv4ElrIASZSZ00EeGFtmBMHydmGslGh1vS+Gvw7
	NpUf3TicPAljH9DxwV8FEvNegmabwXqQzZh5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RLaorp3Vwur1UFUT+c0xQvB9TCYbFYu0
	1x1P8ESM6aTfRUYGqxcrdw/+kAKfcQI7uEXgiXgMHXlbq3t3ajRg8hsgjocXxep4
	OOEl1l4OLUr+WbS4LMsWRE9/nJ3jGUmzCFsIKH7s8u2vcu0Lr7PPT+rE85mQPsrH
	+QApgtQvttA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A05FD3BDB6;
	Thu, 22 Aug 2013 20:31:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C52133BDB2;
	Thu, 22 Aug 2013 20:31:43 +0000 (UTC)
In-Reply-To: <1377201996-27296-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 22 Aug 2013 22:06:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBD7091C-0B69-11E3-B170-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232774>

Stefan Beller <stefanbeller@googlemail.com> writes:

> @@ -41,18 +35,16 @@ static void remove_temporary_files(void)
>  	DIR *dir;
>  	struct dirent *e;
>  
> +	dir = opendir(packdir);
> +	if (!dir)
>  		return;
>  
> +	strbuf_addstr(&buf, packdir);
> +
> +	/* dirlen holds the length of the path before the file name */
>  	dirlen = buf.len + 1;
> +	strbuf_addf(&buf, "%s", packtmp);
> +	/* prefixlen holds the length of the prefix */

Thanks to the name of the variable that is self-describing, this
comment does not add much value.

But it misses the whole point of my suggestion in the earlier
message to phrase these like so:

        /* Point at the slash at the end of ".../objects/pack/" */
	dirlen = strlen(packdir) + 1;
        /* Point at the dash at the end of ".../.tmp-%d-pack-" */
        prefixlen = buf.len - dirlen;

to clarify what the writer considers as "the prefix" is, which may
be quite different from what the readers think "the prefix" is.  In
".tmp-2342-pack-0d8beaa5b76e824c9869f0d1f1b19ec7acf4982f.pack", is
the prefix ".tmp-2342-", ".tmp-2342-pack", or ".tmp-2342-pack-"?

>  int cmd_repack(int argc, const char **argv, const char *prefix)
>  {
> ...
>  	packdir = mkpathdup("%s/pack", get_object_directory());
>  	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
>  
> +	sigchain_push_common(remove_pack_on_signal);
> +
>  	argv_array_push(&cmd_args, "pack-objects");
>  	argv_array_push(&cmd_args, "--keep-true-parents");
>  	argv_array_push(&cmd_args, "--honor-pack-keep");
> ...
> +					rollback_failure.items[i].string,
> +					rollback_failure.items[i].string);
>  		}
>  		exit(1);
>  	}

The scripted version uses

    trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15

so remove_temporary_files() needs to be called before exiting from
the program without getting killed by a signal.

Thanks.
