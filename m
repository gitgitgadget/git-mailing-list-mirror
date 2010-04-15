From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 19:45:59 -0400
Message-ID: <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>
References: <4BC6EECE.6060408@gestiweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, deavidsedice@gmail.com
To: =?ISO-8859-1?Q?David_Mart=EDnez_Mart=ED?= <desarrollo@gestiweb.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 01:46:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2YlP-0001Xp-SY
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 01:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab0DOXqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 19:46:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56612 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328Ab0DOXqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 19:46:20 -0400
Received: by gyg13 with SMTP id 13so1027116gyg.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kuReKuubkXVkiR13/7whMz1cAXZbbWy7i8w8PztP7f8=;
        b=GC3CvfbvCrrx39O8OttRpt8MdwtcpU5G+Czfes+qJ/V2QNCu9UnRwpGiFNi4pzazhQ
         i65nsW5MyAhnFZwxHK0jG7/YAUT/MKELgcizL6xCrVgP/rfAK06V5hR0odfvwm+oIN3w
         k7IsF7MrbTUzSQSKUZm90Ej63v9nuNNvdqXT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Gre/v6mkO6jn90fmR5POzjxyW586vbyXAY6wcAQHfxz4+JBABJWck1vK8rt4xJMH5Y
         eovb54vODM9ZX7o337JhkXpMBQjDjNO3zEKcOAPhOWBO1TLJod0hIZNcErzDRnaqbpDh
         LTKe45LYA0tjDXFmM1Fr9SocaPsbHEbR5Kn00=
Received: by 10.151.143.6 with HTTP; Thu, 15 Apr 2010 16:45:59 -0700 (PDT)
In-Reply-To: <4BC6EECE.6060408@gestiweb.com>
Received: by 10.151.124.1 with SMTP id b1mr955341ybn.106.1271375179175; Thu, 
	15 Apr 2010 16:46:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145035>

On Thu, Apr 15, 2010 at 6:47 AM, David Mart=EDnez Mart=ED
<desarrollo@gestiweb.com> wrote:
> $ git show dac6a95f5 -p --pretty=3Draw --
> facturacion/facturacion/scripts/lineasfacturascli.qs
> commit dac6a95f559604978ff9e1fac24ad752c54382ae
> tree f1472f1d289f9813df5fd691c9cea6ccb04313a7
> parent 5dfdd78f24f4578cdfeed876b8bacb45790af9ef
> parent 6ed54c8c6508b6d5551290b45785eaf44dd05d75
> author David Martinez Marti <desarrollo@gestiweb.com> 1260959309 +010=
0
> committer David Martinez Marti <desarrollo@gestiweb.com> 1260959309 +=
0100
>
> =A0 =A0Merge remote branch 'origin/infosial'
>
> =A0 =A0Conflicts:
>       [...]
>    [empty diff]
>
> There was a conflict on that file but it doesn't show anything change=
d about
> it. Gitk does the same.

You're trying to show the log of a merge commit.  git tries to be
clever about showing diffs on such commits, but it screws up rather
too often to be reliable, and this bites a lot of people (including
myself).

The core of the problem is this: if you're looking at 'git log -p',
you'll see all the individual commits.  But a merge commit is
essentially a combination of all the commits on branch #2 as you add
them to branch #1.  (Or alternatively: all the commits on branch #1 as
you add them to branch #2.)  So if git did the obvious thing and just
showed the *entire* diff that the merge applies to branch #1, it would
be a big long patch, but worse, it would be *equivalent* to the
patches you've already seen from other individual commits.

So what git tries to do is reduce the diff output of a merge commit
down to just the "unexpected" parts: the parts that are different from
what you'd get if you just merged in the individual changes in the
obvious way.  Unfortunately, actually calculating that would be really
complicated; it would require redoing the whole merge just to find out
what happened, and that turns out to be too slow.  So git uses
heuristics to try to guess what happened, and those heuristics don't
always work out.  In your case, it seems to have decided that "nothing
special happened" during the merge even though apparently the file was
entirely blanked out, which seems obviously wrong to me, but I don't
actually know how the heuristics work.

The "git log" options -c and --cc are documented (in 'man git-log') as
supposedly affecting this behaviour.  However, it seems that "--cc"
became the default somehow, and there's no obvious way to turn it back
to the "supposedly default" plain or -c behaviour.  Maybe someone else
on the list can comment more.

Have fun,

Avery
