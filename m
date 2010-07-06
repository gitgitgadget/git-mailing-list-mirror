From: Dylan Reid <dgreid@gmail.com>
Subject: Re: [PATCH] xdiff: optimise for no whitespace difference when 
	ignoring whitespace.
Date: Mon, 5 Jul 2010 23:04:09 -0400
Message-ID: <AANLkTilkML1edHz6JSj7w3u60oFt3Va-5Z2ZBWVphxVI@mail.gmail.com>
References: <1278310017-24299-1-git-send-email-dgreid@gmail.com>
	<1278334842-9701-1-git-send-email-dgreid@gmail.com>
	<7vsk3x72wb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 05:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVySF-0007qr-Np
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 05:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab0GFDEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 23:04:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40859 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab0GFDEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 23:04:10 -0400
Received: by gye5 with SMTP id 5so1509415gye.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 20:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bqO2XheFgWNf4NpBmYqwoiJZMmrmlrR7MJXVu+Sftok=;
        b=jZJX4vdBSlbDGoWeJ9xTL0wQzoeD7pCMhvZi9vkwmZmzjwEFCTP3yfKpGTiFYXgBZy
         BGKJAbUp99AvB1fp6ZD+6Lx1TaIzJo8P3RuRDDAf/Id7OUDj3ZD7kou+fWme0A/bt5wA
         os13QgjyUOgAEewCz1oMLWEQENdhOvFa2dWEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RC589c+B4Cr4QI/kuTdpmdiulYjlXFYF/moC5Bpfi/4R+FCsmaLX5GxxRmsF2PRK/g
         UIGl3GTex3ELHkIvmiIv/RzdirPbIky0ms2EftDC4VVRLgPSXZJS1cd0J/bNNp57XnkS
         vI8R6ENn3acDXwJ6v3Oyey0qmQUsCATlEuB2s=
Received: by 10.100.244.32 with SMTP id r32mr4688204anh.28.1278385449228; Mon, 
	05 Jul 2010 20:04:09 -0700 (PDT)
Received: by 10.150.51.17 with HTTP; Mon, 5 Jul 2010 20:04:09 -0700 (PDT)
In-Reply-To: <7vsk3x72wb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150317>

On Mon, Jul 5, 2010 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dylan Reid <dgreid@gmail.com> writes:
>
>> In xdl_recmatch, do the memcmp to check if the two lines are equal b=
efore
>> checking if whitespace flags are set. =A0If the lines are identicle,=
 then
>
> "identical"?

That's exaclty what I meant.  Correct patch sent.

>
>> there is no need to check if they differ only in whitespace.
>> This makes the common case (there is no whitespace difference) faste=
r.
>> It costs the case where lines are the same length and contain
>> whitespace differences, but the common case is more than 20% faster.
>
> "more than 20% faster" based on what dataset and benchmark?
>

I benchmarked it with some of the bigger files from Linux.  The
results were consistenly > 20% faster
across different file sizes.  I tested it by simply running the
command a few times then running it with
my local build a few times to see if I had achieved any speedup.

~/linux-2.6(119)$ time git blame --incremental -w
=2E/sound/pci/hda/patch_realtek.c > /dev/null

real    0m8.166s
user    0m8.063s
sys     0m0.090s
~/linux-2.6(120)$ time git blame --incremental -w
=2E/sound/pci/hda/patch_realtek.c > /dev/null

real    0m8.010s
user    0m7.866s
sys     0m0.137s
~/linux-2.6(121)$ time ~/work/git/git blame --incremental -w
=2E/sound/pci/hda/patch_realtek.c > /dev/null

real    0m6.115s
user    0m5.986s
sys     0m0.123s
~/linux-2.6(122)$ time ~/work/git/git blame --incremental -w
=2E/sound/pci/hda/patch_realtek.c > /dev/null

real    0m6.119s
user    0m5.986s
sys     0m0.127s


Thanks for taking the time to read the patch.

Dylan
