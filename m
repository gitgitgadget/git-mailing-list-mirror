From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 18:44:16 +0200
Message-ID: <n2n40aa078e1004070944sc137aef3yfc5967d517860192@mail.gmail.com>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
	 <20100407031655.GA7156@spearce.org>
	 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
	 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
	 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
	 <20100407144555.GA23911@fredrik-laptop>
	 <alpine.LFD.2.00.1004071103341.7232@xanadu.home>
	 <v2t4c8ef71004070913r2de3c8car31f39a2ab7aa6d15@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:44:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYMb-00046j-GN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896Ab0DGQoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 12:44:19 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35499 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723Ab0DGQoS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:44:18 -0400
Received: by bwz1 with SMTP id 1so1014774bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2EbZI0ohiYbLrtBFdU/hfJ0YdIRQFMs//OciYYf5kJw=;
        b=sv6Jfjq3Sxp+NHZ/qB2jD+gqPuPikiPx6tyaZ5cGpdXyqQKBEhtZ78K4vNloCKUckX
         ZsJL5AolfobCIMNJG7clcQ9oXJsDPmNP9f0XG0c2ukgLbr8iVTXLx0Jl7POrROf+1/x7
         Zr1w/b4lEuvB1OYJVZwodHWWiLvYGS8MFeidU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=l8PMxM15ICWTO3QSJu/oKIeiWQBpIv6rTG1iG8C3HJn14DvYFzqB/nMY4m8gc7vVd8
         rVXbexGzrJThnJVhdDYLw4/Itie6So/ASkE/0rGUT4YzaVU3spK9l7Qnnh7dIGS2EsPy
         Csew1ldkAOVAupdLJkHDMkHX+86XkbIK+ejio=
Received: by 10.204.72.202 with HTTP; Wed, 7 Apr 2010 09:44:16 -0700 (PDT)
In-Reply-To: <v2t4c8ef71004070913r2de3c8car31f39a2ab7aa6d15@mail.gmail.com>
Received: by 10.204.24.9 with SMTP id t9mr10053988bkb.150.1270658656288; Wed, 
	07 Apr 2010 09:44:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144247>

On Wed, Apr 7, 2010 at 6:13 PM, Fredrik Kuivinen <frekui@gmail.com> wro=
te:
> On Wed, Apr 7, 2010 at 17:08, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Wed, 7 Apr 2010, Fredrik Kuivinen wrote:
>>> diff --git a/thread-utils.c b/thread-utils.c
>>> index 4f9c829..3c8d817 100644
>>> --- a/thread-utils.c
>>> +++ b/thread-utils.c
>>> @@ -1,4 +1,5 @@
>>> =A0#include "cache.h"
>>> +#include <pthread.h>
>>
>> This will fail compilation on Windows surely?
>
> I think it will work. We use "#include <pthread.h>" in builtin/grep.c=
,
> builtin/pack-objects.c, and preload-index.c already.
>

Still, isn't this REALLY the kind of stuff that usually goes in
git-compat-util.h? I'm not asking you to change it, I'm just a bit
puzzled that the other pthread-clients did it this way...

--=20
Erik "kusma" Faye-Lund
