From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Normalise directory names when pushing to some WebDAV
 servers
Date: Thu, 18 Nov 2010 23:10:47 -0600
Message-ID: <20101119051047.GA4201@burratino>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
 <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel Corona <gabriel.corona@enst-bretagne.fr>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 06:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJJGA-0006VO-K3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 06:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab0KSFLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 00:11:37 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37802 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab0KSFLg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 00:11:36 -0500
Received: by yxf34 with SMTP id 34so2438584yxf.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 21:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pf25FQkF8ApKmYrWM4QNysNCc/a2e3i7Ld8/flAX/nA=;
        b=EDi9SUd9vOle8Y18zFoazCcVaHfpyXdegmJPlStYlawptYGlyA3Zex8Q8sxusYz3aB
         DzSb8kgIOLInj4HN3rQgFAWCRY5TOh4JbiassFxbWC5KSuKZIkbglfxUx9b3itLUuzue
         fmKbaiz2jmbLbXtlHcamRNs7RCLeOXGL2kNlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lhgNRFUksIB4QlUUyimAlwPrfvJGHtOT3I43aQZOCj9V9QOIvC+4cbYTfZvXG/K1EV
         VYKeyo2qf+bO5YYTJ+4lZaFB+RUCn50frtrsy4v9jHnkT+oVvlzfYTL0/07YxRm2JiQN
         xZO5o9jzG0Civr2iC65yNfN5/oWtdRB0jqsT0=
Received: by 10.150.158.6 with SMTP id g6mr2867053ybe.72.1290143495360;
        Thu, 18 Nov 2010 21:11:35 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k2sm2098850ybj.8.2010.11.18.21.11.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 21:11:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161724>

Tay Ray Chuan wrote:

> --- a/http-push.c
> +++ b/http-push.c
> @@ -1086,10 +1086,15 @@ static void process_ls_ref(struct remote_ls_ctx *ls)
>  static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  {
>         struct remote_ls_ctx *ls = (struct remote_ls_ctx *)ctx->userData;
> +       struct strbuf buf = STRBUF_INIT;
> 
>         if (tag_closed) {
>                 if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
>                         if (ls->dentry_flags & IS_DIR) {
> +                               end_url_with_slash(&buf, ls->dentry_name);
> +                               free(ls->dentry_name);
> +                               ls->dentry_name = strbuf_detach(&buf, NULL);
> +
>                                 if (ls->flags & PROCESS_DIRS) {

Nit: might make sense to narrow the scope of buf, to avoid tempting
people to reuse or release it.

Thanks,
Jonathan
