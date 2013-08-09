From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 11:49:45 -0700
Message-ID: <7veha266nq.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 20:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7rl5-0006x4-NN
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595Ab3HIStw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 14:49:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353Ab3HIStv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:49:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D771371B3;
	Fri,  9 Aug 2013 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWa6nI6Fmj72VrKDwgAZHgXAMWI=; b=NyvQzQ
	fidtsYu3uw2UfvnyXENzjG/chib1PAfswVpGiAPS6kqezp+uRv4JV5z/KXBkLA6B
	XMZUr4c18bvn0PDou656o2na9AxipH8fDucI3vrxJBLFrN79hJTufu48M7d34kE+
	gdrKxJkXuM5vX1NWL9JPHxIez+WnzkXYKYOMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0XafVOfB7YDfRmi44n/CrhRHCkGJFAa
	NyWBfkwIoa9tN5fggLT7gKfgHuD6brbv3QX4H/FBP5A78CU5bKcpMGpuQFlXAb2K
	vMCQgHQ/NXbo0IMtYw0cAtghF0pYulaWe9Z3ihoZdrtuM1fxZc+BMIRo+89wbUv6
	+PZTZK/h/g4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 519B2371B2;
	Fri,  9 Aug 2013 18:49:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77020371AE;
	Fri,  9 Aug 2013 18:49:47 +0000 (UTC)
In-Reply-To: <1376068387-28510-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Fri, 9 Aug 2013 19:13:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76EDAFF0-0124-11E3-B652-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232010>

Antoine Pelisse <apelisse@gmail.com> writes:

> The current code fixes the path to make it absolute when cloning, but
> doesn't consider tilde expansion, so that scenario fails throwing an
> exception because /home/myuser/~/my/repository doesn't exists:
>
>     $ git clone hg::~/my/repository && cd repository && git fetch
>
> Expand the tilde when checking if the path is absolute, so that we don't
> fix a path that doesn't need to be.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> On Mon, Aug 5, 2013 at 10:30 PM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> Shouldn't that be the job of the shell? (s/~/$HOME/)
>
> I'm not sure what you mean here. Does it mean that I should stop cloning using "~" ?

I think shells do not expand ~ when it appears in a string (e.g. hg::~/there);
you could work it around with

	git clone hg::$(echo ~/there)

and I suspect that is what Felipe is alluding to.  A tool (like
remote-hg bridge with this patch) that expands ~ in the middle of a
string also may be surprising to some people, especially to those
who know the shell does not.

> I also send this patch as I think it makes more sense to keep the
> ~ in the path, but just make sure we don't build invalid absolute
> path.
>
> By the way, I don't exactly understand why:
>
>     abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
>
> is done right after instead of:
>
>     abs_url = os.path.abspath(orig_url)

That looks like a good cleanup to me, too, but I may be missing some
subtle points...

By the way, you earlier sent an updated 1/2; is this supposed to be
2/2 to conclude the two-patch series?

> Cheers,
> Antoine
>
>  contrib/remote-helpers/git-remote-hg |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 1897327..861c498 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -1135,7 +1135,7 @@ def do_option(parser):
>
>  def fix_path(alias, repo, orig_url):
>      url = urlparse.urlparse(orig_url, 'file')
> -    if url.scheme != 'file' or os.path.isabs(url.path):
> +    if url.scheme != 'file' or os.path.isabs(os.path.expanduser(url.path)):
>          return
>      abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
>      cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % abs_url]
> --
> 1.7.9.5
