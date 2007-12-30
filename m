From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sun, 30 Dec 2007 14:02:28 +0100
Message-ID: <e5bfff550712300502p543680b9jbeb9469a5a970f0@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
	 <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 14:03:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8xol-0000Mi-Px
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 14:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXL3NCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 08:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbXL3NCf
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 08:02:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:17902 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbXL3NCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 08:02:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4181870rvb.1
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 05:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IIyM7eKXNeH/gpXKPiXtLNfJ+TY26PRYn9SXbisypZs=;
        b=jIGqUk0yIeunxhS4tKakGjDZOtR+M9TxnvRsuhnrAwfTIg00LVACoSOCBmcL8g4+K1nBNtCAzSZ4WrvdidCAFsTmqJ1rTzBxFF2cujhq91+tb8VN/xLKPV7APLncyOBi6osUSSvYsxHyyw3AoVqJZzdAIHSLmWYbTPsM+ienuuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BhaB0cD7iTW9IcMfu+Zc8lKN/uT00e52aAAeTBTKgP/u61cnV5GzYhuFntP4rhYAQ5Npart/5gYRkrp1b6aNsCz7ZtFr5AeAaC/ikd08ICb4wNpYOIGVUoJ9amy+5J1ZTsmehnWJFpaUw/6mTfZIP0hLShuS73i7VCH24xc60T8=
Received: by 10.141.89.13 with SMTP id r13mr5805992rvl.177.1199019748554;
        Sun, 30 Dec 2007 05:02:28 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 30 Dec 2007 05:02:28 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69358>

On Dec 29, 2007 11:15 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> However, since you already seem to have a profiling setup ready, I would
> be interested in some numbers, i.e. if this patch is faster for you or
> slower, or shows no effect at all.
>

Yes Johannes, your patch is faster then mine ;-)


These are the results tested on Linux tree:

Vanilla

[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
3.61user 0.09system 0:03.70elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27155minor)pagefaults 0swaps


Marco's path

[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
3.21user 0.08system 0:03.30elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27154minor)pagefaults 0swaps


Johannes's patch

[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
2.92user 0.08system 0:03.01elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27155minor)pagefaults 0swaps



But that's not the end of the story....

After profiling I have found a better yet patch :-)

-------------------- CUT ABOVE --------------------

Subject: [PATCH] Certain codepaths (notably "git log --pretty=format...") use

prefixcmp() extensively, with very short prefixes.  In those cases,
calling strlen() is a wasteful operation, so avoid it.

Initial patch by Johannes Schindelin.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 git-compat-util.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..843a8f5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -398,7 +398,16 @@ static inline int sane_case(int x, int high)

 static inline int prefixcmp(const char *str, const char *prefix)
 {
-	return strncmp(str, prefix, strlen(prefix));
+	do {
+		if (*str != *prefix)
+			return *(unsigned const char *)prefix - *(unsigned const char *)str;
+
+		if (!*(++prefix))
+			return 0;
+
+		str++;
+
+	} while (1);
 }

 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-- 
1.5.4.rc2-dirty

BTW the results with this profiled patch are the followings:

Marco's patch TAKE 2 (profiled one)

[marco@localhost linux-2.6]$ time git log --topo-order --no-color
--parents -z --log-size --boundary
--pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
2.89user 0.07system 0:02.96elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27154minor)pagefaults 0swaps


Not a big improvement, but an improvement in any case because the
check for (*prefix==0) and for (*str != *prefix) are swapped regarding
your patch, this means that in the common case of a failing match (as
happens where you are looking for a specific prefix in a string
vector) with this patch you avoid the (*prefix==0) comparison because
prefixcmp() exsits just after the (*str != *prefix).


Of course we need that the *prefix is not "", but we have already
ruled out prefix == NULL, so It does not seem a biggie...

Thanks...it was very fun!
Marco
