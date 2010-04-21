From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 12:12:27 -0500
Message-ID: <20100421171227.GA23794@progeny.tock>
References: <201004210957.48138.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 19:12:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dTS-0008OQ-QT
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 19:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab0DURM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 13:12:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62795 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0DURMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 13:12:25 -0400
Received: by pvg13 with SMTP id 13so974534pvg.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7RYwZY9TRufepz9bQ0TpHK3WV7ooiMLHKm50Tp+9ID4=;
        b=apgUxry0uKPdob4OzBQmH0WUCwnkj6d3kcd9af4tNj74SATskcWfngHKAqNhpD7xqW
         z/UnUPza8I2SVwjaiq2PVqt7qM8F/Va7mZKQ5gqGpx9bPgVHmsoDc74Red/XPrQD/Trp
         n5d0HJQx1/mw9ysFVDgAJsqTZxuOa30TJ/bUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VEL3wQOvumlBXJXQEErRiVev/A0jL3fA96q0QHaDJwVsKh+EW0IhCGE4LCFB2fLMxM
         qFgGCt3TsxtjIqRxYR9VrV0oIjUKcADba5nHz93ysplphhhP8qZPjcVr4I9CEWO83szr
         G05D4BMCdFX1DSxc6SYBqcdh/87D0oMAkUzPI=
Received: by 10.141.188.33 with SMTP id q33mr399127rvp.8.1271869944473;
        Wed, 21 Apr 2010 10:12:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm6718578iwn.4.2010.04.21.10.12.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 10:12:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004210957.48138.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145446>

Johan Herland wrote:

> 2. Merging without a worktree

Eh, I am not a fan.  I am thinking it might be better to use something
like contrib/workdir to make a temporary worktree with its own index
and HEAD in .git/tmp-merge-notes and let the conflict resolvers work
there.

Advantages:

 - easy to debug when something goes wrong
 - merge driver can take other unmerged entries into account
 - (if merging manually) the user is not at the mercy of the program.
   Instead of being forced to consider the conflicts in the order git
   wants, she can skip some and go back to them, look at how many
   there are before deciding to start work, resolve some, reboot to
   test a new kernel, resolve some more later, and visualize the
   result.
 - if the unmerged notes are very long, you might need a temporary
   file anyway
 - maybe some day a kind of rename detection could help cope with
   situations like propagation of notes after a rebase

Disadvantages:

 - setting up a new git dir takes some time
 - a checkout with all notes would be insanely huge.  So somehow one
   has to find an appropriate subset to check out.

>     Possible solution: Conflict resolvers:

I think you can do an entirely in-index merge with =E2=80=98git read-tr=
ee=E2=80=99 and
=E2=80=98git merge-index=E2=80=99.  If you forbid the per-file merge dr=
iver to fail
then this sounds like exactly what you=E2=80=99re talking about.

In my opinion in the case of popping up an editor this is a cruel
thing to do, but in the other cases it=E2=80=99s a good place to start.

Hope that helps,
Jonathan
