From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 14:35:10 +0100
Message-ID: <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
	<20110322111844.GA32446@sigill.intra.peff.net>
	<20110322132820.GA14559@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 14:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21kJ-0007qZ-7y
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab1CVNfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 09:35:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45076 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab1CVNfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 09:35:11 -0400
Received: by bwz15 with SMTP id 15so5830891bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CKB8NZ4v9yAlh6HBZzQdveI+UW6Ic3lx+1zojWGa/zA=;
        b=rN65FwRBKiOldrSHjr3rC9upvFyoELy7EuVAx/XFJV2xDX2+P+Qi+0ATiuz+gMf5F1
         pl3Yhi0JqKPJDFpLU/sXljoXLdWKZH/uOoncXdhL4Q7xbNe7bYHce697SSu2rlBWC2Zp
         PNTUmEgno3an8ox9M5XF4Un00m4qHmfRt648o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cletRjy5DYpQw6RffBfaSZsCjU0e7f2dfwAiDEO40eOd3ARk2d542cGXaCjB9fdzEX
         GaQmsQLhP2upioodwxr6fckX4il3EFgw5o8yoyYy2b7fHG34Qjbee/mBmE25QCzuGzmt
         1Cou7PYyOnXpMyhs1aj69//idJtGF0UR7aTQY=
Received: by 10.204.166.66 with SMTP id l2mr4901199bky.6.1300800910420; Tue,
 22 Mar 2011 06:35:10 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Tue, 22 Mar 2011 06:35:10 -0700 (PDT)
In-Reply-To: <20110322132820.GA14559@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169734>

On 22 March 2011 14:28, Jeff King <peff@peff.net> wrote:
> But I think that is a little too magic for my taste. Although the false
> positives ("!echo 'literal $#'") and false negatives (you want "!foo" to
> _ignore_ its parameters) are pretty obscure, I would prefer to keep
> things simple.

Then how about simply:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6468a68..8097480 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -586,9 +586,16 @@ If the alias expansion is prefixed with an
exclamation point,
 it will be treated as a shell command.  For example, defining
 "alias.new = !gitk --all --not ORIG_HEAD", the invocation
 "git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
+"gitk --all --not ORIG_HEAD". Note that any arguments you pass
+when running aliases are simply appended to the shell command.
+This means that "alias.foo = !echo $# args: $1, $2 and $3" will
+not do what you expect. To use alias arguments as positional
+parameters, wrap your command in a shell function:
+"alias.foo = !foo () { echo $# args: $1, $2 and $3; }; foo"
++
+Shell commands will be executed from the top-level directory
+of a repository, which may not necessarily be the current
+directory.

 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
-- 
/Lasse
