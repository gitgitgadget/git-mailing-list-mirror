From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Wed, 28 May 2014 15:17:20 -0700
Message-ID: <20140528221720.GB12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-26-git-send-email-sahlberg@google.com>
 <20140528194746.GX12314@google.com>
 <CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpmA4-00059M-0S
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 00:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbaE1WRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 18:17:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58072 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbaE1WRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 18:17:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so11705583pab.19
        for <git@vger.kernel.org>; Wed, 28 May 2014 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=F+AgeWRRYnIHyiy7yUslKzk06nAkAm4DmLfEaauKG24=;
        b=LlM+BDEebWtGlsNIm0LbxG1E30YtbkfFNBbGOcLD6zJOzN8K0lydnAyF1LAWdk9uKt
         qr2vaZhEDEgFG5S90s6oKs8K7AduDnFQAB4397w5OTjHtGo9qGbVhekFCVmqcyJVrlU3
         qPiPdbzNRng+4kJSVqg7m19Ec7Oj8UKVWt5dIfTWZZ4ZvGcBHlj0lGYtoaMxjAJxXmh8
         szTrKiq53m/iV0RuInS/efjJ20xtrzBMIlKcMcb5NNru/j9S0gdIpJw6Xk1667H513ki
         3ztuhQMj0GzPsKPUficSRraN7x/tEN/h49z4RwGrsUSRqwCMVZHma0KZVuVFI1iS9g5F
         ImVA==
X-Received: by 10.68.173.65 with SMTP id bi1mr3364192pbc.130.1401315443315;
        Wed, 28 May 2014 15:17:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id om6sm30055116pbc.43.2014.05.28.15.17.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 15:17:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250339>

Ronnie Sahlberg wrote:
> On Wed, May 28, 2014 at 12:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> --- i/fast-import.c
>> +++ w/fast-import.c
>> @@ -1735,21 +1735,28 @@ static void dump_tags(void)
>>  {
>>         static const char *msg = "fast-import";
>>         struct tag *t;
>> -       char ref_name[PATH_MAX];
>> +       struct strbuf ref_name = STRBUF_INIT;
>>         struct strbuf err = STRBUF_INIT;
>>         struct ref_transaction *transaction;
>>
>> +       strbuf_addstr(&ref_name, "refs/tags/");
>> +
>>         transaction = ref_transaction_begin(&err);
>>         for (t = first_tag; t; t = t->next_tag) {
>> -               snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
>> +               strbuf_setlen(&ref_name, strlen("refs/tags/"));
>> +               strbuf_addstr(&ref_name, t->name);
>>
>> -               if (ref_transaction_update(transaction, ref_name, t->sha1,
>> -                                          NULL, 0, 0, &err))
>> -                       break;
>> +               if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
>> +                                          NULL, 0, 0, &err)) {
>> +                       failure |= error("%s", err.buf);
>> +                       goto done;
>> +               }
>>         }
>>         if (ref_transaction_commit(transaction, msg, &err))
>>                 failure |= error("%s", err.buf);
>> +done:
>>         ref_transaction_free(transaction);
>> +       strbuf_release(&ref_name);
>>         strbuf_release(&err);
>>  }
>
> Changed to strbuf.  Thanks.

Thanks.  The semantics when ref_transaction_update() fail seem weird ---
see above.  (refs.h tells me "A failure to update means that the
transaction as a whole has failed and will need to be rolled back", so I
assume that the function should be rolling back instead of calling
_commit at that point.)
