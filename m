From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Fri, 27 Jan 2012 13:35:45 -0800 (PST)
Message-ID: <m3aa58eskw.fsf@localhost.localdomain>
References: <1327673954458-7229895.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ondra Medek <xmedeko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 22:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqtSa-0003Dv-AM
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 22:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab2A0Vfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 16:35:48 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62494 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab2A0Vfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 16:35:47 -0500
Received: by eekc14 with SMTP id c14so709000eek.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 13:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=U/U8Eq0NSuDWVeFUGKV6YGvVNoQrs0E+OeiTvz0+uGg=;
        b=T4ZM+NnGIMgMKktSDNYER+lq/OFkWSIpJfzjJ+QxWruSn9I86GH67eOIl9ORxmNh8/
         bugtOiRdffi06pRgNxA2MsWQFqUu4S67VUhIQkeQsYjtAdD3w3DeD4KXFlll0MpbQA5E
         LevqQ2neW8sCaOF4S4ZdCuQF/XFOvpp5Ck0YE=
Received: by 10.14.16.100 with SMTP id g76mr2700313eeg.102.1327700146180;
        Fri, 27 Jan 2012 13:35:46 -0800 (PST)
Received: from localhost.localdomain (abvs200.neoplus.adsl.tpnet.pl. [83.8.216.200])
        by mx.google.com with ESMTPS id y54sm34466634eef.8.2012.01.27.13.35.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 13:35:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0RLaGbp029502;
	Fri, 27 Jan 2012 22:36:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0RLaFGk029499;
	Fri, 27 Jan 2012 22:36:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1327673954458-7229895.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189235>

Ondra Medek <xmedeko@gmail.com> writes:

> we have gitweb running on Linux box. Some files have Windows line ending
> (CRLF) end we do not use core.autcrlf translation. gitweb show the last \r
> in the end of each line, which is annoying.

Well, this "\r" allows to recognize when file with Windows line ending
(CRLF) made it into repository... which usually is discouraged.  But
if you allow this, I can understand that those "\r" at the end of
every line can be annoying.

A simple _workaround_ would be to create one's own extra stylesheet,
with rule hiding control characters visualization (including "\r"), e.g.

  .cntrl { display: none; }

and stuff thys additional it in @stylesheets via gitweb config file.

> I have created a simple patch to avoid this.

Please read Documentation/SubmittingPatches if you want your work to
be considered for inclusion.  This is not a proper patch -- it lacks
commit message (comments should be outside of it, e.g. between "---"
and diffstat) and signoff.

> It adds just one line. I am not sure if the regexp should
> contain 'g' switch in the end. Also, not sure if there should be some config
> option to switch on/off this?

Note that your patch beside hiding "\r" in the case when file has
Windows line endings, it also hides "\r" in the case where file has
_mixed_ line endings (LF mixed with CRLF, which is incorrect).  Though
handling that well would be quite difficult, I think...

Though esc_html gets passed whole lines, I am not sure if it always
gets passed whole lines and would continue getting passed only whole
lines in the future, so there should be 'g' modifier (or better 'gm'
modifier to make sure that $ matches end of line not only end of
string).

I think it would be better if there was an option to switch hiding
"\r" on and off... though I am not sure if it can be done without
incuring large performance penalty.

> ---
>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index abb5a79..92175bc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1500,6 +1500,7 @@ sub esc_html {
>         if ($opts{'-nbsp'}) {
>                 $str =~ s/ /&nbsp;/g;
>         }
> +       $str =~ s/\r$//;
>         $str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
>         return $str;
>  }
> --

Another solution would be to modify quot_cec...

-- 
Jakub Narebski
