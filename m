From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 04/15] Add new test to ensure git-merge handles pull.twohead and pull.octopus
Date: Fri, 4 Jul 2008 17:34:05 +0100
Message-ID: <e2b179460807040934m27e752e7s4f6a786d45d3bc53@mail.gmail.com>
References: <cover.1214581610.git.vmiklos@frugalware.org>
	 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Olivier Marin" <dkr@freesurf.fr>
To: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 18:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEoFY-0006oT-6Y
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 18:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYGDQeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 12:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYGDQeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 12:34:09 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:27889 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYGDQeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 12:34:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so257322and.103
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/dGNfxDjkIUuTDsaiPk5asZcEh5ZLbL+JwlR5J705xA=;
        b=ifGPxZpe2F/0/lY8UApgLMrgxwOnjCxOCPz90aSlRE8zjBrQ+vD7kF6XUkde7claVm
         JyWXq64dDz8MKSqqPb2/hx70F20UI/4p9veNzR7HqKMWE246ZQMWPNIsynhT9QTzel3y
         pZxU0lTvq6AhOvnIRYRXICKQ7AgyQ0e2OunTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=m+cSipcY54oj+wmn7udYOASVWHbOyNW7Y2tJA73vErlof712G4PqywePllv9R2vABU
         c+VwrIKjM471NoHBnVjOEH/Si8qnOFj+qDywlEhtrpwhNvhT7z/KC6TkpaVJD2YNKHEr
         WDqTr5S+S6PIZdu6MfxiC1Kqr9g3dQrSJz4dk=
Received: by 10.100.209.5 with SMTP id h5mr1068253ang.18.1215189245418;
        Fri, 04 Jul 2008 09:34:05 -0700 (PDT)
Received: by 10.70.20.13 with HTTP; Fri, 4 Jul 2008 09:34:05 -0700 (PDT)
In-Reply-To: <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87400>

2008/6/27 Miklos Vajna <vmiklos@frugalware.org>:
>
> Test if the given strategies are used and test the case when multiple
> strategies are configured using a space separated list.
>
> Also test if the best strategy is picked if none is specified.  This is
> done by adding a simple test case where recursive detects a rename, but
> resolve does not, and verify that finally merge will pick up the
> previous.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  t/t7601-merge-pull-config.sh |  129 ++++++++++++++++++++++++++++++++++++++++++

> +
> +conflict_count()
> +{
> +       eval $1=`{
> +               git diff-files --name-only
> +               git ls-files --unmerged
> +       } | wc -l`
> +}
> +

This here causes the test to fail on AIX (and likely other OS, such as
apparently OSX) where wc -l outputs whitespace. See
http://article.gmane.org/gmane.comp.version-control.git/80450

Here we want the line count not just a return value, so is the
following acceptable?

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 32585f8..9b6097d 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -73,7 +73,7 @@ conflict_count()
        eval $1=`{
                git diff-files --name-only
                git ls-files --unmerged
-       } | wc -l`
+       } | wc -l | tr -d \ `
 }

 # c4 - c5

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Anyway, I thought we preferred $() to backticks?

I do apologise for not being around for the earlier comedy breakage on
AIX, my sysadmins decided to 'improve' our firewall rules which cut my
automated builds off just after the final rc for 1.5.6, then I was on
vacation miles from any computers.

Mike
