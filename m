From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 2/4] Use 'lstat_cache()' instead of
 'has_symlink_leading_path()'
Date: Tue, 06 Jan 2009 15:25:47 -0800
Message-ID: <7vocykf24k.fsf@gitster.siamese.dyndns.org>
References: <1231274192-30478-1-git-send-email-barvik@broadpark.no>
 <1231274192-30478-3-git-send-email-barvik@broadpark.no>
 <alpine.LFD.2.00.0901061304280.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKLKT-00037m-4l
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 00:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbZAFXZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 18:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753783AbZAFXZz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 18:25:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbZAFXZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 18:25:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E378A8E292;
	Tue,  6 Jan 2009 18:25:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA18F8E288; Tue,
  6 Jan 2009 18:25:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901061304280.3057@localhost.localdomain>
 (Linus Torvalds's message of "Tue, 6 Jan 2009 13:08:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C3CC9F2-DC49-11DD-A8BA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104737>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> ...  The previously used call:
>> 
>>    has_symlink_leading_path(len, name);
>> 
>> should be identically with the following call to lstat_cache():
>> 
>>    lstat_cache(len, name,
>>                LSTAT_SYMLINK|LSTAT_DIR,
>>                LSTAT_SYMLINK);
>
> I think the new interface looks worse.
>
> Why don't you just do a new inline function that says
>
> 	static inline int has_symlink_leading_path(int len, const char *name)
> 	{
> 		return lstat_cache(len, name,
> 			LSTAT_SYMLINK|LSTAT_DIR,
> 			LSTAT_SYMLINK);
> 	}
>
> and now you don't need this big patch, and people who don't care about 
> those magic flags don't need to have them. End result: more readable code.

Excellent.

Not that I did not think a backward compatible macro is much easier to
read; after all, ce/ie you mention is a refactorizaton I did myself.

What I didn't think of was that posing the above question is a much better
way to extract a clear explanation why some of these lstat_cache() calls
have LSTAT_NOENT and some of them don't from the author.  It is much
better way than my earlier attempt to do so.

> This is how git has done pretty much all "generalized" versions. See the 
> whole ce_modified() vs ie_modified() thing: they're the same function, 
> it's just that 'ce_modified()' is the traditional simpler interface that 
> works on the default index, while ie_modified() is the "full" version that 
> takes all the details that most uses don't even want to know about.

Yup, thanks for a praise ;-)
