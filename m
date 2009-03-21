From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 1/2] t7700: demonstrate repack flaw which may loosen 
	objects unnecessarily
Date: Sat, 21 Mar 2009 18:16:58 -0500
Message-ID: <ee63ef30903211616pdf9fdal51dda518dd3cfec@mail.gmail.com>
References: <ee63ef30903211525q4a95a27eoa4e95c7954e5cc93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlASY-0006bZ-3H
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbZCUXRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbZCUXRB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:17:01 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:55430 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZCUXRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:17:00 -0400
Received: by gxk4 with SMTP id 4so4351012gxk.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o7F4nC204TUo5mkM4PX/HQq60ojYqH2z6kRW6cWUbIs=;
        b=nTphDvS84Btrqf67lT1XlNMg4dO5+X2FVpsjtCz34EQNct2PgUZcOmCAmxEpItgRXc
         sXAKq9K8Tr/hN3vQf66tBrZ4aabFjR70IPgXPkXKnb+wQCv5NiJwSHl2FCL9SWpdzdFU
         mW+Imt76+YwekgHyO3OLgbP5rQQZAAXTPLsDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fHFW3XFMp+CB25H1FKxAeDmEdTWt9g1tmAW6+Y405sRpEODwYduqJ6uSH4sGzI14CP
         lkiWGnT4kWw1Dk7VyWaEYeLU1N4Da4qPPTWxAtZ/3Bir2ypAWQYxKRysGTScV9TisiOn
         OuAZjscu1NdFWgNPo2RmVXKbPoSlO50t5WzxA=
Received: by 10.150.217.14 with SMTP id p14mr293812ybg.209.1237677418353; Sat, 
	21 Mar 2009 16:16:58 -0700 (PDT)
In-Reply-To: <ee63ef30903211525q4a95a27eoa4e95c7954e5cc93@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114095>

Man I just can't seem to get a patch off without issues.  I meant to
put these two comments in the patch emails.

1) Junio, these two patches are on top of 4d6acb70 which was the tip
of your jc/maint-1.6.0-keep-pack branch.

2) Also, note that this issue affects --keep-unreachable too, but the
fix is different since add_objects_in_unpacked_packs() just calls
add_object_entry() to add the unreachable objects to the list of
objects to pack and it (add_object_entry) already iterates on the pack
list.  One way to fix it, which feels very kludgy to me, is to
temporarily set 'local' to one before calling add_object_entry, so
that it will do nothing if the object is found in any non-local pack.
Unless I'm convinced it is worth it, I don't plan on fixing it.  I
doubt anyone uses --keep-unreachable manually.  It was invented to
make git-gc safe and has now been replaced by --unpack-unreachable.
So, --keep-unreachable may pack objects that it doesn't really need to
pack.  I can live with it.

-brandon


On Sat, Mar 21, 2009 at 5:25 PM, Brandon Casey <drafnel@gmail.com> wrote:
> If an unreferenced object exists in both a local pack and in either a pack
> residing in an alternate object database or a local kept pack, then the
> pack-objects call made by repack will loosen that object only to have it
> immediately pruned by repack's call to prune-packed.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
