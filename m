From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: Allow partial commit of file removal.
Date: Fri, 14 Sep 2007 16:34:33 -0700
Message-ID: <7vveac95yu.fsf@gitster.siamese.dyndns.org>
References: <20070909173324.GA9205@auto.tuwien.ac.at>
	<7vzlzvrlj6.fsf@gitster.siamese.dyndns.org>
	<7v4phzlc3t.fsf_-_@gitster.siamese.dyndns.org>
	<20070913112957.10057.qmail@565d4e4908fbe9.315fe32.mid.smarden.org>
	<7vzlzqieko.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWKgN-0006BM-Cg
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 01:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXINXek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbXINXek
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 19:34:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbXINXej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 19:34:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E7A0613512A;
	Fri, 14 Sep 2007 19:34:56 -0400 (EDT)
In-Reply-To: <7vzlzqieko.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Sep 2007 11:51:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58211>

Junio C Hamano <gitster@pobox.com> writes:

> Gerrit Pape <pape@smarden.org> writes:
>
>> On Wed, Sep 12, 2007 at 04:04:22PM -0700, Junio C Hamano wrote:
>>>  * In my earlier reply to Gerrit, I hinted that we need to
>>>    update the pathspec semantics in ls-tree to properly fix this
>>>    issue.  I cheated here and have ls-files apply its pathspec
>>>    semantics to the entries from HEAD as well.
>>
>> This fixes the problem reported through http://bugs.debian.org/437817
>> just fine, thanks.  Is this an interims-fix, or should the new option
>> be documented?
>
> I honestly am not convinced it is the right fix.  It has a few
> holes in the logic.
>
> Most notably, I think "git rm --cached A; git commit A" would
> not work.

I managed to convince myself that not committing the removal of
A in that case is a _good_ thing, unless somebody comes up with
a good counterexample this will most likely go to 'master' over
the weekend and then to 'maint'.

Any partial commit "git commit <paths>..." is saying:

	I might have changed stuff in the index and also have
	changes in the working tree.  But I do not care about
	the changes between HEAD and the index.  Honestly, I do
	not understand the index at all, and I do not care about
	what I staged earlier to the named paths either.  Take
	the current state of these paths from my work tree and
	make a commit relative to the HEAD.

So, if you do:

	$ edit new-file old-file
        $ rm gone-file
        $ git rm missing-file
        $ git rm --cached disappeared-file
	$ git add new-file ;# was not in HEAD
        $ edit new-file old-file

Then:

	$ git commit new-file old-file

honors what is in the work tree and picks up the later edits,
largely ignoring the changes to the index.

Removal should work the same way to be consistent.

	$ git commit gone-file
	$ git commit missing-file
	$ git commit disappeared-file

should remove the former two but leave the last one alone, as
you _do_ still have disappeared-file in the work tree.

As it happens, the version I sent will error out on the last one
(disappeared-file case).  I think the following patch on top of
it "fixes" it, by adding it back to the index and including its
contents in the resulting commit.


---
diff --git a/git-commit.sh b/git-commit.sh
index 5ea3fd0..bb113e8 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -404,7 +404,7 @@ t,)
 		(
 			GIT_INDEX_FILE="$NEXT_INDEX"
 			export GIT_INDEX_FILE
-			git update-index --remove --stdin
+			git update-index --add --remove --stdin
 		) || exit
 		;;
 	esac
