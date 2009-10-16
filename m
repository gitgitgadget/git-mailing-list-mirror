From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Fri, 16 Oct 2009 00:20:29 -0400
Message-ID: <ca433830910152120l1bd358ads6401572ccc05b29@mail.gmail.com>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 06:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyeLE-0000Rq-7k
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 06:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbZJPEVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 00:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZJPEVI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 00:21:08 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37320 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZJPEVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 00:21:07 -0400
Received: by fxm18 with SMTP id 18so1956490fxm.37
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 21:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=pRlQ3JlcKyoT/wH/vSLIs/PNrfLIxHsIevW8zw7vREI=;
        b=THvbTznvAkBT/rTLhEnzkfOpa+1rCSknoofyYrKnC2nJlUU/8OWzrNstA5GJkf1Dsb
         aMtKuGIP2M8bjYZO55MmFlTSCFsAWG5zQpu/2eHZ162+9QMJn7n6BTFq+lq9iTf6We1c
         mW8BTvkn7ylEK3stUftb+3tMH/bzqT/NhU540=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Qvj1qLAAtcMWtQM5H6ncQqfyPdc/KxYYMB9OwBSpxpFvQN4pCj6WNpfY1soVaxTgo7
         QdELoCDL1r3Yk5NS4yYnDcGhtCKPT0oLARAgDV7z0ozhpi2U+u6PtgDrvAjVc0bEVAVp
         S9Swippve46t95ald853dJ+G5Wc01Dnu9XcZo=
Received: by 10.103.84.6 with SMTP id m6mr394043mul.26.1255666829317; Thu, 15 
	Oct 2009 21:20:29 -0700 (PDT)
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130452>

On Wed, Oct 14, 2009 at 11:36 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> This series is still lacking:
>
>  * The HTTP protocol documentation
>  * Tests for the smart http transport code (existing tests pass)

* Dumb HTTP push support

It would be really nice if git-http-backend supported dumb pushing
over WebDAV.  Currently, to support both smart and dumb pushing, one
has to configure Apache in a very awkward and confusing way (if it is
even possible - I'm still trying to figure it out).  Without some way
to support older clients, it will be very hard to transition to the
new protocol.


Also, your examples use "DocumentRoot /pub/git", but I think most
people would want to have their main website as the DocumentRoot, have
the URL "/git" serve the repositories through gitweb, and have that
same "/git" URL be `git clone'-able.  The Apache configuration for
this is complicated and non-intuitive, so I think an example of this
in the documentation is warranted.  The following accomplishes what I
describe, except it does not work with dump HTTP push, and does not
allow anonymous read-only access.  (I am currently trying to figure
out how to do both of these things.)

-- 8< --
DocumentRoot /var/www/htdocs
# Rest of httpd config...

<Directory /pub/git>
   SetHandler git-http-backend
   Action git-http-backend /git-http-backend virtual
</Directory>

# To allow anonymous access (but to disallow pushing), comment out the
following Location block.
<Location /git-http-backend>
   AuthName "git"
   AuthType Basic
   AuthUserFile /etc/apache2/passwd/git.passwd
   Require valid-user
</Location>

# Each of the following Aliases should be one line:
AliasMatch ^/git/(.*/(HEAD|info/refs|objects/(info/[^/]*|[0-9a-f]{2}/[0-9a-f]{38}|pack/pack-[0-9a-f]{40}\.(pack|idx))|git-(upload|receive)-pack))$
"/pub/git/$1"
ScriptAlias /git "/var/www/cgi-bin/gitweb.cgi"
ScriptAlias /git-http-backend "/usr/local/libexec/git-core/git-http-backend"
-- >8 --
