From: Mikael Magnusson <mikachu@gmail.com>
Subject: "git foo_bar" prints two config errors
Date: Thu, 30 Oct 2014 14:00:32 +0100
Message-ID: <CAHYJk3Rf0rXd1=1+7n-PNABQ77MbKphr8T-nLgwdKNUW_iKo2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 14:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjpLC-00015O-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 14:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629AbaJ3NAe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2014 09:00:34 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:46970 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759379AbaJ3NAd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 09:00:33 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so3242080igd.8
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=R6Np7REUNeSUwld6WwTeXW/Zm1UpE46RUW+OeSkk0i0=;
        b=Y3/e0xSpwYB9t3muD1t5AhBaOuI4O4BjfkUWHU+BxErElSb4OFCbUeQOqxxO39Ei5W
         l7lT5/vuqgvSHXKrShEMeaqMtCOHMTivuyHIIEKJ6cZob/FmiFIcM1/YN/1VzVPwT/V7
         wqnL4VrIsbkqmG7O0GlnnJNGsAsw5rLLFC70rFqWpT8ilBNLsyq7DyXBkeO3se8frJP3
         dCmVDcp/NfyI5xZp04mugxhnuGFJ44/9tz58lc+eeipuaT5nrq+GOUXxsGwUjUcjhFPB
         pOroR1fQnTwA+f2H1kVRrIcD25PyMHsb6FpXOcXgNLcbNsnfFQ/oaTyZEQEvYsFPN7UP
         FTIA==
X-Received: by 10.43.144.131 with SMTP id jq3mr9171801icc.66.1414674032074;
 Thu, 30 Oct 2014 06:00:32 -0700 (PDT)
Received: by 10.50.132.165 with HTTP; Thu, 30 Oct 2014 06:00:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

% git foo_bar
error: invalid key: pager.foo_bar
error: invalid key: alias.foo_bar
git: 'foo_bar' is not a git command. See 'git --help'.

git.c calls alias_lookup() and check_pager_config() resulting in calls
to git_config_parse_key() with the above keys. I looked at the code
and it's not immediately obvious how to suppress the error in this
particular case. You also get an error for the empty argument and
anything that isn't (isalnum || '-') (I discovered the _ case by
accidentally leaving out the 'grep' before searching for a function),

% git ''; git =E3=81=AE
error: key does not contain variable name: pager.
error: key does not contain variable name: alias.
git: '' is not a git command. See 'git --help'.
error: invalid key: pager.=E3=81=AE
error: invalid key: alias.=E3=81=AE
git: '=E3=81=AE' is not a git command. See 'git --help'.

but,
% ln -s /bin/tty ~/bin/git-=E3=81=AE; ln -s /bin/tty ~/bin/git-foo_bar
% git =E3=81=AE
error: invalid key: pager.=E3=81=AE
/dev/pts/51
% git foo_bar
error: invalid key: pager.foo_bar
/dev/pts/51

The command itself is accepted, so I think we shouldn't print the error=
s.

--=20
Mikael Magnusson
