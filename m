From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v4 2/2] git-svn: allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 16:31:52 -0700
Message-ID: <53FD2913-2A8E-42E1-9C76-D0AEBD76E0DA@gmail.com>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79> <ac83ba2812aee248275a0760bb39a00@f74d39fa044aa309eaea14b9f57fe79> <20130718192943.GT14690@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 01:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzxg0-0000Jf-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934645Ab3GRXb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jul 2013 19:31:57 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:65037 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934602Ab3GRXb4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 19:31:56 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so3776049pac.12
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=BCU71Ffqme8w96QW/L5BXvL4F6vi9hwdfXhtaZYt1Vg=;
        b=Dj6gqxvV9CTXBhvBGe/8/Zfhu0cDZvlODj8Ts0K5jpr8b5tEZlopO/TtzGBZiIsQmd
         bRZuOkI98N8/RrYHR8obT3xrslmx/HsjyWr7V7+1eRVXoGuV2fat+ats1L9xtYikmpgu
         twaAlyfAfBBlEvDkYuZQszgn2GOiPYzjGMx2kkrEhK9B20SE/4XWorIA55lOaPbNzOPU
         QzqVpSl3n0lZg0IN3FzO1Dy6H4v/sx1Sj0cVkjIr+eKYlwk15P1kU/VSL9b4d242mlwG
         iA+G7/VGrAZdoPaLuSOUAl6n/lNJdaT0JB7f4FvcSUpwzDT0iT6228k4HiEb+3u9ZE5w
         gynw==
X-Received: by 10.66.232.42 with SMTP id tl10mr15126064pac.159.1374190315648;
        Thu, 18 Jul 2013 16:31:55 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qu10sm16036525pbb.12.2013.07.18.16.31.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 16:31:54 -0700 (PDT)
In-Reply-To: <20130718192943.GT14690@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230766>

On Jul 18, 2013, at 12:29, Jonathan Nieder wrote:
> (cc-ing Eric Wong, who maintains git-svn and knows both it and
> the libsvn perl bindings much better than I do)
> Kyle J. McKay wrote:
>
>> David Rothenberger <daveroth@acm.org> has determined the cause to
>> be that ra_serf does not drive the delta editor in a depth-first
>> manner [...]. Instead, the calls come in this order:
>
> Thanks.
>
> Sorry to nitpick, but the problem is not depth-first versus
> breadth-first versus random.  Blaming the traversal order makes this
> completely confusing.  The actual problem is that the driver asks us
> to keep multiple files open at a time.

On Sun, 07 Jul 2013 18:00:40 GMT, Branko =C4=8Cibej wrote:
> On 07.07.2013 19:40, Jonathan Nieder wrote:
>> (cc-ing subversion's users@ list for advice)
>> Kyle McKay wrote:
>>> On Jul 6, 2013, at 18:37, Jonathan Nieder wrote:
>>
>>>
>>>> Kyle McKay wrote:
>>>>> Begin forwarded message:
>>>>>> [2] http://subversion.tigris.org/issues/show_bug.cgi?id=3D2932
>>>>>
>>>> Ah, thanks for the context.
>>>>
>>>> It's still not clear to me how we know that ra_serf driving the =20
>>>> editor
>>>> in a non depth-first manner is the problem here.  Has that =20
>>>> explanation
>>>> been confirmed somehow?
>>> [...]
>>> Since ra_serf makes multiple connections to the server (hard-coded
>>> to 4 prior to svn 1.8, defaults to 4 in svn 1.8 but can be set to
>>> between 1 and 8) it makes sense there would be multiple active call=
s
>>> to apply_textdelta if processing is done as results are received on
>>> the multiple connections.
>> Ah, that's worrisome.  Do I understand you correctly that to work =20
>> with
>> ra_serf in skelta mode, callers need to make their apply_textdelta
>> callback thread-safe?
>
> No; the editor drive is single-threaded, but the order of the =20
> operations
> isn't strictly depth-first.


Brane also describes this as a non-depth-first traversal order which =20
is the root of the problem.  If the order of operations were strictly =20
depth-first, the previous file would end up being closed before the =20
next one's opened.

> The approach taken in this patch would be racy if the driver calls us
> multiple times concurrently (since temp_acquire can fail).  I believe
> it doesn't but haven't checked.

Brane says the editor drive is single-threaded so that doesn't seem =20
like a problem.
