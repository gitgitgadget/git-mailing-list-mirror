From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate breakage: checkout overwrites untracked
 symlink with directory
Date: Wed, 09 Feb 2011 15:48:12 -0800
Message-ID: <7vpqr0n51f.fsf@alter.siamese.dyndns.org>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org> <20110205183351.GA25717@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Feb 10 00:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnJls-0002La-CV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 00:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab1BIXsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 18:48:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab1BIXsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 18:48:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1AE7B4130;
	Wed,  9 Feb 2011 18:49:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6n5OHSQ1iqzPoDm9enAGLEB4V4c=; b=BQyoRhKbBirdjBv0qkb5KRY
	YR17NTqt8rOSAb7BjGp76PZ+Hi026A92WIAjq8cZX4TpF6Y+Xinz4AsOtl+XCGdy
	DW3dM5BtiNV7xaf34CA4eUhVKzdx9E+KQ2IoUgHbicFritCiyT9/bszryzBNojBR
	Ege/qmfJhFoSBKNFq1Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XliGXUJteXaN6rvi69RiovKq66ABVjLPS2JbH5yxfYj8zXOTZ
	r2ZMLwZSCoNrGiW40ijzhhfiH2z+p91V5NMRivpqxE5cz3z6rte/y+yVg+1QiprX
	rCm/qhcj64Ov18bmtPM6YA4JkzroAHCjn/ImbX0zmQrsLYzfLRHTSucq6g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA64F412F;
	Wed,  9 Feb 2011 18:49:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40658412C; Wed,  9 Feb 2011
 18:49:13 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35CB6D9C-34A7-11E0-831D-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166458>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/symlinks.c b/symlinks.c
> index 3cacebd..034943b 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -223,7 +223,7 @@ int check_leading_path(const char *name, int len)
>         int flags;
>         int match_len = lstat_cache_matchlen(cache, name, len, &flags,
>                            FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
> -       if (flags & (FL_SYMLINK|FL_NOENT))
> +       if (flags & FL_NOENT)
>                 return 0;
>         else if (flags & FL_DIR)
>                 return -1;

This function used to be named has-symlink-or-noent-leading-path before
f66caaf (do not overwrite files in leading path, 2010-10-09) and was used
to check for exactly that condition.  For example, verify_absent_1() used
it to verify that a path A/B/C/D is not on the filesystem (e.g. in
preparation for checking it out) by making sure that none of A, A/B, or
A/B/C exists -- or is an untracked symlink.  If one of them is a symlink
leading elsewhere, even if lstat("A/B/C/D") said the path exists, A/B/C/D
is not something we have in the work tree, and we decide that we can check
out the path by possibly removing intermediate symbolic link and running
mkdir.

Now you are changing the semantics of the function, so that we cannot
clobber intermediate symbolic links when we check out a path.  It may
probably be a good change.

Can we rename this function to fix the naming regression introduced in
f66caaf, by the way?  "check_leading_path()" is a horrible name for a
function that takes some parameters and returns a boolean, as the boolness
of the function already says enough that it is about "check", giving the
first part of the name 0-bit of information, and the remainder of the name
doesn't say much either: what aspect of leading-path is the function
about?  Should the pathcomponents exist, should they not exist, why should
the caller care?

A name that explains for what purpose the caller is expected to call it is
probably the best kind of name.  As long as the purpose does not change,
even though the implementation and the semantics are changed later, the
name can stay the same without losing its meaning.  The second best kind
is a name that explains what it does.  The old name of this function was
of this kind, until f66caaf renamed it to a meaningless name.

Perhaps can-clobber-to-checkout would be a good candidate.
