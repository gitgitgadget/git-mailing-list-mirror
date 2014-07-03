From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 6/7] replace: remove signature when using --graft
Date: Thu, 3 Jul 2014 16:09:42 +0200
Message-ID: <CAP8UFD1DHQf9PuSMVCcsgqJ2xAOxPBEk3S3+iOZRmAY=XmDqaw@mail.gmail.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.38249.chriscool@tuxfamily.org>
	<xmqqpphnfogx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 16:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hht-00082n-HO
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 16:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbaGCOJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 10:09:45 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:42238 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbaGCOJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 10:09:43 -0400
Received: by mail-ve0-f174.google.com with SMTP id jx11so276581veb.33
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e8Eg84EWKoNjVBkXp4jOV6FXc2wWXzUiJLLkZheDiPM=;
        b=n8UaKRoeIlvguOiVWegBc5GfWU6fsWNHdNRpASbxD9ynGawHq+TP6Q+6bbKZxXAIFx
         anmKVx78W6+0px3uuMcRrbUZMu7HfTm+yw9Ob27hM7pQ8QIwBRIJQvGjs+/FSbDa6SEN
         gnDKHpkR1y82IEpptNoaiaGykRGHdPggNdsOMdOP2NXQaqbBdV/vhmANlI1+KypyYImk
         Ui9XFOCtn5nNOLyuXS+TK7OTfneXZQE7i0EhaU4SYLG8U2XH3MGnwUk8EtofVVq28MMQ
         8AT8soovw1kQR2DsnrksiV50OmPBcboa4S++NGlpJWHdnPZb+vl4px/DqUL+agiVU6Si
         oJJw==
X-Received: by 10.58.178.131 with SMTP id cy3mr399031vec.76.1404396582348;
 Thu, 03 Jul 2014 07:09:42 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Thu, 3 Jul 2014 07:09:42 -0700 (PDT)
In-Reply-To: <xmqqpphnfogx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252862>

On Wed, Jul 2, 2014 at 11:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> It could be misleading to keep a signature in a
>> replacement commit, so let's remove it.
>>
>> Note that there should probably be a way to sign
>> the replacement commit created when using --graft,
>> but this can be dealt with in another commit or
>> patch series.
>
> Both paragraphs read very sensibly.

Thanks.

>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -344,6 +344,11 @@ static int create_graft(int argc, const char **argv, int force)
>>
>>       replace_parents(&buf, argc, argv);
>>
>> +     if (remove_signature(&buf))
>> +             warning(_("the original commit '%s' has a gpg signature.\n"
>> +                       "It will be removed in the replacement commit!"),
>
> Hmmm...  does the second line of this message start with the usual
> "warning:" prefix?

Ok, I will use following:

if (remove_signature(&buf)) {
        warning(_("the original commit '%s' has a gpg signature."), old_ref);
        warning(_("the signature will be removed in the replacement commit!"));
}

>> diff --git a/commit.c b/commit.c
>> index fb7897c..54e157d 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1177,6 +1177,40 @@ int parse_signed_commit(const struct commit *commit,
>>       return saw_signature;
>>  }
>>
>> +int remove_signature(struct strbuf *buf)
>> +{
>> +     const char *line = buf->buf;
>> +     const char *tail = buf->buf + buf->len;
>> +     int in_signature = 0;
>> +     const char *sig_start = NULL;
>> +     const char *sig_end = NULL;
>> +
>> +     while (line < tail) {
>> +             const char *next = memchr(line, '\n', tail - line);
>> +             next = next ? next + 1 : tail;
>
> This almost makes me wonder if we want something similar to
> strchrnul() we use for NUL-terminated strings, and I suspect that
> you would find more instances by running "git grep -A2 memchr".
>
> I don't know what such a helper function should be named, though.
> Certainly not "memchrnul()".

I can add this to a GSoC microproject page for next year.

>> +             if (in_signature && line[0] == ' ')
>> +                     sig_end = next;
>> +             else if (starts_with(line, gpg_sig_header) &&
>> +                      line[gpg_sig_header_len] == ' ') {
>> +                     sig_start = line;
>> +                     sig_end = next;
>> +                     in_signature = 1;
>> +             } else {
>> +                     if (*line == '\n')
>> +                             /* dump the whole remainder of the buffer */
>> +                             next = tail;
>> +                     in_signature = 0;
>> +             }
>> +             line = next;
>> +     }
>> +
>> +     if (sig_start)
>> +             strbuf_remove(buf, sig_start - buf->buf, sig_end - sig_start);
>
> If there are two instances of gpg_sig, this will remove only the
> last one, but there is no chance both signatures of such a commit
> can validate OK, and we won't be losing something in between anyway,
> so it should be fine.

Ok.

Thanks,
Christian.
