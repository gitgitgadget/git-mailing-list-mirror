From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2] rollback lock files on more signals than just SIGINT
Date: Wed, 4 Jun 2008 12:40:37 +0100
Message-ID: <e2b179460806040440m29f2326ek3757660646686623@mail.gmail.com>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
	 <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
	 <483EAD69.9090001@gnu.org>
	 <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
	 <483EBF1F.9000809@gnu.org>
	 <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
	 <E1K1jnV-0007HC-Om@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git mailing list" <git@vger.kernel.org>
To: "Paolo Bonzini" <bonzini@gnu.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 13:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3rN6-0006TG-Hv
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 13:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYFDLkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 07:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYFDLkq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 07:40:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:5257 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYFDLkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 07:40:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so36214ywe.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MvzyrM8VyVfJa+5uJ9cZZsAta3fiG5qVcX7rZ8ts8yI=;
        b=XFkAghaYxghveizTMuwl6x5liMS1FdOtglktS0twyl3XDkmq4SFvtge7S51BKhPBL4
         xnrscja18kz5DL0QbfRwxHiLgNpmGBg4iCsTnNJXj2KiqNI5DUAq5ZmM3fQicGbpZtsI
         IGRnn9xfEL1PmV0qdyesoh1t0pYVAYz/QlYjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MYXh7PcROAMNtPWYbY6SxbRwpT3hB7v6SVxqkYy6L4ju0znUNvjzfVFAmTkhshPJoV
         dyaykIoeEZq2GRUQlVOKUG9/HeD7XqJG+/jXTz0/xwBzMQ14zFz/w8ZMJGjq7pMcqTNM
         CUS+93EvzZq/ElWcZagHQ8l004uMbhfxthVwY=
Received: by 10.150.54.1 with SMTP id c1mr16659565yba.63.1212579638025;
        Wed, 04 Jun 2008 04:40:38 -0700 (PDT)
Received: by 10.70.110.16 with HTTP; Wed, 4 Jun 2008 04:40:37 -0700 (PDT)
In-Reply-To: <E1K1jnV-0007HC-Om@fencepost.gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83776>

2008/5/29 Paolo Bonzini <bonzini@gnu.org>:
>
> Other signals are also common, for example SIGTERM and SIGHUP.
> This patch modifies the lock file mechanism to catch more signals.
> It also modifies http-push.c which was missing SIGTERM.
>
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 3531a99..46ec1ce 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -212,4 +212,18 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
>        test "`cat .git/result`" = "editor not started"
>  '
>
> +pwd=`pwd`
> +cat > .git/FAKE_EDITOR << EOF
> +#! /bin/sh
> +# kill -TERM command added below.
> +EOF
> +
> +test_expect_success 'a SIGTERM should break locks' '
> +       echo >>negative &&
> +       sh -c '\''
> +         echo kill -TERM $$ >> .git/FAKE_EDITOR
> +         GIT_EDITOR=.git/FAKE_EDITOR exec git commit -a'\'' && exit 1  # should fail
> +       ! test -f .git/index.lock
> +'
> +
>  test_done

This addition to the testsuite breaks it on AIX with the default sh
(ksh). Replacing the explicit sh -c with $SHELL_PATH -c fixes it for
me (as I have SHELL_PATH pointing to bash). If that's acceptable I can
post a patch if necessary.

Happy to test any other suggested fixes.

Mike
