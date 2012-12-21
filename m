From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch
 master...branch" work?
Date: Fri, 21 Dec 2012 13:45:14 -0800
Message-ID: <CAPc5daWN_a0d2o37CkRk5n9bc4dy5_Zan22dN81waT=-+b7pVA@mail.gmail.com>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org> <CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com>
 <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com>
 <7vr4mj1g8j.fsf@alter.siamese.dyndns.org> <50D4BBDC.6030700@alum.mit.edu> <CANiSa6hcDHTpZnAXR3zxdv-H4r-yRjuSx_kgE5V1rSFk_pNhOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmAWW-0001de-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 22:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab2LUVwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:52:39 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:37164 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2LUVwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 16:52:37 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so5215464oag.31
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=jOeHG681pFzm76FiVqo8tfxxg1U3KSUvqer+OyheiE0=;
        b=yRh93XMvMQ5hfLqGNxo8m57rJsS4XB3Ol6Es/bDYZUuGuIooalqjC1tMbT5sR0l5cT
         f11SLzG0/23Qs9Jw85w92eoRHLaJL8idyMtXB8Iq7J7tU/VFan1oF9LLREOMcs8Hkj1M
         ahrfL2mEyFWzw7h6X3DbnrTwNwHROthAaugmzgxhouoNufeB+N8a9YHEAoIR/N53WQ96
         5f86XImIcpcsodGG9MhDWWCwv+N08nSIbPDmo9NAC/E7TyCGFwM8iNxZ5as3ruEgWEhj
         Zm0+BWqjFxxkS+LGG+hO4VSPSqjh2pwHExb7EDCvWCRUwbgdAMi6zejgjdVIAIdeSbnM
         +rTA==
Received: by 10.182.21.135 with SMTP id v7mr12336008obe.101.1356126334325;
 Fri, 21 Dec 2012 13:45:34 -0800 (PST)
Received: by 10.60.13.102 with HTTP; Fri, 21 Dec 2012 13:45:14 -0800 (PST)
In-Reply-To: <CANiSa6hcDHTpZnAXR3zxdv-H4r-yRjuSx_kgE5V1rSFk_pNhOA@mail.gmail.com>
X-Google-Sender-Auth: DeFUrz7SK5tD6WDqUHQWVbZu8Ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212013>

> Off topic: I also find it hard to wrap my head around what diffing
> against a negative revision would mean. Looking at the result of
> running it, it seems to be the same as diffing against a positive one.

That is not an off-topic at all, but is the crux of "diff A..B" being
a hysterical raisins.
It is parsed as and converted to "diff ^A B" by the revision command
line parser in
setup_revisions(), and the caller *guesses* what the command line
originally said by
inspecting that there are two revs in rev.pending[] array, the first
one is negative and
the second one is positive, to infer that the user typed "diff A..B"
and then finally
decides to compare A and B.

This was done before we introduced rev.cmdline_info to record what was
given from
the command line to result in the set of commits in rev.pending array.
If we were
writing "git diff" UI from scratch today, we wouldn't be looking at
rev.pending but
would be looking at rev.cmdline_info and we can differenciate between
"A B", "^A B",
and "A..B" (and reject the latter two as nonsense).
