From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Sat, 20 Jun 2009 18:58:56 +0200
Message-ID: <200906201858.57346.jnareb@gmail.com>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com> <20090620141626.GK7675@aaroncrane.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sat Jun 20 18:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI3pc-0002mD-VZ
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 18:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbZFTQxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZFTQxt
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 12:53:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:56370 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZFTQxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 12:53:48 -0400
Received: by fg-out-1718.google.com with SMTP id 16so765780fgg.17
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FR8JtpB31ULgkHeGbO21nIxtSGaYbK4nP+YJa16Uaao=;
        b=bdjEfvyTEFcPSjzRLch5mj5WDHVz4cK04lx4wh347FQ8dNQMvWG7hkPBcHAHrt27d5
         A8pNdipafzzYG66cYyqjEzztZOdffmtSYuQyqpCdCpXicF+nfl+E3BM6ILyZRq4Vkzpz
         JVX7RovReCvLvrPrkTp/zCBWsYPUm0mEB1H64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=x5DREJTFparQbIvqKZND/LoUePeN8EfrOfK5VqaX6RFSYPHh/81f3CsInnqLjm6So1
         ipr3CE+fvYOKqjplnOVEzv0BBWfdGuPLhAA/8sv0uOt6CUi+jGP2x4KEPcmx7HuBAdHd
         E9IC/1AED+tawRedwDxQiQKxao/7NzOjccSXQ=
Received: by 10.86.86.2 with SMTP id j2mr4412057fgb.50.1245516830423;
        Sat, 20 Jun 2009 09:53:50 -0700 (PDT)
Received: from ?192.168.1.13? (abwr61.neoplus.adsl.tpnet.pl [83.8.241.61])
        by mx.google.com with ESMTPS id d4sm1783487fga.12.2009.06.20.09.53.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 09:53:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090620141626.GK7675@aaroncrane.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121946>

On Sat, 20 June 2009, Aaron Crane wrote:
> Giuseppe Bilotta writes:

> > +# check if gravatars are enabled and dependencies are satisfied
> > +our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
> > +	(eval { use Digest::MD5 qw(md5_hex); 1; });
> 
> This test for the availability of Digest::MD5 is broken: `use`
> statements are executed at compile time, so the whole program will
> fail if Digest::MD5 can't be loaded.
> 
> A possible fix would be to move the compile-time actions to run time:
> 
>     our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
>          (eval { require Digest::MD5; Digest::MD5->import('md5_hex'); 1 });
>

Good catch!!!  But we don't need import if we are to use slightly longer
form: Digest::MD5::md5_hex.
 
> However, I don't recommend doing that.  Digest::MD5 is a core module
> in Perl 5.8.0 and later, so an installation of Perl 5.8 that doesn't
> have it is broken.  Since gitweb.perl already needs 5.8 (because of
> the `binmode STDOUT, ':utf8'` at the top, if nothing else) I see no
> value in jumping through hoops to make this work in the essentially
> impossible situation where Digest::MD5 is unavailable.

In this case the problem is not with Digest::MD5 not being installed.
The problem is with not loading this module in a CGI script if it is
not required (i.e. problem is not dependencies but performance).

BTW. we sometimes unnecessary calculate MD5 hash repeatedly for the
same author / committer in log-like views... but I don't see how to
solve it in an easy way.

-- 
Jakub Narebski
Poland
