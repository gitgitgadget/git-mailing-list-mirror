From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 13:19:57 -0700
Message-ID: <7vwrp069aq.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
 <AANLkTikc+pBe31j9tA88HwGz2kBouW_0S9oU6PtSQEzj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 22:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBvQs-0001TG-CR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 22:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222Ab0J2UUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 16:20:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab0J2UUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 16:20:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C23C51B77;
	Fri, 29 Oct 2010 16:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xrR7IEMTidStmi5JlCHe6heZszI=; b=CbBoFB
	pVqGLRlfL5vbUxJtHsCxiQWu9xJtSpR0tIFDRaayiToHRwRlzZ4N+zn/D7Itkovj
	oPSfD3nt2yk4UtbLK96Hg+H9bbE+bFes6GPcK0qY0Amk8lFuJhw0TUf1mcW/bJwZ
	qxtUPJa3T7mkv73uEw0YR/F2EU829CafVKdsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLug+UdH//afkId9nbLFsLoPjCIGv3hK
	8OcgoAqSRMBfeRsfA0bV6f/yf7z8wTZ3ccKEqsSgGMgjkyyYWx7phL9oG4RZx1LP
	lppvMMKRZs/XZHcCasuWYtYy3ySMKHMXw+xTmu0un/+kILB5bzqw73lCOXWPlRxk
	eBXVh1YTLdI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97AEF1B75;
	Fri, 29 Oct 2010 16:20:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B96B61B72; Fri, 29 Oct
 2010 16:19:58 -0400 (EDT)
In-Reply-To: <AANLkTikc+pBe31j9tA88HwGz2kBouW_0S9oU6PtSQEzj@mail.gmail.com>
 (Dun Peal's message of "Fri\, 29 Oct 2010 19\:54\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E89396A2-E399-11DF-888D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160360>

Dun Peal <dunpealer@gmail.com> writes:

> It makes no sense IMHO for the disambiguating syntax to break that
> behavior,...

Ahh, Ok, and sorry, I think I misread your original.

I agree that there shouldn't be any difference between "git co foo" and
"git co foo --" when you do not have local "foo" (i.e. immediately after
cloning from somebody who has "foo").

Perhaps something like this...

 builtin/checkout.c |   52 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..ceaf479 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -804,17 +804,30 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		arg = argv[0];
 		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
+		if (has_dash_dash) {
+			argv++;
+			argc--;
+			/*
+			 * Copy arg so that argv[] ends up being all
+			 * paths if arg turns out to be a non-ref.
+			 */
+			argv[0] = arg;
+		}
+
+		/*
+		 * arg may be a ref; or it may be the first of the
+		 * paths, if we did not see dash-dash.
+		 */
 		if (!strcmp(arg, "-"))
 			arg = "@{-1}";
 
 		if (get_sha1_mb(arg, rev)) {
-			if (has_dash_dash)          /* case (1) */
-				die("invalid reference: %s", arg);
+			/* Not a ref */
 			if (!patch_mode &&
 			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
-			    !check_filename(NULL, arg) &&
+			    (has_dash_dash || !check_filename(NULL, arg)) &&
 			    argc == 1) {
 				const char *remote = unique_tracking_name(arg);
 				if (!remote || get_sha1(remote, rev))
@@ -823,11 +836,26 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				arg = remote;
 				/* DWIMmed to create local branch */
 			}
-			else
+			else {
 				goto no_reference;
+			}
+		} else if (!has_dash_dash && argc > 1) {
+			/*
+			 * We saw "checkout foo bar" without dashdash,
+			 * and "foo" can name an object.  It shouldn't
+			 * be a filename. Note that by checking argc,
+			 * we do not complain in the most common case
+			 *	git checkout branch
+			 * even if there happen to be a file called 'branch';
+			 * it would be extremely annoying.
+			 */
+			verify_non_filename(NULL, arg);
 		}
 
-		/* we can't end up being in (2) anymore, eat the argument */
+		/*
+		 * It turns out that we had a ref, so argv[1:] are the
+		 * paths (we stripped dash-dash already).
+		 */
 		argv++;
 		argc--;
 
@@ -847,20 +875,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 		if (!source_tree)                   /* case (1): want a tree */
 			die("reference is not a tree: %s", arg);
-		if (!has_dash_dash) {/* case (3 -> 1) */
-			/*
-			 * Do not complain the most common case
-			 *	git checkout branch
-			 * even if there happen to be a file called 'branch';
-			 * it would be extremely annoying.
-			 */
-			if (argc)
-				verify_non_filename(NULL, arg);
-		}
-		else {
-			argv++;
-			argc--;
-		}
 	}
 
 no_reference:
