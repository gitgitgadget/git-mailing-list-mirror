From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Sat, 29 Dec 2012 15:18:49 -0700
Message-ID: <029f9379-a284-40e6-b4b9-529bd82d6e3e@email.android.com>
References: <20121221080449.GA21741@sigill.intra.peff.net> <50DAB447.8000101@alum.mit.edu> <201212271611.52203.mfick@codeaurora.org> <20121229081021.GC15408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 23:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp4pq-0001EV-QG
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 23:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab2L2WYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 17:24:12 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:17206 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab2L2WYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 17:24:10 -0500
X-IronPort-AV: E=Sophos;i="4.84,379,1355126400"; 
   d="scan'208";a="16934838"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Dec 2012 14:24:10 -0800
Received: from [192.168.1.181] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9DDE010004B1;
	Sat, 29 Dec 2012 14:24:09 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20121229081021.GC15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212320>

Jeff King <peff@peff.net> wrote:

>On Thu, Dec 27, 2012 at 04:11:51PM -0700, Martin Fick wrote:
>> My idea is based on using filenames to store sha1s instead of 
>> file contents.  To do this, the sha1 one of a ref would be 
>> stored in a file in a directory named after the loose ref.  I 
>> believe this would then make it possible to have lockless 
>> atomic ref updates by renaming the file.
>> 
>> To more fully illustrate the idea, imagine that any file 
>> (except for the null file) in the directory will represent the 
>> value of the ref with its name, then the following 
>> transitions can represent atomic state changes to a refs 
>> value and existence:
>
>Hmm. So basically you are relying on atomic rename() to move the value
>around within a directory, rather than using write to move it around
>within a file. Atomic rename is usually something we have on local
>filesystems (and I think we rely on it elsewhere). Though I would not
>be
>surprised if it is not atomic on all networked filesystems (though it
>is
>on NFS, at least).

Yes.  I assume this is OK because doesn't git already rely on atomic renames?  For example to rename the new packed-refs file to unlock it?

...

>> 3) To create a ref, it must be renamed from the null file (sha 
>> 0000...) to the new value just as if it were being updated 
>> from any other value, but there is one extra condition: 
>> before renaming the null file, a full directory scan must be 
>> done to ensure that the null file is the only file in the 
>> directory (this condition exists because creating the 
>> directory and null file cannot be atomic unless the filesystem 
>> supports atomic directory renames, an expectation git does 
>> not currently make).  I am not sure how this compares to 
>> today's approach, but including the setup costs (described 
>> below), I suspect it is slower.
>
>Hmm. mkdir is atomic. So wouldn't it be sufficient to just mkdir and
>create the correct sha1 file?

But then a process could mkdir and die leaving a stale empty dir with no reliable recovery mechanism.


Unfortunately, I think I see another flaw though! :( I should have known that I cannot separate an important check from its state transitioning action.  The following could happen:

 A does mkdir
 A creates null file
 A checks dir -> no other files 
 B checks dir -> no other files
 A renames null file to abcd
 C creates second null file 
 B renames second null file to defg

One way to fix this is to rely on directory renames, but I believe this is something git does not want to require of every FS? If we did, we could Change #3 to be:

3) To create a ref, it must be renamed from the null file (sha 0000...) to the new value just as if it were being updated from any other value. (No more scan)

Then, with reliable directory renames, a process could do what you suggested to a temporary directory, mkdir + create null file, then rename the temporary dir to refname.  This would prevent duplicate null files.  With a grace period, the temporary dirs could be cleaned up in case a process dies before the rename.  This is your approach with reliable recovery.


>> I don't know how this new scheme could be made to work with 
>> the current scheme, it seems like perhaps new git releases 
>> could be made to understand both the old and the new, and a 
>> config option could be used to tell it which method to write 
>> new refs with.  Since in this new scheme ref directory names 
>> would conflict with old ref filenames, this would likely 
>> prevent both schemes from erroneously being used 
>> simultaneously (so they shouldn't corrupt each other), except 
>> for the fact that refs can be nested in directories which 
>> confuses things a bit.  I am not sure what a good solution to 
>> this is?
>
>I think you would need to bump core.repositoryformatversion, and just
>never let old versions of git access the repository directly. Not the
>end of the world, but it certainly increases deployment effort. If we
>were going to do that, it would probably make sense to think about
>solving the D/F conflict issues at the same time (i.e., start calling
>"refs/heads/foo" in the filesystem "refs.d/heads.d/foo.ref" so that it
>cannot conflict with "refs.d/heads.d/foo.d/bar.ref").

Wouldn't you want to use a non legal ref character instead of dot? And without locks, we free up more of the ref namespace too I think? (Refs could end in ".lock")

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
