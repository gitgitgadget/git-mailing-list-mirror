From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useless error message?
Date: Wed, 21 Apr 2010 17:19:54 -0500
Message-ID: <20100421221953.GA25348@progeny.tock>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:20:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4iH1-0006Uo-72
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab0DUWTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 18:19:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52379 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845Ab0DUWTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:19:49 -0400
Received: by gyg13 with SMTP id 13so4018529gyg.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=38+UWi38NuovDkASdUTyoScfOHNCkIda9axoZEZHqA0=;
        b=ZfkXhqFNcst+gaq03Dgd8S/ZeOVjmqEPDCasF87P97O3W2C0iVTyQ1NjOhU0YVl9FM
         S/lu7IGNdaY9IaHftz/v4QPUoiSPTAIxGdIjDQtbxJLWSTofpPXNNunq0sp3zXhbX6aM
         fPEHM7zn8ZwHTr1VywwOCLgUyD4NMP7ik5pSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uJPbwZzhcRWPJv2ZQWnFS/t70rh1cpiSaYSGhjD6KZyN0xFLxsEGRVpRTzX0dUNm4y
         k4E8xHsd+iAo4pcs7jMJZtIu6R6jNyHtZToxybfIgJ+tFRsLLmTFIN4f7PWSbvp1VHuD
         vvvWzFFfJVdizhocKnFKY7JWWuj1QVo9LX708=
Received: by 10.150.213.3 with SMTP id l3mr8855526ybg.215.1271888387900;
        Wed, 21 Apr 2010 15:19:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6854548iwn.14.2010.04.21.15.19.47
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 15:19:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145471>

Aghiles wrote:

> "fatal: The remote end hung up unexpectedly"
>=20
> Is that really meaningful ? Or maybe it is a configuration problem
> on my side ?

Please, fix it. :)

The problem is this: as far as I can tell, the git protocols are
designed around the success case.  Sometimes if there is an error or
other interesting event, the servers are kind enough to notify the
user =E2=80=9Con the side=E2=80=9D.  But in the end, all too often, the=
y do not bother
to inform the client _program_ that a fatal error occured.

We can=E2=80=99t just throw away this hang-up message because sometimes=
 when
the remote host hangs up it really was unexpected.

So the trick is to make it expected more often.  See the side-band-64k
capability in Documentation/technical/protocol-capabilities.txt: the
goal is to have fatal error messages for as many failure modes as
possible.

Examples (I could be missing nuances; I am just trying to convey
the idea):

upload-archive:
 - a pipe(), write(), or poll() failure when communicating over
   the wire or between local processes will result in an unexpected
   hangup.  I have not checked, but I suspect a SIGPIPE can kill
   upload-archive, too.
 - On the bright side, all other error conditions are properly
   handled.  The code for this is very nice and worth imitating.

upload-pack:
 - a missing or shallow repo, HEAD or some other ref pointing to
   a nonexistent object, early protocol error, or failure to start
   rev-list or pack-objects will result in an unexpected hangup.
 - errors from rev-list, pack-objects, or the transition of the
   generated pack are correctly handled.

receive-pack:
 - all errors result in unexpected hup as far as I can tell.

daemon:
 - hangs up without an explanation (except to syslog) for invalid
   or disabled repositories
 - if the underlying service hangs up, hangs up.  If the underlying
   service writes a message to stderr, writes that message to
   syslog.  Surely the client is not interested...

If any other information would help, please let me know.
Jonathan
