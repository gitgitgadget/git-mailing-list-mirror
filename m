From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 16:02:47 -0700
Message-ID: <7vd2q75zoo.fsf@alter.siamese.dyndns.org>
References: <1374675701-10592-1-git-send-email-dev@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, apelisse@gmail.com, felipe.contreras@gmail.com
To: Joern Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Thu Jul 25 01:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2859-0004Ie-AO
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 01:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab3GXXCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 19:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3GXXCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 19:02:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A32B83341A;
	Wed, 24 Jul 2013 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bXZrNQYZoPuG5k03tKdB906hAV4=; b=W1EoBK
	E8jyszbu3F898m+CvLmffVVKFq6EIUd/bvMx6FQir58e3X6M29u2b8Fnb66PaX22
	i6Qa0RiWXE6c4hM2yAQGQQHLAJSQg4BuwLNQhVBU5M0nQEzRe0tO1hRbrNRNgcli
	pF5p7c0ZJMt6EZgMX0fUUd4wBFkEfwCV0I6KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z2IJb+GbyZi3bxEgQdyUnTC+2Mdnx3rV
	eGy5uOuvd0Y8YU4Fb8E96oALdXZ3YW+X1D6EGNa0zZ6otr+tr2TILS0ywV5elb4V
	ZWK8CTtNFrgrjUvWgool/4aHEJYTBYtF2Ixt0x9pdYgI/v/5J4Kz465FVT31O1KB
	zinZxnZCSvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9816C33419;
	Wed, 24 Jul 2013 23:02:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD46833415;
	Wed, 24 Jul 2013 23:02:48 +0000 (UTC)
In-Reply-To: <1374675701-10592-1-git-send-email-dev@joernhees.de> (Joern
	Hees's message of "Wed, 24 Jul 2013 16:21:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29079D6C-F4B5-11E2-9BB0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231121>

Joern Hees <dev@joernhees.de> writes:

> 6796d49 introduced a bug by making shared_path == ".git/hg' which
> will most likely exist already, causing a new remote never to be
> cloned and subsequently causing hg.share to fail with error msg:
> "mercurial.error.RepoError: repository .git/hg not found"
>
> Changing shared_path to ".git/hg/.shared" will solve this problem

Here you say "shared" and the code says "share"; which one is
preferred (I know either would work, but we would want to be
consistent).

I'd vote for "shared", but I do not see a compelling reason to pick
one over the other so...?

> and create a shared local mercurial repository for non local remotes.
> The initial dot circumvents a name clash problem should a remote be
> called "shared".
>
> Signed-off-by: Joern Hees <dev@joernhees.de>
> Mentored-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 0194c67..4a7d7a8 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -390,7 +390,7 @@ def get_repo(url, alias):
>          if not os.path.exists(dirname):
>              os.makedirs(dirname)
>      else:
> -        shared_path = os.path.join(gitdir, 'hg')
> +        shared_path = os.path.join(gitdir, 'hg', '.share')
>          if not os.path.exists(shared_path):
>              try:
>                  hg.clone(myui, {}, url, shared_path, update=False, pull=True)
