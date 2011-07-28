From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Thu, 28 Jul 2011 09:38:05 +0200
Message-ID: <CABPQNSb_k8Ye1zaD6rJcfXPT1_pOU9NBG_Z7pFDgNqtUyL4GUQ@mail.gmail.com>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
 <7v8vrmrxok.fsf@alter.siamese.dyndns.org> <4E2FCAC4.7020408@drmicha.warpmail.net>
 <CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
 <4E2FE024.2030204@drmicha.warpmail.net> <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Reuben Thomas <rrt@sc3d.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Jul 28 09:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmLBD-0002bP-F9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 09:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1G1His convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 03:38:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50106 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab1G1Hiq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 03:38:46 -0400
Received: by pzk37 with SMTP id 37so4101384pzk.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=exU/hcZwq7TLY4VDzPHoev1ETrYjAZLxckLYwB3VHLs=;
        b=nvy9A2Eb79RH0u1I9S1Si8HGpj8iGO8/CG+1iE5a2k4TJNmjr8Hy54NrEFVf0RV/yl
         w6CvvA/gYNkG16LiLstMkO64m+xiKHkJnIieUSskLEzfOGa55hBmny+NqT8OIXop6eCr
         mS5Emsp0akAGZKmI2xcB8tzWbmgWuxjan/Yrg=
Received: by 10.68.12.133 with SMTP id y5mr1330470pbb.104.1311838726092; Thu,
 28 Jul 2011 00:38:46 -0700 (PDT)
Received: by 10.68.48.130 with HTTP; Thu, 28 Jul 2011 00:38:05 -0700 (PDT)
In-Reply-To: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178045>

On Wed, Jul 27, 2011 at 12:19 PM, John Szakmeister <john@szakmeister.ne=
t> wrote:
> On Wed, Jul 27, 2011 at 5:53 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> [snip]
>> I can't reproduce that name truncation with a current git, btw. (So =
I
>> won't bother bisecting where we removed a spurious offset by "prefix=
".)
>
> I can:
>
> :: git --version
> git version 1.7.6.347.g4db0d
> :: git init reproduce-bug
> Initialized empty Git repository in /Users/jszakmeister/tmp/reproduce=
-bug/.git/
> :: cd reproduce-bug
> :: echo foo > foo.txt
> :: mkdir bar
> :: echo bar bar/bar.txt
> bar bar/bar.txt
> :: git add .
> :: git commit -m '.'
> [master (root-commit) a5f76f1] .
> =A02 files changed, 2 insertions(+), 0 deletions(-)
> =A0create mode 100644 bar/bar.txt
> =A0create mode 100644 foo.txt
> :: cd bar
> :: git rm ../foo.txt
> rm 'foo.txt'
> :: git commit ../foo.txt
> error: pathspec 'txt' did not match any file(s) known to git.

What seems to happen here, is report_path_error gets called with a
pathspec that doesn't contain the prefix (which is "bar/"), yet it
tries to skip prefix_len characters ahead in it when reporting.

Why the pathspec isn't prefixed by "bar/" is because of the
normalize_path_copy-call in prefix_path, when called through
get_pathspec("bar/", {"../foo.txt", NULL}).
