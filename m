From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Mon, 28 Apr 2014 14:18:44 -0700
Message-ID: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:19:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesxE-0004HW-QY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbaD1VTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 17:19:07 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:53029 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbaD1VTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 17:19:05 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so6442374wib.14
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pzxW+44p0gLC0FZOqlXKkC9MkVUQ7ZGcOPhJQs3DonQ=;
        b=HebwEjSzXJBClUzk9G3Eq8LbAfzASY9wXZH8dz6hq41mskufuYVuYVAVxh5AV4JwDr
         VJ1kY0JgLtehYxrV2xueyn6H/DDXboJVt2HkdHFNxPUhdKh/SgWt8eAHhzLgDQNqh2CS
         ON6+pajnWVjEvuQQbVm+EBjse2LvvEIDyo0AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pzxW+44p0gLC0FZOqlXKkC9MkVUQ7ZGcOPhJQs3DonQ=;
        b=eVYpeymQDCL8A4z1nrPmMYOR1lmU6Zpyd9DLQFH9MUGfrxHfa/xMUgGH1uh3yWBCVn
         544fIT9XJ+SjQAZK2Qb0yod7AAyZDDc+JnwIe+b/6e/GqbQfOUwWTN/Q7MC1Mmu7UZPQ
         DQgl/yCq8tM1mnO7jOLZAxTJDshsnaBHfPlFJp/eNhdloysta697llSEwtu3YqXRiL2N
         BEIW5oyprL2tdA9sLUe6lAZ5T+VVVZFVgXfP/3zpeM2nSkc6WAGKpp2HELaZok3vVmVQ
         9hb7YPkwgMgFAPY8VP4t5Utxc7dtddL9LhbTGsD7bjWPAN8JQ2qZA/PrfEsJyh7xVFmC
         s8ew==
X-Gm-Message-State: ALoCoQngQmU7l6zUBPYKISuqqU4fGL93wswxMVEx1lhBLSsoHCk2cynRgKUmG253f/ykMdBP8uHc
X-Received: by 10.195.18.8 with SMTP id gi8mr82659wjd.75.1398719944368; Mon,
 28 Apr 2014 14:19:04 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Mon, 28 Apr 2014 14:18:44 -0700 (PDT)
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247454>

On Mon, Apr 28, 2014 at 3:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> I hinted about it earlier [1]. It now passes the test suite and with =
a
> design that I'm happy with (thanks to Junio for a suggestion about th=
e
> rename problem).
>
> From the user point of view, this reduces the writable size of index
> down to the number of updated files. For example my webkit index v4 i=
s
> 14MB. With a fresh split, I only have to update an index of 200KB.
> Every file I touch will add about 80 bytes to that. As long as I don'=
t
> touch every single tracked file in my worktree, I should not pay
> penalty for writing 14MB index file on every operation.

This is a very welcome type of improvement.

I am however concerned about the complexity of the format employed.
Why do we need two EWAH bitmaps in the new index? Why isn't this just
a pair of sorted files that are merge-joined at read, with records in
$GIT_DIR/index taking priority over same-named records in
$GIT_DIR/sharedindex.$SHA1?  Deletes could be marked with a bit or an
"all zero" metadata record.

> The read penalty is not addressed here, so I still pay 14MB hashing
> cost. But that's an easy problem. We could cache the validated index
> in a daemon. Whenever git needs to load an index, it pokes the daemon=
=2E
> The daemon verifies that the on-disk index still has the same
> signature, then sends the in-mem index to git. When git updates the
> index, it pokes the daemon again to update in-mem index. Next time gi=
t
> reads the index, it does not have to pay I/O cost any more (actually
> it does but the cost is hidden away when you do not have to read it
> yet).

If we are going this far, maybe it is worthwhile building a mmap()
region the daemon exports to the git client that holds the "in memory"
format of the index. Clients would mmap this PROT_READ, MAP_PRIVATE
and can then quickly access the base file information without doing
further validation, or copying the large(ish) data over a pipe.


Junio had some other great ideas for improving the index on really
large trees. Maybe I should let him comment since they are really his
ideas. Something about not even checking out most files, storing most
subtrees as just a "tree" entry in the index. E.g. if you are a bad
developer and never touch the "t/" subdirectory then that is stored as
just "t" and the SHA-1 of the "t" tree, rather than the recursively
exploded list of the test directory.
