From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Is there a quick way to identify commits that reference missing
 trees or blobs?
Date: Tue, 26 Jul 2011 11:39:55 +1000
Message-ID: <CAH3AnrouGUPvnYk_O1W_a5qZCmePC41GgEX_qcS3HLpkEm9pHw@mail.gmail.com>
References: <CAH3AnroyfeGOo_23nHKhLjxEnP_qEMi7as1UjXEFjjuVOckBjw@mail.gmail.com>
	<20110725223449.GA25560@toss.lan>
	<20110725224408.GA26057@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 26 03:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlWcr-000547-I0
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 03:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab1GZBj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 21:39:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48138 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab1GZBj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 21:39:56 -0400
Received: by vws1 with SMTP id 1so3393189vws.19
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r9bmcIMKYdTesiEHB2GPA/hw0U01y7BhDpDbmS6ujh4=;
        b=F4PZgQpZUotkBuahGbfw+pAzaTXYrxb4THm3Zc1qGomIZwlazJ29JSq/J/UcjEn8Ri
         vfR1pCZJhDaRhSfuarjxLvkNjKt9yuK1q+Ws9vfxFT4xD6GQGBzugycZhaQw25Poy+od
         yKGb4AtzWLNete3G9wr/8ks4+rHsBzv8jaQKw=
Received: by 10.52.74.69 with SMTP id r5mr2572798vdv.307.1311644395574; Mon,
 25 Jul 2011 18:39:55 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Mon, 25 Jul 2011 18:39:55 -0700 (PDT)
In-Reply-To: <20110725224408.GA26057@toss.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177836>

On Tue, Jul 26, 2011 at 8:44 AM, Clemens Buchacher <drizzd@aon.at> wrot=
e:
> On Tue, Jul 26, 2011 at 12:34:50AM +0200, Clemens Buchacher wrote:
>> On Sun, Jul 24, 2011 at 02:48:20AM +1000, Jon Seymour wrote:
>> >
>> > I was wondering if there is a quick way to identify commits that
>> > reference missing trees or blobs as identified by git fsck?
>>
>> The following command has served me well for this purpose. I apply
>> it to each ref in git-for-each-ref:
>>
>> $ git rev-list --objects $ref | git cat-file --batch-check
>
> Oh, and here is the output you get for different situations. Exit
> status is always 0 unfortunately.
>
> =C2=A0- missing blob
>
> fatal: missing blob object '78981922613b2afb6025042ff6bd878ac1994e85'
> d165426eba5cb4c125bd6e100d1b5de7298eb601 commit 168
> 848740929e99bda0e1a9783e7daa314c5a9732d5 =C2=A0missing
>
> =C2=A0- missing tree
>
> error: Could not read 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
> fatal: bad tree object 84bf061d017459b4be45a49b8d8dc945e7a7fdf5
> abce3ad54002628ab74d72b7e2baa687abcb77f9 commit 168
>
> =C2=A0- missing parent commit
>
> error: Could not read 3aa66f30aa9799ac38a53b551ac4faca9cbd400b
> fatal: Failed to traverse parents of commit 3cfb98a3cbd3f42852e20bd01=
1c7b835b8750df7
>
> Clemens
>

Thanks for that.

Junio, also pointed out in another thread that git rev-list --objects
is quite useful for this purpose. His variant used git pack-objects
which apparently does exit with zero status code.  The zero exit code
here looks like a bug, I think, so perhaps I will submit a patch for
that too (I just did one for git ls-tree).

While concise it isn't a particularly fast way to find commits
affected by damaged trees - it is O(N^2*M), where N is the number of
commits and M is the size of the tree. As indicated in another thread,
I think bisection can potentially be O(K * log(N) * M + K*N), where K
is the number of fully connected bad subgraphs. [ by that I mean a
subgraph consisting only of commits with damaged trees).

jon.
