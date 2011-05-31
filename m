From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] submodule add: improve message when resolving a relative
 url fails
Date: Tue, 31 May 2011 23:34:47 +0200
Message-ID: <4DE55EF7.9050609@web.de>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de> <4DE5561C.3010200@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 31 23:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRWbu-0007nS-JO
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab1EaVgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 17:36:17 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41849 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529Ab1EaVgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 17:36:16 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id AD72519006324;
	Tue, 31 May 2011 23:34:47 +0200 (CEST)
Received: from [93.240.123.160] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRWaN-0007jg-00; Tue, 31 May 2011 23:34:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE5561C.3010200@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/NrC+5IOoFCicPqsXXPzylEpEjHJwn0WJDl3vh
	44GPZdy+7IC+d+HsMULJA2qj6LVB2jZQCbRPNvzQn1L0WmAgg7
	yWEquyP7tkl8eiyPmGRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174831>

A "git submodule add ../sub" interprets "../sub" relative to the default
remote of the superproject. To be able to do that, a url for that remote
has to be set in the superproject's .git/config. If that is not the case
the command fails with:
	"remote (origin) does not have a url defined in .git/config"

This neither mentions the relative repository nor that the .git/config of
the superproject is the one with the missing url. And as a novice user
could assume that relative paths would work just like absolute paths do
in the filesystem and run into this by accident, the message is not very
helpful.

So change that to
	Cannot resolve "../sub" relative to this repository's "origin"
	remote: The remote's URL is not set in .git/config
to give the user a clue that "git submodule add" interprets a relative
path as being relative to its default remote, not the work tree.

Thanks-to: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Thanks for your review, here is the updated patch.

Am 31.05.2011 22:57, schrieb Marc Branchaud:
> However, overall I think this is a pretty fragile way to handle relative
> paths.  Consider:
> 
>  - The super-repo must be a clone in order for this to work at all.
> 
>  - The super-repo cannot be checked out on a detached HEAD.
> 
>  - The current code rewrites the URL so that any relative path is either
>    rejected or munged into an absolute remote URL.
> 
> It seems to me that this feature will only work in a fairly narrow set of
> circumstances, and even when it does work it's likely to do something
> unexpected (think of a super-repo with several remotes).

And even worse: it defies the principle of least surprise when I can't
just replace an absolute filesystem path with a relative one just like
almost everywhere else ... an option enabling this behavior might have
been a better way in hindsight.

> Back when Junio accepted the original patch, he said "If you maintain and
> serve a set related projects you need to give the users a single URL (per
> where the user is and how to reach the server)."  I'm not sure I understand
> that:  Why would the users be adding their own submodules to the
> superproject?  Wouldn't the superproject define the submodules in for them?

I can't tell about that reasoning, but it might make sense in a way I don't
understand yet ...

> I think it would be better to either just reject relative paths entirely, or
> accept any relative path as-is and display a warning that the submodule is
> only valid on the local machine.  (Perhaps one day receive-pack could even be
> taught to reject any pushes with a .gitmodules file containing a relative URL.)

Breaking backwards compatibility should not be considered easily. I tend to
not change such things until I understand the use cases for the solution,
especially as submodule use cases tend to be very different ...


 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..587d74e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,7 +34,7 @@ resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
-		die "remote ($remote) does not have a url defined in .git/config"
+		die "Cannot resolve \"$1\" relative to this repository's \"$remote\" remote: The remote's URL is not set in .git/config"
 	url="$1"
 	remoteurl=${remoteurl%/}
 	sep=/
-- 
1.7.5.3.445.g9c0c23
