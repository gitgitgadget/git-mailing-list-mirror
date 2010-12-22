From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 36/47] rev-parse: prints --git-dir relative to user's cwd
Date: Tue, 21 Dec 2010 17:56:12 -0800
Message-ID: <7vvd2m605f.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-37-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 02:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVDwJ-0002YO-5e
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 02:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab0LVB4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 20:56:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab0LVB4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 20:56:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D41673927;
	Tue, 21 Dec 2010 20:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7dLOiqkF2mBpW+XNWTnZxEG8N
	T0=; b=W2L042J/jvqgYecHgCw/WP7j+4HNFJcKmxs6MNzP7m5bd50io9fxUfJob
	uU1Jb1QjwT2UeRv43NCvBarQn4yZrkB793tyHUYMOjfVW4pvfOQV5/F1LDJB4OMi
	fu0zaG+cgNVsm50US6CdN0i2el4cPq2+UGhywzfi1YiF8gpiFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=X4wzQ3O6dkNJ2moif2K
	uUWjkn8Ntvm9OUsfi1lGRQc0VAK9ptPqANaqA019FXiK6u9/RjwQOtig10A8vZSF
	MBycC71uoFFecLVeB4IOi4da6azGZBA1hfPQxKHMOxQR5UZOUYm6ZycvQMUoYGlC
	EQ0S1ZNaCT1prfPSEvCxmuII=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B06D93924;
	Tue, 21 Dec 2010 20:56:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A05FF3922; Tue, 21 Dec 2010
 20:56:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC3D4680-0D6E-11E0-BD32-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164068>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> git_dir variable in environment.c is relative to git's cwd, not user'=
s
> cwd. Convert the relative path (actualy by making it absolute path)
> before printing out.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/rev-parse.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index a5a1c86..65c287b 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -647,7 +647,11 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>  				static char cwd[PATH_MAX];
>  				int len;
>  				if (gitdir) {
> -					puts(gitdir);
> +					if (is_absolute_path(gitdir) || !prefix) {
> +						puts(gitdir);
> +						continue;
> +					}
> +					puts(make_absolute_path(gitdir));
>  					continue;
>  				}
>  				if (!prefix) {

I do not quite understand this change.  I can obtain GIT_DIR in a relat=
ive
form without this patch already:

    $ cd t/
    $ git --git-dir=3D../.git rev-parse --git-dir HEAD
    ../.git
    c7511731675da8b50c0d5243aa04a98c8a5ee316

Could we please have a new test case to demonstrate what is broken with=
out
this patch?
