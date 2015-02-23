From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame swallows up lines in case of mixed line endings
Date: Mon, 23 Feb 2015 10:44:50 -0800
Message-ID: <xmqqwq38tql9.fsf@gitster.dls.corp.google.com>
References: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
	<54E88BFA.9050900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Sokolov\, Konstantin \(ext\)" <konstantin.sokolov.ext@siemens.com>,
	"'git\@vger.kernel.org'" <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPy07-00084m-J9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbBWSo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2015 13:44:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752284AbbBWSo6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 13:44:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 822133AC75;
	Mon, 23 Feb 2015 13:44:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YStLfUVG8C+q
	UF0V2agY1NrYWiY=; b=Bdy/HSECK6WC3jgHxV1+fkPz2sNPp8E7EHcNYjGbfit7
	Fq9seWwetFvHNEiQjBQCqtoP5AMpHYZcmoAyICQMRxdpotSQ54TFPYGuI5pqa5sW
	kiQQhwMJNxawbT4bXoyiUy/4u1IXuyesDGwans33/rq1pyP3WalvSk6oYmvuW9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fKlyme
	PUT58VRoRm4tDOUFlBieIBczCMzx2Ozh+t/5WUyDqjftRkyBEW5T0NbKuVH4i98J
	uLhgFNyLhN66/ZQuXm8IlK1eQqn6kOUEXEw24DVZC2Wvqin5GgN1XCrczzX+gIuk
	2NntNbayySR4bUMk+WxdIXHdPXdiAMNSYvysE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77CC43AC74;
	Mon, 23 Feb 2015 13:44:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C89163AC73;
	Mon, 23 Feb 2015 13:44:51 -0500 (EST)
In-Reply-To: <54E88BFA.9050900@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 21 Feb 2015 14:45:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D2531B4-BB8C-11E4-AEE5-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264282>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-02-19 14.48, Sokolov, Konstantin (ext) wrote:
>>=20
>> I encounter unexpected behavior in the following case:
>>=20
>> file content:
>>=20
>> line1<CR><LF>
>> line2<CR>
>> line3<CR><LF>
>> line4

You can mark a file as <CRLF> terminated via attributes system and
have Git convert them to use <LF> as end-of-line when file contents
are stored in Git ("<LF> as end-of-line" is the representation "git
blame" uses internally).  Konstantin said "on Windows", and I guessed
initially that the lines are marked as such, but after looking at
the blame.txt output I am not sure.

That means the contents of the lines are:

    First Line:  "line1"
    Second Line: "line2" + CR + "line3"
    Third Line:  "line4"

or if CRLF conversion is not specified in Konstantin's repository:

    First Line:  "line1" + CR
    Second Line: "line2" + CR + CR + "line3" + CR
    Third Line:  "line4" + CR

Either way, that makes the observed behavior totally expected and
understandable.

>> This is what I get as console output (on Windows):
>>=20
>>> git blame -s file.txt
>> 7db36436 1) line1
>> line3436 2) line2
>> 7db36436 3) line4

As printing CR moves the cursor to the beginning of line on many
terminals, it is understandable to see the above output.  After
printing the first line, it will show=20

    7db36436 2) line2

and then go back to the leftmost column and then overwrite 7db3...
with "line3".

Even though we have an option to mark <CR> alone as the end of line
marker, because the blamed content can go through the textconv
filter, it may be possible to define a textconv filter for the path
via the attribute system and convert such "mixed line endings"
contents to a series of <LF>-terminated lines.  That would split the
second line in the original input into two lines and may produce
desired result.
