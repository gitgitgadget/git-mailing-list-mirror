From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 20:45:00 +0100
Message-ID: <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
	 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
	 <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdbQ-0003Rk-Uf
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZARTpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbZARTpC
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:45:02 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:23734 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbZARTpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:45:00 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1318729wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8YshIQ5OGJTmHcAXzW+0ngbB3dzTXKBa9Gn1B6Ixyt8=;
        b=E4wB75Qch8/4c1KG6S3wRKIyFu2fXZbV5jXIzo7XoUNHS/rK/le6Do05IWqMFwH1DK
         rNkBTyznR3vPErIMGT0wz3zhIh8zAJECThGAgmooOXsUevoqiJHY6BKkSXieftaWo7lG
         PK1F7gUWykjrPgq72d8+mi7aEVagDeI0/N8o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dYw55vSGlmYN9KOsP3YVG8gyAX8TFhK+g0iQl/jixRgoiAo9OytW1Sa9EHu9BxpUcP
         2pNv9IAQ6dM9gE70nWd4MN2N56SKpS6C4Pf+RftcOO/LDzRBCyX4JlXmUgVw2EIwdGXB
         hil2ORGLHxksm3qLuotezW2m3vEGNSaOq98YE=
Received: by 10.114.47.12 with SMTP id u12mr830699wau.147.1232307900079; Sun, 
	18 Jan 2009 11:45:00 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106270>

On Sun, Jan 18, 2009 at 19:33, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 18 Jan 2009, Lars Hjemli wrote:
>> Actually, I want this to work for bare repositories by specifying the
>> submodule odbs in the alternates file. So if the current submodule odb
>> wasn't found my plan was to check if the commit object was accessible
>> anyways but don't die() if it wasn't.
>
> Please make that an explicit option (cannot think of a good name, though),
> otherwise I will not be able to use your feature.  Making it the default
> would be inconsistent with the rest of our submodules framework.

Would a test on is_bare_repository() suffice for your use-case? That
is, something like this:

	if (!add_gitlink_odb(path->buf)) {
		linked_odb = 1;
		if (resolve_gitlink_ref(path->buf, "HEAD", sha1))
			die("Unable to lookup HEAD in %s", path->buf);
	} else if (!is_bare_repository())
		return 0;

If this isn't good enough, how do you propose it be solved?


>
>> >> +     commit = lookup_commit(sha1);
>> >> +     if (!commit)
>> >> +             die("traverse_gitlink(): internal error");
>> >
>> > s/internal error/could not access commit '%s' of submodule '%s'",
>> >                        sha1_to_hex(sha1), path);/
>>
>> Ok (I belive this codepath is virtually impossible to hit, hence the
>> "internal error", but I could of course be mistaken).
>
> You make it a function that is exported to other parts of Git in cache.h.
> So you might just as well expect it to be used by other parts at some
> stage.

This function is local to tree.c, but your point is still valid.

--
larsh
