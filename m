From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sun, 02 Sep 2012 11:42:23 -0700
Message-ID: <7vzk58gno2.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Stornelli <marco.stornelli@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2B-0008NO-Og
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab2IBUod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab2IBUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF71C830D;
	Sun,  2 Sep 2012 16:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=5IEXWXnBxtM36JS00pP389HAnQA=; b=rOHFDEiFBeHWD1lSqMwd
	Hr6ftoQ6c+ZCocNTz6OEjSmGmCmOuaZ6PGMthNrbz3EOyc9VJ4wLoUw/0TmsCO4r
	0b8tnKsw7vQ/+zMHp7arz58Cum9f9e/ryVgpXdkwc/4mSA83U2vpYkKN8FtVioTN
	1F1StMU9EhqBqTRJdqNqKw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fsb4qLeIu25Eu/jTLQUnh6KEdb5CzEwrbuWKzyT8iGkAF8
	vsKtzmV2cis4Y+qveFV9x/mr8/5mm5EaWQqizpzssZL0UVBu1wY3fcbrA5Po4sCN
	Z/XeocBNH4Lp6ZOmnRAiii/EsQSJpKn6uDiVgZdT671WVuSSy6nltNS8govRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA7FB830C;
	Sun,  2 Sep 2012 16:44:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E0E2830B; Sun,  2 Sep 2012
 16:44:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEE9510E-F53E-11E1-B684-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204669>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 31.08.2012 16:09, schrieb Marco Stornelli:
>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
>> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
>> +print $addr;'`
>
> The quoting is broken in this line (sq within sq does not work).

As you said later in the thread, perl lets you be loose and say
$ENV{PATCHTMP} without quoting the string "PATCHTMP", so it is not
quite _broken_ per-se, but the above gives a false impression to
readers that the author meant to feed perl

    open FILE, $ENV{'PATCHTMP'};

which is not happening, so at least it is misleading.

> Am I correct that you intend to treat continuation lines with this
> non-trivial perl script?

As the above regexp seems to try to match

	Cc: marco, git,
          j6t, other recipient

I think that indeed is the intent.

> All this processing gets tedious and
> unreadable. Let me suggest this pattern instead:
>
> # translate to Thunderbird language
> LANG_TO="To:"
> LANG_SUBJ="Subject:"
> LANG_CC="Cc:"
>
> LF=	# terminates the _previous_ line
> while read -r line
> do
> 	case $line in
> 	'To: '*)
> 		printf "${LF}%s" "$LANG_TO ${line#To: }"
> 		;;
> 	'Cc: '*) ...similar...
> 	'Subject: '*) ...similar...
> 	' '*)	# continuation line
> 		printf "%s" "$line"
> 		;;
> 	'')
> 		print "${LF}\n"
> 		cat
> 		;;
> 	esac
> 	LF='\n'
> done <"$PATCH" >"$1"

I think that is much more readable.
