From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 09:32:38 -0700
Message-ID: <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> 
	<1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org> 
	<fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com> 
	<20091029155607.GA10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XwH-0001kS-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbZJ2QdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbZJ2QdE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:33:04 -0400
Received: from mail-ew0-f209.google.com ([209.85.219.209]:50590 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZJ2QdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 12:33:02 -0400
Received: by ewy5 with SMTP id 5so171757ewy.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=elpS38ocsCfrnWWI7aZESRRCiXZMUyuroq2WVSLR8nc=;
        b=KlNJvo+a8jthZw04UAmQ/bLRygZLWLvr/hDY5PJlkUhep1lBZGrwbU3BLVd8XF/tJ1
         Cb7ZKkxM1xmNaH9dXNba5p1w3bT7QRanCek6liBRoGXb9zoZFNg8xDJLozcK97wCnHIJ
         Q8YHBuaDCSTvbDjBorAuEOIviKIj8qbOspN1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ORlTtOhO2p5qyT+sifN5ccD49204m2fRBJ3Ee7EkN63A4b/K1SZqM/49EuqcG2MvHc
         EL8uoVoViySTqpQ0YJu3Ep6kF1gZu6K2ULMVjMDAG8OKaqzgO+VQmZjZgt4DyGDmovpr
         9RH2g1/uZP7zSg81iz35g7Xj5gignhlIChwB8=
Received: by 10.216.89.13 with SMTP id b13mr134733wef.45.1256833978104; Thu, 
	29 Oct 2009 09:32:58 -0700 (PDT)
In-Reply-To: <20091029155607.GA10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131611>

Heya,

On Thu, Oct 29, 2009 at 08:56, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
>> > I certainly have to wonder... if this is done in both fetch and
>> > clone, why isn't it just part of fetch_refs?
>>
>> Because clone does not use fetch_refs, or am I missing something?
>
> Hmmph. =A0Weird. =A0Its been a while since I last looked at this code=
,
> maybe I misunderstood it.

Unless you mean transport_fetch_refs? It can't be done in
transport_fetch_refs because the foreign helper transport needs to
update all refs, including those that wanted_peer_refs decided not to
fetch. Otherwise the 'HEAD' ref will not be updated, and it is left at
all zeros. It is not as obvious that that is a problem in this patch,
but when Junio merges with Nico's [5bdc32d3e "make 'git clone' ask the
remote only for objects it cares about"] the code looks like this:

		if (refs) {
			struct ref *ref_cpy;
			mapped_refs =3D wanted_peer_refs(refs, refspec);
			ref_cpy =3D copy_ref_list(mapped_refs);
			transport_fetch_refs(transport, ref_cpy);
			if (transport->update_refs)
			{
				ref_cpy =3D copy_ref_list(refs);
				transport->update_refs(transport, ref_cpy);
				refs =3D ref_cpy;
				mapped_refs =3D wanted_peer_refs(refs, refspec);
			}
		}

Does it make more sense now? transport_fetch_refs gets only a limited
view of the refs, so it cannot pass all the refs to
transport_update_refs as needed.

--=20
Cheers,

Sverre Rabbelier
