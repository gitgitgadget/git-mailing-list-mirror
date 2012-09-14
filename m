From: "Devin J. Pohly" <djpohly@gmail.com>
Subject: Re: [PATCH/RFC] remote-helper: allow fetch to discover sha1 later
Date: Fri, 14 Sep 2012 16:49:12 -0400
Message-ID: <20120914204912.GG1072@chiri.hsd1.pa.comcast.net>
References: <1347531013-10371-1-git-send-email-djpohly@gmail.com>
 <7vmx0t6sod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 22:49:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCcpK-0007J2-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 22:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab2INUtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 16:49:18 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63309 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2INUtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 16:49:17 -0400
Received: by qcro28 with SMTP id o28so3115693qcr.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=onm4pJpMfa3v0nJftbGd5tUZv3ImpZTu4EU0G4lSGJY=;
        b=XjHo838DcfSNhdtadUToRXPknzhmawcSedOcDwwLrP+SF4nNv2azcGtC/XG4+TzjQu
         QYj/4A/zL8aKlpk9qi0lTNPl7T6UHGp6rzvEba7mYmNRDN3FKINZF5/AmI6GhGGOnTx+
         Tlxxi+eW9WlkNZyNuEdIJy8h/a5SW5WkuPpgZ2Mdzv7dUeSMb/4lx1fnOMfDJLyyDGvV
         PcGaRxFEBTkZzb8DVaU7WR4iwSZLsH8/Vg6+2swass8UWd6BDsOnQEOBr7Zfea8wWslV
         GCPFFjECk+JJF0do2cJ+MKgQ7IoglKBabEFHuz2pWewm8k+1J7ceAhclbZIfaFDRK2u+
         R6MA==
Received: by 10.224.53.18 with SMTP id k18mr10373360qag.1.1347655756537;
        Fri, 14 Sep 2012 13:49:16 -0700 (PDT)
Received: from chiri.hsd1.pa.comcast.net (c-71-58-66-108.hsd1.pa.comcast.net. [71.58.66.108])
        by mx.google.com with ESMTPS id fl3sm3744487qab.3.2012.09.14.13.49.14
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 13:49:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmx0t6sod.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205529>

On Thu, Sep 13, 2012 at 11:10:26PM -0700, Junio C Hamano wrote:
> I do not think it is a good idea to allow such a helper to claim that
> it supports "fetch" capability, for at least two reasons:
> 
>  * Being able to "list" is essential for "fetch" based helpers.
>    think, far from "arbitrary".
>    ...

Oh, I don't mean to change the semantics of the list command at all.
What I thought seemed arbitrary was limiting the *fetch* command to refs
with pre-known sha1s.  Any list-time optimization in place or possible
for such refs wouldn't be affected.

(In light of this, specifying a new sha1 for a ref which already had one
in the list should probably be an error rather than a warning.  I'll
update this in the next version and make it clear that a "ref" message
must only be issued for refs reported without a sha1.)

>  * Existing versions of "git" that can drive remote helpers that
>    claim to have "fetch" capability are not prepared to accept an
>    unknown "refs" protocol message from the helper, so a helper
>    written for your new semantics of "fetch" capability will not
>    work with them.
>    ...

I see.  I didn't realize that new helper + old Git client is a supported
combination.  Still, hear me out.

1. A new helper must only send a "ref" message when git asks for a ref
   without a known sha1.
2. Asking for a ref without a known sha1 is unsupported, according to
   git-remote-helpers.txt: "Only objects which were reported in the ref
   list with a sha1 may be fetched [with fetch]."
3. Furthermore, asking for a ref without a known sha1 *already* breaks
   in existing versions of git with current handlers:

    $ git fetch testfetch::../git1 foo
    fatal: bad object 0000000000000000000000000000000000000000
    error: testfetch::../git1 did not send all necessary objects

   Compare - existing version of git, with a new handler:

    $ git fetch testref::../git1 foo
    warning: testref unexpectedly said: 'ref 0f31<snip> refs/heads/foo'
    fatal: bad object 0000000000000000000000000000000000000000
    error: testref::../git1 did not send all necessary objects

So the proposed change doesn't break anything that isn't already broken.
:)

That said, if you're still not sold, a new capability is fine.  Though I
think it can be done without it, I'm certainly not opposed to adding
one.
