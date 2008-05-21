From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix chop_str not to cut in middle of utf8
 multibyte chars.
Date: Wed, 21 May 2008 00:27:55 -0700
Message-ID: <7vve185d6s.fsf@gitster.siamese.dyndns.org>
References: <g0vdse$rj6$1@ger.gmane.org>
 <m3lk244o16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Waldenborg <anders@0x63.nu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 09:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyilC-0006nr-Tv
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 09:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbYEUH2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 03:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbYEUH2G
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 03:28:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbYEUH2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 03:28:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57963DA68;
	Wed, 21 May 2008 03:28:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 85AB3DA67; Wed, 21 May 2008 03:27:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7218C264-2707-11DD-8504-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82533>

Jakub Narebski <jnareb@gmail.com> writes:

> Anders Waldenborg <anders@0x63.nu> writes:
> ...
> Fix chop_str not to cut in middle of utf8 multibyte chars.  Without
> this fix at least author name in short log may cut in middle of a
> multibyte char. When the result comes to esc_html to_utf8 is called
> again, which doesn't find valid utf8 and decodes using
> $fallback_encoding making it even worse.
>  
>> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
>> ---
>>   gitweb/gitweb.perl |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 2facf2d..8308e22 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -866,6 +866,10 @@ sub chop_str {
>>          my $add_len = shift || 10;
>>          my $where = shift || 'right'; # 'left' | 'center' | 'right'
>> 
>> +       # Make sure perl knows it is utf8 encoded so we don't
>> +       # cut in the middle of a utf8 multibyte char.
>> +       $str = to_utf8($str);
>> +
>
> I like the comment here. It explains the whys of code.
>
>>          # allow only $len chars, but don't cut a word if it would fit in $add_len
>>          # if it doesn't fit, cut it if it's still longer than the dots we would add
>>          # remove chopped character entities entirely
>> 
>
> This patch is whitespace damaged, by the way.

I haven't followed the codepath but what do the callers do to the string
returned from chop_str?  Don't they assume the string hasn't been decoded
(because the old implementation of chop_str did not do this to_utf8), and
emit the result directly to the output because it also assumes the
undecoded format is what the outside world wants?  In other words, don't
they now need to do different things because returned string has gone
through the to_utf8() processing already?

Maybe I am worrying too much, after getting burned by decode_utf/encode_utf
data chains in another popular scripting language, and it is possible that
with Perl you may not have to be so careful...


 
