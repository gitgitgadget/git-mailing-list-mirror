From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 14:29:47 +0530
Message-ID: <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <51500C67.9040308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 25 10:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK3Gq-00074a-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 10:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3CYJAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 05:00:13 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:34303 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab3CYJAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 05:00:09 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so5260143iag.41
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pSNP+9m0v0Japfnu2vKz5/SuV3jH0A5REPFgaIl1tc8=;
        b=dVdRWO/IUFiJygRva0x9C0qtuUOLnSKDNb8GTBTBeF8kwqO18F1U3P7T1kDNu1k6Yd
         YBfHrZb3GoDxIwwSezJuUHm966ecjq9h8FETZcxQ9JpeM2gg8GgBn6De5l6oXX086ARB
         871z4hvuo3N+xvuIX3Tk2gU3vzDBXefSz/xUVL2SCxOW2Bz5wnZSC2tZvkg6zap4SRgN
         k/A83WcFuCZw4kzsMNEI9pQgXAWwDK5VHqRu1Os9rBMBUg77HFPme6T/Vv6emomOUBqu
         PYnkAJoppSGhqK5y+2VOoZUFtDb6zrjmiQ9UTjtz7IM9Vs9WghRoSiQXbOXL/PTP6vgm
         pHAA==
X-Received: by 10.50.17.71 with SMTP id m7mr7304966igd.14.1364202008930; Mon,
 25 Mar 2013 02:00:08 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 01:59:47 -0700 (PDT)
In-Reply-To: <51500C67.9040308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219019>

Jens Lehmann wrote:
> Am 24.03.2013 18:38, schrieb Ramkumar Ramachandra:
>> I find this behavior very inconsistent and annoying.  Why would I want
>> to commit the submodule change immediately?  Maybe I want to batch it
>> up with other changes and stage it at a later time.  Why should I have
>> to unstage them manually now?  I get the other side of the argument:
>> what if the user commits the .gitmodule change at a different time
>> from the file change?  In other words, the user should have a way of
>> saying 'submodule stage' and 'submodule unstage'.
>
> Hmm, AFAIK you are the first to bring up such a feature, as in most
> use cases doing a "git (submodule) add <path>" is expected to stage
> what you added.

In my opinion, the 'git submodule add <path>' form is broken, because
it doesn't relocate the object store of the submodule repository (a
bug that we need to fix?).  I always use the 'git submodule add
<repository> <path>' form, which puts the object store of the
submodule repository in .git/modules of the parent repository.  This
form is nothing like 'git add', but more like a 'git clone': arguably,
'submodule clone' is a better name for it.

> Maybe you could teach the stage/unstage code to also
> stage/unstage the corresponding part of the .gitmodules file, but
> I'm not sure it is worth the hassle.

Maybe not.  I'm still not an heavy user of submodules; I notice many
breakages and inconsistencies, but I'm not sure what to fix first, and
how to go about fixing it.  I'm yet to look at git-subtree and draw
inspiration from its design.

Maybe the WTF "You need to run this command from the toplevel of the
working tree" needs to be fixed first?  I think it's a matter of a
simple pushd, popd before the operation and building the correct
relative path.  I'm not sure how it'll work with nested submodules
though.  Then again, I think nested submodules are Wrong; submodules
are probably not the right tool for the job.

>> Now, for the implementation.  Do we have existing infrastructure to
>> stage a hunk non-interactively?  (The ability to select a hunk to
>> stage/ unstage programmatically).  If not, it might be quite a
>> non-trivial thing to write.
>
> Have fun when adding two submodules and unstage only one of them
> later. I think this feature will not work unless you analyze
> .gitmodules and stage/unstage section-wise.

Yes, which is why I asked if we have existing infrastructure to make
this possible.
