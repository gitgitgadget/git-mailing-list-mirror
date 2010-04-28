From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 18:37:58 -0500
Message-ID: <20100428233758.GA1654@progeny.tock>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>,
	David Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 01:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Gpl-0006FY-GP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 01:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab0D1XiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 19:38:09 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:59756 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab0D1XiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 19:38:08 -0400
Received: by qyk9 with SMTP id 9so22089315qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=i6GnL68kv4RkUyH1P3yPmJ8pat9i1T3NA46Szh7iq3E=;
        b=GFjPS41NZpZhTmGi14Pwaf4BFU25pvj3oM8VawruRFb/9T63p88lC25bShsaPERL9D
         Z3ah8ExHdag2BQkd6nETMDtp3tMJJaSt8mhJZCvFi+mtf4WdeJC1qmmqLFIQ6jnv7oUF
         sjgzUmgWQVD/UopT9bOdaIvgm529Gpu7KGTR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rDe6lu2IZFlNgIevh4OhS7x1JZqqX3OgpOan/HqeMKHSa+FUZzUVuOE9S/QrcG19Py
         mu+phsPuA7HeImLefbP/oEzwE39n3dJ6cKe8mpy87Kv3BYdM3l5eaOJ6+04L163Wjqwq
         IXudGnsAtZJILGQAA6uE9hhLHZJ5bOGuY40vI=
Received: by 10.229.242.3 with SMTP id lg3mr5265642qcb.102.1272497886819;
        Wed, 28 Apr 2010 16:38:06 -0700 (PDT)
Received: from progeny.tock (c-76-28-252-211.hsd1.wa.comcast.net [76.28.252.211])
        by mx.google.com with ESMTPS id x34sm240229qce.21.2010.04.28.16.38.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 16:38:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146021>

Hi Jon,

Jon Seymour wrote:

> If you use git reset --mixed HEAD@{1} you can reset the index to
> HEAD@{1} to reflect the pre-merge state.

The HEAD doesn=E2=80=99t advance in a failed merge, right?

[...]
> This is more complicated than it needs to be - if you had stashed (or
> committed) before cherry picking, things would be simpler.

If this were really necessary, I would consider it a bug.

I do think recovery is more complicated than it needs to be, since one
has to check whether the merge/cherry-pick failed before cancelling
it.  There are three cases.

 - If an early check prevented the operation (message with =E2=80=9Cfat=
al:=E2=80=9D,
   status =3D 128), then the index and work tree were not touched.

   No recovery required.

 - If there were conflicts (message with =E2=80=9CConflicts:=E2=80=9D, =
status =3D 1),
   the index will record the competing versions of conflicted files,
   and the work tree will represent the situation with conflict
   markers.

   Use =E2=80=98git reset --merge=E2=80=99 to recover.

 - If the merge proceeded cleanly (status =3D 0), but it was a bad
   idea after all, the index and work tree record the new version now.

   Use =E2=80=98git reset --keep HEAD@{1}=E2=80=99 to undo the operatio=
n.

Have fun,
Jonathan
