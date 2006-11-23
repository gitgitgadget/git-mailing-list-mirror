X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: "stgit clean" has problems with removed generated files
Date: Thu, 23 Nov 2006 16:33:42 +0000
Message-ID: <b0943d9e0611230833y5ffc14d3q922a821744ad05d@mail.gmail.com>
References: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 16:34:14 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qztWXsImHJsKes3DEvAgSHgm3922N0aPnmziHMLINXjo8EQzCC7v/pWKipnu9hzZqlFEXJ62ZfIJp7+fCo88sAZnTh8XtvHefKo09qh6SoM2Yo1qWh5QKuZp4R/OFddklAnp3AWbKPGMGXGJxtcS9YcWzUXsCYTnddwFtToyRCY=
In-Reply-To: <20061123161135.GK5443@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32149>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHWZ-0004NI-By for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757407AbWKWQdn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 11:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbWKWQdn
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:33:43 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:31686 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1757407AbWKWQdn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 11:33:43 -0500
Received: by nz-out-0102.google.com with SMTP id s1so341833nze for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 08:33:42 -0800 (PST)
Received: by 10.64.193.8 with SMTP id q8mr14862218qbf.1164299622266; Thu, 23
 Nov 2006 08:33:42 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Thu, 23 Nov 2006 08:33:42 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 23/11/06, Yann Dirson <ydirson@altern.org> wrote:
> In a kernel tree, the precise problem I had is due to generated files
> committed by error in an upstream branch (a BSP from a well-known
> vendor, indeed ;).  The first patch in my stgir stack does some cleanup
> by removing them from git control (so that "make dep" does not cause
> them to change every so often).
>
> Now when I want to run "stg clean" for applied patches, stgit first
> wants to pop the whole stack, including that patch, which triggers the
> following error:
>
> fatal: Untracked working tree file 'include/asm-arm/constants.h' would be                                                                                                              overwritten by merge.

That's a git error and I think it is the correct behaviour. It is
safer to notify that a local file is overridden by a merge/switch
operation rather than just losing its content.

> Obviously, removing all such files by hand allows to run "stg clean", as
> does (floating and) popping that patch and deleting it, or running "stg clean
> --unappplied".

Maybe 'stg clean' should only pop to the first empty applied patch
rather than popping all of them as it is also more efficient.

> The root issue seems to be that stgit has problem with such generated
> files, ie., files that were removed from version-control, but can still
> legitimately exist in the tree.  Dealing with them could possibly be
> done (eg. allowing to back them up, and restore them when pushing the
> annoying patch), but is not a trivial issue (eg. we still need to guard
> the user against real conflicts).

That's a GIT issue more than an StGIT one, unless GIT already has a
way to deal with this and StGIT doesn't pass the right options.

> First, when cleaning patches, we could first look up which patches are
> to be removed, and only pop the necessary ones.

OK, I mentioned it above as well. This should really be done for
efficiency but it might not solve the problem if the empty patch is
deeper into the stack.

> Second, we could generalize the "clean" subcommand to accept arbitrary
> ranges, not only the "applied" and "unapplied" ones.  A special case
> would be "stg clean that-patch", which would be a secure version of "stg
> delete".

Easy to fix as well.

> BTW, maybe it would those make sense to allowthose special ranges in
> most places a range is valid.

Is there any other place where ranges could be used but aren't?

-- 
