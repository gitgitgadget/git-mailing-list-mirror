From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug Report: git add
Date: Thu, 07 Apr 2011 00:28:26 -0700
Message-ID: <7vlizmfrl1.fsf@alter.siamese.dyndns.org>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
 <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
 <20110407014819.GA12730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 09:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7je1-0000pT-6j
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 09:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1DGH2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 03:28:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1DGH2j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 03:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53B44222A;
	Thu,  7 Apr 2011 03:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GU2Nz7ZHtjnOh0oMXx0Kd9VCHz8=; b=Jf9cKC
	qW3COrm/Nngtc9C8CxZElqIlTdfxF1d8MPUqKfks/zOJcuoRExppgkuEKmOZokqo
	nHEoO6k6rD8ExyKUAhfPGoX2eHj3j569s5vRJ1Y5HQ8YMi69/3SkpkcFlCwBgIPh
	z4uLk+fAoCnKqmwrcMqr+nEG2we/G0VwuvLOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdJ5VyXsD6CUghQT/faD3PttVqS57bg/
	aPFQqRdUq0BwS5HKOlFmGLaOIbF5nwngVdbzk8HNyFJz/Ek9nW3ATo7GMyHXHG2L
	tAPCO0Z45je7LOzZLN8wfMhxr+jNZz6EAhuIx2kWmPxvrsweO2yTpSH1Oyn2RoVk
	sGhKaYRgClo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F2442229;
	Thu,  7 Apr 2011 03:30:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B10AB2228; Thu,  7 Apr 2011
 03:30:23 -0400 (EDT)
In-Reply-To: <20110407014819.GA12730@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Apr 2011 21:48:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E90D9372-60E8-11E0-86D3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171046>

Jeff King <peff@peff.net> writes:

> @@ -139,8 +138,21 @@ static int lstat_cache_matchlen(struct cache_def *cache,
>  			if (errno == ENOENT)
>  				*ret_flags |= FL_NOENT;
>  		} else if (S_ISDIR(st.st_mode)) {
> -			last_slash_dir = last_slash;
> -			continue;
> +			struct stat junk;
> +			struct strbuf gitdir = STRBUF_INIT;
> +			strbuf_add(&gitdir, cache->path, match_len);
> +			strbuf_addstr(&gitdir, "/.git");
> +			if (lstat(gitdir.buf, &junk) < 0) {
> +				if (errno == ENOENT) {
> +					last_slash_dir = last_slash;
> +					strbuf_release(&gitdir);
> +					continue;
> +				}
> +				*ret_flags = FL_LSTATERR;
> +			}
> +			else
> +				*ret_flags = FL_GITREPO;

This only checks "does the directory have .git in it?".

It probably is sufficient, but setup.c:is_git_directory() may do a more
appropriate check, I think.  That ".git" thing could be a regular file
(i.e. "gitdir: path"), so depending on the junk.st_mode, you may have to
call read_gitfile_gently() on it before checking with is_git_directory().

Alternatively, resolve_gitlink_ref() might be usable, but because it is
primarily meant to deal with a submodule, there is a slight impedance
mismatch with the test we are trying to do.  In this codepath, all we care
about is if the subdirectory is controlled by a separate git repository,
and it does not matter if that is an untracked directory from the
superproject's point of view, or if it is bound to the superproject as a
submodule.

Also I suspect resolve_gitlink_ref() may not work for a submodule that
does not have an initial commit but that is a separate issue.
