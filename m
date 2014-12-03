From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 3 Dec 2014 13:59:18 -0800
Message-ID: <20141203215918.GF6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051016.GK6527@google.com>
 <xmqqbnnkwgpg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHxG-0002ly-BL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaLCV7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:59:22 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45136 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaLCV7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:59:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so14711461ieb.9
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gEvx5JN9Cio3YVgrbd/DJmYA2gEsuI2plvA77a3sb5E=;
        b=RjYJDv6OgckwLpZZVaFKBAeeAAXtyjNs2/q6F3OQrSnHfq7plmIZmBNDO60C/wEHzA
         Ce9YCIe7yYHzDNqNE7TVUQrQhzR3QeVVh19CnEli8PPPdfznqaQ0IhQz9tQGcJoDO0W7
         vCSGYSidcPz8yuQQqDelWSk4wvQ7PgbawnLSQnDDD5pF96hb63z9Ymf0aP48Plct1rGs
         T7TucmMmIRjzU3J/JHJQ66h+VmFzWwCq6/QJoQFGUTwgRrHrIqDrl8o55j3I4rQzVtFm
         OXZEIC4F+n6w6CJX5hIBBzG3O5YfCw+F89uSmxGjEHyhXTChQMywDsBvSmQ2KDy3bG9B
         wYFw==
X-Received: by 10.107.135.211 with SMTP id r80mr6886132ioi.67.1417643960921;
        Wed, 03 Dec 2014 13:59:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id ro6sm14239986igb.3.2014.12.03.13.59.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 13:59:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqbnnkwgpg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260699>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +	size_t pos, len;
>> +
>> +	pos = sb->len;
>> +
>> +	va_start(ap, fmt);
>> +	strbuf_vaddf(sb, fmt, ap);
>> +	va_end(ap);
>> +
>> +	len = sb->len - pos;
>> +	strbuf_insert(sb, 0, sb->buf + pos, len);
>> +	strbuf_remove(sb, pos + len, len);
>> +}
>
> This indeed is strange to read; it would be more straightforward to
> use a second strbuf for temporary storage you need to do this,
> instead of using the tail-end of the original strbuf and shuffling
> bytes around.

I could do that.  It's less efficient but if the prevailing sentiment
is that it's worth it then I don't mind.

Would adding a comment to the implementation of strbuf_prefixf help?

> In any case, instead of this:
>
> 	struct strbuf tc_err = STRBUF_INIT;
>       if (transaction_commit(&t, &tc_err)) {
> 		strbuf_addf(err, "cannot fetch '%s': %s", remotename,
> 			tc_err.buf);
> 		strbuf_release(&tc_err);
> 		return -1;
> 	}
>
> you can use the four-line version you cited above, which might be an
> improvement.

Yes, that's the idea.

I'll do the tc_err thing, since I'm not getting a clear feeling that
I've offered enough motivation for the prefixf approach.

Jonathan
