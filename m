From: linux@horizon.com
Subject: Re: The merge from hell...
Date: 3 Feb 2006 01:41:54 -0500
Message-ID: <20060203064154.21015.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 08:08:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4v3o-0003LJ-4E
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 08:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBCHIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 02:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBCHIn
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 02:08:43 -0500
Received: from science.horizon.com ([192.35.100.1]:31283 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751136AbWBCHIn
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 02:08:43 -0500
Received: (qmail 21016 invoked by uid 1000); 3 Feb 2006 01:41:54 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15532>

While we're stress-testing the ystem, does anyone feel like fixing
git-rev-parse 9fdb62af92c741addbea15545f214a6e89460865^10 ?

The following is my attempt, but it doesn't seem sufficient...

$ ~/git/git-rev-parse 9fdb62af92c741addbea15545f214a6e89460865^{1,2,3,4,5,6,7,8,9,10,11,12}
3ee68c4af3fd7228c1be63254b9f884614f9ebb2
876c184b31dc73cc3f38c5b86dee55d091a56769
729b4d4ce1982c52040bbf22d6711cdf8db07ad8
cf82478840188f8c8494c1d7a668a8ae170d0e07
dacd9b80355525be0e3c519687868410e304ad1c
63c94b68ec30847a6e2b36651703f41066f91480
35f652b5ef4ef145ac5514f6302b3f4cebfbbad4
1a38416cea8ac801ae8f261074721f35317613dc
4a90c7e86202f46fa9af011bdbcdf36e355d1721
fatal: '9fdb62af92c741addbea15545f214a6e89460865^10': No such file or directory

(Placed in the public domain; go nuts.)

diff --git a/sha1_name.c b/sha1_name.c
index ba0747c..adf49d2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -388,52 +388,33 @@ static int peel_onion(const char *name, 
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 {
-	int parent, ret;
-	const char *cp;
-
-	/* foo^[0-9] or foo^ (== foo^1); we do not do more than 9 parents. */
-	if (len > 2 && name[len-2] == '^' &&
-	    name[len-1] >= '0' && name[len-1] <= '9') {
-		parent = name[len-1] - '0';
-		len -= 2;
-	}
-	else if (len > 1 && name[len-1] == '^') {
-		parent = 1;
-		len--;
-	} else
-		parent = -1;
-
-	if (parent >= 0)
-		return get_parent(name, len, sha1, parent);
-
-	/* "name~3" is "name^^^",
-	 * "name~12" is "name^^^^^^^^^^^^", and
-	 * "name~" and "name~0" are name -- not "name^0"!
-	 */
-	parent = 0;
-	for (cp = name + len - 1; name <= cp; cp--) {
-		int ch = *cp;
-		if ('0' <= ch && ch <= '9')
-			continue;
-		if (ch != '~')
-			parent = -1;
-		break;
+	int parent = 0, pow10 = 1;
+	const char *cp = name + len;
+	char ch = 0;	/* In case len == 0 */
+
+	/* Parse trailing number and check for ^5 or ~5 */
+	while (cp > name && (ch = *--cp) >= '0' && ch <= '9') {
+		parent += ch - '0' * pow10;
+		pow10 *= 10;
 	}
-	if (!parent && *cp == '~') {
-		int len1 = cp - name;
-		cp++;
-		while (cp < name + len)
-			parent = parent * 10 + *cp++ - '0';
-		return get_nth_ancestor(name, len1, sha1, parent);
+
+	/* Handle foo^[0-9]* case */
+	if (ch == '^') {
+		/* foo^ means foo^1, first parent */
+		if (cp + 1 == name)
+			parent = 1;
+		return get_parent(name, cp - name, sha1, parent);
 	}
+	/* Handle foo~[0-9]* case.  name~ = name~0 = name (not name^0!) */
+	if (ch == '~')
+		return get_nth_ancestor(name, cp - name, sha1, parent);
 
-	ret = peel_onion(name, len, sha1);
-	if (!ret)
+	if (!peel_onion(name, len, sha1))
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
-	if (!ret)
+	if (!get_sha1_basic(name, len, sha1))
 		return 0;
+
 	return get_short_sha1(name, len, sha1, 0);
 }
 
