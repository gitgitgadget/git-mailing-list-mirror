From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: Display error output from git-checkout when detaching HEAD fails.
Date: Mon, 14 Jul 2008 20:57:17 +0100
Message-ID: <1096648c0807141257i76f70322p5a16c86c1c826a66@mail.gmail.com>
References: <1215811619-28512-1-git-send-email-robertshearman@gmail.com>
	 <7vr6a0hvvu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_75801_10258001.1216065437730"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIUBe-0000kc-TX
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbYGNT5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbYGNT5U
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:57:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:8570 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbYGNT5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:57:19 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3495203wri.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=YvwfD6KKap0UgzCs7szH/NcW4o5c2dClaJa77PdGjPI=;
        b=lW0oehp1RArKgaPBkC0TK+SG166fE56NxSFhkzZId0EGxhGDhaX64Q7b7yyrdDzswX
         KW2afelpZatYcqEWeNidWkPccZhE0NTUCQ5OaPdBn5C33WM2Iv08fF+0TZ5w/fLDXsap
         5b2qYyqDHyPXyw1zjcVZewy7gJF80AKITcnhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=F0TUqzHn37O/1HnJ27dtSqOIanrtlJHwjPNoZGmtvnSqFCEqlFsy5y7rHecaIK2Ttx
         3LPWaoR8R+85KlNVffTlDgJeE2fEtDU4oo6ApWEmlJZN5XAkYQkThD9Fdis1jpeegAG+
         Tr/UNsrzNzIKVFlBes1Aw34VPBnBaLJRixMj8=
Received: by 10.90.55.20 with SMTP id d20mr15135917aga.29.1216065437744;
        Mon, 14 Jul 2008 12:57:17 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Mon, 14 Jul 2008 12:57:17 -0700 (PDT)
In-Reply-To: <7vr6a0hvvu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88462>

------=_Part_75801_10258001.1216065437730
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/7/11 Junio C Hamano <gitster@pobox.com>:
> Robert Shearman <robertshearman@gmail.com> writes:
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index e2d85ee..0da2210 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -376,7 +376,7 @@ fi
>>
>>  # Detach HEAD and reset the tree
>>  echo "First, rewinding head to replay your work on top of it..."
>> -git checkout "$onto^0" >/dev/null 2>&1 ||
>
> I think this very much is done deliberately by somebody who knows the
> shell to discard everything.

Why wasn't "git checkout "$onto^0" &> /dev/null" used then? Then only
reason I can come up with would be portability, but it seems
surprising to me.

>> +git checkout "$onto^0" 2>&1 >/dev/null ||
>
> And if it is beneficial to show the error, you just do not touch fd #2,
> like this:
>
>        git checkout "$onto^0" >/dev/null

Absolutely. I was just trying to fix the statement to what I thought
was the original intent.

> As I do not see any reason to send the error message to stdout like you
> did.
>
> I also suspect that this part of the script predates 6124aee (add a quiet
> option to git-checkout, 2007-02-01) where the command learned to be more
> quiet during the normal operation.  Perhaps you can replace the line with
>
>        git checkout -q "$onto^0"
>
> and be done with it.  I haven't tested it, though.

I just tested it and it solves the original issue whilst not
displaying unnecessary messages during a rebase. For reference, the
attached script reproduces the issue that I was trying to solve.

Should I resend the patch (like the following) now that it is
effectively completely your work?

-git checkout "$onto^0" >/dev/null 2>&1 ||
+git checkout -q "$onto^0" ||

-- 
Rob Shearman

------=_Part_75801_10258001.1216065437730
Content-Type: application/x-sh; name=rebase_clash.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_finhsjpz0
Content-Disposition: attachment; filename=rebase_clash.sh

IyEvYmluL3NoCgpnaXQgaW5pdC1kYiAKZWNobyBUZXN0ID4gbmV3CmdpdCBhZGQgbmV3CmdpdCBj
b21taXQgLW0gJ0luaXRpYWwgQ29tbWl0JwpnaXQgYnJhbmNoIGJhc2UKZWNobyBUZXN0MiA+IG5l
d19jbGFzaApnaXQgYWRkIG5ld19jbGFzaApnaXQgY29tbWl0IC1tICdVcHN0cmVhbSBDb21taXQn
IG5ld19jbGFzaApnaXQgYnJhbmNoIHVwc3RyZWFtCmdpdCBjaGVja291dCAtYiBsb2NhbCBiYXNl
CmVjaG8gVW5yZWxhdGVkID4gdW5yZWxhdGVkCmdpdCBhZGQgdW5yZWxhdGVkCmdpdCBjb21taXQg
LW0gJ0xvY2FsIENvbW1pdCcgdW5yZWxhdGVkCmVjaG8gQ2xhc2ggPiBuZXdfY2xhc2gKZ2l0IHJl
YmFzZSB1cHN0cmVhbQo=
------=_Part_75801_10258001.1216065437730--
