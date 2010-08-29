From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/13] transport-helper: factor out
 push_update_refs_status
Date: Sun, 29 Aug 2010 16:36:18 -0500
Message-ID: <20100829213618.GD1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oppa7-0007Tk-2l
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab0H2ViK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 17:38:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57617 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0H2ViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 17:38:09 -0400
Received: by gxk23 with SMTP id 23so1751384gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h2DXLwJveHKM9zajmdtup2x7voHG/8An+2IE6DEy2vQ=;
        b=GmG5hv37bfVNkyzWDr+9uhlNc7X2leZGZIdtfmH2rzgtfCJM8ZwCICi5Utwj+5wyzv
         lHQuyOvTGHJ/AWduXMRvg9qRiVvXNWc/dEKQmmPAPaP1nfiSF8Zafai2/luGwpqu0oAx
         mJpleQwhH77XfB842YkoNJAldBBCMrFliS7Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FVBHpEW8eawxjFaA7rElka20Kjj/bqOjdTykmVn4R79S+NKORLhkBMwZmji9kAL4Il
         4qptCdEz17U/yDO5aPqLsz0k9Tepd0U8gumDXLItAJpXEEtqqXNUb9O/MKtoBsKCOiD1
         4Rlls2OECRoNDORQWW78QJuTMujIL77smBeTA=
Received: by 10.100.209.9 with SMTP id h9mr3514617ang.189.1283117888282;
        Sun, 29 Aug 2010 14:38:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h5sm11268444anb.28.2010.08.29.14.38.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 14:38:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-4-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154720>

Sverre Rabbelier wrote:

> +++ b/transport-helper.c
> @@ -554,6 +554,9 @@ static int fetch(struct transport *transport,
>  	return -1;
>  }
>  
> +static void push_update_refs_status(struct helper_data *data,
> +				       struct ref *remote_refs);
> +
>  static int push_refs_with_push(struct transport *transport,
>  		struct ref *remote_refs, int flags)
>  {
> @@ -609,8 +612,17 @@ static int push_refs_with_push(struct transport *transport,
[...]
> +static void push_update_refs_status(struct helper_data *data,
> +				    struct ref *remote_refs)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct ref *ref = remote_refs;
>  	while (1) {
>  		char *refname, *msg;
>  		int status;
> @@ -679,7 +691,7 @@ static int push_refs_with_push(struct transport *transport,
>  		ref->remote_status = msg;
>  	}

Hmm, I am not too happy with the long loop without explicit condition.
Maybe it would make sense to split out the loop body as its own function?
Something like

	struct ref *ref = remote_refs;
	for (;;) {
		recvline(data, &buf);
		if (!buf.len)
			break;

		push_update_ref_status(&buf, &ref, remote_refs);
	}

>  	strbuf_release(&buf);
> -	return 0;
> +	return;

Not necessary, I think.

>  }

Regardless, for what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a pleasant read.
