From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 23:07:21 +0200
Message-ID: <201004122307.22836.jnareb@gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com> <201004121902.08345.jnareb@gmail.com> <7vvdbwk004.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 23:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1QrK-0000oG-1S
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 23:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab0DLVHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 17:07:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:5506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0DLVHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 17:07:48 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1166143fge.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZKFAnp/quuNWxVzdBKd4EU3+rGfB8VVVoVG53G86KfQ=;
        b=Bzq+1vAAUHWHYtmeGeLmu+LIksOj+wTm9XvuQ+P6l880mQh8ywEbgN5OXXRTblGOfr
         DOJaJVrgOua2goX4pwpfoYl0FyeCB6Wd9KITSyyGJ2HzRUAT0juevG7jCtzPRM9pf1BC
         WP2iODJDMT+8ct4E6IC3MVUG/AnNIBW3a0vuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=llAs80EG1u2vnbp3eNDiK5jdsLcCsk4SPxUOupWGxiUhUtK8OxtR6Dy4QxjPult1Vv
         q2U2WxNBY4Uxc2vJNg/abtjkbJXoQkUwRZL+YfjJ8hX4sSksaO25XzAkth6GkzkBwrvm
         FjqEphZZND91Ief9WPeRTyiDlOhBDZ0Yc3dUI=
Received: by 10.223.68.13 with SMTP id t13mr2871067fai.69.1271106450214;
        Mon, 12 Apr 2010 14:07:30 -0700 (PDT)
Received: from [192.168.1.13] (abvy192.neoplus.adsl.tpnet.pl [83.8.222.192])
        by mx.google.com with ESMTPS id 19sm565369fkr.9.2010.04.12.14.07.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 14:07:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdbwk004.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144768>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Jakub Narebski <jnareb@gmail.com> writes:
> >> 
> >> > How does special case of no value, i.e.
> >> >
> >> >    [sendemail]
> >> >         smtpuser
> >> 
> >> That is not a special case; that is "boolean true".
> >
> > Well, it is "boolean true" *if* git-config is used with '--bool'.
> >
> > If git-send-email.perl used "git config -l -z" to read all its config 
> > variables at once into hash, like gitweb.perl does in the 
> > git_parse_project_config() subroutine, it would be able to distinguish 
> > between those the case of no value:
> >
> >     [sendemail]
> >          smtpuser
> 
> If sendemail is ever re-written in C and use git_config() API, the above
> will become boolean.

Isn't this only for git_config_bool and the like... oh, I see that
git_config_string does not consider no value case proper string value,
and warns that it is suitable only for boolean variables:

   if (!value)
                return config_error_nonbool(var);

> Besides, even if you are sticking to sendemail.perl 
> forever, you are still inventing another convention that "boolean true
> means no I don't want it".  And it is clearly a lot less intuitive than
> "empty means no I don't want it", isn't it?

True, after thinking a bit about this using no value to unset is 
a horrible, horrible hack.  git-send-email should be corrected to not
only check that there is value from config or command line option, but
also that it is sane (i.e. non-empty, or simply true-ish if we say
that smtpuser = "0" is not something we need to worry about supporting).


About ORIGINAL problem: I think it can be done by setting different
identities, and just switching them using sendemail.identity; for some
of those identities sendemail.<identity>.smtpuser can be not set.

-- 
Jakub Narebski
Poland
