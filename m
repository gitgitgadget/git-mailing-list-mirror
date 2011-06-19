From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 6/6] RFC - Notes merge: die when asked to merge a
 non-existent ref.
Date: Mon, 20 Jun 2011 00:03:46 +0200
Message-ID: <201106200003.46490.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-7-git-send-email-ydirson@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQA0-0008SE-7N
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab1FSWHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:07:49 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59476 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729Ab1FSWHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:07:42 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200I2U5GQ0810@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:38 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A5A05179919D_DFE732AB	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:38 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 550EF1796523_DFE7329F	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:37 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200CIB5GO4R00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:37 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1308431208-13353-7-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176034>

On Saturday 18 June 2011, Yann Dirson wrote:
> This causes the "merge empty notes ref (z => y)" test in
> t3308-notes-merge.sh to fail - obviously, it is removing the
> functionnality that is tested for.
> 
> Is there any real use for this ?  It just seems so different from
> "git merge", which errors out in the similar situation:
> 
> $ git merge foo
> fatal: 'foo' does not point to a commit

I understand your reasoning, and I don't have a problem with changing this 
behavior to be in line with "git merge".

> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  builtin/notes.c        |    3 +++
>  t/t3308-notes-merge.sh |    6 ------
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 6bff44f..058b14d 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -908,6 +908,9 @@ static int merge(int argc, const char **argv, const
> char *prefix) expand_notes_ref(&remote_ref, 1);
>  	o.remote_ref = remote_ref.buf;
> 
> +	if (!peel_to_type(o.remote_ref, 0, NULL, OBJ_COMMIT))
> +		die("'%s' does not point to a commit", o.remote_ref);

Hmm. I'm not sure requiring the remote ref to always point to a _commit_ is 
the right solution here. In previous discussions on the notes topic, some 
people (Peff?) expressed a need/interest for history-less notes refs (i.e. a 
notes tree where we don't keep track of its development, but only refer to 
the latest/current version). Obviously, there are two ways to implement 
history-less notes refs: (a) making the notes ref point to a notes commit 
without any parents (i.e. each notes commit is a root commit), or (b) making 
the notes ref point directly at the notes _tree_ object (i.e. no commit 
object at all).

I can't remember off the top of my head whether our earlier discussions on 
this topic resulted in us excluding support for option (b), but if we 
didn't, it should be possible to merge notes refs where one or both refs 
point directly at a tree object, and your above line would break this.

> [...]
> 
> diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
> index 24d82b4..2dcc1db 100755
> --- a/t/t3308-notes-merge.sh
> +++ b/t/t3308-notes-merge.sh
> @@ -104,12 +104,6 @@ test_expect_success 'merge notes into empty notes
> ref (x => y)' ' test "$(git rev-parse refs/notes/x)" = "$(git rev-parse
> refs/notes/y)" '
> 
> -test_expect_success 'merge empty notes ref (z => y)' '
> -	git notes merge z &&
> -	# y should not change (still == x)
> -	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
> -'

Instead of removing the test, please change it into verifying the _new_ 
expected behavior (that we fail with an appropriate error message when asked 
to merge a non-existent notes ref).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
