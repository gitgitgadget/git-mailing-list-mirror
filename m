From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 17 Jun 2008 11:24:53 +0100
Message-ID: <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 12:25:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8YNp-0004b2-Mc
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 12:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbYFQKYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 06:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYFQKYz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 06:24:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:24730 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYFQKYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 06:24:54 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4664528waf.23
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yvxapZSxcc35p1eBbeWmTBdtqzXJNjt1tyCYEJaNWg0=;
        b=iQEsvJ38fx5CBqKRYuGmblMM7lDXGirY18UpvKFifMzSQkn3hnBOF39U4WxfqfGeno
         eA/6UtIB8tF3M3I/E26hE1Cv6XTOM6eg/+C5X/ITFbWQpB6YaxpmLmajYltLvAZCLee6
         w7yvwza8TcWgceVmCOIqG6ge/xDE1e5zn7Dqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Uvg/xQtuKWhiSMvyAtGokTJ7lPVUfkZo496vJySap3EUTEZSO/GQT2oEh5bBIRuh79
         MvLOCXcc6ob3mC5hPLOVK7hnJ45fsu/LfE3YdEhgyNtHqJXNIr+124gyEwvhlf0u5TXz
         2askw04Iib/Crz4L6ZBCv52D9v7GCV8XXJ4ZU=
Received: by 10.114.26.18 with SMTP id 18mr7550083waz.162.1213698293354;
        Tue, 17 Jun 2008 03:24:53 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 17 Jun 2008 03:24:53 -0700 (PDT)
In-Reply-To: <20080612053424.23549.64457.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85285>

Hi Karl,

There are some comments below but I think I haven't fully understood th=
is.

2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
> Create a log branch (called <branchname>.stgit) for each StGit branch=
,
> and write to it whenever the stack is modified.
>
> Commands using the new infrastructure write to the log when they
> commit a transaction. Commands using the old infrastructure get a log
> entry write written for them when they exit, unless they explicitly
> ask for this not to happen.

I was more thinking for this to be the default for backwards API compat=
ibility.

>  class _Directory(object):
> -    def __init__(self, needs_current_series =3D True):
> +    def __init__(self, needs_current_series =3D True, log =3D True):

i.e. we make log =3D False here by default.

> --- /dev/null
> +++ b/stgit/lib/log.py
> @@ -0,0 +1,254 @@
> +r"""This module contains functions and classes for manipulating

Why does this start with an 'r'? I thought this is for regular expressi=
ons.

> +A stack log is a git branch. Each commit contains the complete state
> +of the stack at the moment it was written; the most recent commit ha=
s
> +the most recent state.
> +
> +For a branch C{I{foo}}, the stack log is stored in C{I{foo}.stgit}.

The main question. Is this history preserved after a git-gc?

> +Tree
> +----
> +
> +The top-level tree object has the following entries:
> +
> +  - C{version}: a blob containing the string "C{5\n}".
> +
> +  - C{head}: a blob containing the ASCII hex sha1 of the current HEA=
D,
> +    followed by a newline.
> +
> +  - C{applied}, C{unapplied}: blobs containing one line for each
> +    applied or unapplied patch, in order. Each line consists of
> +
> +      - the ASCII hex sha1 of the patch's commit object,
> +
> +      - a space, and
> +
> +      - the patch's name.
> +
> +  - C{patches}: a tree containing one subtree for each patch, named
> +    after that patch. Each such subtree contains:
> +
> +      - C{a}, C{b}: the patch's I{bottom} and I{top} trees.
> +
> +      - C{info}: a blob containing::
> +
> +          Author: <author name and e-mail>
> +          Date: <patch timestamp>
> +
> +          <commit message>

I might not fully understand this but can we not store just the commit
object if the patch, which would have the bottom/top information.

> +Simplified log
> +--------------
> +
> +The simplified log looks exactly like the normal, or I{full}, log,
> +except for the following:
> +
> +  - Instead of having a tree per patch in the C{patches} subtree, it
> +    has a blob per patch. This blob contains::
> +
> +      Bottom: <sha1 of patch's bottom tree>
> +      Top:    <sha1 of patch's top tree>
> +      Author: <author name and e-mail>
> +      Date:   <patch timestamp>

Can we not point to the original commit corresponding to the patch? It
already has this information.

> +
> +      <commit message>
> +
> +      ---
> +
> +      <patch's diff>

What is the patch's diff here? Cannot it be determined from the trees?

> +The simplified log contains no information not in the full log; its
> +purpose is ease of visualization."""

Ah, OK. But I think it would be more useful to see the diff between
subsequent revisions of a stack rather than the full patch diff.

Thanks.

--=20
Catalin
