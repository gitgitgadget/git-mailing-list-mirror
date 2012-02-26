From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 18:11:30 +0700
Message-ID: <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 12:12:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1c21-000881-BP
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 12:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2BZLMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 06:12:03 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:42174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2BZLMC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 06:12:02 -0500
Received: by werb13 with SMTP id b13so2252228wer.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 03:12:00 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.86.230 as permitted sender) client-ip=10.180.86.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.86.230 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.86.230])
        by 10.180.86.230 with SMTP id s6mr9843379wiz.16.1330254720434 (num_hops = 1);
        Sun, 26 Feb 2012 03:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7GUQAjYzu5B5VMZdmL9euOxfzC0koR8246xYdTLlQ0k=;
        b=Fbgk+qSjoL1i5mkzBrzC/huKCGhxzNSjuFTHs6WaEjUVI9czeGH41ogXmN5YukDv9e
         zWeiBajjh214rB26eXPv75fNiAoCWl7HOhesoVPsWQt6DaVKjdbSZ5857NjPiQT7RwuP
         dNrrYXJFR//ohnx04XuDuf8j/m+yU4VNCaxiY=
Received: by 10.180.86.230 with SMTP id s6mr7786153wiz.16.1330254720325; Sun,
 26 Feb 2012 03:12:00 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sun, 26 Feb 2012 03:11:30 -0800 (PST)
In-Reply-To: <7vk43af14m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191559>

On Sun, Feb 26, 2012 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> ... I wonder if this is a
>> redundant check. --verify-objects is called to verify new packs.
>
> I do not think --verify-objects does not have anything to do with
> verifying the integrity of packs, whether new or old.
>
> The check is about the integrity of the *history* we _might_ already =
have
> on our side, when we find ourselves wanting to fetch up to a commit $=
X,
> whose reachability from the tips of our refs (i.e. the objects that a=
re
> guaranteed to be present in our repository) is unknown, and we someho=
w
> already have the commit $X itself in the repository.
>
> We cannot just declare victory upon seeing commit $X and omit fetchin=
g the
> history leading to the commit, because we may or may not have its par=
ent
> commit object, or the tree object that is recorded in it (it may be t=
hat
> we killed an HTTP walker after we fetched $X but not its parents or
> trees). =C2=A0We need to walk back from $X until we hit one of the ti=
ps of our
> refs, and while doing so, we also need to make sure the trees and blo=
bs
> referenced from the walked commits are also healthy.
>
> As 5a48d24 (rev-list --verify-object, 2011-09-01) explains, we used t=
o do
> this with --objects instead, but that check does not even make sure b=
lobs
> exist [*1*] let alone checking to see if these blobs were healthy. =C2=
=A0The
> whole point of using --verify-objects instead of --objects is to make=
 sure
> that we do not miss blob objects.

"rev-list --objects" does check for blob existence, in finish_object().

On the well-formedness, unless I'm mistaken, --verify-objects is
_always_ used in conjunction with index-pack. --verify-object is not
even documented. index-pack makes sure all (new) object signatures
reflect their content. Commit and tree content are validated by
rev-list walking them. So at least when --verify-objects is used with
index-pack, I don't see the point rehashing every new object _again_.

> [Footnote]
>
> *1* The --objects code reads the commits and trees in order to _list_
> objects to the blob level, so implicitly, it validates that commits a=
nd
> trees reachable from the commit $X we happened to have in our reposit=
ory,
> relying on the fact that we would error out if we fail to read them.



--=20
Duy
