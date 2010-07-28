From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 21:31:38 -0400
Message-ID: <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> 
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> 
	<20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com> 
	<52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvV9-0001ek-Br
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab0G1BcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 21:32:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43989 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0G1BcB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 21:32:01 -0400
Received: by wwj40 with SMTP id 40so1915777wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PVpTz7DVns6e8fJJQewGJkmsDnDVrJzro2TMjSmTPuo=;
        b=PwnNs/OXRCuMrSsoQ+8a8FLopqtW6Ph3uE411dbPnO16QlmaDE/Lcavo5+OTbqQDlG
         HTUmWws/zhTKC9t9byat5o72dl0aVoLGT0EKxqkk5SMyztQ0Rfld0i5ZkZkhN4Fzc6Ab
         G7EmumekEOQGt4nsmTZO1qp7DGz9Ce2ITF8VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bm5edEPHmqew56GZqPBYBHQAqR/vNpY9mRKPatysbDnq0MqNE+KHiUSH+Xu7p0W8vD
         xlCtuFK6sSsJ+zHlrfbu0RGc3K3q9Im0dfVwOMMugoXN/3cWcpBjuYbOBlNjcHre2jjM
         K6p0QzNAuUjZrSxscRJyiOrLzNsJcTvQ8mG+o=
Received: by 10.227.129.149 with SMTP id o21mr9731959wbs.176.1280280718243; 
	Tue, 27 Jul 2010 18:31:58 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 18:31:38 -0700 (PDT)
In-Reply-To: <52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152028>

On Tue, Jul 27, 2010 at 9:14 PM, Joshua Juran <jjuran@gmail.com> wrote:
> Okay, I have an idea. =A0If I understand correctly, the index is a fl=
at
> database of records including a pathname and several fixed-length fie=
lds.
> =A0Since the records are not fixed-length, only sequential search is =
possible,
> even though the records are sorted by pathname.
>
> Here's the idea: =A0Divide the database into blocks. =A0Each block co=
ntains a
> block header and the records belonging to a single directory. =A0The =
block
> header contains the length of the block and also the offset to the ne=
xt
> block, in bytes. =A0In addition to a record for each indexed file in =
a
> directory, a directory's block also contains records for subdirectori=
es. The
> mode flags in a record indicate the record type. =A0Directory records=
 contain
> an offset in bytes to the block for that directory (in place of the S=
HA-1
> hash). =A0The block list is preceded by a file header, which includes=
 the
> offset in bytes of the root block. =A0All offsets are from the beginn=
ing of
> the file.
>
> Instead of having to search among every file in the repository, the s=
earch
> space now includes only the immediate descendants of each directory i=
n the
> target file's path. =A0If a directory is modified then it can either =
be
> rewritten in place (if there's sufficient room) or appended to the en=
d of
> the file (requiring the old and new sequentially preceding blocks and=
 the
> parent directory's block to update their offsets).

Yeah, that's pretty much what bup's current format does, minus
appending rewritten dirs at the end when files are added.  I've
thought of that, but sooner or later, the file would need to be
rewritten anyway, and then you end up with odd performance
characteristics where the file expands in random ways and then shrinks
again when you decide it's gotten too big.  And if you do try to reuse
empty blocks - which should mostly avoid the endless growth problem -
you basically just have a database, including fragmentation problems
and multi-user concerns and all.  That's what made me think that
sqlite might be a sensible choice, since it's already a database :)

But maybe there's some simpler way.

Have fun,

Avery
