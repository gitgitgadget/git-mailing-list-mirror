From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Tue, 23 Jul 2013 19:15:24 -0400
Message-ID: <CAPig+cTPcFJ_kfQ7zveE-Uf-itRRw2O99vQ61Or0QHvkKnxc_g@mail.gmail.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
	<20130723175942.GA21019@goldbirke>
	<7vvc416qvq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 01:15:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1lnn-0008A2-8G
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 01:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933930Ab3GWXP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 19:15:26 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:44049 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab3GWXPZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jul 2013 19:15:25 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so6763289lbd.32
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nbgKFWuzWcXOESGcvS6NrZqTyPcBQCkHfAyiOM1Gwo4=;
        b=WUKo8r2hiJOY0q4pIfeVR7sf4BZFhnfu1n9WhtZ1tqJQ/7rOdoRqZlC1lr6dp7J5+w
         E5RVXALGSy5rIN/XWpgSYM1YXbzdRfdiz8PnJwpgeGuMxe3vtmeGmpx4uaEk0ZCbI40G
         B/RfmKJkPOYifCVPw+3HqsSAdV6KUkD5aNsPTKoDlKuoXmdznKZ0FlatBBfp8djAYXkW
         yqRFDMYSid60SKBEHQ7kHVGxE9dzikt8bS2GvcW6SEHFBhoVYpmVT7gB2CkTyr2ZGj3a
         WxJAten/koo9W6xLxuivX+p5TAqzLINDSI/c0mqIqQTA4+O6iISwwa57a5V1hm1IMptT
         VNcA==
X-Received: by 10.112.77.164 with SMTP id t4mr15155738lbw.52.1374621324479;
 Tue, 23 Jul 2013 16:15:24 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 23 Jul 2013 16:15:24 -0700 (PDT)
In-Reply-To: <7vvc416qvq.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0l1uRqL3fJrUHmCaH14p-IGaDW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231070>

On Tue, Jul 23, 2013 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>> You could avoid the 'cat' here and patch in 4/5 by doing $(wc -l <b.=
c).
> Correct.

Thanks, I like that better.

Unfortunately, what actually got queued on 'next', after applying this
fix-up and re-ordering the patch series, is slightly bogus.  The diff
for f8395edc (range-set: satisfy non-empty ranges invariant) looks
like this:

@@ -67,7 +67,8 @@ test_bad_opts "-L :foo:b.c" "no match"
 # There is a separate bug when an empty -L range is the first -L encou=
ntered,
 # thus to demonstrate this particular bug, the empty -L range must fol=
low a
 # non-empty -L range.
-test_expect_failure '-L {empty-range} (any -L)' '
+test_expect_success '-L {empty-range} (any -L)' '
+ n=3D$(expr $(cat b.c | wc -l) + 1) &&
  n=3D$(expr $(wc -l <b.c) + 1) &&
  git log -L1,1:b.c -L$n:b.c
 '

which incorrectly adds back the $(cat b.c | wc -l) line just above the
fixed $(wc -l <b.c) line.
