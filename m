From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Thu, 23 Feb 2006 16:38:48 +0100
Message-ID: <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 23 16:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCIYq-0000dv-S4
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 16:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWBWPiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWBWPiv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 10:38:51 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:52398 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751454AbWBWPiu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 10:38:50 -0500
Received: by nproxy.gmail.com with SMTP id y38so52532nfb
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 07:38:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucwlqj8BWnXJrKMuRaqxlqpDk9g9JYJD4dG64qq1Uh6AaKstStoTrZvMqnJYnWegIyE5wwJhhOAZvcwxsYsnY0aCWiGF9J9h1FIeU4frFrHByjmU6q5NM9IxqajKZ/2qJrl5h+c4LaMx5CAmUg8PEdoPBAs248Cb47My3qdtry0=
Received: by 10.49.33.10 with SMTP id l10mr2390003nfj;
        Thu, 23 Feb 2006 07:38:48 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 07:38:48 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16652>

On 2/23/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>       Since of these 4, I only use cvsimport myself, I could only test
>       that. Could someone who uses the others give them a hard beating?

I can't really test them (no svn and cvs, and locked down network), but I took
a look at the patches. Hope it helps.

git-cvsimport:

> -               open(F,"git-cat-file commit $ftag |");
> -               while(<F>) {
> +               foreach (qx{git-cat-file commit $ftag}) {
>                         next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;

Are you sure you don't need quoting/safe pipe here?
Or is it a CVS tag?

> +} else {
> +    @input = qx{cvsps --norc opt -u -A --root $opt_d $cvs_tree};
> +    !$? or exit $?;

Same here. $cvs_tree can contain any filesystem-allowed character.

git-svnimport:

> -                       my $sha = <$F>;
> +                       my $sha = qx{git-hash-object -w $tmpname};
> +                       !$? or exit $?;

Is $tmpname safe?

> -       my $sha = <$F>;
> +       my $sha = qx{git-hash-object -w $name};
> +       !$? or exit $?;

Is $name safe?

> -       while(<$f>) {
> +       foreach (qx{git-ls-tree -r -z $gitrev $srcpath}) {
>                 chomp;

Is $srcpath safe?

> -                       while(<$F>) {
> +                       foreach (qx{git-ls-files -z @o1}) {

@o1 must contain filenames. Can be dangerous
