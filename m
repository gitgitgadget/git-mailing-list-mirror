From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 22:33:37 +0200
Message-ID: <81b0412b0906171333l38b1c2e0y2e166bc0ae7a461d@mail.gmail.com>
References: <200906160111.47325.ioe-git@rameria.de>
	 <alpine.LNX.2.00.0906161332080.2147@iabervon.org>
	 <200906171923.08034.ioe-git@rameria.de>
	 <alpine.LNX.2.00.0906171328080.2147@iabervon.org>
	 <81b0412b0906171326y6821d511u5b93cda4a5c14458@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ingo Oeser <ioe-git@rameria.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:34:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH1pS-00061I-B9
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760728AbZFQUdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760656AbZFQUdh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:33:37 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63511 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760187AbZFQUdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:33:35 -0400
Received: by bwz9 with SMTP id 9so639739bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KpYNDMqgfTm1iLVL+NAGHGtWl/W7wCVCZxLqNqk82kc=;
        b=BH8rBy0fbtoMxejT6xiNqh7huDdd+QgDFIMG2eQ8bxzikI/NtO4VbfmV9WORnRLmdP
         3O48JZAoX2WVI0zJ/hdCk3d5w4XUHod6kKUk8Gf1c2RXcREgxM5McyGMfNFfF8a58VFH
         4WzrW2xPmr1FHhrDJzyIgAg633fmcrObKir6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WZSo4RFOc2WjiebFUudgTnkXZbPId3E3fmpNIjs2a1ajte0qK/U7wZndkDPUhZ/AfC
         jcmQPV2g+9SBsAWMWU5jQEmSCteaG60iX1fSMrmkEL8woodCpBdbhf/C85n1A1siI9YC
         SawbFe9VnvW/D1pEFwGsuTy/f0KlwdBbJxlCw=
Received: by 10.204.51.210 with SMTP id e18mr524030bkg.38.1245270817171; Wed, 
	17 Jun 2009 13:33:37 -0700 (PDT)
In-Reply-To: <81b0412b0906171326y6821d511u5b93cda4a5c14458@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121771>

2009/6/17 Alex Riesen <raa.lkml@gmail.com>:
> Or, you can just keep a namespace for each server in the intermediate

I mean namespace of branches:

  refs/heads/webserver_1/master (current)
  refs/heads/webserver_1/next (to be updated to)

> repositories, which records the version the server has and the version
> it should have. Then you can use git diff-tree to find you which files
> have to be transferred. You wont be able to record changes on the servers,
> though.

Something like that:

git diff-tree --diff-filter=AM webserver1_/master..webserver_1/next |
while read f; do scp "$f" webserver_1:"$f" || break; done
git diff-tree --diff-filter=D webserver1_/master..webserver_1/next |
while read f; do ssh webserver_1 rm -f "$f" || break; done
