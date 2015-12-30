From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-svn: add support for prefixed globs in config
Date: Wed, 30 Dec 2015 13:37:32 -0800
Message-ID: <xmqq60zfehyb.fsf@gitster.mtv.corp.google.com>
References: <1451470149-14735-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com,
	normalperson@yhbt.net
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:37:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEORE-0001Dh-8M
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbbL3Vhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:37:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753520AbbL3Vhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:37:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 558EB35B27;
	Wed, 30 Dec 2015 16:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cm+P+VCE69iv1JMmYQy5veFvkEg=; b=sksJlI
	ejHW/j8+YYEGcyFBIoJe3sGgdROABpSBrThYF3Kdz4w+QURctTmXsP3ELCJeZYg8
	ia91xslYYyZba6te6Oj/bPvpxQpSSUjphIQdBvhH3HsKJcW6R2PG0EayEurcw6vx
	MVjh7WCj44ALddjenjgdWLm2VyXvWOakp914k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bm3myAuoBnWNY9yOPILuqsNEumwkKZgd
	W5LSti4v+UZReNpM0+Lq9x7sHmf2HmBN9CHhjAesWjgALRIUtwU32WYRXTzuzUt/
	uFGIX1uKHz1rvIKgb4qiTwqkxUAer7C6y+LNzSBopxr48raogZL3n3zxgTWbK2ed
	epIPrXzWMUI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DDC235B26;
	Wed, 30 Dec 2015 16:37:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C704835B24;
	Wed, 30 Dec 2015 16:37:33 -0500 (EST)
In-Reply-To: <1451470149-14735-1-git-send-email-vleschuk@accesssoftek.com>
	(Victor Leschuk's message of "Wed, 30 Dec 2015 13:09:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 896F3418-AF3D-11E5-A5BB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283202>

Victor Leschuk <vleschuk@gmail.com> writes:

> Introduce prefixed globs for branches and tags in git-svn.
> Globs like 'release_*' allow users to avoid long lines in config like:
>
> branches = branches/{release_20,release_21,release_22,...}
>
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
> Changes from v3:
> 	* Wrapped all test preparations in separate test-cases
>
>  Documentation/git-svn.txt        |   5 ++
>  perl/Git/SVN/GlobSpec.pm         |   9 ++-
>  t/t9168-git-svn-prefixed-glob.sh | 142 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+), 5 deletions(-)
>  create mode 100755 t/t9168-git-svn-prefixed-glob.sh
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 0c0f60b..529cffe 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -1034,6 +1034,7 @@ listed below are allowed:
>  	url = http://server.org/svn
>  	fetch = trunk/project-a:refs/remotes/project-a/trunk
>  	branches = branches/*/project-a:refs/remotes/project-a/branches/*
> +	branches = branches/release_*:refs/remotes/project-a/branches/release_*

Hmph, if you are going this route, I wonder if there is a reason to
limit yourself only to "prefix".  Would allowing something like this:

	branches = branches/pre*post:refs/remotes/project-a/branches/*

i.e., loosening the rule to allow at most one asterisk anywhere on
the left hand side of the colon, and require the same number of
asterisks as the left hand side has on the right hand side of the
colon, be too lax and hurt the users?
