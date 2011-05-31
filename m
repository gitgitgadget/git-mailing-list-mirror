From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Tue, 31 May 2011 22:00:04 +0200
Message-ID: <4DE548C4.2010600@web.de>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 31 22:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRV6s-0003PS-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 22:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab1EaUAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 16:00:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46470 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1EaUAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 16:00:06 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 787481A0C84C5;
	Tue, 31 May 2011 22:00:04 +0200 (CEST)
Received: from [93.240.123.160] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRV6i-0001fa-00; Tue, 31 May 2011 22:00:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE541EC.7010202@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+uMsSLHDth4S5Jb3y3GG2WjIj4Ehuvh0xlSLXa
	dZaHgEqyDZoCL6rCnVGc4y5ZAO1IQ5WlJPgNQqqLiEie1Fshym
	Bmx+MYmxNAxr39g4GIrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174826>

A "git submodule add ../sub" interprets "../sub" relative to the default
remote of the superproject. To be able to do that, a url for that remote
has to be set in the superprojects .git/config. If that is not the case
the command fails with:
	"remote (origin) does not have a url defined in .git/config"

This neither mentions the relative repository nor that the .git/config of
the superproject is the one with the missing url. And as a novice user
could assume that relative paths would work just like absolute paths do
in the filesystem and run into this by accident, the message is not very
helpful.

So change that to
	"Cannot resolve "../sub" relative to remote (origin), its url
	 is not set in .git/config"
to give the user a clue that "git submodule add" interprets a relative
path as being relative to its default remote, not the work tree.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 31.05.2011 21:30, schrieb Jens Lehmann:
> Am 30.05.2011 23:51, schrieb Marc Branchaud:
>> Patch 1 tests the case where "submodule add" fails if the path to the
>> submodule repo is relative (i.e. starts with "../").  This currently fails
>> with "remote (origin) does not have a url defined in .git/config".  Maybe
>> there's a reason to fail?  If so, a better error message would be appreciated.
> 
> I stumbled across this behavior now and then too, but according to the
> commit it added (f31a522a2d) it is intended that adding a relative path
> behaves differently than using an absolute path (it resolves relative to
> the superproject's origin, not the filesystem, and to be able to do that
> the superproject's .git/config has to have an url defined for it). But
> you are right about the error message, it really isn't that helpful ...

What about this patch?


 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..14ef1d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,7 +34,7 @@ resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
-		die "remote ($remote) does not have a url defined in .git/config"
+		die "Cannot resolve \"$1\" relative to remote ($remote), its url is not set in .git/config"
 	url="$1"
 	remoteurl=${remoteurl%/}
 	sep=/
-- 
1.7.5.3.412.gb2afd.dirty
