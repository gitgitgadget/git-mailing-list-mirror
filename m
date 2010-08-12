From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Thu, 12 Aug 2010 20:26:09 +0000
Message-ID: <AANLkTikV-fye7qc5kQNC5dSCTHB6nYoVfCg_PeFuk0KT@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<vpqsk2kjks7.fsf@bauges.imag.fr>
	<AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeM8-00027p-4x
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab0HLU0L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:26:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47504 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab0HLU0K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:26:10 -0400
Received: by gxk23 with SMTP id 23so584615gxk.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MDEMXt4Ct8BUYafy2eesO49FfyLTxt6moqLkHVBz4C4=;
        b=Gc8lk/Ew21OiT0v0YUFLTZB19+8wFHv5iLr25HWe782UHd+MaeH0g4hARRE7Ks01vB
         Gf6S3FGw5Tl8ViG8WHEjlgVuFVCMfRoXvLFBYMEgNX+wFq8ApCcKfYqFtIAPbe4QuVSd
         0tqn5qb0UFs1NnaqOvlFfGsusaIdTUIG2h1Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uLdjFpqtoSDX6qoqL+7dIeXeliq55zmvOUAo6NNOPXyixR//rsQPjTS2XJMhheqhdV
         imvS2LD+/AWZZC88Us05tlv91Ddka9T/34RHYddgk8lw4y3jS/7dAKEEjZNTGytRAn/K
         w6iBvH0/o/PRIsXZqfiPuoepDnNWntzOE3oHQ=
Received: by 10.231.176.197 with SMTP id bf5mr347531ibb.175.1281644769518;
 Thu, 12 Aug 2010 13:26:09 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 13:26:09 -0700 (PDT)
In-Reply-To: <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153409>

On Thu, Aug 12, 2010 at 15:54, Greg Brockman <gdb@mit.edu> wrote:

> Secondly, I don't think this makes '-f' useless. =C2=A0'-f' would sti=
ll be
> used to initially add an untracked file to the index. =C2=A0So this w=
ould
> maintain an invariant that no ignored files are tracked unless the
> user has specified a '-f' for it in the past.

I initially misread what this series was about, and I was about to
withdraw my support for it. But this seems completely reasonable, and
actually I think Git's current behavior here is clearly a bug.

To elabore with examples this behavior here is fine, and I think
everyone agrees with that:

    aoeu tmp (160M) $ git init meh
    Initialized empty Git repository in /tmp/meh/.git/
    aoeu tmp (160M) $ cd !$
    cd meh
    aoeu meh (master) $ echo '*' > .gitignore
    aoeu meh (master) $ mkdir ignore-dir
    aoeu meh (master) $ echo ignore > ignore-dir/file
    aoeu meh (master) $ echo ignore > file
    aoeu meh (master) $ git add file ignore-dir
    The following paths are ignored by one of your .gitignore files:
    file
    ignore-dir
    Use -f if you really want to add them.
    fatal: no files added

Here I have * in .gitignore but I'm adding files with an explicit
path. Making this not ask for -f would be pretty bad, e.g. for the
glob reasons Junio cited.

So I have to -f it:

    aoeu meh (master) $ git add -f file ignore-dir
    aoeu meh (master) $ git commit -m"commiting ignored stuff"
    [master (root-commit) 6cae514] commiting ignored stuff
     2 files changed, 2 insertions(+), 0 deletions(-)
     create mode 100644 file
     create mode 100644 ignore-dir/file

However this part I think is a bug:

    aoeu meh (master) $ echo whee >> ignore-dir/file
    aoeu meh (master) $ echo whee >> file
    aoeu meh (master) $ git status --short
     M file
     M ignore-dir/file
    aoeu meh (master) $ git add file
    aoeu meh (master) $ git add ignore-dir/file
    The following paths are ignored by one of your .gitignore files:
    ignore-dir
    Use -f if you really want to add them.
    fatal: no files added
    $ git status --short
    M  file
     M ignore-dir/file

Here "file" is already tracked by Git and it doesn't complain when I
"git add" a update to it, but it complains about "ignore-dir/file"
just because it's in a subdirectory.

I hadn't noticed this before because I usually use "git add -u", which
doesn't complain about the ignore and happily updates the file in the
index:

    aoeu meh (master) $ git add -u
    aoeu meh (master) $ git status --short
    M  file
    M  ignore-dir/file

I think "git add ignore-dir/file" above should act exactly like "git
add file", and not force me to add a "-f" to "git add".
