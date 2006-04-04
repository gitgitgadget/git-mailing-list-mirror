From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 4 Apr 2006 11:01:30 -0700
Message-ID: <20060404180130.GF14967@reactrix.com>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <4431694C.4000007@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 20:02:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQpqT-00071A-4Y
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDDSBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDDSBe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:01:34 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:23137 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750782AbWDDSBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 14:01:34 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34I1UkH002521;
	Tue, 4 Apr 2006 11:01:30 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34I1UVx002519;
	Tue, 4 Apr 2006 11:01:30 -0700
To: Daniel Drake <dsd@gentoo.org>
Content-Disposition: inline
In-Reply-To: <4431694C.4000007@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18399>

On Mon, Apr 03, 2006 at 07:28:28PM +0100, Daniel Drake wrote:

> Ah, should have known. I am behind a (lame) transparent proxy on port 80.
> 
> I opened that file in my web browser and it showed the old heads. After 
> a force-refresh (ctrl+F5, which sends some additionally http headers to 
> refresh the page from the real server), the old heads disappeared, and 
> git now clones successfully.
> 
> git-http-fetch should probably send those extra headers too. I'll try to 
> find some time to look at this next week.

git-http-fetch uses the "Pragma: no-cache" header when requesting
objects that shouldn't be cached.  Is this the additional header you're
referring to?

This patch adds the header to git-ls-remote for the info/refs request.


git-ls-remote: send no-cache header when fetching info/refs

Proxies should not cache this file as it can cause a client to end up with
a stale version, as reported here:

http://marc.theaimsgroup.com/?l=git&m=114407944125389

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 git-ls-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

da9b6fa01f1a8bd6ab5f6d4346584f3f032584aa
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 2c9a588..b6882a9 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -53,7 +53,7 @@ http://* | https://* )
         if [ -n "$GIT_SSL_NO_VERIFY" ]; then
             curl_extra_args="-k"
         fi
-	curl -nsf $curl_extra_args "$peek_repo/info/refs" ||
+	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
 		echo "failed	slurping"
 	;;
 
-- 
1.3.0.rc1.g9aef-dirty
