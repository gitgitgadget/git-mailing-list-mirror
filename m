From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Thu, 12 Feb 2009 16:37:27 -0500
Message-ID: <76718490902121337l4b7f6f1dh25e6daa9adb48160@mail.gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
	 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
	 <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
	 <20090212002612.GC30231@coredump.intra.peff.net>
	 <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
	 <alpine.LNX.1.00.0902121519160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjGq-0004cv-L8
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbZBLVha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZBLVh3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:37:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:65238 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZBLVh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:37:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so441002rvb.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GQHXh3honELSqf/80FQeoQLw3jIcMhwv9vhsZySITU0=;
        b=mXo9CqHtDsNgg+/lo5P/RGCNVjOtWyWICgi0k+97r4cr0K4DdEWTDOyNUhwvh4gx7N
         m5kScvLmibJ3KYDnvtd2AZ4eFAoTsg/XkRUFc0dkl1PlIhsRJ4GDrI86Y/NYuoIAhQg7
         SwYz0vyeym35YmJIC3hIfixJIzkC97xpWY8lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Me957mN3xk52+e3EIi1dDR5i0Bexdr2+fqhdOrMilxV/1LBveoCWjnt9kfESyiBLvm
         LKceGuf9U0QkWkIiJ2TL0yvIil7gtS9WlmsxryxPze+fFG9zyaVyK2bZQdPyFemALJgi
         U9ttg2CaurkHoazkWKqjzzvZQjMl7DQEPEx9o=
Received: by 10.141.106.14 with SMTP id i14mr765655rvm.143.1234474648135; Thu, 
	12 Feb 2009 13:37:28 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0902121519160.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109664>

On Thu, Feb 12, 2009 at 3:27 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> struct ref *head = locate_head(refs, refs, NULL);
> return head ? xstrdup(abbrev_branch(head->name)) : NULL;
>
> ?

No, I don't _think_ so. refs is everything from the remote side (tags,
etc). I want to only match those things under refs/heads.

I think I have to do something like this (this is more or less what
builtin-clone does):

struct ref *remote_refs, *mapped_refs = NULL;
struct refspec branch_refspec;

branch_refspec.force = 0;
branch_refspec.src = branch_refspec.dst = "refs/heads";

remote_refs = transport_get_remote_refs(transport);
get_fetch_map(remote_refs, branch_refspec, &mapped_refs, 0);
head_points_at = locate_head(refs, mapped_refs, NULL);

> I'd somehow thought I'd moved locate_head() somewhere common, but it
> really ought to be done.

I plan to move it into remote.c.

> There were periodic discussions of how you find
> out when the remote repo changes its HEAD and you might want to do
> something locally about it, and we never came up with a specific thing
> for git to do, but the facility is probably useful.

Thus "git remote set-head -a" is the best I could come up with for
setting it to what the remote has.

> I have the vague memory, as well, that there's some way for a transport to
> report that it actually knows that HEAD is a symref to something in
> particular, and so git shouldn't guess.

I think for http://, but not for git://, but I'm *far* from an expert
in this area.

j.
