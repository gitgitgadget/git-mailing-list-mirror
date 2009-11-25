From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Wed, 25 Nov 2009 01:45:15 +0100
Message-ID: <200911250145.16472.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911210132.44649.jnareb@gmail.com> <200911211556.52175.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 01:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND60j-0007Jc-OQ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 01:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbZKYApW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 19:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933397AbZKYApV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 19:45:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34230 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933372AbZKYApV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 19:45:21 -0500
Received: by bwz27 with SMTP id 27so6542774bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 16:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jKHZeNpbbtznSqsF/qjU5rDJKi9/02DCmXkHGcTWjh0=;
        b=LvxZyeUZVJu44e+S4FLPlHOdPM/on1rradZilhH0SxEJEe3H/2zy+S0UMuKIPm3JzD
         UKu2MfSVvtDl6Y79CBO6nUpPAtt7shIHEZnRe1kwUkLRHLSUYz8iyrW93fnKozeObdnO
         MTq+fsp7apE7oD/FFIC4aYpk/uEqkLZceXh18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CuIyw6t3mA+7hCM5SVuXBmpJrqg1uPf/VEYCm/mpEpT8OwGR4JzKCAFhyH/7lA4P6I
         qDGtKwlu/LfS/u+0Xbwf+j9IqSuetwmecusAc9R4HnIC2WEVLy7MSusa4or4BaBLHKC8
         nV8tKSYI63B/xGKmu0iRKLVRUFpJXmZ8XSyy8=
Received: by 10.204.29.15 with SMTP id o15mr6863172bkc.145.1259109925720;
        Tue, 24 Nov 2009 16:45:25 -0800 (PST)
Received: from ?192.168.1.13? (abwj137.neoplus.adsl.tpnet.pl [83.8.233.137])
        by mx.google.com with ESMTPS id 15sm2027323fxm.6.2009.11.24.16.45.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 16:45:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200911211556.52175.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133600>

On Sat, 21 Nov 2009, Jakub Narebski wrote:
> On Sat, 21 Nov 2009, Jakub Narebski wrote:
> 
> > * Testing it with IE8 (Internet Explorer 8.0.6001.18702) page loading stops
> >   at 0%, at the very beginning on startBlame() function
> > 
> >   IE8 shows that it finds the following errors:
> > 
> >   * "firstChild is null or not an object"
> >     line: 565, char:4
> > 
> >       a_sha1.firstChild.data = commit.sha1.substr(0, 8);
> > 
> >     It might be caused by the fact that firstChild for this case should be
> >     text node containing of pure whitespace:
> >        <a href=""> </a>
> >     Perhaps IE8 simplifies it in "compatibility view" mode
> 
> This bug (be it in gitweb.js or in IE8) is fixed by the following patch:
> 
> -- 8< --
> diff --git i/gitweb/gitweb.js w/gitweb/gitweb.js
> index 200ec5a..c1e425c 100644
> --- i/gitweb/gitweb.js
> +++ w/gitweb/gitweb.js
> @@ -562,7 +562,12 @@ function handleLine(commit, group) {
>  			td_sha1.rowSpan = group.numlines;
>  
>  			a_sha1.href = projectUrl + 'a=commit;h=' + commit.sha1;
> -			a_sha1.firstChild.data = commit.sha1.substr(0, 8);
> +			if (a_sha1.firstChild) {
> +				a_sha1.firstChild.data = commit.sha1.substr(0, 8);
> +			} else {
> +				a_sha1.appendChild(
> +					document.createTextNode(commit.sha1.substr(0, 8)));
> +			}
>  			if (group.numlines >= 2) {
>  				var fragment = document.createDocumentFragment();
>  				var br   = document.createElement("br");
> -- >8 --

Below the same patch is in the form of a proper commit; although the title
(subject) of this commit could be better...

> >  * "Unspecified error" (twice)
> >    line: 777, char:2
> > 
> >      if (xhr.readyState === 3 && xhr.status !== 200) {
> >      	return;
> >      }
> > 
> >    I don't know what might be the source of error here; I suspect that the
> >    error position mentioned by IE8 is bogus.
> 
> But I have no idea how to fix this.  "Unspecified error" isn't very 
> helpful...

Debugging this is serious PITA.  After fix below it appears that this bug
is some intermittent bug, depending on XMLHttpRequest timing.  It more
often than not (at least when I tried to debug it using build-in IE8
debugger) works correctly for the folowing files: README, GIT-VERSION-GEN,
revision.c (once even it did fail when first running for given file, and
then running correctly when reloading from debugger; fun it is not).

It does consistently fail for gitweb/gitweb.perl... but when I tried
to debug it IE8 would hang up when trying to use debugger (with around
600MB available RAM).  Perhaps somebody else would have more luck...

-- >8 --
Subject: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame

Internet Explorer 8 stops at beginning of blame filling
with the following bug
  "firstChild is null or not an object"
at this line
  a_sha1.firstChild.data = commit.sha1.substr(0, 8);

It is (probably) caused by the fact that while a_sha1 element,
which looks like this
  <a href=""> </a>
has firstChild which is text node containing only whitespace (single
space character) in other web browsers (Firefox 3.5, Opera 10,
Google Chrome 3.0), IE8 simplifies DOM, removing trailing/leading
whitespace.

Protect against this bug by creating text element if it does not
exist.

Found-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.js |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 200ec5a..c1e425c 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -562,7 +562,12 @@ function handleLine(commit, group) {
 			td_sha1.rowSpan = group.numlines;
 
 			a_sha1.href = projectUrl + 'a=commit;h=' + commit.sha1;
-			a_sha1.firstChild.data = commit.sha1.substr(0, 8);
+			if (a_sha1.firstChild) {
+				a_sha1.firstChild.data = commit.sha1.substr(0, 8);
+			} else {
+				a_sha1.appendChild(
+					document.createTextNode(commit.sha1.substr(0, 8)));
+			}
 			if (group.numlines >= 2) {
 				var fragment = document.createDocumentFragment();
 				var br   = document.createElement("br");
-- 
1.6.5.3
