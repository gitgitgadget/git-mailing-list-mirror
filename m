From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: RFC: reverse history tree, for faster & background clones
Date: Fri, 12 Jun 2015 14:33:30 +0200
Message-ID: <1434112410.5381.8.camel@kaarsemaker.net>
References: <mlefli$h6v$1@ger.gmane.org>
	 <1434108815.5381.3.camel@kaarsemaker.net> <mlegd8$t71$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andres G. Aragoneses" <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:33:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3O9U-0000u2-9B
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 14:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbbFLMdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 08:33:36 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35080 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbbFLMdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 08:33:35 -0400
Received: by wgme6 with SMTP id e6so23827272wgm.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=9TMCWsXsZKi+ks0xmnakVU630pP3nL3V8UBfSghh6ts=;
        b=Vw7dZOplf9uGcZCAplXkEMKtyppqQ+f0qcipbVsP+nOPIigxDGQr1vnRJ2ENv13Hvd
         W6nEZ4MYwiexBbpiMMe1teHWHwYRxS8klq9GWYHhCPsmbHRRdQhGLOhPH2UhK2ofSXcS
         TlFe6uFR2Sg3nm5fomHjE9szXsRGrumU70aAHefNa4K/KmEh2yKYEdIte3V/f2vgDLcF
         v93KhWDRxoRgMLON0m6wfS5LmCC3bcVnRK5lR75hVP0MqIfUqoRE3YTmmLI4Nir9xIQR
         8mDnPAghHYzewO0MU9ZhESkzMQLmZtnqdzsDhvxeIGaYIzJ4YQGcCP8mU/KbSSF8txxB
         gi5g==
X-Gm-Message-State: ALoCoQkAwCWZacRpQMP/mHQA0nxCGK0XIuH/a9pN7DYV9p/gaqAcHhP12fhQOEVsjZo3jTISNKJj
X-Received: by 10.180.13.175 with SMTP id i15mr6588071wic.30.1434112413866;
        Fri, 12 Jun 2015 05:33:33 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id bw5sm5644273wjc.31.2015.06.12.05.33.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 05:33:32 -0700 (PDT)
In-Reply-To: <mlegd8$t71$1@ger.gmane.org>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271483>

On vr, 2015-06-12 at 13:39 +0200, Andres G. Aragoneses wrote:
> On 12/06/15 13:33, Dennis Kaarsemaker wrote:
> > On vr, 2015-06-12 at 13:26 +0200, Andres G. Aragoneses wrote:
> >
> >> AFAIU git stores the contents of a repo as a sequence of patches in the
> >> .git metadata folder.
> >
> > It does not, it stores full snapshots of files.
> 
> In bare repos too?

Yes. A bare repo is nothing more than the .git dir of a non-bare repo
with the core.bare variable set to True :)

> >> 1. `git clone --depth 1` would be way faster, and without the need of
> >> on-demand compressing of packfiles in the server side, correct me if I'm
> >> wrong?
> >
> > You're wrong due to the misunderstanding of how git works :)
> 
> Thanks for pointing this out, do you mind giving me a link of some docs 
> where I can correct my knowledge about this?

http://git-scm.com/book/en/v2/Git-Internals-Git-Objects should help.

> >> 2. `git clone` would be able to allow a "fast operation, complete in the
> >> background" mode that would allow you to download the first snapshot of
> >> the repo very quickly, so that the user would be able to start working
> >> on his working directory very quickly, while a "background job" keeps
> >> retreiving the history data in the background.
> >
> > This could actually be a good thing, and can be emulated now with git
> > clone --depth=1 and subsequent fetches in the background to deepen the
> > history. I can see some value in clone doing this by itself, first doing
> > a depth=1 fetch, then launching itself into the background, giving you a
> > worktree to play with earlier.
> 
> You're right, didn't think about the feature that converts a --depth=1 
> repo to a normal one. Then a patch that would create a --progressive 
> flag (for instance, didn't think of a better name yet) for the `clone` 
> command would actually be trivial to create, I assume, because it would 
> just use `depth=1` and then retrieve the rest of the history in the 
> background, right?

A naive implementation that does just clone --depth=1 and then fetch
--unshallow would probably not be too hard, no. But whether that would
be the 'right' way of implementing it, I wouldn't know.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
