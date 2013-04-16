From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 14:50:15 +0530
Message-ID: <CALkWK0ndk7hPYk4pN8gmLxLOJR0XsLo1gwHB=n0QkK6DHgLzKQ@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <7vobdfztz9.fsf@alter.siamese.dyndns.org>
 <CALkWK0=cNEkE0bUoWJg119o+FaQywJhgkUxiFfLGPSsLrFVZ=A@mail.gmail.com>
 <7vr4ibu14j.fsf@alter.siamese.dyndns.org> <CALkWK0=6E=s6kJysMo2yC22c3pvCWn90S5neRyP0jpzpYrZboA@mail.gmail.com>
 <vpqli8je8w0.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:21:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US24T-0000u0-3c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab3DPJU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:20:56 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56145 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3DPJUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 05:20:55 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so208711iad.38
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Xt6V69ybIGA63SlMYbzDfGeWFomSK5cyOqlQjgI67As=;
        b=ahOw8ZhGVql9F5R18f46c6ptH7lx/ftp3IIh2acQ5AHUUBtUFe3Uag9E1sIEm3V8SD
         HhrdvGSPX997hLun7U5GS+1/lBOvTNgdJ7L+c5ZuYdVChy9qJf2jPy8IawH+Zvp6KYAG
         wuJ3wH0NNMFOmlRl/JLXGic1tuHvawGWyADDS9QQyMs7MIi+ouHJv4YWTY/xsFn2u0Xk
         MMceUELk2FUdjlNWzat6J9YMYJ4TXB6WPRMAhF3sk2DCJHqyEs81ggZ0SMmKfwt9DFh8
         mvhBsP/slCTj2TgLitvaHsb6qcIIdsvQSGW6idIqwCGc4syx8bSfzt9yBug5uPjktE5B
         Q9Tg==
X-Received: by 10.50.117.3 with SMTP id ka3mr6905809igb.107.1366104055367;
 Tue, 16 Apr 2013 02:20:55 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 02:20:15 -0700 (PDT)
In-Reply-To: <vpqli8je8w0.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221399>

Matthieu Moy wrote:
> Because "git rebase" needs multiple runs in case of conflicts. You have
> to store the information somewhere in the filesystem, not in a variable.
> What you need to store is whether you need to unstash, and where you are
> in the process (in Junio's version, you may be doing the actual rebase,
> or fixing conflicts in index state application, or fixing conflicts in
> tree state application, or done). Storing what you have to do and where
> you are in the process really sounds like a job for the instruction
> sheet, no?

No.  Ultimately, the entry point of all these invocations is
git-rebase.sh.  The plan is to refactor calls from git-rebase.sh to
git-rebase--*.sh scripts so that those scripts return control to
git-rebase.sh, which will be the final exit point.  The logic is very
simple: On the very first invocation of rebase (ie. no existing rebase
in progress), stash.  If the return statement from the specific rebase
script is 1 (which means that there are conflicts to be resolved),
exit as usual.  If it is 0 (which means that the rebase completely
successfully), pop the stash before exiting as usual.

What's so complicated about that?  I'm against leaking the autostash
implementation detail into specific rebases, because I value a clean
and pleasant implementation over everything else.
