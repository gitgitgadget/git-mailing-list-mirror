From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 13:49:21 -0700
Message-ID: <7voctirzu6.fsf@alter.siamese.dyndns.org>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KdQ-0004He-Bt
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbZEXUtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756841AbZEXUtV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:49:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37185 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764AbZEXUtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:49:20 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204921.TQCL17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Sun, 24 May 2009 16:49:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vYpM1b0084aMwMQ04YpMMs; Sun, 24 May 2009 16:49:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=cKKtvLOY1ucA:10 a=pGLkceISAAAA:8
 a=4i2KtJ69iurDqMuHItEA:9 a=i2DVWNH3n0rzEYL2sN0A:7
 a=l7sW_O8_PzM_-cNVe0mYWNp9TlcA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119859>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This small patch series implements support for Stacked Git patch
> series import.
>
> The first commit adds support for StGit patches to mailinfo, which is
> required because StGit's default export template puts the From: line
> between the subject and the body.

This problem description makes it sound as if we always expect From: to
come before Subject: in the mailbox, and reject the input if they come in
a different order, which would be a bug.  Fixing it would not be limited
to supporting StGIT generated patch email.

But a quick glance at the actual patch makes me suspect that is not what
you are doing.  You are feeding something that is not a mailbox at all to
the mailinfo and _unconditionally_ extract the information according to
StGIT rules.

That's a bad taste.

At least, add a "this is not a mailbox, but is a StGIT formatted file, so
please extract info according to the StGIT rule, not the mailbox rule"
option, and

  (1) have a parameter to mailinfo() to trigger your new codepath only
      when the option is given; or

  (2) have a separate function "stgitinfo()" not "mailinfo()" that perhaps
      largely share the logic with the original "mailinfo()" function, and
      call that when the option is given; or even

  (3) have a separate _program_ that knows how to extract information from
      such an input file;

so that normal mailinfo invocation does not mishandle input that is _not_
StGIT output.

> The second commit makes git-am autodetect an StGit patch series index
> (when it's the only file passed to it) and proceeds to import the
> patches indicated in the series.

And that change would be a good place to decide to pass that "This is not
a mailbox but is a StGIT output" option to the updated mailinfo program
(or the new "stgitinfo" program).

What is the larger picture workflow that this new feature is expected to
help?  A project takes patches not in e-mail form but in a directory full
of files uploaded via scp/sftp with the StGIT series file and individual
StGIT patches that are pointed by the series file contained within?

I do not use StGIT anymore, so I do not remember how flexible its export
template mechanism is, nor how widely people use non-default templates,
but I have wonder about two and half things.

 - I am assuming that your patch won't be able to read the StGIT output if
   the uploader used non-default export template, so such a project needs
   to ask the uploaders to use the default template.

   If that is the case, why not ask them to use a custom template that
   generates one single valid mailbox that stores the patches in the right
   order?  That can be processed with stock "git am"; in addition, the
   output can be fed not just to "git".  Any other SCM that can work with
   e-mail based patchflow can use it.

 - Such a project can allow users to use random export templates as long
   as the template used to export the series is indentifiable (perhaps by
   including that template itself in the upload).  Your mailinfo patch
   needs to be extended to reverse what the export template did, and it
   really shouldn't be in the normal mailinfo() codepath.  The right
   approach would become something like (3) above, i.e. separate
   "StGITinfo" program called from "git am" if that is what you shoot for.

 - If StGIT is used by the project to such an extent to allow series
   directory upload, shouldn't the receiving end be also using StGIT to
   import the series, instead of running "git am" anyway?
