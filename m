From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Tue, 02 Jun 2015 01:05:52 +0530
Message-ID: <C9DFEB12-F48F-4F73-AFC8-F37892C75A92@gmail.com>
References: <5569EF77.4010300@gmail.com> <1433008411-8550-6-git-send-email-karthik.188@gmail.com> <xmqqmw0kab94.fsf@gitster.dls.corp.google.com> <556B6234.2010809@gmail.com> <xmqqvbf78oow.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 21:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzVVF-0000g7-Hk
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 21:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbbFATgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 15:36:01 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36018 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbFATf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 15:35:59 -0400
Received: by pacux9 with SMTP id ux9so75703792pac.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=W42Gi72cV/FJJJpMZd+NxRPqxifZFa3vmr8SfEqt57w=;
        b=MuYt0OKeuhhufq0QQpmila8uS7ee5iet8TpLisvxKZ7gFYWS1B/vH+JxCNN7LXYYff
         a0yzCYOaJdjAFy0fKIlzpupZPWmYMJ0zx0uuSq4dUzEYNUe8jJJCjwQwwRGkAlYApZsw
         /MK7a04VJIH9qNyRrMm5+ARFSI5KW8O1sn5e1oIdy7wY+NES7SfIHMj1acPn4KhKn/dh
         CTxlqbyZS3rUY+P8bnP4p+nsau1+XWPCoP9AEawjhBdsSq/9kztDtGsR9NHtFJy4NEw5
         LKzY+Nxl//Ebs5fJc9BNcvReocatVwY8lWU3Bi9OPV0sLTpkYEm2AtuArM49Q69XwUd5
         kVCw==
X-Received: by 10.66.231.42 with SMTP id td10mr42653630pac.98.1433187358848;
        Mon, 01 Jun 2015 12:35:58 -0700 (PDT)
Received: from [100.104.141.60] ([49.15.131.86])
        by mx.google.com with ESMTPSA id y16sm15058869pbt.32.2015.06.01.12.35.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:35:58 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqvbf78oow.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270465>



On June 1, 2015 8:23:51 PM GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
>Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Could be achieved using a simple wrapper around 'filter_refs()'
>> something like this perhaps.
>>
>> int filter_refs_with_pattern(struct ref_array *ref, int
>> (*for_each_ref_fn)(each_ref_fn, void *), char **patterns)
>> {
>> 	int i;
>> 	struct ref_filter_cbdata data;
>> 	data.filter.name_patterns = patterns;
>> 	filter_refs(for_each_ref_fn, &data);
>
>I presume that this is
>
>	filter_refs(&refs, for_each_ref_fn, &data);
>
>as you would need to have some way to get the result back ;-)
>

No it's meant to be that way, see as it takes a struct ref_filter_cbdata, the filters are put in the data.filter.* and we obtain the refs in the data.array.items. So no need for another ref_array to hold the array of items.

>> 	refs->nr = data.array.nr;
>> 	for(i = 0; i < refs->nr; i++) {
>> 		/* copy over the refs */
>> 	}
>> 	return 0;
>> }
>>
>> Is this on the lines of what you had in mind? If it is, than I could
>> just create a new patch which would make ref_filter_handler() private
>> and introduce filter_refs() as shown.
>
>Yeah.  Even though I suggested
>
>	filter_refs(&for_each_ref, ...);
>
>I actually would think the external interface should not mention
>for_each_ref() like I did.  The primary reason why I felt that it is
>bad for the API to export a generic callback function the caller can
>use to call for_each_ref() or for_each_rawref()" in the longer term
>is because it forces us to always iterate all refs; for_each_ref()
>does not know what the callback filter function wants to do.  The
>most common way to filter in the context of your GSoC project is "we
>limit only to refs/heads/*, and then we may also filter by other
>criteria" (that is "git branch" "-l" or possibly with "--contains",
>etc.), and it is very wasteful for that codepath to allow
>for_each_ref() to even enumerate and feed all refs outside the
>refs/heads/* area to your callback, which would involve reading all
>entries in packed-refs (which is a fixed cost so not an overhead)
>and then reading everything in .git/refs/* (which is an overhead we
>could and should avoid when we know we are only interested in the
>branches that live in refs/heads*).
>
>Your first implementation of course can just call for_each_ref() or
>for_each_rawref(), and at the end of GSoC, the code may still do so.
>But by keeping the external interface free of for_each_ref(), you
>could later optimize.
>
>And your above sample only takes for_each_ref_fn without exposing the
>internal use of for_each_ref(), which is good.

That seems good, thanks for the guidance.
