From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: reducing object store size with remote alternates or shallow
 clone?
Date: Tue, 24 Aug 2010 18:29:42 -0500
Message-ID: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
References: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org> <7vhbikx8lu.fsf@alter.siamese.dyndns.org> <2dePxmEZeCbs4IkjGd-Ig2cma8lknd0XEwVdaypeAxtQDY3EZeSEPA@cipher.nrlssc.navy.mil> <7vfwy3vnti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 01:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2wy-0006ny-5z
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 01:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062Ab0HXX3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 19:29:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52508 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab0HXX3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 19:29:50 -0400
Received: by mail.nrlssc.navy.mil id o7ONTh20009064; Tue, 24 Aug 2010 18:29:43 -0500
In-Reply-To: <7vfwy3vnti.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Aug 2010 23:29:43.0822 (UTC) FILETIME=[3B643AE0:01CB43E4]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154383>

On 08/24/2010 01:59 PM, Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>> On 08/24/2010 11:45 AM, Junio C Hamano wrote:
>>
>>> How about doing
>>>
>>>     $ LINUS=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>
>>>     $ git fetch $LINUS
>>>     $ git bundle create myfork.bundle HEAD..master
>>
>> I think you mean
>>
>>       $ git fetch $LINUS master
>>       $ git bundle create myfork.bundle FETCH_HEAD..master
> 
> Thanks, of course you are right.
> 
> Strictly speaking, as I know there is only one branch in the repository of
> Linus, there is no need to say "master" when fetching

Hmm.  It appears that if the current checked-out branch has a configured
merge ref, then a fetch that supplies a repository url (not a remote name)
and no fetch refspec, will not fall back to fetch HEAD from the remote
repository.

i.e. the following fetch does not retrieve any objects nor update FETCH_HEAD

   $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux
   $ cd linux
   $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

but, if you create a new branch, that has no merge ref configuration, then
git behaves as expected:

   $ git branch foo
   $ git checkout foo
   $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Namely we retrieve new objects and update FETCH_HEAD:

   From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
   * branch            HEAD       -> FETCH_HEAD


I think the problem is in builtin/fetch.c: get_ref_map().

When fetch is called as above, with a repository url but no refspec,
we get this call sequence:

   cmd_fetch -> fetch_one
     fetch_one -> do_fetch(argc = 0)
       do_fetch -> get_ref_map(ref_count = 0)
         line 148: has_merge is assigned 1 since the current checked out
                   branch has a merge ref configured
         The 'if' branch is entered, the 'for' loop is not entered,
         ref_map retains its NULL initialization value and
         get_ref_map() returns NULL
       do_fetch -> fetch_refs(ref_map = NULL)
         and the transports do nothing since no refs have been requested

Perhaps the fix should look something like this (warning copy/paste):


diff --git a/builtin/fetch.c b/builtin/fetch.c
index fab3fce..218e71d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -146,7 +146,8 @@ static struct ref *get_ref_map(struct transport *transport,
                struct remote *remote = transport->remote;
                struct branch *branch = branch_get(NULL);
                int has_merge = branch_has_merge_config(branch);
-               if (remote && (remote->fetch_refspec_nr || has_merge)) {
+               if (remote && (remote->fetch_refspec_nr || (has_merge &&
+                               !strcmp(branch->remote_name, remote->name)))) {
                        for (i = 0; i < remote->fetch_refspec_nr; i++) {
                                get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
                                if (remote->fetch[i].dst &&


-Brandon
