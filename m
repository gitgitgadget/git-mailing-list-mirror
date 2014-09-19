From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Fri, 19 Sep 2014 16:01:38 +0200
Message-ID: <CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
	<20140919093910.GA15891@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:24:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUz6t-0002mB-GU
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 16:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425AbaISOBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 10:01:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:55968 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbaISOBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 10:01:48 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XUykr-0005jz-Pf
	for git@vger.kernel.org; Fri, 19 Sep 2014 16:01:46 +0200
Received: by mail-pa0-f51.google.com with SMTP id fa1so169299pad.24
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 07:01:38 -0700 (PDT)
X-Received: by 10.70.137.74 with SMTP id qg10mr1284981pdb.128.1411135298442;
 Fri, 19 Sep 2014 07:01:38 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Fri, 19 Sep 2014 07:01:38 -0700 (PDT)
In-Reply-To: <20140919093910.GA15891@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257287>

On Fri, Sep 19, 2014 at 11:39 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 19, 2014 at 09:39:45AM +0200, Scott Chacon wrote:
>> Currently if you try to merge notes, the notes code ensures that the
>> reference is under the 'refs/notes' namespace. In order to do any sort
>> of collaborative workflow, this doesn't work well as you can't easily
>> have local notes refs seperate from remote notes refs.
>>
>> This patch changes the expand_notes_ref function to check for simply a
>> leading refs/ instead of refs/notes to check if we're being passed an
>> expanded notes reference. This would allow us to set up
>> refs/remotes-notes or otherwise keep mergeable notes references outside
>> of what would be contained in the notes push refspec.
>
> I think this change affects not just "git notes merge", but all of the
> notes lookups (including just "git notes show"). However, I'd argue
> that's a good thing, as it allows more flexibility in note storage. The
> downside is that if you have a notes ref like
> "refs/notes/refs/heads/master", you can no longer refer to it as
> "refs/heads/master" (you have to use the fully qualified name to get the
> note). But:
>
>   1. This makes the notes resolution a lot more like regular ref
>      resolution (i.e., we now allow fully qualified refs, and you can
>      store remote notes outside of refs/notes if you want to).
>
>   2. There are already a bunch of names that have the same problem. You
>      cannot refer to "refs/notes/notes/foo" as "notes/foo", nor
>      "refs/notes/refs/notes/foo" as "refs/notes/foo". Yes, these are
>      silly names, so is the example above.
>
> So it's backwards incompatible with the current behavior, but I think in
> a good way.

FWIW, I agree with this analysis.

>> ---
>>  notes.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I think you need to adjust t3308 (and you should probably add a new test
> exercising your case; this is exactly the sort of thing that it's easy
> to accidentally regress later).

Agree here as well.

AFAICS, the only diff you'll need to make the test suite pass is this:

diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b4..f0feb64 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non-note-trees' '
        test_must_fail git notes merge refs/notes/ &&
        test_must_fail git notes merge refs/notes/dir &&
        test_must_fail git notes merge refs/notes/dir/ &&
-       test_must_fail git notes merge refs/heads/master &&
        test_must_fail git notes merge x: &&
        test_must_fail git notes merge x:foo &&
        test_must_fail git notes merge foo^{bar

Additionally, I suggest adding another test demonstrating your use
case as well. Something like setting up a small scenario for notes
collaboration, and walking through the various steps:

 - Creating a couple of repos where notes are added/edited
 - Setting up config to allow pushing and/or fetching notes
 - Performing the push/fetch
 - Merging with the corresponding local notes ref

Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
