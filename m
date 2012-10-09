From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Tue, 9 Oct 2012 02:50:10 -0400
Message-ID: <CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
	<7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
	<7v4nm4i37u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLTe2-0001c2-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 08:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2JIGuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 02:50:12 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48686 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2JIGuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 02:50:11 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4718526oag.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6rUyTD7RJQdK36ZT6A4PAhfn81hvrZm/CQy2/W9ceO0=;
        b=Ff8cRS7n8sjTIJiq45ybnQJh7UVn8/BVzIQHP0YxA/hXfUQuKq2OJL8H85gzq/IG8F
         zLE85CSw36pWsxXQTzcsx3lgtc2ZDxrX3MZrOPDkkAL0OtZWy+6z9HrBK7yWCkiLt7jj
         BhWG6FfU5ec8wwnS/HwIUpFAuSRmIwg3iBzJ+QVWzYa0+I2VytP0tvuC9ZMUN8IEPENs
         ND6W1V2GobJVbpMFwwgFiPGlRE0PxJo0QWjc4EgoepIZNqGlAff/TGSEL8XmAAcu+hLA
         qfFtPl21XXgtj2enoi9Z2GGyqihS9kyMZdqEHn1yPPGFs191w0rhyTBsIlVcQj9aQvkR
         G+/A==
Received: by 10.182.174.66 with SMTP id bq2mr2060128obc.101.1349765410670;
 Mon, 08 Oct 2012 23:50:10 -0700 (PDT)
Received: by 10.60.54.169 with HTTP; Mon, 8 Oct 2012 23:50:10 -0700 (PDT)
In-Reply-To: <7v4nm4i37u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207305>

On Tue, Oct 9, 2012 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Assuming that the above guess is correct (which is a huge
>> assumption, given the lack of clarity in the description), I think
>> the feature might make sense.  The example would have been a lot
>> easier to follow if it were something like this:
>>
>>     $ git submodule foreach --revision v1.0 'git grep -e frotz $sha1'
>
> Imagine you have a checkout of v2.0 of the superproject in your
> working tree, and you run "git submodule foreach --revision v1.0".
> Further imagine a submodule S that used to exist back when the
> superproject was at v1.0 no longer exists in the current codebase
> (hence there is no such submodule in the working tree).
>
> Shouldn't the above "foreach ... grep" still try to find 'frotz' in
> the submodule S that was bound to v1.0 of the superproject?
>
> Given that your patch does not touch the part of cmd_foreach where
> it decides which submodule to descend into, it still will base its
> decision solely on the set of submodules that are bound to and have
> been "git submodule init"ed in the version of the superproject that
> is _currently_ checked out, no?

That's a good observation. My use-case for this (poorly explained in
the commit message) is as part of a release process, where I wish to
apply corresponding tags to the superproject and its submodules like
so:

$ cd /path/to/superproject
$ git tag -m "1.0" v1.0 deadbeef
$ git submodule foreach --revision deadbeef \
  'git tag -m "superproject 1.0" superproject-1.0 $sha1'

Typically deadbeef may be a day or two behind HEAD and it's nice to be
able to tag it and the submodules w/o having to switch everything to a
detached HEAD. In my case, tagging and updating submodule revisions
are somewhat common, while adding/removing submodules is a rare event.

I didn't mention this issue explicitly because I thought it was
covered by the existing documentation: "Any submodules defined in the
superproject but not checked out are ignored by this command."

As you previously stated, I need to improve the documentation that
goes along with this patch, so I'll call-out this limitation. I'm not
sure what else can be done. You can't descend into a submodule that
isn't there.

j.
