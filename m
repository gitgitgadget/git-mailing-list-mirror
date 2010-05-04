From: Clemens Buchacher <drizzd@aon.at>
Subject: update-index --really-refresh unsets assume-unchanged bit
Date: Tue, 4 May 2010 10:57:22 +0200
Message-ID: <20100504085722.GA32217@localhost>
References: <20100501092512.GA15941@localhost>
 <20100501092720.GB15941@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 10:57:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Dwp-0001ee-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 10:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab0EDI5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 04:57:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:21971 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab0EDI5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 04:57:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1441390fga.1
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=UF25VFOc60o+SSLVpthcIzpU/E3RNhd2+FQJYAsNJgI=;
        b=oj7iTvCEW7O1oKyh7C1jjB40Z/P5OP8rvHg7vvIJnka95YbUR69hUMriDB8d6WGAYT
         yiEGn6NqVXaId9041NGgVAufjG95LTiGPgiaJXIOW2SegmveB6/ndHcnGEH4cI8Hm/fM
         A3zk7GPzE+FiISacN7A5MIZ90Z6TDXBrKBMnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Rr+gxE4KaSnOvIMHSrBXniLxqufJztXR4c2JaN1r9SwpMHV6WNiJbYwT9EpK0kOAW7
         FQ9PmELwg69PKHiS6L/997Qm0lAVNRjnOhQ+AZ7FqcuW8UR/bzSt/l3AbmzSyJD6ykyr
         6cW64d9pheFCIZRFeY77fxVotKGAElhQ4stAg=
Received: by 10.87.20.36 with SMTP id x36mr12292227fgi.14.1272963455999;
        Tue, 04 May 2010 01:57:35 -0700 (PDT)
Received: from darc.lan (p549A456A.dip.t-dialin.net [84.154.69.106])
        by mx.google.com with ESMTPS id 35sm10670432fkt.7.2010.05.04.01.57.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 01:57:35 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O9DwQ-0000JT-RX; Tue, 04 May 2010 10:57:22 +0200
Content-Disposition: inline
In-Reply-To: <20100501092720.GB15941@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146302>

On Sat, May 01, 2010 at 11:27:20AM +0200, Clemens Buchacher wrote:

>  --really-refresh::
>  	Like '--refresh', but checks stat information unconditionally,
> -	without regard to the "assume unchanged" setting.
> +	without regard to the "assume unchanged" setting. The "assume
> +	unchanged" bit is unset for all paths.

Scratch that latter part, please. I just noticed the bit is unset only for
modified files. If the file matches the index, or even if it has been
deleted in the work tree, the bit is _not_ unset.

So the current behavior is quite strange. I see several possible
interpretations of --really-refresh:

 Update index for specified paths, disregarding the assume-unchanged bit,

 a) ... and do not ignore work tree changes for tracked files any more.
    I.e., unset the assume-unchanged bit for all files.

 b) ... and do not ignore work tree changes for the specified paths any more.
    I.e., unset assume-unchanged bit only for specified paths.

 c) ... but continue ignoring work tree changes as before.
    I.e., do not unset the assume-unchanged bit for any paths.

(and the current behavior)

 d) ... and do not ignore work tree changes for modified files any more.
    I.e., unset assume-unchanged bit for modified paths.

I believe c) is the most useful, since it allows the user to deactivate the
assume-unchanged bit temporarily. All other options potentially change the
assume-unchanged bit, which the user may or may not want. In my opinion, it
makes no sense to bundle the two operations "update index disregarding the
assume-unchanged bit" and "(conditionally) unset assume-unchanged bit."

Clemens
