From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] Replace hard-coded path with one configurable at make
 time
Date: Sun, 4 Apr 2010 23:28:01 +0100
Message-ID: <20100404222801.GB31315@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:29:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYKK-0005OY-OS
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0DDW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:29:50 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39018 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0DDW3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:29:49 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NyYKB-0007X7-Tm; Sun, 04 Apr 2010 23:29:48 +0100
Content-Disposition: inline
In-Reply-To: <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143955>

Junio C Hamano <gitster@pobox.com> writes:

>  * What's the point of making this configurable, other than "because we
>    can"?

I have a local patch against git to fix these paths, as I run it on slightly
unusual systems with a non-standard directory layout (no /usr, but
/local/bin in some cases) and I don't like to see incorrect paths compiled
into my binaries. It occurred to me that if I want to fix it one way
locally, others may well want to vary it too for different reasons, e.g. to
add /opt/bin or /usr/gnu to the default path.

Ultimately, I guess it feels like it should be configurable rather than
needing to be patched in the source for the same reason prefix or gitexecdir
is, but this is definitely for a minority audience!

Were it just exec_cmd.c, I would just have changed it to use _PATH_DEFPATH
from <paths.h> in preference to a make variable, as that should always give
an appropriate value for a correctly put-together system and is a sensible
place to treat as the central definition of 'default path'. However, in this
case it's needed in the shell script too and I don't think I can easily get
at _PATH_DEFPATH from there.

>  * Use of "$(x_SQ)" is about protecting whitespaces and single quotes in
>    the literal from make and shell, but does not have anything to do with
>    protecting things like $foo in that literal from the location $x is
>    eventually embedded in.  As long as paths on DEFPATH do not have double
>    quote in it (which would be a sane assumption), the patch to exec_cmd.c
>    would work fine, but I don't know if you need an extra quoting when
>    DEFPATH is used in shell scripts.  E.g. DEFPATH=$GIT_EXEC_PATH:/usr/bin
>    would have GIT_EXEC_PATH expanded in mongoose configuration file, but
>    will not be expanded in exec_cmd.c, leading to an inconsistent
>    behaviour.

Oh I see, yes; I didn't worry about quoting it correctly in the generated
shell script, assuming it would be reasonable... but if I'm assuming it's
reasonable there's no point in the _SQ to protect the shell invoking sed in
the first place.

I also notice that the makefile makes the assumption that ' might occur in
pathological paths and so needs quoting, but then uses sed 's|x|y|g' for
(say) @@PERL@@ which will break for other pathological paths containing | or
\1 and so on. Tidying that up fully might be entertaining!

Cheers,

Chris.
