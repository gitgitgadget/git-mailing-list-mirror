From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: [StGit PATCH 4/5] Simplify editor selection logic
Date: Wed, 30 Jan 2008 09:55:18 -0500
Message-ID: <76718490801300655r3d1b5b41l2945b4f730faedb2@mail.gmail.com>
References: <20080129030059.926.29897.stgit@yoghurt>
	 <20080129030349.926.45486.stgit@yoghurt>
	 <200801292109.37785.kumbayo84@arcor.de>
	 <20080130072828.GA24648@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>,
	"Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 15:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKEM0-0007JG-IJ
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 15:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYA3OzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2008 09:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYA3OzW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 09:55:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:5446 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYA3OzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2008 09:55:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so419110wah.23
        for <git@vger.kernel.org>; Wed, 30 Jan 2008 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=O9GtRFnfSoz/vsrSfP2sGT3krlqv8AkMURxwqDswsuw=;
        b=g9xdLVpa/iPz/wIKRCUTp1rmTzNR6JHlaKS23+pKQZy+fIzAI5eBXATkiUdQFPMs9581coi/WuRf2h7DuOr12SOy90fvYndTT3gnaSXVNcaVmxxc4fYRqRhKJFE6PXDM2LixStGLTLMQaxdBPkOOW53kZ0xlnv+B9pEXc0QWNEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=eRjV95PVuwbULKPcKLGy/6iQa8klRA9evyHrZP8sPw8toVfhsCAbKdKDN5dZ8CpXp4Pv0ez4H/9/8ropmX5snxb230wffJB5pwOYXGqDMhc+ixHcVmrIOU/1oHo5b6d4ntOUF/FikzzEEn4yHwoevrhikvbY6waoW8gXMCzmUto=
Received: by 10.114.149.2 with SMTP id w2mr984251wad.5.1201704918033;
        Wed, 30 Jan 2008 06:55:18 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Wed, 30 Jan 2008 06:55:18 -0800 (PST)
In-Reply-To: <20080130072828.GA24648@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 067d2dbe4c8fdf1d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72057>

On Jan 30, 2008 2:28 AM, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> You could write it kind of like this:
>
>   def e(key): return os.environ.get(key, None)
>   def c(key): return config.get(key)
>   editor =3D filter(None, [e('GIT_EDITOR'), c('stgit.editor'), c('cor=
e.editor'),
>                          e('VISUAL'), e('EDITOR'), 'vi'])[0]

Too clever by half if you ask me. Why not just:

editor =3D (os.environ.get('GIT_EDITOR') or
          config.get('stgit.editor') or
          config.get('core.editor') or
          os.environ.get('VISUAL') or
          os.environ.get('EDITOR') or
          'vi')

And be done with it?

> Of course, if we're going to have code like this in several places
> (you already mentioned the pager), we could build a function like
> this:
>
>   editor =3D get_config(['GIT_EDITOR', 'stgit.editor', 'core.editor',
>                        'VISUAL', 'EDITOR'], default =3D 'vi')
>
> that would differentiate between env variables and conf keys by
> looking for dots in the name or something.

def get_config(keys, default=3DNone):
    rv =3D default
    for k in keys:
        if '.' in k:
            d =3D config
        else:
            d =3D os.environ
        if k in d:
            rv =3D d[k]
            break
    return rv

j.
