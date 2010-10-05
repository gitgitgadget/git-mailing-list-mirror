From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/18] builtin/notes.c: Split notes ref DWIMmery into a
 separate function
Date: Tue, 5 Oct 2010 10:50:53 -0500
Message-ID: <20101005155053.GH12797@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-8-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39qR-0000l8-JR
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0JEPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:54:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39770 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab0JEPyR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 11:54:17 -0400
Received: by fxm4 with SMTP id 4so505066fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CL6DJzZF3ZMAvRwZRn7Z7sR46F2ClTQPFkw/YlkGr5M=;
        b=rqPjsv1OAG6/fju4IbWb8QHhTn/tIsaF4/FXL9AaPLeGqOTwUGTQ+ZTvZ3Ne+xSXSl
         1GzMaOKBKpkwhUlo+2KiqOgvkg9nIVN0TQYALa7Nuf7oQASrjV88c8zT9yMCmEqdFWXk
         s4RgPONeqjTnpEiPUZ844ebmTyVgQTNdGvpxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L+YiXg6sp0CAtXKy4DWXyH89XODlsl/E9hpm0O71W1w7DgQvGM3TfBld/sNJ/xESO8
         6UIFE9yPWy11dTYtQ2Rmu0CPM3FLhvdOkg2O9qVEGjBgNcOBCN0CYDn4OyLW6+ZUdeKq
         yTEbGE3631nuSoJYrGgSInlhZN6+OHL/RzBtw=
Received: by 10.223.125.148 with SMTP id y20mr11035432far.94.1286294054043;
        Tue, 05 Oct 2010 08:54:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b9sm2966624faq.31.2010.10.05.08.54.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 08:54:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-8-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158210>

Johan Herland wrote:

> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -83,6 +83,16 @@ struct msg_arg {
>  	struct strbuf buf;
>  };
>  
> +static void expand_notes_ref(struct strbuf *sb)
> +{
> +	if (!prefixcmp(sb->buf, "refs/notes/"))
> +		return; /* we're happy */
> +	else if (!prefixcmp(sb->buf, "notes/"))
> +		strbuf_insert(sb, 0, "refs/", 5);
> +	else
> +		strbuf_insert(sb, 0, "refs/notes/", 11);
> +}

Aside: I'm not sure this is the most convenient rule to use after all.

Example:

 $ git log --notes-ref=charon/notes/full
 fatal: unrecognized argument: --notes-ref=charon/notes/full
 $ git log --show-notes=charon/notes/full
 warning: notes ref refs/notes/charon/notes/full is invalid
...
 $ git log --show-notes=remotes/charon/notes/full
 warning: notes ref refs/notes/remotes/charon/notes/full is invalid
...
 $ git log --show-notes=refs/remotes/charon/notes/full -1
 commit 16461e8e5fc5b2dbe9176b9a8313c395e1e07304
 Merge: c3e5a06 79bd09f
 Author: Junio C Hamano <gitster@pobox.com>
 Date:   Thu Sep 30 16:02:27 2010 -0700
 
     Merge branch 'il/remote-fd-ext' into pu
     
     * il/remote-fd-ext:
       fixup! git-remote-fd
 
 Notes (remotes/charon/notes/full):
     Pu-Overview:
         What's cooking in git.git (Sep 2010, #07; Wed, 29)
 $

And now that I think of it, the revision args parser uses its own code
for this...

Regardless, this patch is a step in the right direction imho.
