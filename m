From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Tue, 04 Mar 2014 01:09:39 +0100
Message-ID: <877g8akenw.fsf@fencepost.gnu.org>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	<xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
	<xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
	<CACsJy8ASBeravdk67pbOJbrFUbwg21JwYcLtSbDDMJOu9-F=yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 01:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcva-0002Uo-55
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 01:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbaCDAJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 19:09:41 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:35070 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbaCDAJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 19:09:41 -0500
Received: from localhost ([127.0.0.1]:34110 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKcvU-0001Uv-3H; Mon, 03 Mar 2014 19:09:40 -0500
Received: by lola (Postfix, from userid 1000)
	id C039DE065F; Tue,  4 Mar 2014 01:09:39 +0100 (CET)
In-Reply-To: <CACsJy8ASBeravdk67pbOJbrFUbwg21JwYcLtSbDDMJOu9-F=yA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 4 Mar 2014 06:37:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243318>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 4, 2014 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index cbd86c3..68ffaef 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const char *suffix);
>>
>>  static inline const char *skip_prefix(const char *str, const char *prefix)
>>  {
>> -       size_t len = strlen(prefix);
>> -       return strncmp(str, prefix, len) ? NULL : str + len;
>
> Just a note. gcc does optimize strlen("abcdef") to 6, and with that
> information at compile time built-in strncmp might do better.

Indeed, most (but not all) of the calls have a constant string as
prefix.  However, strncmp in each iteration checks for both *str as well
as *prefix to be different from '\0' independently (and it appears
unlikely to me that the optimizer will figure out that it's unnecessary
for either) _and_ compares them for equality so it's not likely to be
faster than the open-coded loop.

One could, however, use memcmp instead of strncmp.  I'm just not sure
whether memcmp is guaranteed not to peek beyond the first mismatching
byte even if the count would allow for more.  It could lead to undefined
behavior if the first mismatching byte would be the ending NUL byte of
str.

-- 
David Kastrup
