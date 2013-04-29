From: Jeff King <peff@peff.net>
Subject: Re: Git.pm with recent File::Temp fail
Date: Sun, 28 Apr 2013 22:16:51 -0400
Message-ID: <20130429021651.GA2751@sigill.intra.peff.net>
References: <20130322205758.09ca9107@pc09.procura.nl>
 <CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
 <20130428110933.436786bd@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Apr 29 04:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWdeQ-0005Fn-KY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 04:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab3D2CQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 22:16:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:51012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661Ab3D2CQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 22:16:53 -0400
Received: (qmail 31234 invoked by uid 102); 29 Apr 2013 02:17:07 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Apr 2013 21:17:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Apr 2013 22:16:51 -0400
Content-Disposition: inline
In-Reply-To: <20130428110933.436786bd@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222760>

On Sun, Apr 28, 2013 at 11:09:33AM +0200, H.Merijn Brand wrote:

> Still failing in 1.8.2.2
> 
> Short fix:
> --8<---
> diff --git a/perl/Git.pm b/perl/Git.pm
> index dc48159..7a252ef 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1265,7 +1265,7 @@ sub _temp_cache {
>                         $tmpdir = $self->repo_path();
>                 }
> 
> -               ($$temp_fd, $fname) = File::Temp->tempfile(
> +               ($$temp_fd, $fname) = File::Temp::tempfile(
>                         'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
>                         ) or throw Error::Simple("couldn't open new temp file");

I think this fix is the right thing. Your patch probably didn't get
applied because it did not follow the guidelines in SubmittingPatches.
Please make sure the subject-line of your email says "[PATCH]".

I.e., this part:

> From b3be713101469f8bea14b854eb7840132ffdca8a Mon Sep 17 00:00:00 2001
> From: "H.Merijn Brand - Tux" <h.m.brand@xs4all.nl>
> Date: Sun, 28 Apr 2013 11:03:15 +0200
> Subject: [PATCH] Git.pm with recent File::Temp fail

Should be your actual email header, not just in the body of the message.

> git-1.8.2{,.1,.2}, perl-5.16.3, File::Temp-0.23
> 
> Without patch:
> 
> $ git svn fetch
> 'tempfile' can't be called as a method at /pro/lib/perl5/site_perl/5.16.3/Git.pm line 1117.
> 
> After patch:
> 
> $ git svn fetch
>         M       t/06virtual.t
> r15506 = 6c65be7ff36ffc6fd9b960a4b470ca297103004e (refs/remotes/git-svn)

I think the relevant thing is that File::Temp 0.23 started complaining
about this. From their Changes file:

  2013-03-14 Tim Jenness <tjenness@cpan.org>

          ---- Release V0.23 CPAN ----

  [...]
        * Temp.pm: Calling tempfile or tempdir as a class method now
          produce a more useful fatal error message

So I think the right commit message is something like:

  We call File::Temp's "tempfile" function as a class method, but it was
  never designed to be called this way. Older versions seemed to
  tolerate it, but as of File::Temp 0.23, it blows up like this:

    $ git svn fetch
    'tempfile' can't be called as a method at .../Git.pm line 1117.

  Fix it by calling it as a regular function, just inside the File::Temp
  namespace.

-Peff
