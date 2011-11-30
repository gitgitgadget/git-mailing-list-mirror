From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Wed, 30 Nov 2011 11:00:04 -0800
Message-ID: <1322679604.1710.64.camel@yos>
References: <1322546563.1719.22.camel@yos>
	 <20111129090733.GA22046@sigill.intra.peff.net>
	 <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
	 <20111129205905.GA1793@sigill.intra.peff.net>
	 <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 20:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVpOE-0005dI-AC
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab1K3TAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 14:00:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55285 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1K3TAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 14:00:11 -0500
Received: by ghrr1 with SMTP id r1so952958ghr.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=qk+jzHvhXAgDB3q8cvwArntTvT67eIPPwhYLeeGB8j0=;
        b=r4/RnSvvovws55ohxcVRGO4t4Oe94Cg2vWEJO0MUtRS/npuEivYxM5+7Iwr9ToZ7xf
         hyrfxlMiN27J6gznFTpxGnN+/FaBzrI0h6rPk58CV2zyLawlzM3hpX4DkWq4I5gDA369
         D660+3DDO7J5rjxswF3lIkd9AlfgsSjhhidhA=
Received: by 10.50.12.227 with SMTP id b3mr4101307igc.24.1322679610732;
        Wed, 30 Nov 2011 11:00:10 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id wo4sm6047870igc.5.2011.11.30.11.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 11:00:08 -0800 (PST)
In-Reply-To: <CACsJy8A6kGmn0h0xdxfTC4krXgc8hzO1fHTdqfk0YnASGN5K0w@mail.gmail.com>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186135>

[Will send a reply to Jeff's comment from last night with some 
clarifications and explanations later].

> What I'm thinking is whether it's possible to decouple two sha-1 roles
> in git, as object identifier and digest, separately. Each sha-1
> identifies an object and an extra set of digests on the "same" object.
> Object database is extended to store all these new digests and mapping
> between sha-1 and them. When we need to verify an object, given an
> sha-1, we rehash that object and check the result digest with the ones
> linked to the sha-1.

The patch I created (at least, a reasonable chunk of the code) kind of
does that:  it is very easy to change the CRC to whatever message digest
one wants.  I used a CRC primarily because I had the impression that
people were very concerned about speed, but it is easy to change that to
the message digest of your choice.  In any case, it might be a good
starting point if you want to try something in a different direction.

Basically, when you create a loose object, in addition to getting a
SHA-1 ID, you get a message digest that gets stored as well (in a
separate file). When you index a pack file, you get an IDX file
containing the SHA-1 ID  plus a corresponding MDS file containing the
message digest. Index-pack calculates the SHA-1 value from the object
stored in the pack file, and the (additional) message digest is computed
at the same time using the same data.  Commands like verify-pack check
both the IDX file and the MDS file for consistency with the matching
pack file.  The new message digest (the CRC in the patch) is used only
in cases where a repository is being altered (e.g., a loose object or
pack file is being created or a fetch, push, or pull operation) or some
explicit verification operation is running (e.g., git verify-pack).

Adding an additional header to the commit message is a good idea (I had
actually tried that, but something went wrong, although one of you
suggested what the problem might have been --- I can try again if there
is some interest in pursuing that).

It might be worth pointing out that you can use the SHA-1 hash of the
contents of objects (e.g., without the Git object header) as an
additional digest:  I tried a test using two 128-byte files with the
same MD5 hash, differing past the 20th byte, and deleted the first
four bytes of each.  With those bytes deleted, the hash collision
went away. I doubt if there is a known efficient algorithm that can
generate a hash collision for two files and for two other files that
differ from the first set by deleting N bytes from both.
