From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] patch-id: make it stable against hunk reordering
Date: Fri, 28 Mar 2014 15:26:56 -0700
Message-ID: <xmqqppl67ydr.fsf@gitster.dls.corp.google.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
	<xmqqzjka7z26.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 23:27:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTfEz-00063w-38
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 23:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbaC1W1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 18:27:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbaC1W1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 18:27:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A08278A4E;
	Fri, 28 Mar 2014 18:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=citw0+F5uQCEdNLI7a6Zjw+osko=; b=SlY3/l
	K6Dua1nm36y7L0hlxX2fKlcn7xOgTYHZEGUQuXouG0HhGz8AoKPhx94lTvOA6OrP
	/7ecFIJSGFb32cJjyIQytsxExvB3nBMyULO1E6tSFD2we7aEud+pWhhUbot3L+XI
	B8CuYy6EY1QVnqNmT+fOHbpGT0M82h34RD0BI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3jf+IXkd2I7y6bTvR6oNZrBdAGzaLzE
	N7JCXjH14ej7fOr3OYs2kHCpqHms5Ws0HuCPJScVAkeopIWdHXQ1xuDdUKWuzdh7
	wb5A/BlNe4pL+oWFLx0KpFj/QF3i1cuGiJ0poetorD5VEzdQTXcS6C9kjaXNxKH2
	Le6ObKLO36Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5FB878A4D;
	Fri, 28 Mar 2014 18:27:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 144EA78A4A;
	Fri, 28 Mar 2014 18:27:00 -0400 (EDT)
In-Reply-To: <xmqqzjka7z26.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 28 Mar 2014 15:12:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1443A3DC-B6C8-11E3-A916-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245429>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -99,6 +116,18 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>>  			if (!memcmp(line, "@@ -", 4)) {
>>  				/* Parse next hunk, but ignore line numbers.  */
>>  				scan_hunk_header(line, &before, &after);
>> +				if (stable) {
>> +					if (hunks) {
>> +						flush_one_hunk(result, &ctx);
>> +						memcpy(&ctx, &header_ctx,
>> +						       sizeof ctx);
>> +					} else {
>> +						/* Save ctx for next hunk.  */
>> +						memcpy(&header_ctx, &ctx,
>> +						       sizeof ctx);
>> +					}
>> +				}
>> +				hunks++;
>>  				continue;
>>  			}
>>  
>> @@ -107,7 +136,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>>  				break;
>>  
>>  			/* Else we're parsing another header.  */
>> +			if (stable && hunks)
>> +				flush_one_hunk(result, &ctx);
>>  			before = after = -1;
>> +			hunks = 0;
>>  		}
>>  
>>  		/* If we get here, we're inside a hunk.  */
>> @@ -119,39 +151,46 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
>>  		/* Compute the sha without whitespace */
>>  		len = remove_space(line);
>>  		patchlen += len;
>> -		git_SHA1_Update(ctx, line, len);
>> +		git_SHA1_Update(&ctx, line, len);
>>  	}
>>  
>>  	if (!found_next)
>>  		hashclr(next_sha1);
>>  
>> +	flush_one_hunk(result, &ctx);
>
> What I read from these changes is that you do not do anything
> special about the per-file header, so two no overlapping patches
> with a single hunk each that touches the same path concatenated
> together would not result in the same patch-id as a single-patch
> that has the same two hunks.  Which would break your earlier 'Yes,
> reordering only the hunks will not make sense, but before each hunk
> you could insert the same "diff --git a/... b/..." to make them a
> concatenation of patches that touch the same file', I would think.
>
> Is that what we want to happen?  Or is my reading mistaken?

Heh, I was blind---copying into header_ctx and then restoring that
in preparation for the next round is exactly for duplicating the
per-file header sum to each and every hunk, so you are already doing
that.
