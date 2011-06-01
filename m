From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Thu, 2 Jun 2011 04:18:30 +0600
Message-ID: <BANLkTi=pK4pu=XpdPWWCaQ2KdEQRXB29pw@mail.gmail.com>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
	<20110601220518.GA32681@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRtkM-00080g-VN
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab1FAWSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 18:18:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64985 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab1FAWSc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 18:18:32 -0400
Received: by ewy4 with SMTP id 4so88811ewy.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8RRRc1jxZDtG1oZ/V5L2KvkIbwTEfbhhYIpj49ThR9Q=;
        b=n4W9izUPQhh78nbtLMumHMmU4YOJQ+WnSLVWa+cZovd1Pg07dvAFD9r9Kt63m+z9Mz
         l06L7Lh5CMGTJXnBsVK76ZE5HfMFMiXTVj1igFdH0QSfekslOteEBNsPZDuxOe3n+QiR
         /AFsYzboBf+a21jKOyk5ZnSYasSD/TY0S/ilo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i2OuSbsJlPCM1nijUgo0LIeVNHnNSiAiSE0YFjuoHa3ZFF2OvOXOpHgcbERVLTrOSW
         4+yuC395n3y/qA/aJRXnInawDW4qNBdcjzEJcC8jrlvgQitMB6bG09VzZ49a3lbdibf3
         B8OEIKbe2cBjNa1rbkUQT4lXixg4rmwnQvnTE=
Received: by 10.14.1.71 with SMTP id 47mr3735eec.128.1306966711110; Wed, 01
 Jun 2011 15:18:31 -0700 (PDT)
Received: by 10.14.22.4 with HTTP; Wed, 1 Jun 2011 15:18:30 -0700 (PDT)
In-Reply-To: <20110601220518.GA32681@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174907>

>> git clone ssh://127.0.0.1/`pwd`/test test2
>> remote: Counting objects: 3, done.
>> remote: Total 3 (delta 0), reused 0 (delta 0)
>> Receiving objects: 100% (3/3), done.
>> error: Trying to write ref HEAD with nonexistant object
>> 91dbc2403853783f637744c31036f94a66084286
>> fatal: Cannot update the ref 'HEAD'.
>
> This is quite bad behavior. In addition to the ugly error messages, i=
t
> actually aborts the clone. So it is impossible to clone a repo with a
> detached HEAD that is not otherwise referenced.
Which could be evil without resumable clone on a big repo.
git clone --bare will work though.

> We basically have two choices:
>
> =A01. Fetch objects for HEAD on clone.
>
> =A02. Don't checkout a detached HEAD if we don't have the object (or
> =A0 =A0 possibly, don't checkout a detached HEAD at all; we already d=
o
> =A0 =A0 something similar for the case of a HEAD that points to a bog=
us
> =A0 =A0 branch).
>
> I think (2) is more consistent with the refspec we set up, but (1) is
> probably more convenient to users (and better matches the case where =
the
> remote is on a detached HEAD that _does_ point to something we have).
I like (2) a bit more too, and give a hint about explicit HEAD fetching=
=2E

> I think it should just be a matter of adding HEAD to the list of thin=
gs
> we fetch, although we don't actually want to write it to a ref. I'll
> take a look.
I tried to hack it through via adding HEAD:HEADtmp static const
refspec to remote.{h,c}
and hit "Ignoring funny ref 'HEAD' locally" in remote.c:get_fetch_map,
commented out that ignore and got:

error: unable to resolve reference HEAD: No such file or directory
fatal: Cannot lock the ref 'HEAD'.

from builtin/clone.c:
=2E..
                        const char *head =3D skip_prefix(our_head_point=
s_at->name,
                                                       "refs/heads/");

                        update_ref(reflog_msg.buf, "HEAD",
                                   our_head_points_at->old_sha1,
                                   NULL, 0, DIE_ON_ERR);
=2E..
afaik from gdb HEAD ended up being a symlink to "" ref or so.
