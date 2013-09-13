From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Fri, 13 Sep 2013 20:59:50 +0700
Message-ID: <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 13 16:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKTvF-0007eY-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 16:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780Ab3IMOA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Sep 2013 10:00:26 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38733 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246Ab3IMOAV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 10:00:21 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so1100487obc.7
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PovoPWVI68ONHf/pSD2hu9JLQWpbGWxyv0zrznXDlQk=;
        b=aHCf7bHvwGLWPXHPOe6Hg1s5xwXsE6LrZe4hQmIVyn2YBxBd7bmQowxbjKpazZNxx4
         MERL9UIHJgB2yQBQ7+RmWGBure7gIyihU/Ex8StyTWtEdMYczwg9nzmHzwbXz3K6DkOR
         qR0OuYCJ+8YqvOACTcR10VQCFhWz/jF6YZmSr59fKUfnC+nLnRVEz1NiresHsbrEeKH5
         4rzTE34hImVJD6U5LnoeMxCsduAyf1DOT6NoJvnfljeK2qbePWT7lVgLRCbggdq6vH8V
         IgYVmQI4wNvednRQx0HW+M4CzfMKWrU2qP4/HhWl1ORShvqlbfouKX+fXWnqSQG0GbM+
         0/Rg==
X-Received: by 10.182.98.162 with SMTP id ej2mr7278240obb.61.1379080821087;
 Fri, 13 Sep 2013 07:00:21 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 13 Sep 2013 06:59:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234754>

On Fri, Sep 13, 2013 at 8:27 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 12 Sep 2013, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> The intention is to store flat v4 trees in delta base cache to avoid
>> repeatedly expanding copy sequences in v4 trees. When the user needs
>> to unpack a v4 tree and the tree is found in the cache, the tree wil=
l
>> be converted back to canonical format. Future tree_desc interface ma=
y
>> skip canonical format and read v4 trees directly.
>>
>> For that to work we need to keep track of v4 tree size after all cop=
y
>> sequences are expanded, which is the purpose of this new field.
>
> Hmmm.... I think this is going in a wrong direction.

Good thing you caught me early. I was planning to implement a better
version of this on the weekend. And you are not wrong about code
maintainability, unpack_entry() so far looks very close to a real
mess.

> Yet, pavkv4 tree walking shouldn't need a cache since there is nothin=
g
> to expand in the end.  Entries should be advanced one by one as they =
are
> needed.  Granted when converting back to a canonical object we need a=
ll
> of them, but eventually this shouldn't be the main mode of operation.

There's another case where one of the base tree is not v4 (the packer
is inefficient, like my index-pack --fix-thin). For trees with leading
zeros in entry mode, we can just do a lossy conversion to v4, but I
wonder if there is a case where we can't even convert to v4 and the v4
treewalk interface has to fall back to canonical format.. I guess that
can't happen.

> However I can see that, as you say, the same base object is repeatedl=
y
> referenced.  This means that we need to parse it over and over again
> just to find the right offset where the needed entries start.  We
> probably end up skipping over the first entries in a tree object
> multiple times.  And that would be true even when the core code learn=
s
> to walk pv4 trees directly.
>
> So here's the beginning of a tree offset cache to mitigate this probl=
em.
> It is incomplete as the cache function is not implemented, etc.  But
> that should give you the idea.

Thanks. I'll have a closer look and maybe complete your patch.
--=20
Duy
