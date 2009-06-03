From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 17:39:48 +0200
Message-ID: <200906031739.49682.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090603144837.GE3355@spearce.org> <20090603150746.GF3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBsZe-0004iZ-1K
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 17:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbZFCPjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 11:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZFCPjv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 11:39:51 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36870 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbZFCPju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 11:39:50 -0400
X-Greylist: delayed 105552 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 11:39:50 EDT
Received: by fxm9 with SMTP id 9so71731fxm.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sM9hTtgxdfHC0RhzCFwqSt8+eiV6rsQ0BYsECuiwoeU=;
        b=K8PXRAUaVX1GvAgk6dxjgpWe1ALMuKzC859GO5kLEk7T1dn98dKV2wauzY4Vy6QOFc
         RkBa2V3F9Qutq1pvCnIonTuuTixgrK+lsr6KIwYqR+bzoc+HEmBu9Q3RaF1/7gwrxAns
         sn9poO5I7IK5napuUVqCrPokTQt/f5215+bxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Fjed2ISO4sQxXKLzTCPC7LC6u+CnZq/Ury15CQTy/JLhzFPy6JTgPXyjNkD/eynnSc
         Vq13uUNQkaVPk9uA07cco4uEF7pAvEWX0nsdop7RU16IZ4CocWWsh1QqWjn/wa6prk7Q
         aTYJeoiJHReIG98sBneH0HI93sD+QR06BYnF8=
Received: by 10.103.214.13 with SMTP id r13mr717036muq.37.1244043591512;
        Wed, 03 Jun 2009 08:39:51 -0700 (PDT)
Received: from ?192.168.1.13? (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id 25sm2142983mul.29.2009.06.03.08.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 08:39:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090603150746.GF3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120614>

On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:

> > > What options besides (required?) "host=<server>[:<port>]" are supported?
> > 
> > Currently only host is supported.  And yea, it takes the :<port> if
> > the client included the port number in the URL (git://foo:8813/path).
> 
> Ok, I'm wrong.  It *doesn't* send the port.  The reason is obtuse,
> but git_tcp_connect() clobbers the port number out of the host

What about git_proxy_connect()? Does it clobber port number either?

> name string, so that later when git_connect() sends this "host=%s",
> only the host name is transmitted.

Hmmm... so does that mean that in the following fragment of deamon.c
on branch is dead in practice?

  if (strncasecmp("host=", extra_args, 5) == 0) {
    val = extra_args + 5;
    vallen = strlen(val) + 1;
    if (*val) {
      /* Split <host>:<port> at colon. */
      char *host = val;
      char *port = strrchr(host, ':');
      if (port) {
        *port = 0;
        port++;
        free(tcp_port);
        tcp_port = xstrdup(port);
      }
      free(hostname);
      hostname = xstrdup_tolower(host);
    }

    /* On to the next one */
    extra_args = val + vallen;
  }


> > Actually, I just realized JGit isn't compliant here.  It doesn't
> > send the :<port> like C Git would.
> 
> So, actually JGit is compliant here.

Well, we can take the stance that C Git isn't compliant either ;-)

>  
> > > Do I understand correctly that "host=<host>" information is required
> > > for core.gitProxy to work, isn't it?
> 
> If core.gitProxy or GIT_PROXY_COMMAND are set, you can lie to the
> remote git daemon about the host.  E.g.:
> 
>   $ cat proxy.sh
>   #!/bin/sh
>   exec nc git.kernel.org 9418
> 
>   GIT_PROXY_COMMAND=proxy.sh git ls-remote git://github.com/foo.git
> 
> During that kernel.org receives "\0host=github.com\0" host header,
> which is not the name you connected to it as.  :-)
> 
> In practice I doubt anyone would do that, but, you can confuse
> yourself.  I guess about equally as well as url.insteadof.  :-)


A question: do compliant implementation MUST not fail on receiving
arguments it doesn't understand, e.g.:

   003bgit-upload-pack /project.git\0host=myserver.com\0user=me\0

or can it go hang the client, or silently fail?

-- 
Jakub Narebski
Poland
