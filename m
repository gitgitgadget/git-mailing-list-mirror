From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/11] vcs-svn: Read the preimage while applying deltas
Date: Thu, 14 Oct 2010 18:40:08 -0500
Message-ID: <20101014234008.GC29494@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
 <20101013093037.GD32608@burratino>
 <1287092755.10477.9.camel@wilber>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?utf-8?B?5ZSQ6bOz?= <audreyt@audreyt.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 01:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6XSb-0005Y4-LW
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 01:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab0JNXnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 19:43:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57358 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0JNXnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 19:43:39 -0400
Received: by qyk2 with SMTP id 2so84696qyk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uhb/q1KlgZ3WQQ0xjkC7Fhuuh4DFD5F3jeCVtwzu0e4=;
        b=yH/arV5jCeub0YfYW0g+ERKA6b4SUanvo2fqWV3nmYZ9vVVKRWvcLhavnqwXQBVaO2
         c9Rae3nXBGf4POFLZnmJ45z2WLlSAckQo/Cec3IeGZ2SHg065cAuFFUO6NjPBQ5RNpQq
         XDDUu7FrSmOngoTz7adBf53c1+Mo013MZ21Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g+n1HSgH7rNp7ia8EHCym/l6Oi5wRxeMqfccmwNLRzDeTdYxHwkmBnAff/FPQh1k/s
         aE/8hWsmXH+ACF1/IHqjCuFDihUpk5K4ri0rZqcp27b5GkXQ7LNJ2nQ4eSL/FL0uoF8+
         5o7jTBHwsVfYFcR5QUZTnlGJ13fB3VZhXlmms=
Received: by 10.229.247.3 with SMTP id ma3mr16186qcb.1.1287099816991;
        Thu, 14 Oct 2010 16:43:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l13sm10153874qck.7.2010.10.14.16.43.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 16:43:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287092755.10477.9.camel@wilber>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159086>

Sam Vilain wrote:

> All I did was make the module lazy - version 0.02 was by =E5=94=90=E9=
=B3=B3, any
> detailed knowledge I had of the binary format fell out of my head pre=
tty
> quickly :-)

Ah, my bad.  =E5=94=90=E9=B3=B3, as part of an attempt to natively supp=
ort fetching
from and pushing to svn repositories, some contributors to the git
project are working on an svndiff0 applier.  If you're interested in
reliving old memories, please feel free to look it over (especially
the test cases).  Thoughts, simplifications, bug reports, improvements
welcome.

http://thread.gmane.org/gmane.comp.version-control.git/151086/focus=3D1=
58913

Anyone wanting to try it can check out

	git://repo.or.cz/git/jrn.git svn-da

and use the test-svn-fe command:

	make test-svn-fe
	./test-svn-fe -d <preimage> <delta> <delta length>

or the tests:

	make
	cd t && sh t9011-svn-da.sh -v -i

The preimage or delta argument can be /dev/stdin for use in a pipeline.

Thanks for your work on svk and pugs!
Jonathan
