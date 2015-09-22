From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Tue, 22 Sep 2015 10:54:12 -0700
Message-ID: <CA+P7+xrwM44tMHMW+dEJx_tMtcMVEQELNq=J=rqs1uQ+feuZqQ@mail.gmail.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
 <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
 <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com> <CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
 <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 19:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeRmC-0008RO-AL
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 19:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759466AbbIVRye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 13:54:34 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36581 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400AbbIVRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 13:54:33 -0400
Received: by ioii196 with SMTP id i196so22228513ioi.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0nOVIceaUAmMv1dCwmfH3X19a88KI4tEMsam8RsD06E=;
        b=QNiz8nzMJcf7SCxBSF8s1dHYGHuTseQ92F0gdxLnDeRz/ZF5URChr2sjvpfIeMQb0X
         gluYngixJEVG8tGUzYCrUAXFsiN1Buoavw4eVyoxBqumjRz+NeK4a3bpMFZWxcclFo9R
         ozIuzlql+9NXt4BQ6xf8MS8MVce3ArO5GXXwbxSPo4227Zn2ruaY/XA6au9x7kJh6j27
         2TXmFcb+ST3pThrHBiCuXy7Lq4OlXd9Lyg8o8NRganR2arDpWAEgU4NYYUvLFRU1JjIr
         N/d8qiyQKJyAk5nkiQbTe6ryzb4LqQbctdAW6eHtEDI42upvhzXYqJkvN4dndM5ytF7y
         DJBw==
X-Received: by 10.107.133.151 with SMTP id p23mr40720350ioi.71.1442944472227;
 Tue, 22 Sep 2015 10:54:32 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 22 Sep 2015 10:54:12 -0700 (PDT)
In-Reply-To: <xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278406>

On Tue, Sep 22, 2015 at 7:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Calls expand_notes_ref() made on a command line argument that
> specifies the source (which I think is similar to what the other
> recent topic calls "read-only") should be made to calls to a more
> lenient version (and you can start with get_sha1() for that purpose
> without introducing your own DWIMs in the first step), while leaving
> calls to expand_notes_ref() for destination and the implementation
> of expand_notes_ref() itself unmolested, so that we can keep the
> safety in expands_notes_ref() that makes sure that the destination
> of a local operation is under refs/notes/*.

The other issue here is that expand_notes_ref is called on the --ref
argument waaay before the current code even decides if the operation
is "read" or "write". Thus we'd have to break this out and handle
things very differently.

I don't believe expand_notes_ref() is actually providing any safety.
That is all done by init_notes_check. Note that passing the
environment variable bypasses the expand_notes_ref entirely, though I
think we did use it as part of the refs configuration.

It seems like a lot more heavy lifting to change the entire flow of
how we decide when to expand "--ref" for "read" operations vs "write"
operations.

That is, git notes list.

It's easy to change behavior of git notes merge as it handles its
argument for where to merge from separately, but it's not so easy to
change git notes show...

Regards,
Jake
