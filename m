From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 16:23:04 +0200
Message-ID: <201007261623.05850.jnareb@gmail.com>
References: <4C4D152A.7050505@gmail.com> <AANLkTinAO8R6mg967XeqFgMHInT4pMlxODz29Jovfki1@mail.gmail.com> <4C4D932A.1010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Anders Kaseorg <andersk@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: julio.lajara@alum.rpi.edu
X-From: git-owner@vger.kernel.org Mon Jul 26 16:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdOaX-00055M-2b
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 16:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab0GZOXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 10:23:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35371 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab0GZOXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 10:23:23 -0400
Received: by bwz1 with SMTP id 1so2811332bwz.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lOEpeqhGALcfyPZkHNKfdJQoWbI2G+t7Of6LNNeDXCQ=;
        b=ByqprQgDULGUqzabEzKJbYuhPOuR31BwRtcZyDDE+iuDhSlA8j6qa0Jy5Hzf0PRzQ4
         dUaNB/OQjtefxiIqvRXe6IXXjKfHYQcdDsacNujZg1zsJfUVPGyeM4gsVEaeFJ1crI5B
         6U+koNnRMlUXxoiRk42wEbI4sIJbxc+ojLpJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EgLZ0ALGAqv0dB6v+EpwdfYd8ntMEn9KDvsYUtIQLumnxpRwmJ6fzwlZXJkGj5IDfH
         0aOtHCJQzVOqX1Z6al2arh9GhiEXQ3UtWl0sb9xTvoV/YtCEX9wT6AHM09POfGy3hgOj
         Iw2X79YuvA+iTW2UkgPQeuKcThIQVzO5RqI4o=
Received: by 10.204.25.151 with SMTP id z23mr5730330bkb.46.1280154201732;
        Mon, 26 Jul 2010 07:23:21 -0700 (PDT)
Received: from [192.168.1.13] (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id x19sm2920092bkv.9.2010.07.26.07.23.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 07:23:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C4D932A.1010101@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151842>

On Mon, 26 Jul 2010, Julio Lajara wrote:

> Hi, Ive managed to narrow down the issue to a line in the gitolite's 
> contrib/gitweb/gitweb.conf that I appended to the default 
> /etc/gitweb.conf . It was working with 1.7.0.4 but 1.7.2 doesnt like 
> this line:
> 
> $ENV{GL_USER} = $cgi->remote_user || "gitweb";
> 
> I corrected it by just setting it equal to gitweb and all is well now.

I think the following commit is the reason that this stopped working
869d588 (gitweb: Move evaluate_gitweb_config out of run_request, 2010-07-05)

>From its commit message:

    gitweb: Move evaluate_gitweb_config out of run_request
    
    Move evaluate_gitweb_config() and evaluate_git_version() out of
    run_request() to run(), making them not run one for each request.
    This changes how git behaves in FastCGI case.
    
    This change makes it impossible to have config which changes with
    request, but I don't think anyone relied on such (hidden action)
    behavior.

I guess I was wrong about that.  I wonder if it would be possible to 
re-enable this feature (which I think is needed to be able to use
$cgi->remote_user) but without having all pay the [slight] performance
penalty of including (and I think parsing) config file once per each
request.

-- 
Jakub Narebski
Poland
