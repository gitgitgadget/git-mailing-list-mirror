From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Thu, 4 Dec 2008 01:20:08 +0100
Message-ID: <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vy6yw95ln.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L81yE-0008BE-VX
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 01:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYLDAUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 19:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYLDAUM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 19:20:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:52445 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYLDAUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 19:20:10 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1990364nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 16:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ApKT4+lS+FSGNh4XO6/w4zxTsALuflymBGX+gKjuaVQ=;
        b=GX45kTj6J6skkYe0ekgsExHQ2XQ+dRG/hWzgKOOovF/tujKy5PkHik3fN8Mln0nyeJ
         sa/pTR9Vx57IKJIpdJkOILw3gh4K6dCiPXFJryGu3Km3NqA7MSvf+4UZFY5+dAXnZxSc
         H5vKIdrXJ7UyKJxIOD8MDM8tAL6+6gZS+uqzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SrNeEFQUe1OVQ5O+6r47zsLcXChuEhKnqz5RFiv7dmoBmPv+4laJ4CgrbhOZl0AQ4L
         CJs0FRp+eMfV62vu9C4e09WCaryNSouueX2HkTP/ZEfVl6K+g5lWnHKMDkrBmW7wgY5F
         LaTyXNkJBQkHn+MA7HWXE2e2AbmyY0KBqyn0E=
Received: by 10.210.58.13 with SMTP id g13mr3200221eba.94.1228350008451;
        Wed, 03 Dec 2008 16:20:08 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 16:20:08 -0800 (PST)
In-Reply-To: <7vy6yw95ln.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102309>

On Thu, Dec 4, 2008 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>> +
>> +     # The maximum number of patches in a patchset generated in patch
>> +     # view. Set this to 0 or undef to disable patch view, or to a
>> +     # negative number to remove any limit.
>> +     'patches' => {
>> +             'override' => 1,
>> +             'default' => [16]},
>>  );
>
> Looking at the existing entries in the %feature hash, it seems that it is
> our tradition that a new feature starts as disabled and not overridable
> (see 'ctags' in the context above).

I always assumed that the disabled default was related to how invasive
the changes would be (to the UI or computationally-wise). As for the
overridability, that's actually the only reason why it would make
sense to put in the %feature hash ... otherwise a conf-settable
$patch_max (as in v2) would have been enough.

>>  sub git_commitdiff {
>>       my $format = shift || 'html';
>> +
>> +     my $patch_max = gitweb_check_feature('patches');
>> +     if ($format eq 'patch') {
>> +             die_error(403, "Patch view not allowed") unless $patch_max;
>> +     }
>> +
>
> Should you have to pay overhead for the check-feature call even when
> the $format is not "patch"?

Actually I wasn't sure if I could use my within the if block, and have
the value visible outside (it's used further down when picking the
options to pass to format-patch). And since it was used in the second
patch anyway to choose whether to add the 'patch' link in html view or
not, I just put it outside the block.

>> @@ -5396,6 +5410,7 @@ sub git_commitdiff {
>>       }
>>       # we need to prepare $formats_nav before almost any parameter munging
>>       my $formats_nav;
>> +
>
> Noise.

Oopsie.

>> @@ -5532,6 +5552,15 @@ sub git_commitdiff {
>>                       print to_utf8($line) . "\n";
>>               }
>>               print "---\n\n";
>> +     } elsif ($format eq 'patch') {
>> +             my $filename = basename($project) . "-$hash.patch";
>> +
>> +             print $cgi->header(
>> +                     -type => 'text/plain',
>> +                     -charset => 'utf-8',
>> +                     -expires => $expires,
>> +                     -content_disposition => 'inline; filename="' . "$filename" . '"');
>> +             # TODO add X-Git-Tag/X-Git-Url headers in a sensible way
>
> A stupid question.  Are you talking about sending these X-Foo as extra
> HTTP headers?  What good would they do (iow what will they be used for by
> the receiving browser/wget)?

No, as extra 'email' headers, similarly to what commitdiff_plain does.
It might or might not make sense, and might or might not be worth the
effort. For sure the best way to enable these things would have to
give git format-patch some support for extra headers specified on the
command line.

> Other than that the patch seems quite straightforward and was a pleasant
> read.  Thanks.

Thank you.

-- 
Giuseppe "Oblomov" Bilotta
