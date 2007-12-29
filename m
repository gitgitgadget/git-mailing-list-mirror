From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Speedup prefixcmp() common case
Date: Sat, 29 Dec 2007 19:01:08 +0100
Message-ID: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 19:01:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8g0I-0000OP-4q
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 19:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbXL2SBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbXL2SBK
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 13:01:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:40069 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbXL2SBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 13:01:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3920625rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 10:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=O6oxOc1kNqU8ezxxbBVEuGXgYYMv3R7OaPxycBcx33w=;
        b=nfrGBaMLYaYyB7lAO9DbogGPBFFO6K3DQj0kBiYjwTyfZJp7WiEgXHMkfEBEspz0mcXAJt+bl3I0gtaEw/26bWdBfD7u2m6/RhwB9UPv4XOr6R5C4FGz6mlv0qx8ryBhwJgMLi/dlHuQSOplrXKWBcu8l2KmBtr5fmy+VpvOmAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xiax2Df57hF3DrbHwPCgg68ExbDgBrEMzS4JqLDRYNq7FnRnmPEXqf4dZ4aT2r3yf5m7hCEieLBfh6H7ncNt3axEJV0rNaZFSZjfc/1OIxBy+rXUMMtrkykZG/E1wQP59HJqZYppnqq76gfwg8Sn/0XP7dlk9bU9pOSZj3YqMxQ=
Received: by 10.141.99.4 with SMTP id b4mr5470791rvm.208.1198951268713;
        Sat, 29 Dec 2007 10:01:08 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 10:01:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69321>

In case the prefix string is a single char avoid a
costly call to strlen() + strncmp()

With this patch git log with --pretty=format option
is 10% faster

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Some profiling of git-log shows that strbuf_expand() is
called for each commit, and every time checks the
placeholders vector against the current one.

This check is done calling prefixcmp() in a tight loop.
Speeding up prefixcmp() speeds up the whole git-log thing.

NOTE I: I have tried to perform the single char check
directly in the loop, so to avoid to modify prefixcmp()
but the results, although better then the vanilla case,
are not so good. This means that there are other fast
paths that benefit from this optimization of prefixcmp().

NOTE II: currently for _each_ commit is done the whole
check of the --pretty=format against the placeholders vector.
This is clearly suboptimal because the custom format
_never changes_ for the whole git-log run, so some
caching  of the parsed format would be surely effective.

Anyhow, as I said before, this change seems to positively
impact other paths apart from the loop in strbuf_expand()
so it seems worth to have anyway.


 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..e26b684 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -398,6 +398,10 @@ static inline int sane_case

 static inline int prefixcmp(const char *str, const char *prefix)
 {
+	// shortcut common case of a single char prefix
+	if (prefix && *(prefix + 1) == '\0' && str)
+		return *str - *prefix;
+
 	return strncmp(str, prefix, strlen(prefix));
 }

-- 
1.5.4.rc2-dirty
