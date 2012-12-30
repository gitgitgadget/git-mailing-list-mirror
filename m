From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Sun, 30 Dec 2012 10:03:19 -0700
Organization: CAF
Message-ID: <201212301003.19802.mfick@codeaurora.org>
References: <20121221080449.GA21741@sigill.intra.peff.net> <20121229081021.GC15408@sigill.intra.peff.net> <029f9379-a284-40e6-b4b9-529bd82d6e3e@email.android.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 30 18:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpMId-0007Cw-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 18:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab2L3RDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 12:03:22 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:52388 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab2L3RDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 12:03:21 -0500
X-IronPort-AV: E=Sophos;i="4.84,382,1355126400"; 
   d="scan'208";a="16972456"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Dec 2012 09:03:20 -0800
Received: from mfick-laptop.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9405C10004BE;
	Sun, 30 Dec 2012 09:03:20 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-41-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <029f9379-a284-40e6-b4b9-529bd82d6e3e@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212336>

On Saturday, December 29, 2012 03:18:49 pm Martin Fick wrote:
> Jeff King <peff@peff.net> wrote:
> >On Thu, Dec 27, 2012 at 04:11:51PM -0700, Martin Fick 
wrote:
> >> My idea is based on using filenames to store sha1s
> >> instead of file contents.  To do this, the sha1 one of
> >> a ref would be stored in a file in a directory named
> >> after the loose ref.  I believe this would then make
> >> it possible to have lockless atomic ref updates by
> >> renaming the file.
> >> 
> >> To more fully illustrate the idea, imagine that any
> >> file (except for the null file) in the directory will
> >> represent the value of the ref with its name, then the
> >> following transitions can represent atomic state
> >> changes to a refs
> >
> >> value and existence:
> >Hmm. So basically you are relying on atomic rename() to
> >move the value around within a directory, rather than
> >using write to move it around within a file. Atomic
> >rename is usually something we have on local filesystems
> >(and I think we rely on it elsewhere). Though I would
> >not be
> >surprised if it is not atomic on all networked
> >filesystems (though it is
> >on NFS, at least).
> 
> Yes.  I assume this is OK because doesn't git already rely
> on atomic renames?  For example to rename the new
> packed-refs file to unlock it?
> 
> ...
> 
> >> 3) To create a ref, it must be renamed from the null
> >> file (sha 0000...) to the new value just as if it were
> >> being updated from any other value, but there is one
> >> extra condition: before renaming the null file, a full
> >> directory scan must be done to ensure that the null
> >> file is the only file in the directory (this condition
> >> exists because creating the directory and null file
> >> cannot be atomic unless the filesystem supports atomic
> >> directory renames, an expectation git does not
> >> currently make).  I am not sure how this compares to
> >> today's approach, but including the setup costs
> >> (described below), I suspect it is slower.
> >
> >Hmm. mkdir is atomic. So wouldn't it be sufficient to
> >just mkdir and create the correct sha1 file?
> 
> But then a process could mkdir and die leaving a stale
> empty dir with no reliable recovery mechanism.
> 
> 
> Unfortunately, I think I see another flaw though! :( I
> should have known that I cannot separate an important
> check from its state transitioning action.  The following
> could happen:
> 
>  A does mkdir
>  A creates null file
>  A checks dir -> no other files
>  B checks dir -> no other files
>  A renames null file to abcd
>  C creates second null file
>  B renames second null file to defg
> 
> One way to fix this is to rely on directory renames, but I
> believe this is something git does not want to require of
> every FS? If we did, we could Change #3 to be:
> 
> 3) To create a ref, it must be renamed from the null file
> (sha 0000...) to the new value just as if it were being
> updated from any other value. (No more scan)
> 
> Then, with reliable directory renames, a process could do
> what you suggested to a temporary directory, mkdir +
> create null file, then rename the temporary dir to
> refname.  This would prevent duplicate null files.  With
> a grace period, the temporary dirs could be cleaned up in
> case a process dies before the rename.  This is your
> approach with reliable recovery.

The whole null file can go away if we use directory renames.  
Make #3:

3) To create a ref, create a temporary directory containing a 
file named after the sha1 of the ref to be created and rename 
the directory to the name of the ref to create.  If the 
rename fails, the create fails.  If the rename succeeds, the 
create succeeds.

With a grace period, the temporary dirs could be cleaned up 
in case a process dies before the rename,

-Martin
