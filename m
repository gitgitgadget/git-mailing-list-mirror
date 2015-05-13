From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Tue, 12 May 2015 18:13:48 -0700
Message-ID: <xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
	<xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
	<20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Wed May 13 03:13:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLFE-0007j8-UC
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 03:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbbEMBNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 21:13:51 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38069 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964896AbbEMBNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 21:13:51 -0400
Received: by igbhj9 with SMTP id hj9so31626068igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+OS0oJ17yJ1OaQP+jceepiqFmTdj1p42dGjxuMWRJz4=;
        b=jP9LrI7zUs2U1wbk/4Yfqkzt0Ck2ye3xtMNHgY502uWEYpp+oBgx32xsQsjsOKfiVv
         I+v4XmbUOIyUtf+JS314r+laPFWjZO7+ooeWYpCB5Cek4+7qmPI/pWpu1kGK3IUZSD1I
         OjXg3tr4y4nwPgaUlGGWyrtRAbcOkFuZGPyfHHRP2srTKDiJQZqJH3i7yq8f6EGRgDzL
         tDLsTiYqpy5VqS1wReFcS3UuCBzKxR2XBOb0t6rl5RYXhKcV+Eedyqt5tSTU+CaAWFSI
         oNu4LCcdy4NfHYAHh/k3bgpCvvQJnuvDekav6oBpyKnnIvU7aX1eTFTlaW22I+bWFsmU
         XBUA==
X-Received: by 10.50.61.200 with SMTP id s8mr25085963igr.7.1431479630442;
        Tue, 12 May 2015 18:13:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id k74sm13142294iok.30.2015.05.12.18.13.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 18:13:49 -0700 (PDT)
In-Reply-To: <20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
	(Trevor Saunders's message of "Tue, 12 May 2015 20:54:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268910>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> On Tue, May 12, 2015 at 04:24:00PM -0700, Junio C Hamano wrote:
>> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
>> 
>> > When the first bad commit has been found git bisect prints something
>> > like this:
>> >
>> > 	<40 char sha1> is the first bad commit
>> > 	Commit <40 char sha1>
>> > 	...
>> >
>> > 	:100644 100644 10f5e57... a46cfeb... M  bisect.c
>> > 	:100755 100755 ae3fec2... 65a19fa... M  git-bisect.sh
>> >
>> > The raw diff output is not really useful, and its kind of silly to print
>> > the sha1 twice.  Instead lets print something like this:
>> >
>> > 	The first bad commit is
>> > 	Commit <sha1>
>> > 	...
>> 
>> According to +CCouder, this change will break existing people's use
>> cases.
>> 
>> See $gmane/268881
>
> Well, technically he just said it might be that people are parsing the
> output and could be broken, but if you'd rather not take that risk then
> I guess we just have to leave things the way they are.

FWIW.

 - I personally do not agree that those who scripted around "git
   bisect" (as opposed to those who wrote scripts to be driven by
   the "bisect run" interface) are worth worrying about.  But I am
   not the whole of the Git world ;-)

 - I personally do not find two same 40-hex on two lines is silly at
   all.

 - I _do_ think diff-tree --raw output without recursive is silly.
   It is not useful for humans (it doesn't even give paths fully),
   and it is insufficient for scripts, which can grok more through
   information out of the 40-hex.

So perhaps if we keep

	<40 char sha1> is the first bad commit

and then replace the diff-tree output with "show -s", then the
result would be good enough, I would say.
