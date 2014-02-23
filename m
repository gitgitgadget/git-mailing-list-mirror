From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] diff: do not reuse_worktree_file for submodules
Date: Sun, 23 Feb 2014 13:46:37 +0100
Message-ID: <87bnxyq9n6.fsf@thomasrast.ch>
References: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
	<d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
	<xmqqy518cezh.fsf@gitster.dls.corp.google.com>
	<8738jbtmji.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?Q?Gr=C3=A9gory?= Pakosz <gregory.pakosz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 23 13:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHYSj-0001YL-OM
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 13:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbaBWMqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 07:46:52 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:36725 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbaBWMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 07:46:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A34154D6564;
	Sun, 23 Feb 2014 13:46:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7Iu3BQq6PTw6; Sun, 23 Feb 2014 13:46:37 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (9-226.197-178.cust.bluewin.ch [178.197.226.9])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 83E8D4D64BD;
	Sun, 23 Feb 2014 13:46:37 +0100 (CET)
In-Reply-To: <8738jbtmji.fsf@thomasrast.ch> (Thomas Rast's message of "Sat, 22
	Feb 2014 12:27:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242543>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <tr@thomasrast.ch> writes:
>>
>>> @@ -2845,8 +2845,9 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>>>  		remove_tempfile_installed = 1;
>>>  	}
>>>  
>>> -	if (!one->sha1_valid ||
>>> -	    reuse_worktree_file(name, one->sha1, 1)) {
>>> +	if (!S_ISGITLINK(one->mode) &&
>>> +	    (!one->sha1_valid ||
>>> +	     reuse_worktree_file(name, one->sha1, 1))) {
>>
>> I agree with the goal/end result, but I have to wonder if the
>> reuse_worktree_file() be the helper function that ought to
>> encapsulate such a logic?
>>
>> Instead of feeding it an object name and a path, if we passed a
>> diff_filespec to the helper, it would have access to the mode as
>> well.  It would result in a more intrusive change, so I'd prefer to
>> see your patch applied first and then build such a refactor on top,
>> perhaps like the attached.
>
> I see that you already queued 721e727, which has the change you
> described plus moving the S_ISGITLINK test into reuse_worktree_file.
> The change looks good to me.

I spoke too soon; it breaks the test I wrote to cover this case, for a
reason that gives me a headache.

When we hit the conditional

>>> -	if (!one->sha1_valid ||
>>> -	    reuse_worktree_file(name, one->sha1, 1)) {
>>> +	if (!S_ISGITLINK(one->mode) &&
>>> +	    (!one->sha1_valid ||
>>> +	     reuse_worktree_file(name, one->sha1, 1))) {

sha1_valid=0 for the submodule on the worktree side of the diff.  The
reason is that we start out with sha1_valid=0 and sha1=000..000 for the
worktree side of all dirty entries, which makes sense at that point.  We
later set the sha1 by looking inside the submodule in
diff_fill_sha1_info(), but we never set sha1_valid.  So the above
conditional will now trigger on the !one->sha1_valid arm, completely
defeating the change to reuse_worktree_file().

We can fix it like below, but it feels a bit wrong to me.  Are
submodules the only case where it makes sense to set sha1_valid when we
fill the sha1?


 diff.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git i/diff.c w/diff.c
index dabf913..cf7281d 100644
--- i/diff.c
+++ w/diff.c
@@ -3081,6 +3082,8 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 				die_errno("stat '%s'", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
 				die("cannot hash %s", one->path);
+			if (S_ISGITLINK(one->mode))
+				one->sha1_valid = 1;
 		}
 	}
 	else


-- 
Thomas Rast
tr@thomasrast.ch
