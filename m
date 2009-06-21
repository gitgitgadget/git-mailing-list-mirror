From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sun, 21 Jun 2009 10:01:41 +0200
Message-ID: <200906211001.42254.jnareb@gmail.com>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org> <alpine.LNX.2.00.0906210244510.2147@iabervon.org> <7vhbyat6qc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 09:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIHvP-0002Wn-7b
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 09:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbZFUH4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbZFUH4c
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 03:56:32 -0400
Received: from mail-fx0-f224.google.com ([209.85.220.224]:50615 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbZFUH4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 03:56:32 -0400
Received: by fxm24 with SMTP id 24so27408fxm.37
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nnWDaRDkX8mFNGSodhkd1qBTBLXU2dPKqa825zcK//A=;
        b=mTatpwsQmBqZR0GiaR3lq5s+cXK1OZcJHUPTBsJaa8btW6Tqq9kJGS4vaVAiKJJJEt
         y+qexVNaSfpUTTkiX5CKKqcCUuxWiUDcG5wLdPv4U62fjoNcjvM9E11yI/2Q04TnTBzE
         3miMcdpfxKC2ND5EU8Jdj33oBPxefPkZCjSeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V2jpSh4eokTpDnrra6xPK0P3J/xCyq2VepHUkeuXAcAyYoXc0eIjo8teZRV7PdUysf
         VH7q9k3QCEJ3QBUvmGJ+dxRCoiUsQufrdEZhwFmBazrRcUuPbKf+/8oc8H6Rh2hoY4GK
         gJ44vy02OsqV0eQr3PwQG32tvM7h05sbY15+4=
Received: by 10.204.77.67 with SMTP id f3mr4703004bkk.75.1245570993662;
        Sun, 21 Jun 2009 00:56:33 -0700 (PDT)
Received: from ?192.168.1.13? (abvn211.neoplus.adsl.tpnet.pl [83.8.211.211])
        by mx.google.com with ESMTPS id c28sm9555025fka.49.2009.06.21.00.56.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 00:56:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhbyat6qc.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121970>

On Sun, 21 June 2009, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
>>> Why is this a good change?
>>
>> It was always using a temporary file; it just used to use a temporary file 
>> that was a shell script fragment and needed to be read with "eval". It 
>> can't be done entirely in core because it may be determined before a 
>> conflict and only used when run with --continue after the user resolves 
>> the conflict.
> 
> Ahh, Ok.
> 
> Using a _known_ and defined format, instead of ad-hoc scriptlet, is an
> improvement.
> 
> I still wonder if we can avoid using three separate "git show" and "git
> config" invocations, though.  But a half of that inefficiency will go away
> when this is migrated to C, as a single git_config() will grab all three, 
> although the writing side is still very inefficient X-<.

I think we can on the reading side: just use "git config --list", or
perhaps "git config --get-regexp <sth>" (where <sth> can be ".*") which
conveniently has SPC as separator, and feed it to appropriate 3 x 'read'.

On the writing side we can simply write in the config file format, we
don't need to use git-config for that.  Although I wonder if there won't
be trouble with shell escaping and quoting rules (eval / sed, which
I guess does shell quoting / shell unquoting).

On getting the information side we can use git-show with custom format
or git-cat-file fed to while-read-case construct.


This way from 3 x 3 = 9 git commands git-rebase--interactive.sh would
use only 2.

-- 
Jakub Narebski
Poland
