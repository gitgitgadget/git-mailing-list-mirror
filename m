From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Thu, 27 Jun 2013 20:47:15 +0200
Message-ID: <vpqppv7bdcc.fsf@anie.imag.fr>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	<7vr4fnsafy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 20:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsHEB-0007kn-I5
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab3F0Sr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 14:47:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45372 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab3F0Sr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 14:47:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5RIlDr9013417
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Jun 2013 20:47:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsHDw-0005r8-9j; Thu, 27 Jun 2013 20:47:16 +0200
In-Reply-To: <7vr4fnsafy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Jun 2013 10:57:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Jun 2013 20:47:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229143>

Junio C Hamano <gitster@pobox.com> writes:

> As far as I can tell, the only real reason why you need this and
> cannot use ../../bin-wrappers/git directly is because the GITPERLLIB
> it gives you only points at ../../perl/blib/lib and not this
> directory.

Not only. You also need to have contrib/mw-to-git/ in the $PATH to be
able to run "git mw" and "git clone mediawiki::...".

>  - Is there a reason you would not want to "install" whatever Perl
>    modules you want to "use" via GITPERLLIB mechanism to
>    ../../perl/blib/lib?

A previous version of the patch did something like this. This previous
iterations had issues, IIRC with the PATH, but they should be solvable
(and most likely independant from the $GITPERLLIB).

>  Perhaps it will interfere with the real installation step in
>  ../../perl/Makefile? If that is the case, then it is not a good idea,
>  but otherwise, that would let you use ../../bin-wrappers/git as-is.

I do not like very much the idea of having the same target directory for
two Makefiles, but that's just instinctive suspicion, not a real
argument.

>  - Perhaps we could do:
>
> 	GITPERLLIB="${GPLEXTRA+$GPLEXTRA:}@@BUILD_DIR@@/perl/blib/lib"
>
>    in wrap-for-bin.sh, so that your instruction can become
>
> 	GPLEXTRA=$(pwd) ../../bin-wrappers/git whatever-mw-thing

You'd have to tweak the $PATH too, but that could be done by a very
small wrapper calling Git's bin-wrapper/git, like this:

GIT_ROOT_DIR=../../..
GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
GIT_MEDIAWIKI="$GIT_EXEC_PATH"/contrib/mw-to-git
PATH="$GIT_MEDIAWIKI"/contrib/mw-to-git:"$PATH"
GPLEXTRA="$GIT_MEDIAWIKI"/contrib/mw-to-git

exec "${GIT_EXEC_PATH}/bin-wrappers/git" "$@"

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
