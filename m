From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 14:46:39 -0500
Message-ID: <20101029194639.GA1738@burratino>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 21:46:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBuub-0000yp-Dh
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 21:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761715Ab0J2Tqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 15:46:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63925 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab0J2Tqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 15:46:46 -0400
Received: by gyg4 with SMTP id 4so2216275gyg.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rHiB0TngEyJYW+QyfnLSEFz6uV5qsVwLgnGQjyji7IA=;
        b=kIE9E0FPJsXUbXHBw8Co78H6WHIdQhbt4MuCvSkjiBd+EvjdTLI1JT9bZUoZMlCmij
         ev0AnjsiQDFA+qCsb6it5W9dDbEb2BA8P7nUaz02iKk4iHttDGZN9HnUZOEr8Xq+mjDc
         mCdNS/oxDaOovsKgRrOhOxF/od2nCVBL/tK4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R4F+UjZvQ+kdkyoRSdhnvNS6mhB4ggjgwJ8CootTUt1lWJXLh0sdWDytoJFhbT+wL4
         fnrp7tNdKIYrD9HnP5AJwIpKQQ3h6I9Z8ytf58LJfba1dhZC1LrqkyHshbHBjYOCNRGB
         sui56fDA728n88DCtLIAAizVJVjq2y88rTJFc=
Received: by 10.42.121.16 with SMTP id h16mr9888794icr.71.1288381605399;
        Fri, 29 Oct 2010 12:46:45 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id y14sm979385vch.4.2010.10.29.12.46.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 12:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160359>

Junio C Hamano wrote:

>       I can see why this is confusing, though.
>
> Dun Peal <dunpealer@gmail.com> writes:
>> $ git checkout foo --
>> fatal: invalid reference: foo
>
> Immediately after a clone you would have
>
>     refs/heads/master
>     refs/HEAD -> refs/heads/master
>     refs/remotes/origin/foo
>     refs/remotes/origin/whatever-else-you-have
>     ...
>
> and there is no commit that you can name with "foo" when asking git to
> check out some paths out of, nor there is no branch that you can name with
> "foo" when asking git to check out to work on it.

How about something like this?
-- 8< --
Subject: checkout: apply Dscho's dwim even with "--" present

git reset and similar commands use -- to disambiguate between
revisions and paths on the command line.  The same syntax is not
necessary to specify a revision to git checkout (for convenience
and historical reasons, revisions are preferred over paths), but
for consistency it is accepted:

	git checkout master --; # check out master branch, not "master" file.

The autovivification of branches introduced by 70c9ac2f1 (DWIM "git
checkout frotz" to "git checkout -b frotz origin/frotz", 2009-10-18)
is currently disabled by that syntax, for no good reason.  Paranoid
scripts can still use

	git checkout --no-guess master

or even better,

	old=$(git rev-parse --verify HEAD)
	new=$(git rev-parse --verify refs/heads/master^0)
	git read-tree -m -u --exclude-standard $old $new
	git symbolic-ref -m "$me: switching branches" HEAD refs/heads/master

Requested-by: Dun Peal <dunpealer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..1dc3640 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -771,6 +771,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *   <ref> must be a valid tree, everything after the '--' must be
 	 *   a path.
 	 *
+	 *   Except: with no paths, if <something> does not resolve as
+	 *   an object, no -t nor -b was given, and there is a tracking
+	 *   branch whose name is <something> in one and only one remote,
+	 *   then this is a short-hand to fork local <something> from
+	 *   that remote-tracking branch.
+	 *
 	 * case 2: git checkout -- [<paths>]
 	 *
 	 *   everything after the '--' must be paths.
@@ -808,13 +814,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			arg = "@{-1}";
 
 		if (get_sha1_mb(arg, rev)) {
-			if (has_dash_dash)          /* case (1) */
-				die("invalid reference: %s", arg);
 			if (!patch_mode &&
 			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
-			    !check_filename(NULL, arg) &&
+			    (has_dash_dash || !check_filename(NULL, arg)) &&
 			    argc == 1) {
 				const char *remote = unique_tracking_name(arg);
 				if (!remote || get_sha1(remote, rev))
@@ -822,9 +826,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				opts.new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch */
-			}
-			else
+			} else if (has_dash_dash) {	/* case (1) */
+				die("invalid reference: %s", arg);
+			} else {
 				goto no_reference;
+			}
 		}
 
 		/* we can't end up being in (2) anymore, eat the argument */
