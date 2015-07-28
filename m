From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Wed, 29 Jul 2015 02:11:11 +0530
Message-ID: <CAOLa=ZTXSutXd4HCrXoVoLT0kQzppiC7gUJpnk8DYYCo7M5XNw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com> <vpqa8ugwfyf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:41:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBh4-0000rV-BT
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbbG1Ulm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:41:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36671 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbG1Ull (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:41:41 -0400
Received: by obnw1 with SMTP id w1so93407382obn.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fXXQX6cUHTxCrsy+ysHItunYhRVrNM0uF8Qj1wSsNEA=;
        b=Afimkw3C8GzTl3OVRpgEgCeVP+pyP4lycW/q6n6zBRfE3VUWbw3QK3fmymLdOQ1h40
         fD3jjCasygNGNsswxNosyOFZjYgitazyQ47S57BTVwcEff84qq+OUA4QRMUL0gBl+bXw
         A3GJSRqbweBfBQTAgU0gGoNCoXEtqkMBWDc7SGiUqt/ZZ4MIjpJLjJ/JAGDUDUAbiAyv
         jGJINz2jrSqJuVAFDZigQOdXYhygu9WA38rscPYQ5PvwgWrij0PV/f21g/Yp33MXxhCx
         Ro2diMlU6/cs44fOoVxISNnb0a9vk79CxME3LY4W+3VqN3GA4RwIj1bb4mGa+a3q/cLo
         MSTQ==
X-Received: by 10.182.204.38 with SMTP id kv6mr36476791obc.70.1438116101026;
 Tue, 28 Jul 2015 13:41:41 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 13:41:11 -0700 (PDT)
In-Reply-To: <vpqa8ugwfyf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274842>

On Tue, Jul 28, 2015 at 7:18 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>>> +static void ref_array_append(struct ref_array *array, const char *refname)
>>> +{
>>> +       size_t len = strlen(refname);
>>> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
>>> +       memcpy(ref->refname, refname, len);
>>> +       ref->refname[len] = '\0';
>
> This looks very much like new_ref_array_item, except that the later also
> takes an objectname parameter. I find it suspicious that you leave the
> objectname field uninitialized.
>

Well the objectname is not required here, the idea is to retain the way branch.c
works.

> Why is this code not calling new_ref_array_item?
>

Because no objectname is there.

> A detail: you could return a pointer to the newly allocated object to
> write
>
>         item = ref_array_append(array, refname);
>
> instead of
>
>         ref_array_append(array, refname);
>         item = array->items[array->nr - 1];
>

Yeah doing that :)

>>> +       REALLOC_ARRAY(array->items, array->nr + 1);
>>> +       array->items[array->nr++] = ref;
>>> +}
>>
>> This function belongs more to ref-filter.{c,h}...
>
> The function disapears in the next commit, but I also think that this
> function deserves to exist in ref-filter.{c,h} and remain after the end
> of the series.
>

Why though? I don't see the need when new_ref_array_item() is present.

-- 
Regards,
Karthik Nayak
