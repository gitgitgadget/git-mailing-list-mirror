From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] checkout --rebase
Date: Fri, 19 Jul 2013 17:03:27 +0530
Message-ID: <CALkWK0kVNw3Ko3+_Y-KDF=pdha6wxyMmQmLtOOr5tQYzgUr_Mw@mail.gmail.com>
References: <CALkWK0m-ZpVvvgAB_yzooah0=veeNDudahs=4ur2YHN03h-h4g@mail.gmail.com>
 <CA+xP2SbHD+MU4K0JBbZdA6bWQFQerBi5mWA+7G9=tBksjp+LXw@mail.gmail.com> <CALkWK0nM4fkCPNJo_c3Rpwh1azsGRdGvM3S80vcuRiRXDT0vOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 13:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V08wv-00055R-H6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 13:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759989Ab3GSLeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 07:34:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33876 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3GSLeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 07:34:07 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so8919057iea.25
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XxWonJAKq6AfTKKFf1/T0aOgdXxEy05TughHomoNjTk=;
        b=jcDitLzQVLH4cKcUOHyDJJnNeAdNAyuzun5LTmL3LVRxyccDzgacQySokXObcpSSIt
         FRksDcCoE0xXF2JZLqedwdrdRns0nQ0+xj4aETGPeIPUZub/sZBcgBQJSg/Je4bF/lz6
         fQ4+iTgSu0b2xIBUZTARj1/p2YdUPBebLnjZL0DUeabAFCOB8RZLrAawzEa4x/ZLE3o6
         4Zm/NNfRxP7Z1kzytYDMNvOKzlfMlG+RzRZ2CYGbgta1TN9iIiX0BeluWtgzHnBmhgge
         oCHBVnJu7Rco/oBwHQGzzP2dssUWbrTHwwFiGjfFyLVzSh8ryiFqInEa39Z9wecQFfFR
         bb5A==
X-Received: by 10.42.76.5 with SMTP id c5mr9779879ick.91.1374233647418; Fri,
 19 Jul 2013 04:34:07 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 04:33:27 -0700 (PDT)
In-Reply-To: <CALkWK0nM4fkCPNJo_c3Rpwh1azsGRdGvM3S80vcuRiRXDT0vOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230792>

Ramkumar Ramachandra wrote:
> Sebastian Staudt wrote:
>> Isn't this what you want?
>>
>>  $ git rebase master um-build
>
> Ha, yes.  Sorry about the stupidity.

Hm, I'm not entirely sure how to optimize the codepath to eliminate
the checkout.  It seems to be absolutely necessary atleast in the -i
codepath.

Let's inspect when $switch_to is set:

	# Is it "rebase other $branchname" or "rebase other $commit"?
	branch_name="$1"
	switch_to="$1"

$revisions seems to be set correctly, and rebase--am does a
move_to_original_branch as the last step.  So, I wonder if this will
work:

diff --git a/git-rebase.sh b/git-rebase.sh
index 0039ecf..7405d9a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -542,9 +542,15 @@ then
 	if test -z "$force_rebase"
 	then
 		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" ||
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
-			git checkout "$switch_to" --
+		if ! test -z "$switch_to"; then
+			if "$type" = am; then
+				GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout -b $switch_to-2" \
+					git checkout -b "$switch_to-2" --
+			else
+				GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
+					git checkout "$switch_to" --
+			fi
+		fi
 		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
 		finish_rebase
 		exit 0

(ofcourse, we still need a mechanism to remove this temporary
$switch_to-2 branch)

What about rebase--merge?  Can we eliminate the checkout then?
