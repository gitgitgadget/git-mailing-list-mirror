From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 9 Dec 2013 15:45:01 -0800
Message-ID: <20131209234500.GY29959@google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
 <52A37D70.3090400@gmail.com>
 <87fvq41esw.fsf@thomasrast.ch>
 <52A3A1F5.3080906@gmail.com>
 <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
 <52A5CDB0.2020206@gmail.com>
 <20131209200820.GU29959@google.com>
 <52A64FE9.5010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqAVj-0004GV-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab3LIXpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:45:07 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:62911 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab3LIXpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:45:06 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so3329812yhz.36
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FE8Tz5p42TksVocLp2m/EcS42AcWIGR5qON9KcRt5EA=;
        b=TICg7EcgpSAiZX9g2bdjdz6UJlPvF2yt+bWS7O2h/XgA6xSOGU1V0qrLXh7oWouxAL
         1KtR/B8lDSUa6bSS2uB3RcOA3n1YMmdb6M/nIbYL1LOD8WU9Jp9nqjrJq183DI2UkoaR
         woMXdBZxngEg+Wpc/vUPSTMwj3JxyhKOG33Jrep0uj7NDlw9Aq/LUy2uA0tUAwbydv8E
         C6AeTcuj7c2G7w3etqc0NgFzBxpe5S0xjZgRSbPmbawzXVFjkFv7ujsgTNHnrSPvFrnx
         ZjE2yAut18HZllTrUx8ipAYsVVn2n/B0sJre/8ywWWgXL4wRo9ZZtJrzt9RN4BS0ghQa
         sWzg==
X-Received: by 10.236.190.199 with SMTP id e47mr17883455yhn.26.1386632704804;
        Mon, 09 Dec 2013 15:45:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id b30sm19582426yhm.5.2013.12.09.15.45.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 15:45:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A64FE9.5010004@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239123>

Karsten Blees wrote:

> (Besides, __attribute__((aligned)) / __declspec(align) can only
> _increase_ the alignment, so aligned(1) would have no effect).

Good catch.

> Googling some more, I believe the most protable way to achieve this
> via 'compiler settings' is
>
>  #pragma pack(push)
>  #pragma pack(4)
>  struct hashmap_entry {
>    struct hashmap_entry *next;
>    unsigned int hash;
>  };
>  #pragma pack(pop)
>
> This is supported by at least GCC, MSVC and HP (see your link). The
> downside is that we cannot use macros (in git-compat-util.h) to emit
> #pragmas. But we wouldn't have to, as compilers aren't supposed to
> barf on unknown #pragmas.

Technically this can be done using macros:

 #if (gcc)
 #	define BEGIN_PACKED _Pragma("pack(push,4)")
 #	define END_PACKED _Pragma("pack(pop)")
 #elif (msvc)
 #	define BEGIN_PACKED __pragma(pack(push,4))
 #	define END_PACKED __pragma(pack(pop))
 #else
 	/* Just tolerate a little padding. */
 #	define BEGIN_PACKED
 #	define END_PACKED
 #end

Then you can do:

 BEGIN_PACKED
 struct hashmap_entry {
 	...
 };
 END_PACKED

Whether that's nicer or uglier than the alternatives I leave to you.
;-)

Thanks,
Jonathan
