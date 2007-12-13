From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 15:38:32 +0000
Message-ID: <b0943d9e0712130738s18ad303fu17a8412097377900@mail.gmail.com>
References: <20071213133653.13925.89254.stgit@krank>
	 <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
	 <87lk7yr7ib.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 13 16:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2q9b-0006Kj-PK
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 16:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762643AbXLMPig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 10:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762631AbXLMPif
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 10:38:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:26242 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762625AbXLMPie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 10:38:34 -0500
Received: by nz-out-0506.google.com with SMTP id s18so392895nze.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mapt/Dy35wGciGMwSFw2Gh+t++PdZzYhA859HBQ8WZc=;
        b=IbEc1hCl0YQlvOM+zMHY6HX1vvCjC+AANDtloPQgllAcI/atbJJ20PZQTVRdVFHUE89f3tCR5U6YkKVGnvoVJS2iczRU7wVHre37SQRuUK9ZB47QprKjfzRN1gg++/1T4kWwmiAP2n7ig7z0RJynYAtDln3dvLhJDgSIF2wLFto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlC8e9cgcr6XNtfnNCKXG051EfqFzyqByCrdV8NxcSP7J5hFhk5T7eARA1sNB2aSaZmWEs1GLOEJyxzXJEso39BEBULY94ROoqonRNZIzURRHpeQ00XWyBjQtZXPa/Mru56gaYlhqWmb7OnByNiNLFWmy74Y/UxivFKKHM7nO7E=
Received: by 10.141.2.19 with SMTP id e19mr1179743rvi.88.1197560312083;
        Thu, 13 Dec 2007 07:38:32 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Thu, 13 Dec 2007 07:38:32 -0800 (PST)
In-Reply-To: <87lk7yr7ib.fsf@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68163>

On 13/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
> > On 13/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> >> I have a fair amount of branches, and I noticed that "stg branch -=
l"
> >> takes ridiculously long to finish.
> >
> > I have the same problem.
> >
> >> Maybe someone can help me find a quicker replacement for the
> >> get_protected call?
>
> Hey, why not put the "protected" flag in the config? Then we can get
> it the same way as the other stuff.
>
> Protecting a branch is a configuration action, so it makes sense to
> put it in the config.

Yes, I'm OK with this. The only problem I see is that we have to
change the stgit.formatversion and provide an upgrade in the Series
object. However, 'stg branch -l' no longer initialises the Series
objects and the upgrade won't happen.

The branch command would have to check format version and force the
upgrade if it isn't the required one.

BTW, have you run stg-prof to check where it spends most of the time?
Is it caused by Python object creation or GIT calls invoked during the
Series objects initialisation. If the latter, we can turn some
variables into properties and access them lazily.

--=20
Catalin
