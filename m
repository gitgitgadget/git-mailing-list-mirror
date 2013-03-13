From: David Aguilar <davvid@gmail.com>
Subject: Re: Suggestion for difftool behaviour during a merge conflict
Date: Wed, 13 Mar 2013 15:26:03 -0700
Message-ID: <CAJDDKr4OLmkPmXA9R3pMh0BksZcYJpfT-nRwwqkF+j6F-wLoBg@mail.gmail.com>
References: <CAFaJEqu8gHSLK5u7v5ZOaJ1XjAhV=F9p46MEo2sDVH4vpXAojA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFu82-0005Od-7n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934308Ab3CMW0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 18:26:05 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46862 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273Ab3CMW0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 18:26:04 -0400
Received: by mail-wg0-f43.google.com with SMTP id e12so1102373wge.34
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=7ye7JxCUKDf5ojp65em/9831Rai8bmKNvojztreim3w=;
        b=CnNExfaSCT4NHyH99ij1rjxt84Xy/OulL/e/yC3MMYXOb4p4m0iayXfz7L+yVNvucC
         MIgJD2Bu9ijQGMG//7PmN3RQEJ2kSJU/sBWJkAog7984R9sjcjzWp8E41s3vtchWOEv5
         dBAiP9Kr/8WbdntThnS9vDBG7m69sCFOHgBJDDfFoLTXCKlOSEWKASccizlfuiN9x2bV
         ftq6C390swToh/dj3t5WyiRWfvzlwdBXGIttCexrCeNj3mxehEm2I0ngF+9nhOCevhUq
         CfpXZJyVQedCtNg6tW3wIXeS0Y+SeE2Q0eZonQtZIfEKWQ4/cXkpvCvw+12ydLWt47HF
         RJAA==
X-Received: by 10.194.76.37 with SMTP id h5mr103422wjw.21.1363213563441; Wed,
 13 Mar 2013 15:26:03 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 13 Mar 2013 15:26:03 -0700 (PDT)
In-Reply-To: <CAFaJEqu8gHSLK5u7v5ZOaJ1XjAhV=F9p46MEo2sDVH4vpXAojA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218096>

On Wed, Mar 13, 2013 at 11:48 AM, =C3=98ystein Walle <oystwa@gmail.com>=
 wrote:
> When a merge is ongoing and there are conflicts, 'git difftool' will
> output the exact same --cc-style diff output as 'git diff' will witho=
ut
> further explanation. This has lead to some confusion: A couple of wee=
ks
> ago a person asked on #git why his difftool wasn't working. After a l=
ong
> while we realized difftool's behaviour after invocations such as 'git
> difftool HEAD~ HEAD' would work as expected but 'git difftool' "simpl=
y
> wouldn't".
>
> With that in mind I have three suggestions on improving 'git difftool=
':
>
>  - Show a three-way diff between the versions (local, remote, merge)
>    using the user's configured difftool. Diffing against the version
>    containing the markers will generate some extra noise in the difft=
ool
>    and might be confusing, but it's similar in behaviour to how 'git
>    difftool' normally works.
>
>  - Prompt the user if they want to launch 'git mergetool' instead sin=
ce
>    a merge is ongoing. Reasonable but it might be awkward if the user=
 is
>    asked whether the conflict was resolved or not when all they wante=
d
>    to do was to visually diff something.
>
>  - Add a notice to stderr saying that a --cc-style diff output is sho=
wn
>    instead; or document the behaviour in the man page. Definitely the
>    simplest option.
>
> I'm willing to try to take a stab at either of these but I wanted to
> bring it up first. There is of course an implicit fourth option which=
 is
> to do nothing, and that I'm wrong about this :)

Thanks for bringing this up.

I think the simplest first step would be to detect this state,
print a message saying that difftool cannot be used during a merge,
and suggest mergetool instead.

We would need to be careful to still allow difftool <ref> <ref>
and only trigger this behavior when the cc-style diff would be printed.

I have a feeling that this happens deep in git-diff.
git-difftool--helper is driven by git-diff via the
GIT_EXTERNAL_DIFF mechanism, and that mechanism is probably not
triggered when in this state, so we may need to add another
breadcrumb that we can build upon.

> Best regards,
> =C3=98ystein Walle

cheers,
--=20
David
