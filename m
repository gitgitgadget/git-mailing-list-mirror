From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on
 orphan branches
Date: Mon, 30 Nov 2015 13:24:24 +0100
Message-ID: <20151130132424.Horde.2BMsKJ5eWOY71RtsJbP8UQw@webmail.informatik.kit.edu>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
 <1448376345-27339-2-git-send-email-szeder@ira.uka.de>
 <56555A5B.20504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 13:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3NW4-0007av-4w
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 13:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbbK3MYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 07:24:46 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52326 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606AbbK3MYp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 07:24:45 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1a3NVa-0005ZI-8j; Mon, 30 Nov 2015 13:24:42 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1a3NVI-0000J0-Ez; Mon, 30 Nov 2015 13:24:24 +0100
Received: from x4db1bb21.dyn.telefonica.de (x4db1bb21.dyn.telefonica.de
 [77.177.187.33]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 30 Nov 2015 13:24:24 +0100
In-Reply-To: <56555A5B.20504@kdbg.org>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1448886282.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281804>


Quoting Johannes Sixt <j6t@kdbg.org>:

>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -200,7 +200,19 @@ require_work_tree () {
>> }
>>
>> require_clean_work_tree () {
>> -	git rev-parse --verify HEAD >/dev/null || exit 1
>> +	if git rev-parse --verify HEAD >/dev/null 2>/dev/null
>> +	then
>> +		compare_to=3DHEAD
>> +	else
>> +		if [ -z "$ORPHAN_OK" ]
>> +		then
>> +			echo >&2 "Cannot $1: Your current branch does not have any commi=
ts yet."
>> +			exit 1
>> +		else
>> +			# SHA1 of an empty tree
>> +			compare_to=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> +		fi
>> +	fi
>
> It is worrysome that this now throws away any error message of
> rev-parse. A more conservative approach would be to test for -z
> "$ORPHAN_OK" first and entail new behavior only for the "$ORPHAN_OK"
> case.

Those error messages didn't seem to be helpful and in some cases they
were even misleading, e.g.:

    $ git checkout --orphan orphan
    $ git rm -rf .
    $ git script valid-branch
    fatal: Needed a single revision
    $ # Huh?  Didn't I just gave you one?!

G=C3=A1bor
