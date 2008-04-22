From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Have tests and programs understand paths containing spaces
Date: Wed, 23 Apr 2008 03:07:38 +0400
Message-ID: <20080422230738.GD26950@dpotapov.dyndns.org>
References: <20080422212801.GB20417@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:08:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoRbZ-0007bz-SG
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 01:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbYDVXHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 19:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762429AbYDVXHw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 19:07:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33853 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932947AbYDVXHp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 19:07:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so922028nfb.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=+ty29AT1x4mLuOCRUDu4B7pcC6mkKQAsh67Z51ZKlKc=;
        b=Zxprujae6rsdrI0k4nqL37IiAfDcgCd37Ip/Qdxhe4RcTCt+jbOFqDJuQsFTkpJTJKsx39BwmyJ21c9xb3Ib8vVUYIZDIEMM13XPA1JDsln/6/1ZQWYx9eZWAA0hQXaUAoeMatQxWhZIKWbridDfW4vapQ8prEtLwpJZRyJXiwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GZ7SIOBnkmyTp2fbgNZ/b4F7+KvYtFSWWjxNnkhJJHYVEtCfLw8eUVhNzNA/MQuN+C83UnTAqmAkYbjGj2kKOlAQ8H5BMaE4zMpgKy9x4YJJ+auzpZ9uo4jGPDCYHARunsCPtb24qm1SNOq2Y1SVjxuGq+M5HF/hpCxgIrZ21oY=
Received: by 10.78.193.5 with SMTP id q5mr79927huf.59.1208905662778;
        Tue, 22 Apr 2008 16:07:42 -0700 (PDT)
Received: from localhost ( [85.140.171.25])
        by mx.google.com with ESMTPS id 1sm8836884nfv.3.2008.04.22.16.07.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 16:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080422212801.GB20417@regex.yaph.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80170>

On Tue, Apr 22, 2008 at 11:28:01PM +0200, Arjen Laarhoven wrote:
> 
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 129ff57..2d04d4f 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -55,7 +55,7 @@ void launch_editor(const char *path, struct strbuf *buffer, const char *const *e
>  		strbuf_init(&arg0, 0);
>  		if (strcspn(editor, "$ \t'") != len) {
>  			/* there are specials */
> -			strbuf_addf(&arg0, "%s \"$@\"", editor);
> +			strbuf_addf(&arg0, "'%s' \"$@\"", editor);

This change has been already discussed on the mail, and I believe it
was ultimately rejected, because it will break things for people using
something like that: GIT_EDITOR='emacs -nw'. If you have spaces in the
path to your editor, you should quote in the definition of the editor:

git config core.editor '"c:/Program Files/What/Ever.exe"'

Thus, by putting extra quotes will break things for people who uses some
their favorite editor with extra options and for those who already use an
editor from c:/Program Files on Windows.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9e568bf..40a521a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -512,7 +512,7 @@ EOT
>  	close(C);
>  
>  	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
> -	system('sh', '-c', '$0 $@', $editor, $compose_filename);
> +	system('sh', '-c', '"$0" $@', $editor, $compose_filename);

See above.

>  
>  	open(C2,">",$compose_filename . ".final")
>  		or die "Failed to open $compose_filename.final : " . $!;
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index a44b1c7..a8a024b 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -73,7 +73,7 @@ git_editor() {
>  		exit 1
>  		;;
>  	esac
> -	eval "${GIT_EDITOR:=vi}" '"$@"'
> +	eval '"${GIT_EDITOR:=vi}"' '"$@"'

See above.


Dmitry
