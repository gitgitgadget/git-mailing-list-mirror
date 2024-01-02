Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8315EBE
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="nkOP/xjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=akkIEVf/5ZbBuPCjXKYnyowwNMfqxyjUFolP99ksYcc=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=nkOP/xjO1Fb0qnnzFly23G5gF6k0cTkAl+C81Wh7z4EIrNXszvUFYfQEz66y9dCCNcnJW6TlHnTP
        bC1PbdrIpPQRq/+D+Q5/37/GvIWl+QoKHUQmQsH4tSZZFiEuO6+z+l4PyHuTwnXwTDZCFf79TFAu
        2mAhft9bGEknuKNRG7s=
Received: by smtp-relay.sendinblue.com with ESMTP id 9e180f50-4bf4-4822-9b02-2a1b50114e09; Tue, 02 January 2024 19:57:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  2 Jan 2024 10:57:38 -0900
Subject: [RFC PATCH 0/6] completion: improvements for git-bisect
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 2E670520261; Tue,  2 Jan 2024 10:57:50 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: Sjxt7Hhx5toORZLomH28K3bmc9ARZm4TOdPMpgjyip83WMzFBh0jMKDtTK0k8UWC_JSJMBbFD_dpqLVGuCFk0bh-iJhyj99CtLHs1jj7E5YlrMnd0YU0sBSrOjQ1_ZYublKTCf2Tv61kbAKFtYUWwO47vy-RX1MDFk8eZdSQfqIM
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Bring completion for bisect up to date with current features.

This is RFC mainly because of an implementation issue in patch 2: I think
the mechanism of requiring COMPREPLY to be empty, possibly writing into it,=

then checking it post-call is too fragile, but I'm not sure how people =
would
like to fix this.  I'd prefer to just add an assert() of some sort to =
enforce
the empty-COMPREPLY precondition, rather than rewrite the guts of the =
former
=5Fgit=5Flog() function to use some other intermediate return mechanism =
(this
would be overkill in this simple context IMO).  But I'm not sure how to
do that in a completion context: for sure nothing that is done here should
ever have a chance of showing garbage on a user's screen, but of course =
for
assert() to be useful a dev would need to see it somehow.  Suggestions =
welcome.

Other than that issue I think it's all reasonable and ready, though there
are a couple other decisions that I guess people might disagree with:

  * good/old/new/bad terms are always completed (even if they're
    invalild because --term-(good|bad) have been used).  The idea here
    is that if the user has become confused about their own terms it's
    better to let git give them an error message than to have
    normally-working completion not happen.

  * 'view' is recognized as a subcommand, but not as a completion
    candidate.  This lets complete of git bisect v<TAB> keep working which
    seems convenient and some poor person somewhere probably really wants =
:)
    view is just an alias so loss of interface recall is minimal.

Britton Leo Kerin (6):
  completion: complete new old actions, start opts
  completion: git-log opts to bisect visualize
  completion: move to maintain define-before-use
  completion: custom git-bisect terms
  completion: recognize but do not complete 'view'
  completion: add comment

 contrib/completion/git-completion.bash | 310 +++++++++++++++----------
 1 file changed, 181 insertions(+), 129 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
--
2.43.0


