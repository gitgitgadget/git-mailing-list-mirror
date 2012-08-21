From: Brandon Casey <drafnel@gmail.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 18:53:53 -0700
Message-ID: <CA+sFfMexCWLza65bVp2uXoqo3+yY5MPBBcGugoEA6UCEwAv6Ow@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
	<CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
	<7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
	<CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
	<7v628dght9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 03:54:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3dfN-0004m6-4x
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 03:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab2HUBx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 21:53:56 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41644 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2HUBxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 21:53:54 -0400
Received: by vbbff1 with SMTP id ff1so6021585vbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1LXkIRf7ai2Z9VFVSaylbdVMBrUdB+MvcNksqxLb7mI=;
        b=OjZzNxuJkCqR6cYXQo63m1Toqg6Y1T2kHPIHjEch6KBKig5kjPwhK1zjIj18UW7y3B
         JdJU216hfUN6V4JOATJYIbX6fwYpb1obcwHk2m7yqtmEw9eo8ybwiZsLNg9gv0E5ezoi
         oG2nkZoBHyx8C/2uDXgArujEhgFq4Y7ZygeotFKMtKQe1cDZbYnKuQYecA2j++InjAvI
         VPk5P6Z6y2FrgUc4t4f8gGmMbEVawektivyUV7qwPjrN9pP+v1QmwvGaxfNApYFb+3d4
         K4uJq/znT/eGPf9AgHQsHbazTnFYg4PnaN7FjlIO+ar2d0P0wgI/+R1YxwAlmBl+oQlB
         y5bw==
Received: by 10.220.225.194 with SMTP id it2mr12021864vcb.32.1345514033740;
 Mon, 20 Aug 2012 18:53:53 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Mon, 20 Aug 2012 18:53:53 -0700 (PDT)
In-Reply-To: <7v628dght9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203914>

On Mon, Aug 20, 2012 at 6:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> On Mon, Aug 20, 2012 at 10:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> John Arthorne <arthorne.eclipse@gmail.com> writes:
>>>
>>>> For all the details see this bugzilla, particularly comment #59 where we
>>>> finally narrowed this down:
>>>>
>>>> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150
>>>
>>> What does "at the system level" in your "does *not* work at the
>>> system level." exactly mean?
>>
>> "git config --system receive.denynonfastforwards true" is not honored.
>>  At all.  (And I checked there was nothing overriding it).
>>
>> "--global" does work (is honored).
>>
>> Tested on 1.7.11
>
> Thanks, and interesting.
>
> Does anybody recall if this is something we did on purpose?  After
> eyeballing the callchain starting from cmd_receive_pack() down to
> receive_pack_config(), nothing obvious jumps at me.
>
> Could this be caused by a chrooted environment not having
> /etc/gitconfig (now I am just speculating)?
>
> A quick "strace -f -o /tmp/tr git push ../neigh" seems to indicate
> that at least access() is called on "/etc/gitconfig" as I expect,
> which makes me think that near the beginning of git_config_early(),
> we would read from /etc/gitconfig if the file existed (I do not
> install any distro "git", so there is no /etc/gitconfig on my box).
>
> Puzzled.

Seems to work for me.  Force push was denied when
receive.denyNonFastForwards was set to true in system-level gitconfig.
 Tested with git installed in my home directory, so my system-level
gitconfig was at $HOME/etc/gitconfig.

Sitaram and John, are you sure you modified the correct file?  Also be
sure you're using the git-receive-pack that expects the system
gitconfig at the place that you think it is.

The system-level gitconfig is hard-coded in the git binary and may not
always be at /etc/gitconfig.  It is usually set to be relative to the
installation directory "$prefix" in the Makefile.  I don't think we
expose the path to the system-level gitconfig file anywhere in the ui.
 One way to figure out where it should be is to use 'git config' to
edit it like this:

   git config --system -e

Hopefully your editor exposes the path that it is editing even if you
don't have permission to modify it.

I'm thinking that the git-receive-pack binary that you guys used
expects the system gitconfig to be in a different location than the
one you modified.

-Brandon
