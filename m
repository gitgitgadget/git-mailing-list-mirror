From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH/RFC] Introduce a built-in attribute "text"
Date: Fri, 24 Oct 2008 23:51:06 -0700
Message-ID: <7vwsfx9nhh.fsf@gitster.siamese.dyndns.org>
References: <1224856547-30533-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 08:52:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktd0j-0007iK-Ep
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 08:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYJYGvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 02:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYJYGvU
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 02:51:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbYJYGvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 02:51:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F20473503;
	Sat, 25 Oct 2008 02:51:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7C22773502; Sat, 25 Oct 2008 02:51:12 -0400 (EDT)
In-Reply-To: <1224856547-30533-1-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Fri, 24 Oct 2008 15:55:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52C3A624-A261-11DD-8687-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99096>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "text is the opposite of "binary": It sets the attributes "crlf" and
> "diff". It is needed because attribute macros can't be negated,

If the reason for this patch is really (and only) because macros cannot be
negated, perhaps we should be allowing to negate them?  That is, given:

	[attr] binary = -diff -crlf
        *.bar !binary

you would set diff and crlf to TRUE for b.bar, because the normal action
is to set them to FALSE.

If the original attribute macro expands to anything but setting other
attributes to TRUE or FALSE (i.e. to a string value, or reseting to
UNSPECIFIED), or if a related attribute is not the exact opposite, you
cannot simply negate, but need to introduce a new attribute like your
patch does.  For example, it is conceivable you might instead want to
define:

	[attr] text = diff

i.e. without "crlf" bit.

Since what you want to do here is merely to negate what is already there,
it might make more sense to simply bite the bullet and give the attribute
mechanism the ability to negate an attribute macro.

This is of course untested (you can tell that by noticing that it does not
come with patch to the test scripts) nor undocumented, but it looks
obvious enough ;-).  Originally we silently ignored attempts to negate or
to reset an attribute macro.  We now allow you to negate an attribute
macro, and the definition of "negating" is:

 - negation of setting to TRUE is setting to FALSE.
 - negation of setting to FALSE is setting to TRUE.
 - negation of anything else is itself.

The third one is arbitrary and people may want to come up with a different
behaviour (with solid argument explaining why that behaviour is more
sensible).

 attr.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git c/attr.c w/attr.c
index 17f6a4d..0021cec 100644
--- c/attr.c
+++ w/attr.c
@@ -558,7 +558,24 @@ static int path_matches(const char *pathname, int pathlen,
 	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
 }
 
-static int fill_one(const char *what, struct match_attr *a, int rem)
+static const char *attr_negate(const char *value)
+{
+	if (value == ATTR__TRUE)
+		return ATTR__FALSE;
+	else if (value == ATTR__FALSE)
+		return ATTR__TRUE;
+	else
+		/*
+		 * NEEDSWORK: here we define negation of setting
+		 * to anything but TRUE and FALSE is itself.  We
+		 * may want to instead say it is not touching the
+		 * attribute, in which case you could simply return
+		 * NULL from here.
+		 */
+		return value;
+}
+
+static int fill_one(const char *what, struct match_attr *a, int rem, int negated)
 {
 	struct git_attr_check *check = check_all_attr;
 	int i;
@@ -569,6 +586,11 @@ static int fill_one(const char *what, struct match_attr *a, int rem)
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
+			if (negated) {
+				v = attr_negate(v);
+				if (!v)
+					continue;
+			}
 			debug_set(what, a->u.pattern, attr, v);
 			*n = v;
 			rem--;
@@ -588,7 +610,7 @@ static int fill(const char *path, int pathlen, struct attr_stack *stk, int rem)
 			continue;
 		if (path_matches(path, pathlen,
 				 a->u.pattern, base, strlen(base)))
-			rem = fill_one("fill", a, rem);
+			rem = fill_one("fill", a, rem, 0);
 	}
 	return rem;
 }
@@ -602,9 +624,11 @@ static int macroexpand(struct attr_stack *stk, int rem)
 		struct match_attr *a = stk->attrs[i];
 		if (!a->is_macro)
 			continue;
-		if (check[a->u.attr->attr_nr].value != ATTR__TRUE)
-			continue;
-		rem = fill_one("expand", a, rem);
+		if (check[a->u.attr->attr_nr].value == ATTR__TRUE)
+			rem = fill_one("expand", a, rem, 0);
+		else if (check[a->u.attr->attr_nr].value == ATTR__FALSE)
+			rem = fill_one("expand", a, rem, 1);
+			
 	}
 	return rem;
 }
