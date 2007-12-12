From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Thu, 13 Dec 2007 08:58:33 +1300
Message-ID: <46a038f90712121158n674a9044t75ef99473314457c@mail.gmail.com>
References: <20071211200418.GA13815@mkl-desktop>
	 <20071212083154.GB7676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Markus Klinik" <markus.klinik@gmx.de>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2XjQ-0000gy-6Z
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 20:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbXLLT6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 14:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbXLLT6g
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 14:58:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:44108 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbXLLT6f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 14:58:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so676954ugc.16
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QFVD6Y/fXV5IinlH1iYhiTAixrI0gJ7VPNTrzCf25hA=;
        b=Bk9tPJIpA/ANdRum+ZSnGnuSHqdtbxZW4jeTwpw2oCNuC+OH0w38phqhFDZUzVexv1jO+8tmPHj1ldxG4UoCpeyvfvgwCIrheXfXln6G9GsEPQviNe4duM21SH1dfava5Kvs9ndeqyU4GQYa8SNe9NziCWWYQDVfHxLN3/66vTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BhOLX4oPRIvV/8b7xf0obcUm+RK45rwUPwh2WehscMNZkSDVDw3GIwXNY3AHvoeHOwzud6kkWao7Pehx5NwVfXYb57sm0oitK9tLvoEHu5gxsgaDy/dzfttVkHEyEOj2HNxMSRb8mcfi8BjIZegZdUEoP1/vY5ROssVfYRQLhhw=
Received: by 10.66.225.9 with SMTP id x9mr2590139ugg.47.1197489513603;
        Wed, 12 Dec 2007 11:58:33 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Wed, 12 Dec 2007 11:58:33 -0800 (PST)
In-Reply-To: <20071212083154.GB7676@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68096>

On Dec 12, 2007 9:31 PM, Jeff King <peff@peff.net> wrote:
> We will make our commits
> in two CVS invocations, but since CVS isn't atomic _anyway_, we
> shouldn't mind losing the atomicity.

Quick note -- I used to understand that cvs was not atomic, but
reading the on-the-wire protocol has taught me otherwise. Modern
versions of cvs are actually quite atomic-ish -- the protocol expects
the client to give all the relevant data to the server, and then say
"yep, that was all", and only _then_ the server does its commit.

So if the client dies or cancels along the way, nothing ever happens
on the server side.

Still, I suspect that the _server_ is not atomic, so if the server
process dies or finds a problem along the way, you could end up with a
half-commit in the repository, and maybe some hosed ,v files.

IOWs, the protocol *is* atomic, and this patch does make things
slightly more brittle. Perhaps require an option to be set before we
do this?


m
