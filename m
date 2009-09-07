From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Mon, 7 Sep 2009 17:27:51 +0800
Message-ID: <20090907172751.6cf38640.rctay89@gmail.com>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
	<0016e6470f36315b8a0472bc75a8@google.com>
	<20090904212956.f02b0c60.rctay89@gmail.com>
	<7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
	<be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
	<7vocpn44dg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 11:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkaWF-00069g-P4
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 11:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbZIGJ2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 05:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZIGJ2D
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 05:28:03 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:46289 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZIGJ2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 05:28:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so6526599and.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=mj9Av70Xlac3agWHHGi/fXRp5ePdrVvpA+YJAzBt5Ks=;
        b=HclGNBC6sZEmn8U1/J2O15PufdR3aCayzgy2UJ9+eP9zwCry4/xOQfddjmYSP7G9ZG
         6iQ7SpXDPo/PLZEV5WAp+tjvLZVcqIqoB2eQvOVZG2md68uWIjyCV3/qnD9UpRYRbokD
         ZXve1hZZtQS5PdH9/WB5IGOZiyvqan30AXUV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=cuslmVxtM4P1SGE6tei0qk3Z00BDewlMLWhMOTmA0kpbxJWofzoE81WzvTIWez1QWz
         dR7+amBplo7U4/5f/MTNu7NqgYrp99U/2dYonDPMRZbuG6Sd4vBGYOqelfwBvu0apWpl
         UqWAi1YKeOAP1ctoF6oGRyvoSdmNfSyOo1j2E=
Received: by 10.101.55.7 with SMTP id h7mr15108977ank.116.1252315684931;
        Mon, 07 Sep 2009 02:28:04 -0700 (PDT)
Received: from your-cukc5e3z5n (cm99.zeta152.maxonline.com.sg [116.87.152.99])
        by mx.google.com with ESMTPS id c14sm544682ana.8.2009.09.07.02.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 02:28:04 -0700 (PDT)
In-Reply-To: <7vocpn44dg.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127914>

Hi,

On Mon, Sep 7, 2009 at 3:10 PM, Junio C Hamano<gitster@pobox.com> wrote:
> We couldn't perform the check, and then what happens?  We continue as if
> everything is peachy, assuming that the *.idx file we thought we were
> going to get describe what objects are in the corresponding pack, and barf
> when we try to read the *.idx file that we failed to download even though
> the server said we should be able to get it?

We didn't check for the *.idx, only the corresponding *.pack file.

About barfing on a failed *.idx file transfer: in 48188c2 and later, we
still do have ample checks here and there in the HTTP api. http_get_file()
returns a HTTP_ERROR if we fail to get a file (a *.idx file here).

The issue is that the check on the file (a HEAD request) fails, but not
its actual transfer (a GET request). There's no compromise on error
handling; we can live with a bad response to HEAD requests, but we will
still fail if we can't GET the file.

> Ahh, v1.6.3 ships with fetch_index() that checks CURLE_OK and returns an
> error(), but that is about .idx file, and it did not have the "do they
> have the corresponding .pack file?" check introduced by 48188c2
> (http-walker: verify remote packs, 2009-06-06), which is what makes the
> server give us 500 error.

Just to clarify: the "check" of CURLE_OK in http-walker.c::fetch_index()
in v1.6.3 is fundamentally different from the check we have in 48188c2
(http-walker: verify remote packs, 2009-06-06).

The first "check" is a full-blooded GET request, and we do get back
actual data (in this case, the pack index file). The second check isn't
a GET request, just an inconsequential HEAD request; we don't get back
any real data.

> Before that check, we ignored a request to
> fetch_index() if we already had one.

48188c2 didn't really remove the check (for the presence of the *.idx
locally), it just pushed it further down.

But being placed so late makes it rather ineffective and useless.

> Why do we even call fetch_index() when we have one?  After all, we are
> talking about "git clone" here, so it is not about "we failed once and the
> previous attempt left .idx files we fetched".  Why
>
> should we even have .idx file to begin with, that would have protected
> v1.6.3 clients from getting this error?
>
> Unless we are calling fetch_index() on the same .idx file twice from our
> own stupidity, that is.
>
> The same logic now is in fetch_pack_index(), which is called from
> fetch_and_setup_pack_index().  I do not still see how we end up calling
> the function for the same .idx file twice, though.

We should bump up this check before the verify-remote-pack one, I think
there's no mysterious bug here to find.

> In the meantime, I do not think it is a good idea to loosen the error
> checking on our side to accomodate a server in such a (hopefully
> temporary) broken state, however popular it is.

Agreed. I didn't intend my patch to loosen up error checking, merely to
be clearer about what we're looking for. If read in another context
(separate from fixing cloning over github.com), my patch can be seen as
one that clarifies the verify-remote-pack check:

  Case 1: A 404 is received. The pack file is not available, so we stop.

  Case 2: Our check failed, due to some reason (request failed,
          unauthorized, etc). Nothing conclusive about availabilty of
          file. Continue anyway.

PS. I wrote 48188c2 with the aim of having http-push.c and http-walker.c
fetch behaviour match each other as closely as possible, and later move
these out into http. At that time, I toyed with the idea of removing
the check. I wondered if the overhead incurred by the HEAD request was
useful, since if there's going to be an error, we would be hit anyway
with a GET. We already do this for almost every other http request
(info/refs, objects/info/packs, etc). But the patch series was meant to
be a refactor job, not a feature/behaviour change, so there you have it.

-- 
Cheers,
Ray Chuan
