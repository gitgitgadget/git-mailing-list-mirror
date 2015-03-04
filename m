From: Jeff King <peff@peff.net>
Subject: Re: git add to ignore whitespaces, some day?
Date: Wed, 4 Mar 2015 05:05:50 -0500
Message-ID: <20150304100549.GA15788@peff.net>
References: <CAJ+F1CL_X7d3RayLmohU3tMi6w5juVFEwCEBUA_Nf-Z53bq+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:06:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT6Bk-0004Ur-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbbCDKFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 05:05:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:56166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932792AbbCDKFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 05:05:52 -0500
Received: (qmail 384 invoked by uid 102); 4 Mar 2015 10:05:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:05:52 -0600
Received: (qmail 29101 invoked by uid 107); 4 Mar 2015 10:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 05:05:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 05:05:50 -0500
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL_X7d3RayLmohU3tMi6w5juVFEwCEBUA_Nf-Z53bq+ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264745>

On Fri, Feb 27, 2015 at 01:09:30AM +0100, Marc-Andr=C3=A9 Lureau wrote:

> It would be nice if git-add could be told to ignore whitespace
> changes, wouldn't it?
>=20
> According to SO, I am not the one to think so:
> http://stackoverflow.com/questions/3515597/git-add-only-non-whitespac=
e-changes
>=20
> A change to add--interactive would be as simple as adding the diff -b
> or -w option like:
> my @diff =3D run_cmd_pipe("git", @diff_cmd, "-w", "--", $path);

What would it mean to stage such a hunk? For example, consider this
situation:

    git init

    echo 'foo();' >file
    git add file

    {
      echo 'if (something) {'
      echo '    foo();'
      echo '}'
    } >file

A regular diff shows:

    diff --git a/file b/file
    index a280f9a..ce0eeda 100644
    --- a/file
    +++ b/file
    @@ -1 +1,3 @@
    -foo();
    +if (something) {
    +    foo();
    +}

but "diff -w" would show:

    diff --git a/file b/file
    index a280f9a..ce0eeda 100644
    --- a/file
    +++ b/file
    @@ -1 +1,3 @@
    +if (something) {
         foo();
    +}

If we try to apply that hunk to what is in the index, it will not work.
The context line does not exist in the index file. Even if you could
convince git-apply to massage it into place, it still does not update
the whitespace in the 'foo();' line. IOW, we did not stage the full hun=
k
at all; running "git add -p" again would show that we still have the
whitespace change to stage.

So if you were to pursue this, it would have to have two copies of each
hunk: the one to apply, and the "display" copy that we show the user. W=
e
do this already for colorization. However, I think we rely there on the
fact that the two versions of the diff match up, line for line. Whereas
here, you would not even necessarily have the same number of hunks
between the regular and "-b" versions.

-Peff
