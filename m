From: Patrick Higgins <phiggins@google.com>
Subject: apply --cached --whitespace=fix now failing on items added with "add -N"
Date: Mon, 22 Jun 2015 08:29:49 -0600
Message-ID: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 16:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72jo-0001xC-Iu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbbFVOaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:30:11 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:32895 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbFVOaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 10:30:09 -0400
Received: by obpn3 with SMTP id n3so31189627obp.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=1I6KbT2iDjOkWgU92SGoLZQiPVSMivkkIW8bOAVsK80=;
        b=MZdSu5QDLiwH4rIQShP9BzzpV1D7nrNdUkb2oD87pc1qX6OBmBp5a5R3LHd23WqXrZ
         Bb9THVuGktRRs82UkQ74V2Aqc2iIOEDDu67D/06sPqkElz/1Ogqp2WdSIo5wf7mKXXO8
         yvh5bu+5UJs2C1mKDeiRCPn48LtfAi8x15Cvwmq3zL9PzNeulUSU+h+K9XZUXsw+bP19
         nCCY0z5d+c6/hKTzTwbpI3hls14s1Cjib806XVAojY34XWXcaZsvY9eu93WLHWdo6FY+
         iL6Gv8Cyk94RBrDgL21WYywiUmO53mvkcrLFOdOSLxS+4tKMyM9ht1J+9kSyDQGLPJaf
         S0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=1I6KbT2iDjOkWgU92SGoLZQiPVSMivkkIW8bOAVsK80=;
        b=bMD7zf5mEBFirGYiiZD71L6eahsU3PLDxzF2z+05aT+hPruIbwf3gaiOMmtK3qNP9o
         hZAaisM03DCPG3Q3hPW7z1c9SVTh2u1vWoNjHz5mgenMKAsJCQqJDEh0H8YYVC/fiytm
         S+uS50YBNqDCOz/MX2IhQFBQ9pHo49Fr+6SREV9JQR1kpVY6It9f2PDvDEfDSwi8i23o
         A/KkFzx2FHq63qXPLs76lATJssbM+sveSKR0jv9O9sNX/n5pJlwbhYBJEtDX7n7iiFpM
         Q6QFw5+TJ5sgq9k7SBUN5Ct7r1OijmSWYBQQr/JOPW8hXcnXfNEzmblEmlthOrJh+1q3
         yCIA==
X-Gm-Message-State: ALoCoQkesR923mlrnOLyj0KCorD2Vj6OU1Lh10gffSJjR5SdEE8qwy9+3XHiuz8eF0vIUV52F2IP
X-Received: by 10.182.60.103 with SMTP id g7mr19713739obr.70.1434983409268;
 Mon, 22 Jun 2015 07:30:09 -0700 (PDT)
Received: by 10.202.193.2 with HTTP; Mon, 22 Jun 2015 07:29:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272363>

I like to use git to remove trailing whitespace from my files. I use
the following ~/.gitconfig to make this convenient:

[alias]
        wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached
--whitespace=fix;\
                git checkout -- ${1-.} \"$@\"' -"

The wsadd alias doesn't work with new files, so I have to use "git add
-N" on them first. As of a week or two ago, the "apply --cached" step
now fails with the following, assuming a new file named bar containing
"foo " has been added with "add -N":

$ git diff -- "$@" | git apply --cached --whitespace=fix
<stdin>:7: trailing whitespace.
foo
error: bar: already exists in index

The final "git checkout" at the end of wsadd truncates my file. I've
changed the ";" to a "&&" to fix the truncation.

Were there any recent changes to "git apply" that might have caused this?

$ git --version
git version 2.4.3.573.g4eafbef
$ uname -a
Linux <redacted> 3.13.0-53-generic #89-Ubuntu SMP Wed May 20 10:34:39
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
