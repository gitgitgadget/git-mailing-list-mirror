From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 5/5] clean: improve performance when removing lots of
 directories
Date: Tue, 28 Apr 2015 02:24:23 -0400
Message-ID: <20150428062422.GM24580@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-6-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 08:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymywa-00080y-J3
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbbD1GY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 02:24:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:50996 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932573AbbD1GYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:24:25 -0400
Received: (qmail 20521 invoked by uid 102); 28 Apr 2015 06:24:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:24:25 -0500
Received: (qmail 11992 invoked by uid 107); 28 Apr 2015 06:24:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 02:24:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 02:24:23 -0400
Content-Disposition: inline
In-Reply-To: <1430030985-14499-6-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267902>

On Sun, Apr 26, 2015 at 08:49:45AM +0200, Erik Elfstr=C3=B6m wrote:

> +/*
> + * Return 1 if the given path is the root of a git repository or
> + * submodule else 0. Will not return 1 for bare repositories with th=
e
> + * exception of creating a bare repository in "foo/.git" and calling
> + * is_git_repository("foo").
> + */
> +static int is_git_repository(struct strbuf *path)
> +{
> +	int ret =3D 0;
> +	int unused_error_code;
> +	size_t orig_path_len =3D path->len;
> +	assert(orig_path_len !=3D 0);
> +	if (path->buf[orig_path_len - 1] !=3D '/')
> +		strbuf_addch(path, '/');
> +	strbuf_addstr(path, ".git");
> +	if (read_gitfile_gently(path->buf, &unused_error_code) || is_git_di=
rectory(path->buf))
> +		ret =3D 1;
> +	strbuf_setlen(path, orig_path_len);
> +	return ret;
> +}

This iteration looks reasonable overall to me.

Should this is_git_repository() helper be available to other files? I
think there are other calls to resolve_gitlink_ref() that would want th=
e
same treatment (e.g., I think "git status" may have a similar issue).

-Peff
