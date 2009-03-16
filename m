From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-patch: fix invocation in sub working tree 
	directory
Date: Tue, 17 Mar 2009 00:25:38 +0100
Message-ID: <36ca99e90903161625x317556f4hc826aabd01494ca0@mail.gmail.com>
References: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vbps1umg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	u.kleine-koenig@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 00:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjMDD-0008S2-PQ
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 00:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbZCPXZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbZCPXZm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 19:25:42 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:57618 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZCPXZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 19:25:41 -0400
Received: by ewy25 with SMTP id 25so3675113ewy.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hw6UJRFMQI7hTUNNfFHkYzeoZ99ldaAIl1uR92qTEDU=;
        b=Q7FnKCZyq1yeCNWIxpAn6PTp0n3Ns069stAfySEJOBkn/FUeLGlyDy91o7vDTpUnu/
         n1qIEXZIOQS9qGhTKqenvA4tTU9Tf8J/GzfFG2bmHdEjxqmUvZvNtKp1eZnFV+hn6BLB
         09FlIwCShbYapTWqC1GEcojNbcVFLXEWVX43w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BPKv87MHPfjiAKMoEPDMPCFhy5ZWBs+1NPLugFua8aPhE42BWkvtziGTq4hsLE7iNd
         oy5Yra6pZ4QpCULs075FNEzATZ4IpfLm7CYjppJ6Kjp+xytxMnLrdwq1y7FZQ/IKNFtr
         ky+XGeqQX6Q1KofnPcm6oUIjWCyzgGOo/67tA=
Received: by 10.210.130.13 with SMTP id c13mr3957235ebd.40.1237245938841; Mon, 
	16 Mar 2009 16:25:38 -0700 (PDT)
In-Reply-To: <7vbps1umg9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113404>

On Mon, Mar 16, 2009 at 23:33, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> tg patch won't work in a sub directory of the working tree, because =
'git diff
>> --name-only' prints the names relative to the top working tree.
>
> "diff --relative --name-only"?
No, unfortunately. In my bug case the changed file was in another
subtree, and --relative restricts the output to only files under the
current subtree.

>
>> This is only a quick fix which prefixes all file names with 'git rev=
-parse
>> --show-cdup'. The right solution would be to cd into the top working=
 tree
>> somewhere in tg.sh.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>> =C2=A0tg-patch.sh | =C2=A0 =C2=A07 ++++++-
>> =C2=A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/tg-patch.sh b/tg-patch.sh
>> index d701c54..e33bab2 100644
>> --- a/tg-patch.sh
>> +++ b/tg-patch.sh
>> @@ -50,13 +50,18 @@ cat_file "$topic:.topmsg"
>> =C2=A0echo
>> =C2=A0[ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$=
name"} -- ".topmsg")" ] || echo '---'
>>
>> +# if we are in a sub working tree dir, we need to prefix all file n=
ames from
>> +# git diff --name-only with this cdup
>> +cdup=3D$(git rev-parse --show-cdup)
>> ...
>> + =C2=A0 =C2=A0 sed -e "s#^#$cdup#" "$git_is_stupid" |
>
> Do TopGit folks care about special characters in pathnames?
Do 'git rev-parse --show-cdup' return anything other than slashes and d=
ots?

Bert
