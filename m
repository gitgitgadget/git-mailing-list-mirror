From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Sat, 06 Sep 2014 19:46:28 +0200
Message-ID: <87ppf863rf.fsf@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<38527c9f6ae31ad39d8f3dddfe5252a3527629ed.1393059605.git.tr@thomasrast.ch>
	<CAPig+cRRvEUDivU=ySx7wY9qYsCYSvn68aY8s_jfX=Z=jh=Ptg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 19:46:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQK4d-0006Gx-TW
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbaIFRqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:46:51 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40714 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbaIFRqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:46:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 46DD74D65CD;
	Sat,  6 Sep 2014 19:46:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q-uFWVer06rJ; Sat,  6 Sep 2014 19:46:37 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 2FBB54D6510;
	Sat,  6 Sep 2014 19:46:34 +0200 (CEST)
In-Reply-To: <CAPig+cRRvEUDivU=ySx7wY9qYsCYSvn68aY8s_jfX=Z=jh=Ptg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 23 Feb 2014 04:19:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256589>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Feb 22, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
>> -static void lazy_init_name_hash(struct index_state *istate)
>> +void init_name_hash(struct index_state *istate, int force_dir_hash)
>>  {
>>         int nr;
>>
>>         if (istate->name_hash_initialized)
>>                 return;
>> +
>> +       istate->has_dir_hash = force_dir_hash || ignore_case;
>
> This is getting a bit convoluted. Refactoring lazy_init_name_hash()
> into two functions would eliminate the complexity. For instance:
>
>   void init_name_hash(struct index_state *istate)
>   {
>   ...pure initialization code...
>   }
>
>   static void init_name_hash_if_needed(struct index_state *istate)
>   {
>     if (ignore_case && !istate->name_hash_initialized)
>       init_name_hash(istate);
>   }
>
> The two existing callers of lazy_init_name_hash() in name-hash.c,
> which rely upon the lazy/ignore-case logic, would invoke the static
> init_name_hash_if_needed().
>
> The new caller in patch 8/8, which knows explicitly if and when it
> wants the hash initialized can invoke the public init_name_hash().

That unfortunately doesn't really help because the conditional part only
affects the dir hash.  Callers request the name hash for other reasons,
but we only do the dir hashing when ignore_case is in effect.

So it's not simply about overriding lazy initialization, but about
choosing to trigger a specific subpart of the initialization.

-- 
Thomas Rast
tr@thomasrast.ch
