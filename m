From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Sat, 21 Nov 2009 15:56:50 +0100
Message-ID: <200911211556.52175.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <4B06157B.10203@gmail.com> <200911210132.44649.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 15:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBrNv-0004AC-5N
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 15:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbZKUO4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 09:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbZKUO4J
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 09:56:09 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55248 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbZKUO4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 09:56:08 -0500
Received: by bwz27 with SMTP id 27so4057199bwz.21
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tluyShH03M2XSP7kFehOL8GQRTJ73exRBIEOl2B5meQ=;
        b=Y6MU1oixijq8o1qoj4x6pnQntc35uoKyWsniwibp6mO6siwkVcyLTUC+sK3rYSDO5F
         xQvvsLW8RSD1HXvcTrx8IAG5bZk/I8E1UGJRQcwH8CPuzHWKhqX7+6PVFu818niowghk
         3PzgUFAULeV8lc7s0t7aRJi2H5BGsojGxv+hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iXOJzVDILaMbPxozJpJy4eocd7y8bvdkwtv5PCSOJClNBSXKtKfbWbFezcgADBW/TP
         o7mLWbuo19vSpe72rSClTaANSFTzhrFG1nJfuplplAwYwUpXwO4PbabCJj3bhL4F1FWD
         aP/qg0hmHWqugBw5mZr7uFbDjRThuStSGj8U4=
Received: by 10.204.20.82 with SMTP id e18mr2608028bkb.168.1258815372385;
        Sat, 21 Nov 2009 06:56:12 -0800 (PST)
Received: from ?192.168.1.13? (abvw56.neoplus.adsl.tpnet.pl [83.8.220.56])
        by mx.google.com with ESMTPS id 16sm674472bwz.7.2009.11.21.06.56.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 06:56:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200911210132.44649.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133396>

On Sat, 21 Nov 2009, Jakub Narebski wrote:

> * Testing it with IE8 (Internet Explorer 8.0.6001.18702) page loading stops
>   at 0%, at the very beginning on startBlame() function
> 
>   IE8 shows that it finds the following errors:
> 
>   * "firstChild is null or not an object"
>     line: 565, char:4
> 
>       a_sha1.firstChild.data = commit.sha1.substr(0, 8);
> 
>     It might be caused by the fact that firstChild for this case should be
>     text node containing of pure whitespace:
>        <a href=""> </a>
>     Perhaps IE8 simplifies it in "compatibility view" mode

This bug (be it in gitweb.js or in IE8) is fixed by the following patch:

-- 8< --
diff --git i/gitweb/gitweb.js w/gitweb/gitweb.js
index 200ec5a..c1e425c 100644
--- i/gitweb/gitweb.js
+++ w/gitweb/gitweb.js
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
-- >8 --

> 
>  * "Unspecified error" (twice)
>    line: 777, char:2
> 
>      if (xhr.readyState === 3 && xhr.status !== 200) {
>      	return;
>      }
> 
>    I don't know what might be the source of error here; I suspect that the
>    error position mentioned by IE8 is bogus.

But I have no idea how to fix this.  "Unspecified error" isn't very 
helpful...

-- 
Jakub Narebski
Poland
