From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/4] clone: open a shortcut for connectivity check
Date: Fri, 3 May 2013 08:41:44 -0400
Message-ID: <CAPig+cSvoahDBxg+SzEMPSbNUXfi18Q=iKmRTuznmz6qz6V-6g@mail.gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 14:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFJ9-0000we-9N
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab3ECMlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:41:47 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:61595 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3ECMlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 May 2013 08:41:46 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so1483299lab.38
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PQ90TFGl6Adl8aZL3wnlseRwN/vWo4zrQ3sEkmyhdYs=;
        b=wi9x+9obsigHPPw0xDxEHQCw0SSDsbw2J7Jwi3TRsee5E952yvQUqo/zXcnAB69kbZ
         CD3EV2jSPtftfJV94W90F68JbhiXgmRVhVDq3FUgpPTMR+IGiSTJawQlYc8KiMIsthF6
         nDFm8tBWWO8NxFRRU4TQjuqeh2Ndbc2HlBzcc9yU9eoq/WNFkrXQDQJSN9fJ6o2f01ZJ
         KSynTUP4f8wmDJtrsYR4GMRrOw18lUZ8DZ8WqKyDrfNSPC6eSmw63L95WEnJqHNO2tEe
         a6nDl+Zer17cTkk1Et0SBE7HZjjx7PTiZAYdwNNNdkwZoOLpYSPki5NSDUD/wSV0+whe
         pN8g==
X-Received: by 10.112.126.226 with SMTP id nb2mr4325428lbb.38.1367584904898;
 Fri, 03 May 2013 05:41:44 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Fri, 3 May 2013 05:41:44 -0700 (PDT)
In-Reply-To: <1367584514-19806-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 5luC28zhBhbZRPG1Ypl7OEbrmXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223310>

On Fri, May 3, 2013 at 8:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> In order to make sure the cloned repository is good, we run "rev-list
> --objects --not --all $new_refs" on the repository. This is expensive
> on large repositories. This patch attempts to mitigate the impact in
> this special case.
>
> In the "good" clone case, we only have one pack. If all of the
> following are met, we can be sure that all objects reachable from the
> new refs exist, which is the intention of running "rev-list ...":
>
>  - all refs point to an object in the pack
>  - there are no dangling pointers in any object in the pack
>  - no objects in the pack point to objects outside the pack
>
> The second and third checks can be done with the help of index-pack a=
s
> a slight variation of --strict check (which introduces a new conditio=
n
> for the shortcut: pack transfer must be used and the number of object=
s
> large enough to call index-pack). The first is checked in
> check_everything_connected after we get an "ok" from index-pack.
>
> "index-pack + new checks" is still faster than the current "index-pac=
k
> + rev-list", which is the whole point of this patch. If any of the
> conditions fails, we fall back to the good old but expensive "rev-lis=
t

s/fails/fail/

> ..". In that case it's even more expensive because we have to pay for
> the new checks in index-pack. But that should only happen when the
> other side is either buggy or malicious.
>
> Cloning linux-2.6 over file://
>
>         before         after
> real    3m25.693s      2m53.050s
> user    5m2.037s       4m42.396s
> sys     0m13.750s      0m16.574s
>
> A more realistic test with ssh:// over wireless
>
>         before         after
> real    11m26.629s     10m4.213s
> user    5m43.196s      5m19.444s
> sys     0m35.812s      0m37.630s
>
> This shortcut is not applied to shallow clones, partly because shallo=
w
> clones should have no more objects than a usual fetch and the cost of
> rev-list is acceptable, partly to avoid dealing with corner cases whe=
n
> grafting is involved.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
