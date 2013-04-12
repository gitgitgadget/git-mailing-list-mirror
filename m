From: Evan Priestley <epriestley@epriestley.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 07:45:56 -0700
Message-ID: <D960D402-22EA-4C2B-BFDD-9BE512C88D97@epriestley.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 16:46:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQfEs-0008W1-IU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 16:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3DLOqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 10:46:00 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58715 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3DLOp7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 10:45:59 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so1455985pdd.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 07:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer:x-gm-message-state;
        bh=VOju0P4Pmtd1OJRSiWrqwX9fFSc9g57vZQfznV616AQ=;
        b=nSSTYfurS6woGshZh+iuac8alDbwCYkuOXgx5OGsm/KQYwYl3Bi7Qds5By1/XOc2oY
         Ct4BzhOl3ZfkYpgalcVXtY7uMdV8L1Bw6aGyAmwF+Eo7f36izyc0rjyM5/ou7llKO6vK
         J/4Zon53RK3TIIk+mTynLkMXmLbBWQBpfSCUw1XAnypqNVY+Gvd9jUeUC/bKvBWzd6BT
         3CHLSDjKtpU3Iv/JsLOmZtP0s6Km5Kz56saFp5fR9gsxbzV5u69si1BbRNp3hdHGuwVc
         CcKBhZkYHxPPGu8kYRyRlnOF5WdSQvnHnEtp/EuXoeXrTdT19x8WVe+fMCWY2+agVzvH
         RgAg==
X-Received: by 10.68.172.5 with SMTP id ay5mr15286256pbc.73.1365777959303;
        Fri, 12 Apr 2013 07:45:59 -0700 (PDT)
Received: from [10.0.1.8] (c-67-174-199-97.hsd1.ca.comcast.net. [67.174.199.97])
        by mx.google.com with ESMTPS id kd7sm8812161pbb.34.2013.04.12.07.45.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 07:45:58 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
X-Gm-Message-State: ALoCoQk+OW9RVaVP2Q/IJ+tlFNvZQief1wF5mEzApiYhtpnZWBFIdCz5m1whyjQKTbLbnTt5ylrK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220982>

Jonathan Nieder <jrnie...@gmail.com> wrote:

> I'm not sure whether to keep 96b9e0e (config: treat user and xdg
> config permission problem as errors) in the long run, BTW.
>=20
> Insights welcome.

=46or what it's worth, here's an anecdote about this:

I work on some open source software which includes a web-based reposito=
ry browser for Git, somewhat similar to gitweb. We implement this parti=
ally by executing `git` commands from the webserver (usually Apache). F=
or example, we run `git cat-file =85` to retrieve file content to show =
to the user.

After this change, a number of users who manage installs of the softwar=
e are hitting "fatal: unable to access '/root/.config/git/config': Perm=
ission denied" while browsing repositories, because their Apache runs a=
s some unprivileged user (like "apache" or "www-data") but with HOME=3D=
/root. We've seen about half a dozen reports of this now, so I believe =
this sort of setup is at least somewhat common and not just a bizarre o=
ne-off user with a broken environment. Users generally have difficulty =
resolving this error on their own, as it's not obvious that this boils =
down to an Apache environmental issue.

We'll likely resolve this by running `HOME=3D/ git ...` instead of `git=
 ...` when we execute commands (or some more finessed version of that, =
but basically pointing HOME at some dummy readable directory). From cur=
sory investigation, it appears we can't avoid this fatal with more surg=
ical settings like GIT_CONFIG or XDG_CONFIG_HOME, since git still ends =
up looking in HOME and fataling anyway. This fix is a bit clunky, but n=
ot really a big deal.

I imagine our use case is fairly unusual, but I wanted to relate it in =
case it's helpful in balancing concerns here. If I've missed a more rea=
sonable approach to solving this than redirecting HOME, please let me k=
now, but it looks like that's more or less what the git-daemon patch is=
 doing too.

Thanks,
Evan Priestley
