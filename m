From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains spaces
Date: Sun, 29 Jul 2012 14:31:38 -0400
Message-ID: <CABURp0rM_zkA0Hb=kkJcEeqWBX0qgRqH-zviW8ofp-qQqkW6uw@mail.gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com> <500F00C7.4040209@web.de>
 <7va9yogb37.fsf@alter.siamese.dyndns.org> <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 20:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvYHe-0002GB-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 20:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab2G2ScA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 14:32:00 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33053 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2G2Sb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 14:31:59 -0400
Received: by qcro28 with SMTP id o28so2582349qcr.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i6wXzx1KdMHuyFiOScQa5+N4rzpoWrY1Vp9jm5DefMk=;
        b=v1ShuBbaFdeIoLpuERYaJv0/I2ATcdmmkOeV0X6FZl6OTXMtryfNfs3puapgz4Hddd
         JFxppG29iyMDJpf/JcOveQghMnHJaNFRRb/vFX5929ZD/9PqTxbcjmbzrGGHFs/fJXv1
         VnX4umY/oDB82At/Im4IWKa3Sd8sxgZG+AraW41mzyL/zpxCKVkChXFYVYiyuKrKFCA2
         pwiuXEu3uaJJKMEZFSiXLukVw+kJjLqUr2jS+duHxDMXTbotXu/4G1obeItOeQPHE+LP
         YeJyKGlkZNjJBEMewuCbPOShsHgqj/ef7Krr9x/TEcYWK9jXGpuBoDgrcgmU+ok8bYDr
         cyww==
Received: by 10.224.180.146 with SMTP id bu18mr19795210qab.10.1343586718875;
 Sun, 29 Jul 2012 11:31:58 -0700 (PDT)
Received: by 10.229.165.201 with HTTP; Sun, 29 Jul 2012 11:31:38 -0700 (PDT)
In-Reply-To: <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202488>

On Tue, Jul 24, 2012 at 4:33 PM, Justin Spahr-Summers
<justin.spahrsummers@gmail.com> wrote:
> On Tuesday, 24. July 2012 at 13:26, Junio C Hamano wrote:
>> Jens Lehmann <Jens.Lehmann@web.de (http://web.de)> writes:
>>
>> > Am 24.07.2012 21:01, schrieb Justin Spahr-Summers:
>> > > This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git-33) and 1.7.11.3.
>> > >
>> > > Steps:
>> > > 1. Create or clone a repository to an absolute path that contains spaces.
>> > > 2. Add a submodule to the repository, if it does not already have one.
>> > > 3. Within that submodule, attempt to add another submodule.
>> > >
>> > > The result is an error "fatal: Not a git repository", followed by the relative path to the submodule directory within .git/modules of the top-level repository.
>> > >
>> > > Similarly, using "git submodule update --init --recursive" in a freshly-cloned repository that matches the above configuration will fail with the same error. "git clone --recursive" does not seem to suffer from the same problem at clone time, but will still fail to add recursive submodules.
>> >
>> > Hmm, I don't understand how that is different from what t7407 does, it uses
>> > "git submodule update --init --recursive" in to populate recursive submodules
>> > in a freshly cloned repository whose path contains a space (in the trash
>> > directory name) in test number 8.
>>
>>
>>
>> I can see one codepath that would behave incorrectly, especially if
>> the submodule path relative to the superproject has whitespaces in
>> it. In module_clone(), you have:
>>
>> # We already are at the root of the work tree but cd_to_toplevel will
>> # resolve any symlinks that might be present in $PWD
>> a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
>> b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
>> ...
>> # Turn each leading "*/" component into "../"
>> rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
>> echo "gitdir: $rel/$a" >"$sm_path/.git"
>>
>> I _think_ $sm_path is computed correctly by the codeflow leading to
>> this place, and $b is also computed correctly, but notice the lack
>> of quoting around $b when you echo it? It will be split at $IFS, so
>> if b='/Program Files/My Stupidity/', the sed script will see a
>> single SP between My and Stupidity, which is different from what you
>> wanted to feed, I presume.
>>
>> Having said that, I do not think git-submodule is prepared to take
>> paths with path-unsafe characters in it, given that many part of it
>> has loops like "while read mode sha1 stage sm_path" that reads from
>> ls-files/ls-tree output without -z (which means it cannot handle
>> pathnames with LF in them).
>>
>> My recommendation at this point (i.e. not a long term) for people
>> with problems Justin saw is "Don't do it then".
>
> I appreciate the debugging work. Unfortunately, none of the relative submodule paths have had whitespace in them, so I'm not sure that's the issue.
>
> Here's some real output, with a couple specific names removed, starting from the root of the top-level repository (where External/twui is a submodule):
>
> $ cd External/twui
> $ git submodule add git://github.com/petejkim/expecta.git TwUITests/expecta
> Cloning into 'TwUITests/expecta'...
> remote: Counting objects: 988, done.
> remote: Compressing objects: 100% (404/404), done.
> remote: Total 988 (delta 680), reused 842 (delta 535)
> Receiving objects: 100% (988/988), 156.30 KiB, done.
> Resolving deltas: 100% (680/680), done.
> fatal: Not a git repository: ../../../../../../../../Volumes/drive name with spaces/Users/justin/Documents/Programming/project name with spaces/.git/modules/External/twui/modules/TwUITests/expecta

I saw something similar before but I was unable to reproduce the
conditions.  In my case, my superproject was cloned with an earlier
version of git and some new submodule behaviors seemed to cause me
problems.

Is "project name with spaces" a freshly cloned project also using,
say, 1.7.11.3?

I am not able to reproduce the problem here on Linux using your same
example command.

Phil
