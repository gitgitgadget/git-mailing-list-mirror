From: "Eric Raible" <raible@gmail.com>
Subject: Re: PATCH: Allow ':/<oneline prefix>' notation to specify a specific file
Date: Thu, 3 Jul 2008 04:05:21 -0700
Message-ID: <279b37b20807030405s8212daarcd4d0083cc2df03e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENcS-0006M6-So
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYGCMFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYGCMFQ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:05:16 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:9797 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYGCMFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:05:11 -0400
Received: by wf-out-1314.google.com with SMTP id 27so767267wfd.4
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qZIjo6SwX1CiIGUOpfZOkzpG4KYsuYyYPs7uUayOwVw=;
        b=HKcebEFhOfplOQt+TPGEPYnU1tJRjPC0t+oF4PFGaAAPaYI2MAKz7Sxk8MnFeOAzxW
         S+eMTjgQFLGzmnNunnPnnexfFRst9RW/heJtYspeqGzZLfJ8p90gDjs1GrrO8zRJE+0x
         jipbxZ2Y/QaRBhEdU4LxxJWBmxhS2gVNwRlBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=oeIb88GGIxX9/H4opiTC00p9Ft5lyJ9dPtQmV+m1FGbSqSBBTVPKQ98x+g/fJz9FoZ
         h28botHPIa3MIj1fM5KXH6xqOy+6aiRjLCE5FzWaqEAQAkkp1B+GYYyyeKcoio/WKPXz
         vwLHr6Jnd9F7/YIfLBxH3wxPOJUtb9EEIOucU=
Received: by 10.142.173.14 with SMTP id v14mr3530704wfe.74.1215083121726;
        Thu, 03 Jul 2008 04:05:21 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 3 Jul 2008 04:05:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87270>

On Thu, Jul 3, 2008 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> So when you have ":/A:B:C", you first try to look for string "A:B:C", and
> then when it fails try "A:B" and look for path C?

Exactly.  And as you pointed out it doesn't break existing usage by design.

>  (1) An obvious micro-optimization. Check if "A:B:C" is a rev, and if and
>     only if it fails, run strrchr() to find fallback point;

Done.  This version is more careful about return values as well.

>  (2) When you do not find either "A:B:C" nor "A:B", perhaps try "A" and
>     find "B:C" as a path in it?  IOW, you may want to fallback more than
>     once;
>  (3) If you are given ":/A~20" or ":/A^2", perhaps you would want to do
>     something similar?

I agree these are nice but get_sha1_oneline() is time-consuming as is
and I'm not familiar enough with the code to attempt a complete
refactorization.

And without refactoring get_sha1_oneline() would need to be called
repeated for each ~, ^, or : (working backward) until it succeeds.

I'll leave it to Johannes to refactor get_sha1_oneline to handle the
":/A~20" or ":/A^2" cases if he chooses to, as it's currently beyond
my git-fu.

An alternative suggested by Peff:
	:/ should stop eating text at the first ':', and allow '\:' for
	a literal colon and '\\' for a literal backslash.

is arguably better because it's completely unambiguous and allows
for a simpler implementation but it's not backwards compatible.
I'd be willing to come up with patch for that if people agree that
it's worth it.

Please note that the commit message uses the current subject,
so if this is applied it should be kept consistent.

- Eric

----- 8< -----

Although the rev-parse documentation claims that the tree-ish:path/to/file
syntax is applicable to all tree-ish forms this is not so when using the
:/ "oneline prefix" syntax introduced in v1.5.0.1-227-g28a4d94.

For instance, to see the file changed by this patch one could say:
	git show ":/Allow ':/<oneline prefix>'":sha1_name.c

Note that this should but doesn't handle ~ and ^, so it will fail when
trying to show the parent of this commit message by using
	git show ":/Allow ':/<oneline prefix>'"^

Signed-off-by: Eric Raible <raible@gmail.com>
---
 sha1_name.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b0b2167..415b4ce 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -697,8 +697,20 @@ int get_sha1_with_mode(const char *name, unsigned
char *sha1, unsigned *mode)
 		int stage = 0;
 		struct cache_entry *ce;
 		int pos;
-		if (namelen > 2 && name[1] == '/')
-			return get_sha1_oneline(name + 2, sha1);
+		if (namelen > 2 && name[1] == '/') {
+			char *copy, *colon;
+			name += 2;
+			ret = get_sha1_oneline(name, sha1);
+			if (!ret || !(colon = strrchr(name, ':')))
+				return ret;
+			copy = xstrdup(name);
+			copy[colon - name] = '\0';
+			ret = get_sha1_oneline(copy, sha1);
+			if (!ret)
+				ret = get_tree_entry(sha1, colon+1, sha1, mode);
+			free(copy);
+			return ret;
+		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
 		    name[1] < '0' || '3' < name[1])
-- 
1.5.6.1.1356.g3885.dirty
