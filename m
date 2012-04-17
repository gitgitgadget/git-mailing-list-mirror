From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v6 0/4] Enhance git-rebases flexibiilty in handling empty commits
Date: Tue, 17 Apr 2012 14:20:05 -0400
Message-ID: <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Clemens Buchacher <drizzd@aon.at>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 20:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKD1B-0005M9-6v
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab2DQSUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:20:39 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:53727 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab2DQSUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:20:38 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKD0q-00007P-0A; Tue, 17 Apr 2012 14:20:29 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195782>

git's ability to handle empty commits is somewhat lacking, especially when
preforming a rebase.  Nominally empty commits are undesireable entries, the 
result of commits that are made empty by prior commits covering the same changs.
But occasionally, empty commits are useful to developers (e.g. inserting notes 
into the development history without changing any code along the way).  In these
cases its desireable to easily preserve empty commits during operations like 
rebases.

This patch series enhances git to do just that.  It adds two options to the 
git-cherry-pick command, --allow-empty, which allows git cherry-pick to preserve
an empty commit, even if the fast forward logic isn't applicable during the 
operation, and --keep-redundant-commits, which allows the user to also keep
commits that were made empty via conflict resolution.  It also enhances
git-rebase to add a --keep-empty option which enables rebases to preserve empty
commits. 

I've tested these operations out myself here and they work well for me

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

---
Change notes:

Based on version 1 feedback from this list, the following changes have been made

V2)
	* Changed --keep-empty to --allow-empty in the git cherry-pick command

	* Converted run_git_commit to use argv_array

	* Updated cherry-pick --allow-empty description in man page
	
	* added ignore-if-made-empty option to git-cherry-pick

	* Added test to test suite to validate the new cherry-pick options

	* Updated git-rebase man page to be less verbose and more accurate in the
	description of the keep-empty option

	* squashed the addition of the keep-empty flag in git-rebase down to one
	commit from 3

	* fixed up coding style in git-rebase script

	* Optimized detection of empty commits

	* Only augmented git-rebase-editor message if empty commits are
	possible
	
V3)
	* reversed the --ignore-if-empty-logic to by default only keep initially
	empty commits

	* replaced --ignore-if-empty with --keep-redundant-commits, to allow
	empty commits that are made empty via conflict resolution, in addition
	to commits that were created as empty

	* reworked is_original_commit_empty to be more efficient and portable

	* Misc sylistic and spelling cleanups

V4)
	* Reverted the cherry-pick advice changes in V3 based on in-thread
	discussion

	* Rewrote my changes to is_original_commit_empty and run_git_commit to
	not have to fork, making them more efficient.

v5)
	* Additional help text clean up
	* Additional error checking added to run_git_commit code
	* Whitespace cleanup
	* Removed needed cache_tree freeing
	* Test case cleanup
	* Fixed regression in t3404 and t3416 - this turned out to be 
        a problem with the note that git rebase -i adds at the bottom
	of the rebase text.  It was inadvertently indented and caused the
	test fake editor to misread the commit template.  The indentation 
	has been corrected, and these two tests, as well as all the other
	expected tests pass now

v6)
	* synced keeep-redundant-commits option and variable name
	* fixed up some comment terminology
	* minor newline cleanup
	* Removed some unneeded braces from test code
	* minor syntatic cleanup in rebase scripts

	* Refactored empty index checking to make run_git_commit more readable
	I was also going to change the logic so that it operated more like git
	cherry-pick did before the patchset, but Junio's comments made me think
	the new logic was preferable.
--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

