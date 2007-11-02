From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] post-update hook: update working copy
Date: Fri, 02 Nov 2007 16:36:06 +1300
Message-ID: <472A9B26.2020608@vilain.net>
References: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz> <7vd4ut7948.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 04:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnLl-0007ms-4P
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXKBDhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbXKBDhW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:37:22 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:47723 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXKBDhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:37:21 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1InnLL-0004AI-1y; Fri, 02 Nov 2007 16:37:11 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id F326220055; Fri,  2 Nov 2007 16:37:10 +1300 (NZDT)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7vd4ut7948.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63052>

Junio C Hamano wrote:
>> Now that git-stash is available, it is not so unsafe to push to a
>> non-bare repository, but care needs to be taken to preserve any dirty
>> working copy or index state.  This hook script does that, using
>> git-stash.
> 
> Honestly, I am reluctant to do things that _encourages_ pushing
> into a live tree.

I think a lot of people want this, and explaining why it doesn't work to
people is especially tiresome given that I know it can work, and the
caveats get smaller and smaller each time.  I still think that the
operation can be made safe enough for general use.

>  - Who guarantees that the reflog is enabled for the HEAD?

Ok, so I guess if that's the case then the old behaviour is OK.
However, this would not be required if implemented in receive-pack, as
the only thing I'm using it for is to get the revision that the current
index is based on.

The other option, which was writing two hooks, both of which need to be
enabled, seemed far too ugly!

>  - Who guarantees that a human user is not actively editing the
>    work tree files without saving?  You would not see "dirty
>    state", the editor would notice "the file was modified since
>    you started editing it" and tell so to the user, but the user
>    cannot recover from the situation without knowing to do the
>    three-way merge between HEAD@{1}, HEAD and the index _anyway_.

There seems to be a lot of focus on this.  However I don't think it is a
showstopper; in this instance that the person who has their life ruined
by the incoming push can blame the person who did it, blame themselves
for giving that stupid user access to their working directory, and then
accept that the tool is doing the best that it can.

>> +	if git diff-index HEAD@{1} >/dev/null
> 
> Are you missing "--cached" here?

Ah, yes, good catch.

>> +	if [ "$wc_dirty" -ne 0 -o "$index_dirty" -ne 0 ]
>> +	then
>> +		new=$(git rev-parse HEAD)
>> +		git-update-ref --no-deref HEAD HEAD@{1}
>> +		echo "W:stashing dirty $desc - see git-stash(1)" >&2
>> +		(cd $GIT_WORK_TREE
>> +		git stash save "dirty $desc before update to $new")
>> +		git-symbolic-ref HEAD "$ref"
> 
> This part feels somewhat dangerous.  What happens if we are
> interrupted in the middle of these commands?

Heh.  What seems to happen is that the local command is aborted and the
remote one continues.  Nonetheless I'll add a trap statement, but again
if implemented in receive-pack it could probably be more resilient.

>> +	fi
>> +
>> +	# eye candy - show the WC updates :)
>> +	echo "Updating working copy" >&2
>> +	(cd $GIT_WORK_TREE
>> +	git-diff-index -R --name-status HEAD >&2
>> +	git-reset --hard HEAD)
>> +}
> 
> And I would have expected you would unstash the dirty state here.
> Are there any reason not to?

If git-stash could support stashing conflicted merges, I don't think so.

However, if the user is a git-shell user, then they won't be able to
resolve the conflict and they won't be able to re-push as the stash will
fail (a condition not visited by the above).

Sam.

changes as you suggested are below;

diff --git a/templates/hooks--post-update b/templates/hooks--post-update
index 352a432..b15c711 100755
--- a/templates/hooks--post-update
+++ b/templates/hooks--post-update
@@ -25,6 +25,11 @@ fi
 update_wc() {
 	ref=$1
 	echo "Push to checked out branch $ref" >&2
+	if [ ! -f $GIT_DIR/logs/HEAD ]
+	then
+		echo "E:push to non-bare repository requires a HEAD reflog" >&2
+		exit 1
+	fi
 	if (cd $GIT_WORK_TREE; git-diff-files -q --exit-code >/dev/null)
 	then
 		wc_dirty=0
@@ -33,7 +38,7 @@ update_wc() {
 		wc_dirty=1
 		desc="working copy"
 	fi
-	if git diff-index HEAD@{1} >/dev/null
+	if git diff-index --cached HEAD@{1} >/dev/null
 	then
 		index_dirty=0
 	else
@@ -49,11 +54,13 @@ update_wc() {
 	if [ "$wc_dirty" -ne 0 -o "$index_dirty" -ne 0 ]
 	then
 		new=$(git rev-parse HEAD)
-		git-update-ref --no-deref HEAD HEAD@{1}
 		echo "W:stashing dirty $desc - see git-stash(1)" >&2
-		(cd $GIT_WORK_TREE
-		git stash save "dirty $desc before update to $new")
+		( trap 'echo trapped $$; git symbolic-ref HEAD "'"$ref"'"' 2 3 13 15 ERR EXIT
+		git-update-ref --no-deref HEAD HEAD@{1}
+		cd $GIT_WORK_TREE
+		git stash save "dirty $desc before update to $new";
 		git-symbolic-ref HEAD "$ref"
+		)
 	fi
 
 	# eye candy - show the WC updates :)
