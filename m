From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: don't hardcode HEAD in dist target
Date: Mon, 02 Jun 2014 11:53:36 -0700
Message-ID: <xmqq4n035ej3.fsf@gitster.dls.corp.google.com>
References: <20140531202507.GA9101@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrXMi-0001zz-6s
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbaFBSxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:53:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57331 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbaFBSxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:53:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10B1E1D70C;
	Mon,  2 Jun 2014 14:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g99+kfreDHVlMPcxn30QnnUFli4=; b=ub9IeT
	zhGX7VpZdsESg0VaUFy0JcRezzgpzR4bDodSjhdYl3PhqGi72J1DA9CE9V1G2Vqr
	QrFjK4JS5J7VA1yGg0YeIsBwTxUsXuVAM24MHEuyeRElU7kKPHAtVTaIMHQqQf/o
	+lh8bLZNshn57bgCE6PLoshSMyPpUfKi+g3W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GrJ/xwdRUnrFBAsz6J0X/rbtwMr81aZz
	eFGnEt2QwzT+dMMgVs8j5RQ3suCu0CwdMe4vWfmwtzE9XZTZl+wDXibN+8v48fxi
	v2SRCxPQw+W7wjfkRL+ZHVD0toUkmOYi4cbZ4J/JdeubFdt9UaV9ciZDjHt7o2Cw
	QZRLgOe45bc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 074C41D70B;
	Mon,  2 Jun 2014 14:53:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6680C1D704;
	Mon,  2 Jun 2014 14:53:39 -0400 (EDT)
In-Reply-To: <20140531202507.GA9101@spirit> (Dennis Kaarsemaker's message of
	"Sat, 31 May 2014 22:25:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35BCBB82-EA87-11E3-A38D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250580>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Instead of calling git-archive HEAD^{tree}, use $(GIT_VERSION)^{tree}.
> This makes sure the archive name and contents are consistent, if HEAD
> has moved, but GIT-VERSION-FILE hasn't been regenerated yet.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
> I have a somewhat odd setup in which I share a .git between multiple
> checkouts for automated builds. To minimize locking time for parallel
> builds with different options, there's only a lock around checkout and
> running git describe $commit > version, the builds themselves run in
> parallel.
>
> This works just fine except during 'make dist', which is hardcoded to
> package up HEAD, but that's not always the commit that is actually
> checked out, another process may have checked out something else.
>
> I realize this setup is somewhat strange, but the only change necessary
> to make this work is this one-line patch, so I hope that's acceptable.

The "dist" target happens to do a clean checkout to a temporary
directory with "git archive" and then muck with its contents before
tarring up the result, so moving HEAD around may appear to work for
this particular target, but htmldocs/manpages targets use what is in
the current checkout of Documentation/ area.  Turning the HEAD^{tree}
into $(GIT_VERSION)^{tree} would make the inconsistency between the
two worse, wouldn't it?

If we were to change the "dist" rules, we may want to go in the
opposite direction.  Instead of using "git archive" to make a
temporary copy of a directory from a commit, make such a temporary
copy from the contents of the current working tree (or the index).
And then tar-up a result after adding configure, version etc. to it.
That would mean what will be in the tarball can be different from
even HEAD, which is more consistent with the way how documentation
tarballs are made.

Alternatively, you can update the dist-doc rules to make a temporary
copy of documentation area and generate the documentation tarballs
out of a pristine source of a known version---which would also make
these two consistent.  I am not sure which one is more preferrable,
though.

Why are you sharing the .git/HEAD across multiple checkouts in the
first place?  If they are to build all different versions, surely
these working trees are derived from different commits, no?  Have
you considered using contrib/workdir/git-new-workdir, perhaps?

I dunno.

>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a53f3a8..63d9bac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2433,7 +2433,7 @@ git.spec: git.spec.in GIT-VERSION-FILE
>  GIT_TARNAME = git-$(GIT_VERSION)
>  dist: git.spec git-archive$(X) configure
>  	./git-archive --format=tar \
> -		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
> +		--prefix=$(GIT_TARNAME)/ $(GIT_VERSION)^{tree} > $(GIT_TARNAME).tar
>  	@mkdir -p $(GIT_TARNAME)
>  	@cp git.spec configure $(GIT_TARNAME)
>  	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
