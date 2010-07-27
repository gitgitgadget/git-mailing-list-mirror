From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 19:29:41 -0400
Message-ID: <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 01:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdtbJ-00086L-1d
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 01:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0G0XaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 19:30:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44334 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0G0XaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 19:30:02 -0400
Received: by wyf19 with SMTP id 19so3628838wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oXMemHMCYPVciQ4/Ot1oJp1NmKSno6fTTDLNMWVovlk=;
        b=CYxQlZBbSyMRjVCDyOrIrWenUU905IOycsacgem7ZUw5v4/4RSA1wgvP6i8112uK1t
         rFc9yfHEI+zDP/bt+t+fkxR9iqomYk9sqjiDrtDLHjO4T0JEetTxkY8f9r6TgktJCEPc
         UeHCRP8SVaLk61pDqc/qZ8GesjV7V4bObA1G0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JsEIigy43UldFpwHgtyuOaswCjREsvLoK/SN0eO/SHsd7c83UuZMuId4k711VLiYDM
         HEuZcm4F6uXFGL+NhgDnhhO2ONJ2Tob/ibz2whMYYvFe1+u5r6YRcd6Q35uTMA3MyhiY
         ZBwO+VRpAi7KqRz40idUIJW0MXPqcpjPtofrA=
Received: by 10.216.21.204 with SMTP id r54mr3253545wer.95.1280273401343; Tue, 
	27 Jul 2010 16:30:01 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 16:29:41 -0700 (PDT)
In-Reply-To: <20100727122018.GA26780@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152015>

On Tue, Jul 27, 2010 at 8:20 AM, Finn Arne Gangstad <finnag@pvv.org> wrote:
> Reading through the thread about subtree I noticed Avery mentioning
> using inotify to speed up git status & co.
>
> Here is a quick hack I did some time ago to test this out, to use it
> call "igit" instead of "git" for all commmands you want to speed up.
>
> There is one minor nit: The speedup gain is zero :) git still
> traverses all directories to look for .gitignore files, which seems to
> totally kill the optimisation.

Hey, this is kind of cool.  Except for that last part :)

Actually I think the problem is a little worse than .gitignore files.
'git status', for example (which is called by git commit), wants to
generate a list of the files it *doesn't* know about.  Unfortunately,
those files aren't in the index at all.  So it resorts to doing
recursive readdir() across the entire repository.  The net result is
about as slow as doing that plus one stat() per file in the index.

An inotify daemon could easily keep track of which files have been
added that aren't in the index... but where would it put the list of
files git doesn't know about?  Do they go in the index with a special
NOT_REALLY_INDEXED flag?

This is the main question that has so far prevented me from trying to
solve the problem myself.

Thanks,

Avery
