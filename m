From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 16:32:41 +0100
Message-ID: <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 02 17:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRrRT-0002BA-Jt
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 17:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211AbXIBPcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbXIBPcn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 11:32:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:59650 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbXIBPcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 11:32:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so755165rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 08:32:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PlgUVAjI7nJAo7QXoKOY76/MV3ZaFPMhPYsE1ehbJ/GHKzg28/Qd7ilR7JQSg0bYOzBtTpE13hENrJ0/XLL/VTpZ+B53NpfmrgBDL+cfuEP1Pjl8lTbvUEdPnkFZa7hzyovCMLBurOJ3ej9sxwcTfYy/D5cnRYuQPRU7xYXSEok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJOZ4p+/8UxaKZB0B7UyYUyHjUws8y1HKINMPuU0Fal+Q0Vtr8kndhXV2sEGSxJqWXMP61JLUXmkI1ynw0nyoJ/GX4txUCWaCHfOii+xtSdv0RIyIri29SH2EZ7NGfeXh2rHpJ0Ut/u830ihHoyCPKB3dovZCCGlIXJu8o6+qlw=
Received: by 10.141.52.5 with SMTP id e5mr1603494rvk.1188747161282;
        Sun, 02 Sep 2007 08:32:41 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Sun, 2 Sep 2007 08:32:41 -0700 (PDT)
In-Reply-To: <46DACE0D.5070501@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57342>

On 02/09/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> This gives us a significant speedup when adding, committing and stat'ing files.
> (Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)
>
> +               if (ext && (!_stricmp(ext, ".exe") ||
> +                           !_stricmp(ext, ".com") ||
> +                           !_stricmp(ext, ".bat") ||
> +                           !_stricmp(ext, ".cmd")))
> +                       fMode |= S_IEXEC;
> +               }

This breaks executable mode reporting for things like configure
scripts and other shell scripts that may, or may not, be executable.
Also, you may want to turn off the executable state for some of these
extensions (for example if com or cmd were not actually executable
files). This makes it impossible to manipulate git repositories
properly on the MinGW platform.

Would it be possible to use the git tree to manage the executable
state? That way, all files would not have their executable state set
by default on Windows. The problem with this is how then to set the
executable state? Having a git version of chmod may not be a good
idea, but then how else are you going to reliably and efficiently
modify the files permissions on Windows?

The rest of the patch looks good on a brief initial scan.

- Reece
