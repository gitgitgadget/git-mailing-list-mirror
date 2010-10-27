From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 12:31:32 -0500
Message-ID: <20101027173132.GA15657@burratino>
References: <20101027131506.4da06c6d@MonteCarlo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:31:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9qu-0004sF-7U
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab0J0Rbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:31:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60362 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab0J0Rbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 13:31:41 -0400
Received: by ewy7 with SMTP id 7so860770ewy.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ap//WjX00MF3lG6gBCMoBbR8I2SburEIwqBfsP4/EXQ=;
        b=x0AAxyyoz+9S6LW7K/M6OF9iNxPHWJRgqetDl5bzNvpDsTqtqjZoswMk/Z6aG68f/1
         MSpGGNiNvl9OlXZqJb5u2SR/9cNgfFoQTcl26KWCbbCNbdci7git/eyp3V7lp/WgleLw
         CRgAIdUYXQtv/WiVAcOCZqvMulGD6asis5J9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IhBrO+q1yD/nFrBNmXiMOcCsddbqToB1VmPOWL09huL8N3IA5/Ee9Bx06UXhSgGib1
         CIOixN/r2t/AreJ67A4sUxOdzQjFdwIRjVLc3cA39LwtKq1A/aDosmFiRPqtTFrWwXc8
         r1couQCNrWFVmjK/7E524LQRgGAZ/aaLUno/s=
Received: by 10.213.114.83 with SMTP id d19mr8678621ebq.46.1288200700508;
        Wed, 27 Oct 2010 10:31:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v20sm9296vbw.19.2010.10.27.10.31.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 10:31:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101027131506.4da06c6d@MonteCarlo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160106>

Hi Peter,

Peter van der Does wrote:

> The completion script does not work as expected under Bash 4.

Thanks for your work fixing this.  That's awesome.

It would be ideal if someone could write or find a nice summary of the
problem and the chosen solution, for inclusion in the commit message.

Could some zsh user perhaps test that the new zsh support is not
broken?

>  1 files changed, 355 insertions(+), 62 deletions(-)

Kind of unfortunate.  There are a lot of comments, but still...

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -76,12 +76,251 @@
>  #
>  #       git@vger.kernel.org
>  #
> +# Updated for Bash 4.0

I don't think this comment will be so important for posterity (e.g., once
bash 5 comes around ;-)).

[...]
> +# If the function _get_comp_words_by_ref does not exists, we can assume the
> +# bash_completion 1.2 script isn't loaded and therefor we're defining the
> +# necessary functions ourselves.

Probably this explanation belongs in the commit message?  A comment
could provide a brief reminder, like:

	if ! type _get_comp_words_by_ref &>/dev/null ; then
		# The bash_completion 1.2 library was not loaded,
		# so we have to define some functions from it ourselves.

Are the implementations taken from bash_completion?  If so, that would
be very useful information for the log message: future readers may
want to know where to look for a more recent version.

> +	# Assign variable one scope above the caller
[... I'm assuming this is all written correctly, etc ...]

> @@ -331,7 +570,8 @@ __gitcomp_1 ()
>  # generates completion reply with compgen
>  __gitcomp ()
>  {
> -	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local cur
> +	_get_comp_words_by_ref -n "=" cur
[...]

The rest looks sane.  Maybe it would make sense to split this into two
patches for readability:

 - one to introduce the _get_comp_words_by_ref function
 - one to use it

?
