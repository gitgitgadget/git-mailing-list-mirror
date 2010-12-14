From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] git-p4: Fix 'p4 opened' in git-p4 for names with spaces
Date: Tue, 14 Dec 2010 23:36:56 +0000
Message-ID: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com>
References: <1292360165-26771-1-git-send-email-jerzy.kozera@gmail.com>
	<1292360165-26771-2-git-send-email-jerzy.kozera@gmail.com>
	<7vvd2wq72l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jerzy Kozera <jerzy.kozera@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSeQY-0007dW-EF
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab0LNXg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 18:36:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38428 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab0LNXg5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 18:36:57 -0500
Received: by qwa26 with SMTP id 26so1343085qwa.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=33V5jITBkS1sdBtti7LwE/lo9zpPGBa0dic6gwpWUD0=;
        b=cDKrc9f+xJUjxYUM94jWj5Wd90MJGMj6AvjdgFI9DtmW9l+dHHp6qAYekjHTVwiHCr
         mn08K58YxFCnOXVngpn72AdMyvReAkt4D4mLarRTiDZmMN9LXWeCyk62Ev5MsflkY52S
         eQJ5KUbz0/rvS73VlCg55GfCSdBwIedzRXitg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xjOzTSQLbjmufjhb3bTj5beEuZNiwVbnLXa7LL2hfyTOpzS+lb8GFFbjRFt5cwU6L0
         4Sia8X4RSA3XqRUcny9+hM4LSOlLZxA5cx9YpOw2NWOWFgcpVL0K7BzwMhdyZ67DjFvQ
         a7AsbRI1xqlpvLtYHITVK5zQ7xSuObocNUDX8=
Received: by 10.229.187.196 with SMTP id cx4mr245686qcb.178.1292369816465;
 Tue, 14 Dec 2010 15:36:56 -0800 (PST)
Received: by 10.229.186.73 with HTTP; Tue, 14 Dec 2010 15:36:56 -0800 (PST)
In-Reply-To: <7vvd2wq72l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163721>

On 14 December 2010 23:16, Junio C Hamano <gitster@pobox.com> wrote:
> Jerzy Kozera <jerzy.kozera@gmail.com> writes:
>
>> Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
>> ---
>> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> index 04ce7e3..a5297e7 100755
>> --- a/contrib/fast-import/git-p4
>> +++ b/contrib/fast-import/git-p4
>> @@ -144,7 +144,7 @@ def setP4ExecBit(file, mode):
>> =A0def getP4OpenedType(file):
>> =A0 =A0 =A0# Returns the perforce file type for the given file.
>>
>> - =A0 =A0result =3D p4_read_pipe("opened %s" % file)
>> + =A0 =A0result =3D p4_read_pipe("opened \"%s\"" % file)
>
> Don't you need a lot more than that? =A0What if file has " or \ in it=
?

Those are invalid characters for a filename on Windows, so cannot be
entered/present in the filename. On Linux, they are accepted, but
don't get put into the filename, so it all depends on where the data
for file comes from (API call or user/external source). Not sure how
Mac/BSD/Solaris handle those characters.

This looks fine to me, but I wonder if there are other places
referencing file paths that require quoting to correctly handle
spaces.

Also, escaping the quote characters can be avoided by using single
quoted string literals:

+    result =3D p4_read_pipe('opened "%s"' % file)

- Reece
