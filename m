From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG/TEST] show breakage of status for copy+conflict
Date: Thu, 5 Aug 2010 07:55:13 -0500
Message-ID: <20100805125513.GB23334@burratino>
References: <1280960393-17256-1-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 14:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh005-0004d4-E4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 14:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760317Ab0HEM4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 08:56:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52135 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760276Ab0HEM4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 08:56:33 -0400
Received: by iwn33 with SMTP id 33so176177iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sBmCKS9WzzsIBpnTeJg55kn9ewnUT+hJoNnbTyqLbJk=;
        b=mZ9oAy3DuaNVYiclLkrBTE7iMpWrBSr0fUfSDCKA7S6Mqys/nEXgHnTBziy6zSBDwK
         d1ZPhfp1ASU2JfPpW4KtsCKjtf72ENiVnNL97BVVMlm9etq6BYM15YOUBP77qiOFRcAy
         f1gjdLrHTpl0THWn51lid2MPdrPJT/jMoEuiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JiewyRHIfDLahS32uud8Brk5Ck+EYMQ8vkT9kgFRR3cQZYoRO1O3GWI99t6GfG3AEM
         T6IJWBqUoFpkzL2KJUh0ESZKxh09gjOBk03bqb/QrQgxO+mD3Gtih7JMDV+0WUwuQlii
         KXZPC2JMyqTCCmEg+f5Yjm9BvAoZmewCCScjc=
Received: by 10.231.59.13 with SMTP id j13mr12201046ibh.77.1281012992613;
        Thu, 05 Aug 2010 05:56:32 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm117835ibe.11.2010.08.05.05.56.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 05:56:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280960393-17256-1-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152653>

Will Palmer wrote:

> I noticed during a rebase that a conflicted file was not showing up
> under the "both changed:" line, and was instead showing up as the
> original name of a rename.
> This was because the file had conflicts, and so was not in the index
> (or at least, not in stage 0, if I have my terminology correct), whil=
e
> another, very similar (both based on the same template) file had been
> added as part of the same change on my side.

Hmm, so:

   3
  /
 1 --- 2


1: file A with content A

2: file A with content A',
        B with content A

3: file A with content A''

where the changes A->A' and A->A'' conflict.

And behind the scenes:

There is only one merge-base, so merge_recursive has nothing to
contribute.  It=E2=80=99s all merge_trees()=E2=80=99s bag;

merge_trees() does unpack_trees() before anything else, which could
care less about rename detection;

Then it tries get_renames(), which figures out what happened;

Then process_renames(), which realizes there is nothing to do to fix
this up and reports CONFLICT (content);

And "Automatic merge failed", without any more advice to describe what
happened.

Caller tries "git status".

$ git ls-files --stage --abbrev
100644 aed72d7 1        A
100644 0abac9e 2        A
100644 a5f0d50 3        A
100644 aed72d7 0        B
$ git diff-index --cached HEAD --abbrev
:100644 000000 aed72d7... 0000000... U  A
:000000 100644 0000000... aed72d7... A  B
$ git diff-index -M --cached HEAD --abbrev
:100644 100644 aed72d7... aed72d7... R100       A       B

"git status -s" prints the right output.  So wt_status_collect() seems
to have collected the right information somehow.

> I don't really have the time right now to look for exactly what cause=
s
> this bug, so I'm hoping that posting a demonstration of it will get
> someone else to fix it for me.

No ideas at the moment; sorry.

Jonathan
