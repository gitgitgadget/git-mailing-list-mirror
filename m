From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Tue, 3 Apr 2007 16:57:24 +0200
Message-ID: <200704031657.25698.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703311816.05283.jnareb@gmail.com> <7vmz1t6oe2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 18:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYlnE-0007t0-AF
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXDCQXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 12:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXDCQXb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 12:23:31 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:10122 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXDCQXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 12:23:30 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1930223muf
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 09:23:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fGsmZIKEHnySbZ4FaCY8NbDDw5S8dXuSyHisLviZ1jx3VCV4SuXfcrD2L+QujZFnbz3xq2um0KgbalvcYRDxRFFYjmAlxr2HrLo1bZkyZlHeTrxCmsDPil4REzWvWqqOVnx35COg5DYMIKuy/YJCkWuGF0mQW6z67ITLivGPk5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rHWYTXtoOFJXdLjkX1PsV8N66r6oM3AOqDQo/PK9VGyotlCdEi5BTBS74l3jyARb26CMXRaFruki6t6XulvlRxia3rHKUAkUw4aXamab7iIvHwPidX8op6IAHIhGq4RIz/xF65DAAdNZyLxyoTRa+a4u6uMTzMlNzHCf4tdNtkk=
Received: by 10.82.148.7 with SMTP id v7mr3597780bud.1175617408289;
        Tue, 03 Apr 2007 09:23:28 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm24624800muf.2007.04.03.09.23.25;
        Tue, 03 Apr 2007 09:23:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz1t6oe2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43626>

On Sun, Apr 1, 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> First is not escaped filename in HTTP header. There was some discussion
>>> about this, and even patch by Luben Tuikov which added to_qtext 
>>> subroutine to deal with escaping in HTTP (which has diferent rules than
>>> escaping in HTML, or in HTML attributes)
>>>  * gitweb: using quotemeta
>>>    http://thread.gmane.org/gmane.comp.version-control.git/28050/
>>>  * [PATCH] gitweb: Convert Content-Disposition filenames into qtext
>>>    http://thread.gmane.org/gmane.comp.version-control.git/28437
>>> But the patch was newer accepted; either lost in the noise, or in lack
>>> of summary to the discussion.
>>
>> Junio, do you remember by chance why this patch was dropped?
> 
> No, but I suspect that was because the noisiness of the thread
> around them suggested they were not ready to be applied.  I do
> not remember if people submitted the patch and commented on
> reached a consensus.

Probably not. Here is alternative proposal. It does not implement
  RFC2184: MIME Parameter Value and Encoded Word Extensions
but I'm not sure if 1) it is needed for _HTTP_ Content-Disposition
header filename, 2) all browsers implement it.

By the way, $str =~ s/[\n\r]/_/g; line (as per Junio Hamano and Petr
Baudis suggestion) is needed not only for buggy browsers, but also for
buggy CGI implementation:

  $ perl -wle \
  'use CGI; \
   our $cgi = new CGI; \
   print $cgi->header(-content_disposition => "inline; filename=\"file\nname\"");'

generates (for CGI version 3.10)

  Content-disposition="inline; filename=&quot;file
  name&quot;"

which is a bit strange. Single LF (not CRLF pair) does not need to be
quoted in the header, as per RFC822.

-- >8 --
# Generate value of Content-Disposition header field, with "inline"
# disposition type, for a given filename parameter
# Usage: $cgi->header( [...],
#          -content_disposition => content_disposition($filename))
# References: RFC 2183, RFC 822 and RFC 2045
sub content_disposition {
	my $filename = shift;

	#RFC2183: The Content-Disposition Header Field
	# parameter value containing only non-`tspecials' characters [RFC 2045]
	# SHOULD be represented as a single `token'.
	#RFC2045: MIME Part One: Format of Internet Message Bodies
	# token := 1*<any (US-ASCII) CHAR except SPACE, CTLs,
	#             or tspecials>
	if ($filename =~ m/[[:space:][:cntrl:]()<>@,;:\\"\/\[\]?=]/) {
		#RFC2183: The Content-Disposition Header Field
		# parameter value containing only ASCII characters, but including
		# `tspecials' characters, SHOULD be represented as `quoted-string'.

		# It not worth potential problems to try to carry newlines (and such)
		# in the header; it is just _suggested_ filename
		$filename =~ s/[[:cntrl:]\n\r]/_/g;

		#RFC822: Standard for the Format of ARPA Internet Text Messages
		# quoting is REQUIRED for CR and "\" and for the character(s) that
		# delimit the token (e.g., "(" and ")" for a comment).  However,
		# quoting is PERMITTED for any character.
		$filename =~ s/([\\"\r])/\\$1/g;
		$filename = '"' . $filename . '"';
	}
	return "inline; filename=$filename";
}
-- >8 --
P.S. We could probably always quote filename parameter, even if it
is not needed ("SHOULD be represented as a single `token'" part).

P.P.S. Here is an example of RFC2184 encoded header:

   Content-Type: application/x-stuff
    title*1*=us-ascii'en'This%20is%20even%20more%20
    title*2*=%2A%2A%2Afun%2A%2A%2A%20
    title*3="isn't it!"

-- 
Jakub Narebski
Poland
