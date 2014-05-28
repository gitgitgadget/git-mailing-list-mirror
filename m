From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Wed, 28 May 2014 16:20:52 -0700
Message-ID: <CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-26-git-send-email-sahlberg@google.com>
	<20140528194746.GX12314@google.com>
	<CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
	<20140528221720.GB12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:21:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpn9b-0006rB-QV
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbaE1XUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:20:55 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:41517 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbaE1XUx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:20:53 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so13213098veb.5
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LVQFM3IlquFMIfkVtFXJmQzBA1yGJ0i+3JeBq6FvgHw=;
        b=AmOE1Bf9+sgXGaG9MUsV0Q9ttOX54SjMCC8u/tcO8Plu2sea6tBhNddfY/KIcF/E63
         6gPl1DzUWYExTHmS2JlQhy4Z0xxEdx7ZCXhZgrLSX5/38J/ZR++Xlp/hax8S1Ic+vfm4
         g+Swj8E4y/NLM8HDjU3upjddRbHXkKFljYDoa+/1cStGU68qicA1Kpy0FJ8cY9z3+mOw
         BJTFswwwfx7Ga3NAyJyHJPo8YfezlnBOdZfHyaoGrSe6iUzsR0b6eX9AgF21OUbF2wZ1
         9JL1SXDLLLsj+V9LOdu4U14KIEWhyLqt7p/3KS0k6h2bhSJc+Bu83ZOz7+dYqDeVItgp
         HZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LVQFM3IlquFMIfkVtFXJmQzBA1yGJ0i+3JeBq6FvgHw=;
        b=IXBCZLcoXlUxRBPH2CcZA4oP5ReFFn1MmoAdjg6B65oJxwbtiMEz1QlowrdfP3EhGf
         uIgA6Z5eOZ2wvLpDgb3TCQ/DU0tSP5GLhCkCwsWmEYmZxuZID3UGaXbnjysdUaiPC/Pi
         qH76/PQtxMG0Rrh1v2Az5hbOcYe2p6Ems1U1A6W75Ols2xDD1CJSM6LQ3utnLM/PPU34
         XXEQ1aUT7fid3mfWp7EM6MCAfVDwTqLHngcX/nDmXaJa9MD3Tundso8sGa21tB9OZU2V
         J+iDd/LisEQ1ZRxsbKXf7//XTlVgIGRM/0iw2mu0dPW+nhWPCZ09PHjxBOwqRsieR6FC
         54xg==
X-Gm-Message-State: ALoCoQmtcNvo6vQ5LXduafAFoTg84uq/nzidtYAgHaczyDh4O8CC5/36UavB/UejmKKxJH/OU+Nf
X-Received: by 10.58.126.135 with SMTP id my7mr2998528veb.27.1401319252360;
 Wed, 28 May 2014 16:20:52 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 16:20:52 -0700 (PDT)
In-Reply-To: <20140528221720.GB12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250343>

On Wed, May 28, 2014 at 3:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> On Wed, May 28, 2014 at 12:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> --- i/fast-import.c
>>> +++ w/fast-import.c
>>> @@ -1735,21 +1735,28 @@ static void dump_tags(void)
>>>  {
>>>         static const char *msg = "fast-import";
>>>         struct tag *t;
>>> -       char ref_name[PATH_MAX];
>>> +       struct strbuf ref_name = STRBUF_INIT;
>>>         struct strbuf err = STRBUF_INIT;
>>>         struct ref_transaction *transaction;
>>>
>>> +       strbuf_addstr(&ref_name, "refs/tags/");
>>> +
>>>         transaction = ref_transaction_begin(&err);
>>>         for (t = first_tag; t; t = t->next_tag) {
>>> -               snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
>>> +               strbuf_setlen(&ref_name, strlen("refs/tags/"));
>>> +               strbuf_addstr(&ref_name, t->name);
>>>
>>> -               if (ref_transaction_update(transaction, ref_name, t->sha1,
>>> -                                          NULL, 0, 0, &err))
>>> -                       break;
>>> +               if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
>>> +                                          NULL, 0, 0, &err)) {
>>> +                       failure |= error("%s", err.buf);
>>> +                       goto done;
>>> +               }
>>>         }
>>>         if (ref_transaction_commit(transaction, msg, &err))
>>>                 failure |= error("%s", err.buf);
>>> +done:
>>>         ref_transaction_free(transaction);
>>> +       strbuf_release(&ref_name);
>>>         strbuf_release(&err);
>>>  }
>>
>> Changed to strbuf.  Thanks.
>
> Thanks.  The semantics when ref_transaction_update() fail seem weird ---
> see above.  (refs.h tells me "A failure to update means that the
> transaction as a whole has failed and will need to be rolled back", so I
> assume that the function should be rolling back instead of calling
> _commit at that point.)


diff --git a/fast-import.c b/fast-import.c
index 4a7b196..e24c7e4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1735,15 +1735,24 @@ static void dump_tags(void)
 {
        static const char *msg = "fast-import";
        struct tag *t;
-       struct ref_lock *lock;
-       char ref_name[PATH_MAX];
+       struct strbuf ref_name = STRBUF_INIT;
+       struct strbuf err = STRBUF_INIT;
+       struct ref_transaction *transaction;

+       transaction = ref_transaction_begin(&err);
        for (t = first_tag; t; t = t->next_tag) {
-               sprintf(ref_name, "tags/%s", t->name);
-               lock = lock_ref_sha1(ref_name, NULL);
-               if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-                       failure |= error("Unable to update %s", ref_name);
+               strbuf_reset(&ref_name);
+               strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+
+               if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+                                          NULL, 0, 0, &err))
+                       break;
        }
+       if (ref_transaction_commit(transaction, msg, &err))
+               failure |= error("%s", err.buf);
+       ref_transaction_free(transaction);
+       strbuf_release(&ref_name);
+       strbuf_release(&err);
 }


I rely on the fact that if the transaction has failed then it is safe
to call ref_transaction_commit since it is guaranteed to return an
error too.
