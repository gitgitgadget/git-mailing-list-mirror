From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 12:32:50 -0400
Message-ID: <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net> <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net> <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 17:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKAL6-00062g-7r
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 17:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716Ab3CYQdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 12:33:12 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:53263 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758704Ab3CYQdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 12:33:11 -0400
Received: by mail-qc0-f170.google.com with SMTP id d42so2793636qca.29
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WMLaojOo6/cD7gy2VDQ21h5PWvLWyFVh8F61MmbfntQ=;
        b=inZvC1pQ8RciYgVhpg+aK2JnSJss2kEeAvlSXbNl07rPfJnilLQd6WTLqiPB4bIXgQ
         MUwO0RaWh//LlJ5Tj9iApU9gZYjsAqEM4UCdvCWKPhJ7AHuiVMATrBcLE6eDzLa2dN/f
         FzuCeBgVvaz+tceh7vm5VF4o81EfP9QMgOY6NiTlX7Ds9ThOjCwNEbaGWA+FP9Opsdr4
         GBSMxd5Ll7m+yFSghNjuFZrhSqdG7rzmJZk/SZ2/kTsxnLVmBhlYtRXEAu+I+KWNiHQ2
         FHhp+tyMG/L+pZymuzWaK6330ZFILP3Fl/Il3bfSowtlr54sz4+diMRRz6xo1OY/7zz2
         FbIQ==
X-Received: by 10.229.78.148 with SMTP id l20mr1769868qck.33.1364229190605;
 Mon, 25 Mar 2013 09:33:10 -0700 (PDT)
Received: by 10.49.110.164 with HTTP; Mon, 25 Mar 2013 09:32:50 -0700 (PDT)
In-Reply-To: <20130325155600.GA18216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219045>

On Mon, Mar 25, 2013 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 25, 2013 at 10:31:04PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, Mar 25, 2013 at 9:56 PM, Jeff King <peff@peff.net> wrote:
>> > There are basically three levels of transport that can be used on a
>> > local machine:
>> >
>> >   1. Hard-linking (very fast, no redundancy).
>> >
>> >   2. Byte-for-byte copy (medium speed, makes a separate copy of the
>> >      data, but does not check the integrity of the original).
>> >
>> >   3. Regular git transport, creating a pack (slowest, but should include
>> >      redundancy checks).
>> >
>> > Using --no-hardlinks turns off (1), but leaves (2) as an option.  I
>> > think the documentation in "git clone" could use some improvement in
>> > that area.
>>
>> Not only git-clone. How git-fetch and git-push verify the new pack
>> should also be documented. I don't think many people outside the
>> contributor circle know what is done (and maybe how) when data is
>> received from outside.
>
> I think it's less of a documentation issue there, though, because they
> _only_ do (3). There is no option to do anything else, so there is
> nothing to warn the user about in terms of tradeoffs.
>
> I agree that in general git's handling of corruption could be documented
> somewhere, but I'm not sure where.

Hi there,

First of all, thanks for the analysis, it's much appreciated. It's
good to know that we weren't totally off-base in thinking that a naive
copy may be out of sync, as small as the chance are (certainly we
wouldn't have known the right ordering).

I think what was conflating the issue in my testing is that with
--mirror it implies --bare, so there would be checking of the objects
when the working tree was being created, hence --mirror won't show the
error a normal clone will -- it's not a transport question, it's just
a matter of the normal clone doing more and so having more data run
through checks.

However, there are still problems. For blob corruptions, even in this
--no-hardlinks, non --mirror case where an error was found, the exit
code from the clone was 0. I can see this tripping up all sorts of
automated scripts or repository GUIs that ignore the output and only
check the error code, which is not an unreasonable thing to do.

For commit corruptions, the --no-hardlinks, non --mirror case refused
to create the new repository and exited with an error code of 128. The
--no-hardlinks, --mirror case spewed errors to the console, yet
*still* created the new clone *and* returned an error code of zero.

It seems that when there is an "error" as opposed to a "fatal" it
doesn't affect the status code on a clone; I'd argue that it ought to.
If Git knows that the source repository has problems, it ought to be
reflected in the status code so that scripts performing clones have a
normal way to detect this and alert a user/sysadmin/whoever. Even if a
particular cloning method doesn't perform all sanity checks, if it
finds something in the sanity checks it *does* perform, this should be
trumpeted, loudly, regardless of transport mechanism and regardless of
whether a user is watching the process or a script is.

Thanks,
Jeff
