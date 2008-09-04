From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 02:41:22 -0700
Message-ID: <7v3akg5jul.fsf_-_@gitster.siamese.dyndns.org>
References: <48BF759B.9090309@lwfinger.net> <48BF97B3.5060309@viscovery.net>
 <7vljy85mwx.fsf@gitster.siamese.dyndns.org>
 <57518fd10809040211q12d1f0ddk16f2d4273ee7d488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Larry Finger" <Larry.Finger@lwfinger.net>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbBMS-0002sr-So
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbYIDJli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYIDJli
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:41:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbYIDJlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:41:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 271D55EA19;
	Thu,  4 Sep 2008 05:41:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0CFCA5EA18; Thu,  4 Sep 2008 05:41:24 -0400 (EDT)
In-Reply-To: <57518fd10809040211q12d1f0ddk16f2d4273ee7d488@mail.gmail.com>
 (Jonathan del Strother's message of "Thu, 4 Sep 2008 10:11:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8B18840-7A65-11DD-A9D4-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94915>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> On Thu, Sep 4, 2008 at 9:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Larry Finger schrieb:
>>>> On one of my systems, I found strange behavior for git-1.5.6.GIT. On the
>>>> first pull of the linux-2.6 tree, I got a message that one file was not
>>>> uptodate. When I investigated any possible differences with git-diff,
>>>> there were none. A subsequent git-pull worked fine. I lost the console
>>>> output for linux-2.6, but the same thing happened for Linville's
>>>> wireless-testing, as shown below:
>>>>
>>>> finger@sonylap:~/wireless-testing> git --version
>>>> git version 1.5.6.GIT
>>>> finger@sonylap:~/wireless-testing> git pull
>>>> error: Entry 'drivers/bluetooth/bt3c_cs.c' not uptodate. Cannot merge.
>>>> fatal: merging of trees 294e21019bac11cb782e8d1893d02ce98ed816a4 and
>>>> 810d24221c9c532475af90d1b7ba9ca381dc3696 failed
>>>> Merge with strategy recursive failed.
>>> ...
>>> The 'git diff' that you did next corrected this behind your back, so that
>>> the subsequent 'git pull' did not see any modification anymore. (BTW, if
>>> you had used 'git status' instead of 'git diff' you would have observed
>>> the same behavior.)
>>
>> That still does not explain the symptom --- shouldn't "git pull" or
>> underlying "git merge"  have first refreshed the index?
>>
>> 1.5.6 is before the C rewrite of git-merge, so it is somewhat surprising
>> that if there were such bugs, but 1.5.6.GIT does not tell us much...
>
> Incidentally - git stash pop/apply has the same problem.  Touching a
> file, then applying the stash over the top will tell you "Cannot
> restore on top of a dirty state", but will work fine after a "git
> status"

That one is unfortunately completely an unrelated issue.  "stash apply"
never refreshed the index on its own.

But pull to merge codepath in question that Larry originally brought up
always did, and that is what puzzles me.

Perhaps some virus scanner or trackerd is running under Larry's working
tree that contaminates the stat information after we refresh the index?  I
dunno.

In any case, I think this should fix the unrelated issue.

-- >8 --
stash: refresh the index before deciding if the work tree is dirty

Unlike the case where the user does have a real change in the work tree,
refusing to work because of unclean stat information is not very helpful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git c/git-stash.sh w/git-stash.sh
index e15c12a..d799c76 100755
--- c/git-stash.sh
+++ w/git-stash.sh
@@ -39,6 +39,7 @@ clear_stash () {
 create_stash () {
 	stash_msg="$1"
 
+	git update-index -q --refresh
 	if no_changes
 	then
 		exit 0
@@ -101,6 +102,7 @@ save_stash () {
 
 	stash_msg="$*"
 
+	git update-index -q --refresh
 	if no_changes
 	then
 		echo 'No local changes to save'
@@ -150,6 +152,7 @@ show_stash () {
 }
 
 apply_stash () {
+	git update-index -q --refresh &&
 	git diff-files --quiet --ignore-submodules ||
 		die 'Cannot restore on top of a dirty state'
 
