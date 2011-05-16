From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/11] streaming: read non-delta incrementally from a pack
Date: Sun, 15 May 2011 17:58:46 -0700
Message-ID: <BANLkTin7DALU8sfFxzJo62DGtNE2fsZxXw@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com> <1305505831-31587-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLm9c-0003jP-Ku
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 02:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab1EPA7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 20:59:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57809 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1EPA7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 20:59:08 -0400
Received: by vws1 with SMTP id 1so2819449vws.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 17:59:08 -0700 (PDT)
Received: by 10.52.180.135 with SMTP id do7mr5241616vdc.273.1305507546079;
 Sun, 15 May 2011 17:59:06 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 17:58:46 -0700 (PDT)
In-Reply-To: <1305505831-31587-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173697>

On Sun, May 15, 2011 at 17:30, Junio C Hamano <gitster@pobox.com> wrote=
:
> +static read_method_decl(pack_non_delta)

I am not a huge fan of these decl macros... but I can see how writing
out the same function prototype 3 times is annoying.

> + =A0 =A0 =A0 switch (in_pack_type) {
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1; /* we do not do deltas for n=
ow */

Haha. Deltas are going to be painful. Very, very painful.

We actually try to stream deltas in JGit. Our implementation isn't
useful. It only works if the base object is only accessed in
sequential order by the delta instruction sequences.

I had plans to add an external delta base cache to
$GIT_DIR/objects/delta-base-cache using a block file format that is
random accessible, but has CRC-32 checksums on each block to still
ensure there isn't silent data corruption on reads. You can read more
about it here http://egit.eclipse.org/r/1724 but the patch is probably
stalled and will get abandoned.

I think the better strategy is to avoid delta compression altogether
for objects that are so big we cannot materialize them as a contiguous
buffer. What a reasonable limit is, I don't know... but its probably
got to be around 25-50 MB. The Android project (as an example) has 6+
MB XML documents in their source code repository that are very delta
compressible.

--=20
Shawn.
