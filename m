From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 23:35:41 +0200
Message-ID: <50412E2D.7070503@kdbg.org>
References: <5040C59A.6090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Ysc-0007ip-95
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 23:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab2HaVfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 17:35:48 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53950 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754998Ab2HaVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 17:35:47 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 97FA61000B;
	Fri, 31 Aug 2012 23:35:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 81F3F19F3D9;
	Fri, 31 Aug 2012 23:35:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5040C59A.6090303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204610>

Am 31.08.2012 16:09, schrieb Marco Stornelli:
> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
> +print $addr;'`

The quoting is broken in this line (sq within sq does not work).

Am I correct that you intend to treat continuation lines with this
non-trivial perl script? All this processing gets tedious and
unreadable. Let me suggest this pattern instead:

# translate to Thunderbird language
LANG_TO="To:"
LANG_SUBJ="Subject:"
LANG_CC="Cc:"

LF=	# terminates the _previous_ line
while read -r line
do
	case $line in
	'To: '*)
		printf "${LF}%s" "$LANG_TO ${line#To: }"
		;;
	'Cc: '*) ...similar...
	'Subject: '*) ...similar...
	' '*)	# continuation line
		printf "%s" "$line"
		;;
	'')
		print "${LF}\n"
		cat
		;;
	esac
	LF='\n'
done <"$PATCH" >"$1"

Instead of printing right away, you can also accumulate the data in
variables and print them right before the 'cat'. I would do that only if
a particular order of To:, Cc:, and Subject: is required in the output.

(I don't know how the "do not delete this line" line fits in the
picture, but I'm sure you can figure it out.)

-- Hannes
