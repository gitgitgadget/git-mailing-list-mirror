From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Tue, 10 Dec 2013 00:19:05 +0100
Message-ID: <52A64FE9.5010004@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com> <52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch> <52A3A1F5.3080906@gmail.com> <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <52A5CDB0.2020206@gmail.com> <20131209200820.GU29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:19:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqA6b-0003k9-N7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712Ab3LIXTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:19:10 -0500
Received: from mail-ea0-f170.google.com ([209.85.215.170]:43556 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3LIXTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:19:07 -0500
Received: by mail-ea0-f170.google.com with SMTP id k10so1904380eaj.29
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 15:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g6ZAth0fIeMClP3aLtvh1kB7bMGXOndi7E4m0lfCET4=;
        b=GEYvlQtMUurRPUF+Ecxsvt+26tlXEdOPDVps/iyo4XSHbYrnau8eJigC3ivjh4Q3bq
         5e8dbnrwUNnIDoeS/huyh6e88Nfo4o+JdMVXSWS9RE8NkOmLcCOsGT/Rq6eYTodJQFln
         Laz9UvX/pUNCfpHyY4jz8kpOQ6ejyqy/zvswNQ+0t00nVZ8GFV8flFv1VK2d7b41a+66
         yyPGttLrnOGQjlJSYCr6MOo04SdZfJ2oA6kTCGieN7OGqPCFlkTIkig9sLqbribjjJFn
         6ZJUxu3IxboEyGZQ5GvgH++ktR2zaEIa2ddPcyhNb+x0jtED4V9IMhtDlowLy1Q0IgYD
         Pdbw==
X-Received: by 10.15.26.200 with SMTP id n48mr14851893eeu.46.1386631146482;
        Mon, 09 Dec 2013 15:19:06 -0800 (PST)
Received: from [10.1.100.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 1sm34172842eeg.4.2013.12.09.15.19.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 15:19:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131209200820.GU29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239119>

Am 09.12.2013 21:08, schrieb Jonathan Nieder:
> Karsten Blees wrote:
> 
>> GCC supports __packed__ as of 2.3 (1992), so any other compilers
>> that copied the __attribute__ feature probably won't complain.
> 
> Alas, it looks like HP C doesn't support __packed__ (not that I
> care much about HP C):
> 
>  http://h21007.www2.hp.com/portal/download/files/unprot/aCxx/Online_Help/pragmas.htm#Attributes
> 

Thanks for the link

> Maybe a macro expanding to __attribute__((aligned(1))) on the fields
> would work?  The same macro could expand to __declspec(align(1)) in
> the MSVC build.
> 

But alignment is not the same as packing. We still want the structure to be 8-byte aligned (i.e. variables of the type should start at 8-byte boundaries). We just don't want the size of the structure to be padded to a multiple of 8, so that we can extend it without penalty. (Besides, __attribute__((aligned)) / __declspec(align) can only _increase_ the alignment, so aligned(1) would have no effect).

Googling some more, I believe the most protable way to achieve this via 'compiler settings' is

 #pragma pack(push)
 #pragma pack(4)
 struct hashmap_entry {
   struct hashmap_entry *next;
   unsigned int hash;
 };
 #pragma pack(pop)

This is supported by at least GCC, MSVC and HP (see your link). The downside is that we cannot use macros (in git-compat-util.h) to emit #pragmas. But we wouldn't have to, as compilers aren't supposed to barf on unknown #pragmas.


However, considering the portability issues, the macro solution (injecting just the two fields instead of a struct) becomes more and more attractive in my mind...

Karsten
