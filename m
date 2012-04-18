From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Wed, 18 Apr 2012 14:28:18 -0400
Message-ID: <CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
	<CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
	<7vsjg1knwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKZc7-0006jQ-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 20:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab2DRS2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 14:28:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36909 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2DRS2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 14:28:18 -0400
Received: by yenl12 with SMTP id l12so3886406yen.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=USpYrAmdtZKBA3eB0WRT8f9Ge3GfJa24w4qV1+2ySD4=;
        b=tOfMNMuSl6t7/lSNU29T5Q/qlWTGmPSX9aphA1BxDjZKczSuo7zIqeW+VKMGTj2OTM
         7xetghxqqBTDKKxgwfnOOqg6EouWuW28778Rw70LT1z3i7zUGCsBekE9+wTmkMc3EGr8
         J2G4oMN99xw9jyuifNSQTgOVpD4ORu+xeYmHktEr8wwsIAGgp6KpVqH6fxnpZcrKj2g/
         Op6i93voc3EhChJxTenhaGfPC8GIgmX6WJ1b5KlOkcxoSdPEP5w+TarXObS6Vn5w5RwI
         EpV1IlKrWlMQ2xDCzT09u8WgOVSHIxPt6W93D0rP5az54QPpnvQX5fXo0F4V9OFAupjc
         gZOA==
Received: by 10.50.186.132 with SMTP id fk4mr14314502igc.23.1334773698204;
 Wed, 18 Apr 2012 11:28:18 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 18 Apr 2012 11:28:18 -0700 (PDT)
In-Reply-To: <7vsjg1knwr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195879>

On Wed, Apr 18, 2012 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> So now we must decide how to handle deal with this use case. =C2=A0I=
t seems
>> there are two options:
>>
>> 1) Append '--no-renames' to the end of the 'git diff --raw' argument
>> list. =C2=A0This will override any '-C' or '-M' settings. =C2=A0This=
 is a simple
>> solution, but it loses some information about copies and renames.
>
> Or not use Porcelain "git diff", but use the plumbing "git diff-index=
" or
> "git diff-files" so that you won't get bitten by such end user settin=
gs.

Looking back on it now, I agree that it would have been better to use
the plumbing commands from the beginning.  Changing from the porcelain
to the plumbing commands will require new logic to parse the diff
options to figure out which of 'diff-index', 'diff-files' or
'diff-tree' should be called.  We may also want to add support for
some specific standard diff options (like '-R').

=46or now, would you object to an updated patch that simply detects and
ignores options that change the output of 'git diff --raw'?  Or do you
think that we need to switch to the plumbing commands before the
directory diff feature can be called stable?

I was planning to look for the following:
    --find-renames (and -M)
    --find-copies (and -C)
    --cc (and -c)

If any of the above are detected, 'difftool' would print a warning
that the option is not supported and then prune it from the arguments
passed to 'git diff --raw'.


> In either case, this "feature", by feeding two entire trees to an ext=
ernal
> program, makes it the responsibility of that external program to matc=
h up
> files in these two trees, so we shouldn't be doing rename detection
> ourselves at all.

I agree that we should not try to do it in the 'difftool' command.
Unfortunately, it appears that none of the external tools can detect
renames or copies.
