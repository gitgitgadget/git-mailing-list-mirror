From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 19:15:47 +0700
Message-ID: <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org,
	Jeff King <peff@peff.net>
To: blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Feb 13 13:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5bGU-0005j6-WE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 13:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933887Ab3BMMQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 07:16:19 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33540 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab3BMMQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2013 07:16:18 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so1149248obq.21
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 04:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=mREsyeGHhniqRCdwL70PiPzDDgPf7kdjFLa1XCdHL7Y=;
        b=PDcI2x7ElSAI4j4BwYaFtczKrsC12fx5AbWVU3lNUDwlIwQyPVWG6zzvC7j0CbHjUB
         tpIE4b5uczdzNuXecvy9c2zkJWGSW7o4bJa1GZ3HkNAo+Zja4nq5jyUTBV63YX+VjTW0
         qX9YZek09VeDUhUEBayt4eA/pHlZoxQjeARCGQJiby0/3X3f4QQ4PGYJUKAK6L6U4fyB
         WzEf3zjdVK+Ywgy9iEF45rUwftlXI36Blnk0QZKbnmiRmSsyp2cnskcOF6GHVJzCxWYH
         vzLbyzrU1ve6CYssvfSCwMT/sjiu7FMiL1DmV68i3eRpjMG8+p8jCwJPreeGo7v2fgcr
         ZyRA==
X-Received: by 10.60.1.129 with SMTP id 1mr15931325oem.93.1360757777308; Wed,
 13 Feb 2013 04:16:17 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Wed, 13 Feb 2013 04:15:47 -0800 (PST)
In-Reply-To: <511AAA92.4030508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216251>

On Wed, Feb 13, 2013 at 3:48 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> 2.) 0.135 s is spent in name-hash.c/hash_index_entry_directories, reindexing the same directories over and over again. In the end, the hashtable contains 939k directory entries, even though the WebKit test repo only has 7k directories. Checking if a directory entry already exists could reduce that, i.e.:

This function is only used when core.ignorecase = true. I probably
won't be able to test this, so I'll leave this to other people who
care about ignorecase.

This function used to have lookup_hash, but it was removed by Jeff in
2548183 (fix phantom untracked files when core.ignorecase is set -
2011-10-06). There's a looong commit message which I'm too lazy to
read. Anybody who works on this should though.


> @@ -53,14 +55,23 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
>         unsigned int hash;
>         void **pos;
>         double t = ticks();
> +       struct cache_entry *ce2;
> +       int len = ce_namelen(ce);
>
> -       const char *ptr = ce->name;
> -       while (*ptr) {
> -               while (*ptr && *ptr != '/')
> -                       ++ptr;
> -               if (*ptr == '/') {
> -                       ++ptr;
> -                       hash = hash_name(ce->name, ptr - ce->name);
> +       while (len > 0) {
> +               while (len > 0 && ce->name[len - 1] != '/')
> +                       len--;
> +               if (len > 0) {
> +                       hash = hash_name(ce->name, len);
> +                       ce2 = lookup_hash(hash, &istate->name_hash);
> +                       while (ce2) {
> +                               if (same_name(ce2, ce->name, len, ignore_case)) {
> +                                       add_since(t, &hash_dirs);
> +                                       return;
> +                               }
> +                               ce2 = ce2->dir_next;
> +                       }
> +                       len--;
>                         pos = insert_hash(hash, ce, &istate->name_hash);
>                         if (pos) {
>                                 ce->dir_next = *pos;
-- 
Duy
